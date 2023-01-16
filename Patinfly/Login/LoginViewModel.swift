//
//  LoginViewModel.swift
//  Patinfly
//
//  Created by deim on 4/10/22.
//

import Foundation


class LoginViewModel: ObservableObject{
    
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    
    var loginDisable : Bool{
        credentials.email.isEmpty || credentials.password.isEmpty
        
    }
    
    func login(completition: @escaping (Bool) -> Void){
        showProgressView = true
        APIservice.shared.login(credentials: credentials){[unowned self] (result:Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
            case .success:
                completition(true)
            case .failure(let authError):
                credentials = Credentials()
                error=authError
                completition(false)
            }
            
        }
    }

}
