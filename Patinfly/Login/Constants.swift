//
//  Constants.swift
//  ServerHTTPAccess
//
//  Created by Tomas GiS on 8/12/22.
//

import Foundation

struct APIConstants{
    static let scheme = "https"
    static let host = "patinfly.com"
    static let token: String = "cXwoo4aCs8VKooJyX2ddGQF1WLOjdwNpGvbazLVM2AWAJxVuTy"
    static let urlServer: String = "https://patinfly.com/"
    static let pathStatus: String = "/endpoints/status/"
    static let pathScooter: String = "/endpoints/scooter/"
    static let pathScooterStart: String = "/endpoints/rent/start"
    static let pathScooterStop: String = "/endpoints/rent/stop"

    static func baseURL() -> URLComponents{
        var baseServerURL: URLComponents = URLComponents()
        baseServerURL.scheme = APIConstants.scheme
        baseServerURL.host = APIConstants.host
        return baseServerURL
    }
    
    static func serverStatus() -> URLComponents{
        var urlServerStatus: URLComponents = APIConstants.baseURL()
        urlServerStatus.path = APIConstants.pathStatus
        return urlServerStatus
    }
   
    static func scooters() -> URLComponents{
        var urlServerScooters: URLComponents = APIConstants.baseURL()
        urlServerScooters.path = APIConstants.pathScooter
        return urlServerScooters
    }
    
}
