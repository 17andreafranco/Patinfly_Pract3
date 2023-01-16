//
//  ContentView.swift
//  Patinfly
//
//  Created by deim on 20/9/22.
//

import SwiftUI


struct ScooterRowView: View {
    let name: String
    let state: String
    let distancce: String
    let battery: Float
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 10){
                HStack(){
                    Text(name).bold().foregroundColor(.black).font(.body)
                    Spacer()

                    if(battery >= 75){
                        Image(systemName: "battery.100").font(.title2).foregroundColor(.green)
                    }
                    if(battery < 75 && battery >= 50){
                       Image(systemName: "battery.75").font(.title2).foregroundColor(.green)
                    }
                    if(battery < 50 && battery > 25){
                        Image(systemName: "battery.50").font(.title2).foregroundColor(.yellow)
                     }
                    if(battery <= 25){
                        Image(systemName: "battery.25").font(.title2).foregroundColor(.red)
                    }
                    if(battery == 0){Image(systemName: "battery.0").font(.title2)}
                }
                
                HStack{
                    switch state{
                    case "ACTIVE": Image(systemName: "scooter").font(.title2).foregroundColor(.green)
                    default:
                        Image(systemName: "scooter").font(.title2).foregroundColor(.red)
                    }
                    Spacer()
                  
                    HStack{
                        Text("km:")
                        Text(distancce)
                    }.frame(width: 190, alignment: .trailing)
                }

            }
        }
    }
}

struct ContentView: View {
   
   // @State var scooters: Scooters = Scooters (scooters: [])
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors:[]) var scooters: FetchedResults<ScooterDB>
    @StateObject var dataController = DataController()

    var body: some View {
        NavigationView{
            VStack{
                List(scooters){scooter in
                        if(scooter.state == "ACTIVE"){
                            NavigationLink{
                                ScooterDetailView(scooter: scooter).environment(\.managedObjectContext, dataController.containerScooter.viewContext)
                            }label:{
                                ScooterRowView(name: scooter.name!, state: scooter.state!,
                                               distancce: "10",battery: scooter.battery_level).environment(\.managedObjectContext, dataController.containerScooter.viewContext)
                            }
                            
                        }else{
                            ScooterRowView(name: scooter.name!, state: scooter.state!,
                                           distancce: "10",battery: scooter.battery_level).environment(\.managedObjectContext, dataController.containerScooter.viewContext)
                        }
                    }
                }
            }.navigationTitle("Scooters")
        }
    }





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
