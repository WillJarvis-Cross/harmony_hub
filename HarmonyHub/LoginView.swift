//
//  LoginView.swift
//  HarmonyHub
//
//  Created by Namashi Sivaram on 2023-07-05.
//

import SwiftUI
import Firebase
struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: { login() }) {
                Text("Sign in")
            }
        }
        .navigationTitle("LOGIN")
        .padding()
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success LOGIN")
                presentationMode.wrappedValue.dismiss()
                               NotificationCenter.default.post(name: NSNotification.Name("RefreshRootView"), object: nil)
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
