//
//  Constant.swift
//  Patinfly
//
//  Created by deim on 16/1/23.
//


import Foundation

struct APIConstants{
    static let scheme = "https"
    static let host = "patinfly.com"
    static let token: String = "zZ1HaGomryYFVjQJLlpwSKv0EXATPksIOgUexbfd"
    static let urlServer: String = "https://patinfly.com/"
    static let pathStatus: String = "/endpoints/status/"
    static let pathScooter: String = "/endpoints/scooter/"
    static let pathRentStart: String = "/endpoints/rent/start/ea153fe6-d480-11ec-91c7-ecf4bbcc40f8"
    static let pathRentStop: String = "/endpoints/rent/stop/ea153fe6-d480-11ec-91c7-ecf4bbcc40f8"
    
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
    
    static func scootersStartRent() -> URLComponents{
        var urlServerScooters: URLComponents = APIConstants.baseURL()
        urlServerScooters.path = APIConstants.pathRentStart
        return urlServerScooters
    }
    
    static func scootersStopRent() -> URLComponents{
        var urlServerScooters: URLComponents = APIConstants.baseURL()
        urlServerScooters.path = APIConstants.pathRentStop
        return urlServerScooters
    }
    

    
    
}
