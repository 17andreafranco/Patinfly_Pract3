//
//  ScooterServer.swift
//  Patinfly
//
//  Created by deim on 9/1/23.
//

import Foundation

struct ScootersServer: Hashable, Codable{
    var scooters: [Scooter]
}

struct  ScooterServer: Hashable, Codable, Equatable{
    var uuid: String
    var name: String
    var longitude: Float
    var latitude: Float
    var battery_level: Float
    var km_use: Float
    var date_last_maintenance: String
    var state: String
    var on_rent: Bool
}
