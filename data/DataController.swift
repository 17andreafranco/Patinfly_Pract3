//
//  DataController.swift
//  Patinfly
//
//  Created by deim on 29/11/22.
//


import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject{
    let containerScooter = NSPersistentContainer(name:"ScooterDB")
    var uuid : String = try! UserDefaults.standard.string(forKey: "uuid") ?? "hola"
    let dateFormatter = DateFormatter()

    @Environment(\.managedObjectContext) var moc

    init(){
        containerScooter.loadPersistentStores{
            description, error in
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func searchScooter()-> ScooterDB?{
        print(uuid)
        @FetchRequest (sortDescriptors:[]) var scooters: FetchedResults<ScooterDB>
        
        print(moc)
        if (containerScooter == nil){
            return nil}
        
            
        let context = containerScooter.viewContext
        let request = NSFetchRequest<ScooterDB>(entityName: "ScooterDB")
        
        let stringValue = uuid as CVarArg
        let resultado = try? context.fetch(request)
        for scooter in resultado ?? []{
            print("Lista-",scooter)
            if scooter.uuid == stringValue as! String{
                return scooter
            }
        }
    
        print("Res",resultado)
        return resultado!.first
    }
    func saveScooter(scooter: Scooter){
        let scooterData: ScooterDB = ScooterDB(context: containerScooter.viewContext)
        scooterData.name = scooter.name
        scooterData.uuid = scooter.uuid
        scooterData.longitude = scooter.longitude
        scooterData.latitude = scooter.latitude
        scooterData.battery_level = scooter.battery_level
        scooterData.date_last_mantinance = scooter.date_last_maintenance
        scooterData.state = scooter.state
        scooterData.on_rent = scooter.on_rent
        try? containerScooter.viewContext.save()
    }
    
    func saveRent(uuid: String, date_start:String){
        print("Holaaaa ",date_start)
        let rentData: RentDB = RentDB(context: containerScooter.viewContext)
        //dateFormatter.timeStyle = .medium
        
        rentData.uuid=uuid
        rentData.date_start = date_start
        try? containerScooter.viewContext.save()
    }
    
}
