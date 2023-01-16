//
//  Scooter.swift
//  Patinfly
//
//  Created by deim on 4/10/22.
//

import Foundation

struct Scooters: Hashable, Codable{
    var scooters: [Scooter]
}

struct  Scooter: Hashable, Codable, Equatable{
    var uuid: String
    var name: String
    var longitude: Float
    var latitude: Float
    var battery_level: Float
    var km_use: Float
    var date_last_maintenance: String?
    var state: String
    var on_rent: Bool
}


    

