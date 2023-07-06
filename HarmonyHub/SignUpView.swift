//
//  SignUpView.swift
//  HarmonyHub
//
//  Created by Namashi Sivaram on 2023-07-05.
//

import SwiftUI
import Firebase
struct SignUpView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password1: String = ""
    @State private var password2: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            TextField(
                "Email",
                text: $email
            )
            

            .autocapitalization(.none) // Corrected modifier name
            .disableAutocorrection(true)
            .border(Color.secondary) // Corrected modifier syntax
            TextField(
                "User name",
                text: $username
            )
            

            .autocapitalization(.none) // Corrected modifier name
            .disableAutocorrection(true)
            .border(username.count >= 7 ? Color.green : Color.red) // Corrected modifier syntax
            TextField(
                "Password",
                text: $password1
            )
            
            .autocapitalization(.none) // Corrected modifier name
            .disableAutocorrection(true)
            .border(password1.count >= 7 ? Color.green : Color.red) // Corrected modifier syntax
            TextField(
                "Retype password",
                text: $password2
            )
            

            .autocapitalization(.none) // Corrected modifier name
            .disableAutocorrection(true)
            .border(validatePass() ? Color.green : Color.red)
            
            Button(action:{signUp()}
                
            , label:{ Text("OK")})
            
            
        }
        .navigationTitle("SIGN UP")
        
    }
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password1) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                print("DFYTFTFYTFYTFYTF")
            } else {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error != nil{
                        print(error?.localizedDescription ?? "")
                        print("username error")
                    }
                    else{
                        
                        print("Sucess with username")
                        presentationMode.wrappedValue.dismiss()
                                       NotificationCenter.default.post(name: NSNotification.Name("RefreshRootView"), object: nil)
                    }
                  // ...
                }
                print("success SIGN")
            }
        }
    }
    func validatePass() -> Bool{
        
        return (password1==password2&&password1.count>=7)
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
