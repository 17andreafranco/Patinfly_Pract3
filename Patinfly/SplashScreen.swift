//
//  SplashScreen.swift
//  Patinfly
//
//  Created by deim on 4/10/22.
//

import SwiftUI
import CoreData

struct SplashScreen: View {
    @StateObject var authentication = Authentication()

    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
       
        if self.isActive{
            if authentication.isValidated{
                ContentView()
            }else{
                //LoginView()
                ContentView()
            }
        }
        else{
        VStack{
            VStack{
                Image(uiImage: UIImage(named: "Logo") ?? UIImage()).scaleEffect(0.8)
                
                Text("Patinfly").font(.title)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{withAnimation(.easeIn(duration: 1.2)){
                self.size = 1.0
                self.opacity = 1.0
            }
    }
        }.frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.12).onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                withAnimation{
                    self.isActive = true
                    
                }
                /*if let url = Bundle.main.url(forResource: "scooters", withExtension: "json"){
                    do{
                        let dataController = DataController()
                        let jsonData = try Data(contentsOf: url)
                        print(jsonData)
                        let decoder = JSONDecoder()
                        print(try decoder.decode(Scooters.self, from: jsonData))
                        let scooters: Scooters = try decoder.decode(Scooters.self, from: jsonData)
                        for scooter in scooters.scooters{
                            dataController.saveScooter(scooter: scooter)
                        }
                       
                 }*/
               
                APIservice.checkServerStatusWithCompletion(){(result: Result<ServerStatus, NetworkError>) in
                    //print(try? result.get().status)
                    if((try? result.get().status) != nil){
                        APIservice.scooterList(withToken: APIConstants.token)
                        APIservice.scooterListWithCompletion(withToken: APIConstants.token) {(result: Result<Scooters, NetworkError>) in
                            do {
                            let dataController = DataController()
                            for scooter in try result.get().scooters{
                                dataController.saveScooter(scooter: scooter)
                            }
                            } catch let parseError {
                                        print("JSON Error \(parseError.localizedDescription)")
                            }
                        }
                        
                    } else{
                        print("!OLEEE")
                    }
                    //print(try? result.get().self)
                }
                       
                }
            }
        }
       }
    }






struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .previewInterfaceOrientation(.portrait)
        SplashScreen()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
