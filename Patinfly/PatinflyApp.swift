//
//  PatinflyApp.swift
//  Patinfly
//
//  Created by deim on 20/9/22.
//

import SwiftUI

@main
struct PatinflyApp: App {
    @StateObject var authentication = Authentication()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors:[]) var scooters: FetchedResults<ScooterDB>
    @StateObject var dataController = DataController()
    var uuid = UserDefaults.standard.string(forKey: "uuid") ?? "hola"
     
    var body: some Scene {
        
        WindowGroup {
            if authentication.isValidated{
                let defaults = UserDefaults.standard
                if(true){
                    ScooterDetailView(scooter: dataController.searchScooter()!).environment(\.managedObjectContext, dataController.containerScooter.viewContext)
                }else{
                ContentView().environmentObject(authentication).environment(\.managedObjectContext, dataController.containerScooter.viewContext)
                }
            }
            else{
                //LoginView().environmentObject(authentication)
                //SplashScreen().environmentObject(authentication).environment(\.managedObjectContext, dataController.containerScooter.viewContext)
                if(uuid == "hola"){
                    SplashScreen().environmentObject(authentication).environment(\.managedObjectContext, dataController.containerScooter.viewContext)
                }else{
                    
                    ScooterDetailView(scooter: dataController.searchScooter()!).environment(\.managedObjectContext, dataController.containerScooter.viewContext)

                }
                    
                
                
            }
        }
    }
}


