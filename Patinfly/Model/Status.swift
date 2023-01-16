//
//  Status.swift
//  Patinfly
//
//  Created by deim on 10/1/23.
//

import Foundation

//{"status": {"version": 1, "build": 1, "update": "2022-05-08T19:52:51.552000Z", "name": "1-0001"}}
struct Status: Codable {
    let id:Int = 1
    let version: Int
    let build: Int
    let update: String
    let name: String
}

struct ServerStatus: Codable{
    let id:Int = 1
    let status: Status
}
