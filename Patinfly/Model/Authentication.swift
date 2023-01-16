//
//  Authentication.swift
//  Patinfly
//
//  Created by deim on 27/9/22.
//


import SwiftUI

class Authentication: ObservableObject{
    @Published var isValidated:Bool = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable{
        case invalidCredentials
        var id:String{
            self.localizedDescription
        }
        
         
        var errorDescription: String?{
            switch self{
            case .invalidCredentials:
                return NSLocalizedString("El teu usuari o constrasenya són incorrectes", comment: "")
            }
        }
    }
    
    
    
    
    
    
    func  updateValidation(success: Bool){
        withAnimation{
            isValidated=success
        }
    }
    
}
