//
//  ServerStopRent.swift
//  Patinfly
//
//  Created by deim on 10/1/23.
//

import Foundation

struct RentStop: Codable{
    let uuid: String
    let date_start: String
    let date_stop: String
}


struct ServerStopRent: Codable {
    let code:Int
    let msg: String
    let rent: RentStop
    let timestamp: String
    let version: Float
}
