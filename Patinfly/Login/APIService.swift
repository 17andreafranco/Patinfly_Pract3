//
//  APIService.swift
//  Patinfly
//
//  Created by deim on 27/9/22.
//

import Foundation


class APIservice{
    
    static let shared = APIservice()
    
    enum APIError: Error{
        case error
    }
    
    func validUser(credentials:Credentials) -> Bool{
        return (credentials.email == "A" ) && (credentials.password == "asd")
    }
    
    
    func login(credentials:Credentials, completition: @escaping(Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if self.validUser(credentials: credentials){
                completition(.success(true))
            }
            else{
                completition(.failure(.invalidCredentials))
            }
        }
        
    }
    
    static func checkServerStatus(){
        let callURL = APIConstants.serverStatus()
        var response:HTTPURLResponse?
        let task = URLSession.shared.dataTask(with:callURL.url!){
            (data, response, error) in
            guard let data = data else{
                print("APIService: error accessing server status")
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                print("Server response: 3xx, 4xx or 5xx")
                return
            }
            
            do {
                print(data)
                let jsonData = try JSONDecoder().decode(ServerStatus.self, from: data)
                //scooterList(withToken: APIConstants.token)
                print(jsonData)

            }catch let errorParser{
                print("The data from server status is compliance with the specifications or server is not working")
                print(errorParser)
            }
             
        }
        task.resume()
    }
    
    static func serverStartRent(withToken: String,uuid: String, completion: @escaping (Result<ServerRent, NetworkError>) -> Void){
        let callURL = APIConstants.scootersStartRent()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(ServerRent.self, from: data!)
                    completion(.success(jsonData))
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
    
    static func serverStopRent(withToken: String,uuid: String, completion: @escaping (Result<ServerRent, NetworkError>) -> Void){
        let callURL = APIConstants.scootersStopRent()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(ServerRent.self, from: data!)
                    completion(.success(jsonData))
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
    static func checkServerStatusWithCompletion(completion: @escaping (Result<ServerStatus, NetworkError>) -> Void){
        let callURL = APIConstants.serverStatus()
        let task = URLSession.shared.dataTask(with:callURL.url!){data, response, error in
                    
            if let networkError = NetworkError(data: data, response: response, error: error) {
                        print("APIService: error accessing server status")
                        completion(.failure(networkError))
            }
            do {
                let status = try JSONDecoder().decode(ServerStatus.self, from: data!)
                completion(.success(status))
            } catch let errorParser{
                print("The data from server status is compliance with the specifications or server is not working")
                print(errorParser)
                completion(.failure(.decodingError(errorParser)))
            }
        }
        task.resume()
    }
    
    static func scooterList(withToken: String){
        let callURL = APIConstants.scooters()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        let task = URLSession.shared.dataTask(with:request){
            (data, response, error) in
            guard let data = data else{
                print("APIService: error accessing server status")
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                print("Server response: 3xx, 4xx or 5xx")
                return
            }
            
            do {
                
                let scooters: Scooters = try JSONDecoder().decode(Scooters.self, from: data)
                //let jsonData = try JSONDecoder().decode(Scooters.self, from: data)
                
                print(scooters)
                // Do stuff here
            }catch let errorParser{
                print("The data from server status is compliance with the specifications or server is not working")
                print(errorParser)
            }
             
        }
        task.resume()
    }
    
    static func scooterListWithCompletion(withToken: String, completion: @escaping (Result<Scooters, NetworkError>) -> Void){
        let callURL = APIConstants.scooters()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(Scooters.self, from: data!)
                    completion(.success(jsonData))
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
    
    

}
