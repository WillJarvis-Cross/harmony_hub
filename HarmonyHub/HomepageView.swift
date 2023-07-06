//
//  HomepageView.swift
//  HarmonyHub
//
//  Created by Namashi Sivaram on 2023-07-03.
//

import SwiftUI
import Firebase
struct HomepageView: View {
    var name:String = Auth.auth().currentUser!.displayName!
    var user = Auth.auth().currentUser
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Primary")
                    .ignoresSafeArea()
                
                    
                    
                
                VStack {
                    Spacer()
                    Text("Welcome Back, "+name).font(Font.system(size:25, design: .default)).bold()

                    ZStack {
                        VStack() {
                            
                            Spacer()
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.white)
                                
                                .frame(width: geometry.size.width, height: geometry.size.height*0.8)
                                
                        }
                        VStack {
                            Spacer()
                            VStack{
                                HStack{
                                    Button(action: {
                                        print("friends")
                                    }, label: {RoundedRectangle(cornerRadius: 25)
                                            .fill(Color("Secondary"))
                                            .frame(width: 150, height: 150)})
                                    
                                    Button(action: {
                                        print("friends")
                                    }, label: {RoundedRectangle(cornerRadius: 25)
                                            .fill(Color("Secondary"))
                                            .frame(width: 150, height: 150)})
                                    
                                }
                                HStack{
                                    Button(action: {
                                        print("friends")
                                    }, label: {RoundedRectangle(cornerRadius: 25)
                                            .fill(Color("Secondary"))
                                            .frame(width: 150, height: 150)})
                                    Button(action: {
                                        signOut()
                                    }, label: {RoundedRectangle(cornerRadius: 25)
                                            .fill(Color("Secondary"))
                                            .frame(width: 150, height: 150)})
                                    
                                }
                                
                            }
                            Spacer()
                            VStack(alignment: .leading){
                                Text("AudioScape").foregroundColor(.gray)
                                    
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color("Tertiary"))
                                
                                
                                    .frame(width: 310,height: 150)
                            }
                            Spacer()
                        }
                        
                    }

                    
                }
                
                
            }
            
        }
    }
    func signOut() {
        
        do {
                try Auth.auth().signOut()
            } catch let error {
                print("Error signing out: \(error.localizedDescription)")
            }
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
