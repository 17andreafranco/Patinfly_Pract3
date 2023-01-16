//
//  LoginView.swift
//  Patinfly
//
//  Created by deim on 20/9/22.
//

import SwiftUI


struct LoginView: View {
    @State var labelText: String = "Not Selected"
    @State var estado :Bool = false
    
    
    @StateObject private var loginViewModel=LoginViewModel()
    @EnvironmentObject var authentication : Authentication
    
    var body: some View {
        NavigationView{
        VStack {
            Image("Logo").padding(.vertical,10)
            
            Text("Patinfly").font(.largeTitle).foregroundColor(Color("TitleColor"))
            
            TextField("Adreça de correo electronic",text:$loginViewModel.credentials.email).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.emailAddress).padding(.horizontal,100).padding(.vertical,5).autocapitalization(.none)
            
            SecureField("Contrasenya",text: $loginViewModel.credentials.password).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal,100).padding(.vertical,5)
            if loginViewModel.showProgressView{
                ProgressView()
                
            }
            
            Button("Sign in"){
                if(estado == true){
                    loginViewModel.login{
                        success in
                        authentication.updateValidation(success: success)
                }
                
                }
            }.disabled(loginViewModel.loginDisable).padding(10).multilineTextAlignment(.center)
            Text("Condicions").multilineTextAlignment(.center)
            Toggle(isOn: $estado){}.offset(y: -45).padding(.horizontal,50).padding(.vertical,5)
            NavigationLink(destination: ConditionView()){
                Text("Condicions d'ús").foregroundColor(Color("PrimaryColor")).padding(.horizontal,100).padding(.bottom,80)
            }
            
        }
    }
}

    
struct ConditionView: View {
    var body: some View {
        
            ScrollView {
                VStack{
                    Text("Terminos y condiciones de uso.").padding(.horizontal,25).padding(.bottom,25).font(.largeTitle).multilineTextAlignment(.center)
                    Text("With the apperance of the electric scooter in city traffic, the law has responded as it usually does in such cases. First, a new, popular phenomenon arises. Second, owing to the risks and problems arising from this phenomenon, users and legal practitioners see the need for regulation. And so also on this occasion, this new reality is gradually being regulated, at the European, national and local level. Because you do not neet any authorization to use an electric scooter users, especially minors , maybe unaware of the law applicable to the damage caused by scooter. EU and Spanish national and local authorities have done little to publlicize the regulations applicable to the use of electric scooters and the fact that these rules can vay from place to place. Fro example, a trip acroos Madid on an electric scooter will take you trhoughh areas with differing regulations because loca bylaws dictate what electric scooters are allowed and not allowed to do on the streets of each municipality.").multilineTextAlignment(.center).padding(.horizontal,10).padding(.vertical,90)
                    }
        
        }
        
       
}
    
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.portrait)
        LoginView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

}

