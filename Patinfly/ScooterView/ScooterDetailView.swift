//
//  ScooterDetailView.swift
//  Patinfly
//
//  Created by deim on 25/10/22.
//
import MapKit
import SwiftUI
import CoreData
import Foundation
    
struct Place: Identifiable {
let id = UUID()
let name: String
let latitude: Double
let longitude: Double
var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}




struct ScooterDetailView: View {
    var scooter: ScooterDB
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.155440105238064, longitude: 1.1087023235714373), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State private var finish = true
    @State private var start = false
    @State  var startTime = "00:00:00"
    @State var finishTime = "00:00:00"
    let dataController = DataController()
    let dateFormatter = DateFormatter()
    
    @AppStorage("uuid") var uuid: String = "hola"

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        let places = [
            Place(name: "Position 1", latitude: Double(scooter.latitude), longitude: Double(scooter.longitude))
        ]
        VStack{
            HStack{
                Text(scooter.name!).fontWeight(.bold).font(.title3).padding(.horizontal,40).lineLimit(1)
                    
                if(scooter.battery_level >= 75){
                    Text(String(scooter.battery_level)+"%")
                    Image(systemName: "battery.100").font(.title2).foregroundColor(.green)
                }
                if(scooter.battery_level < 75 && scooter.battery_level >= 50){
                    Text(String(scooter.battery_level)+"%")
                   Image(systemName: "battery.75").font(.title2).foregroundColor(.green)
                }
                if(scooter.battery_level < 50 && scooter.battery_level > 25){
                    Text(String(scooter.battery_level)+"%")
                    Image(systemName: "battery.50").font(.title2).foregroundColor(.yellow)
                 }
                if(scooter.battery_level <= 25){
                    Text(String(scooter.battery_level)+"%")
                    Image(systemName: "battery.25").font(.title2).foregroundColor(.red)
                }
                if(scooter.battery_level == 0){Image(systemName: "battery.0").font(.title2)}
                
            }.frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.12)
            Map(coordinateRegion: $region, showsUserLocation: true,  annotationItems: places){ place in
                    MapMarker(coordinate: place.coordinate)

                }.frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.22).ignoresSafeArea(edges: .top)
            Image("Logo").resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay{Circle().stroke(.gray,lineWidth: 4)
                }
                .shadow(radius: 7 ).offset(y:-70).padding(.horizontal,130)
            VStack{
                Text("Inicio del alquier")
                Text(startTime).padding(.vertical,20)
                Text("Final del alquiler")
                Text(finishTime).padding(.vertical,20)
            }
         
            }.onAppear(){
                LocationManager.shared.getUserLocation{ location in
                    DispatchQueue.main.async{
                        region.center.latitude = location.coordinate.latitude
                        region.center.longitude = location.coordinate.longitude
                    }
                }
                
          
            }.onAppear(){
                @FetchRequest (sortDescriptors:[]) var scooters: FetchedResults<RentDB>
                let context = dataController.containerScooter.viewContext
                let query = NSFetchRequest<RentDB>(entityName: "RentDB")
                let resultado = try? context.fetch(query)
                dateFormatter.timeStyle = .medium
                for rent in resultado ?? []{
                    print(rent.date_start,"----",rent.date_stop)
                    if rent.date_start != nil && rent.date_stop == nil{
                        finish.toggle()
                        start.toggle()
                        //print("dadsfass",dateFormatter.string(from: rent.date_start ?? Date.now))
                        startTime = rent.date_start ?? "00:00:00"
                    }
                    else if rent.date_start == nil{
                        finish = true
                        start = false
                    }
                        
                }
                
            }.onDisappear(){
                print("Taaaaachaaan")
            }
    
        
        if(finish){
                Button(action: {
                    rentScooter(uuid: scooter.uuid)
                    uuid = scooter.uuid!
                    updateStartDate(uuid:scooter.uuid)
                    //print("hola",uuid)
                    finish.toggle()
                    start.toggle()
                            }, label: {
                                    Text("start".uppercased()).font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                        .padding(.vertical, 20)
                            })
        }else{
        
        Button(action: {
            stopScooter(dateFormatter: dateFormatter)
            dateFormatter.timeStyle = .medium
            finish.toggle()
            start.toggle()
            uuid="hola"
                    }, label: {
                        
                            Text(" stop ".uppercased()).font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .padding(.vertical, 20)
                    })
        
    }
            
/* Si se quiere usar esto comentar la variable scooter
 struct ScooterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterDetailView()
    }
}*/

}
    func rentScooter(uuid:String!)
    {
        APIservice.serverStartRent(withToken: APIConstants.token, uuid: uuid){(result:Result<ServerRent, NetworkError>) in
            let context = dataController.containerScooter.viewContext
            let query = NSFetchRequest<RentDB>(entityName: "RentDB")
            let resultado = try? context.fetch(query)
            do {
                dataController.saveRent(uuid: uuid,date_start: String(try result.get().rent.date_start))
            } catch let parseError {
                        print("JSON Error \(parseError.localizedDescription)")
            }
        }
        
    }
    func stopScooter(dateFormatter:DateFormatter){
        let context = dataController.containerScooter.viewContext
        let query = NSFetchRequest<RentDB>(entityName: "RentDB")
        let resultado = try? context.fetch(query)
        //dateFormatter.timeStyle = .medium
        APIservice.serverStopRent(withToken: APIConstants.token, uuid: uuid){(result:Result<ServerRent, NetworkError>) in
            do {
                for rent in resultado ?? []{
                    if rent.date_start != nil && rent.date_stop == nil{
                        rent.date_stop = dateFormatter.string(from: Date.now ?? Date.now)
                        finishTime = String(try result.get().rent.date_stop ?? "00:00:00")
                        try? context.save()
                    }
                    else if rent.date_start == nil{
                        finish = true
                        start = false
                    }
                }
                print(try? result.get().rent.date_stop)
            } catch let parseError {
                        print("JSON Error \(parseError.localizedDescription)")
            }
        }
        
        
    }
    func updateStartDate(uuid:String!){
        let context = dataController.containerScooter.viewContext
        let query = NSFetchRequest<RentDB>(entityName: "RentDB")
        let resultado = try? context.fetch(query)
        dateFormatter.timeStyle = .medium
        if finishTime != "00:00:00"{
            finishTime = "00:00:00"
        }
        for rent in resultado ?? []{
            if rent.uuid == uuid{
                startTime =  rent.date_start ?? "00:00:00"
            }
        }
    }
}
