//
//  HomepageView.swift
//  HarmonyHub
//
//  Created by Namashi Sivaram on 2023-07-03.
//

import SwiftUI
import Firebase
import CoreLocation
import FirebaseFirestore
import Geohash
struct HomepageView: View {
    var name:String = Auth.auth().currentUser!.displayName!
    var user = Auth.auth().currentUser
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var firestoreManager = FirestoreManager()
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
                                        queryGeo()
                                    }, label: {RoundedRectangle(cornerRadius: 25)
                                            .fill(Color("Secondary"))
                                        .frame(width: 150, height: 150)})
                                    
                                    Button(action: {
                                        queryGeo()
                                    }, label: {RoundedRectangle(cornerRadius: 25)
                                            .fill(Color("Secondary"))
                                        .frame(width: 150, height: 150)})
                                    
                                }
                                HStack{
                                    Button(action: {
                                        addUser()
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
    func addUser() {
        // Get the current user's UID from Firebase Authentication
        if let uid = Auth.auth().currentUser?.uid {
            // Get the current location from the LocationManager
            if let location = locationManager.lastKnownLocation {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                // Prepare the list of song names
                let songNames = ["song1", "song2", "song3"]
                
                // Call the FirestoreManager to add the user's data to Firestore
                firestoreManager.addUserData(uid: uid, latitude: latitude, longitude: longitude, songNames: songNames)
            } else {
                print("Error: Location data not available.")
            }
        } else {
            print("Error: User not logged in.")
        }
    }
    func queryGeo(){
        if let location = locationManager.lastKnownLocation {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            do{
                let queryGeohash = try Geohash.encode(latitude: latitude, longitude: longitude, precision: .custom(value: 8))
                let queryCollection = firestoreManager.db.collection("users")
                print(queryGeohash)
                // Perform the query
                queryCollection
                    .whereField("geohash", isGreaterThanOrEqualTo: queryGeohash)
                    .whereField("geohash", isLessThanOrEqualTo: queryGeohash + "~")
                    .getDocuments { (snapshot, error) in
                        if let error = error {
                            print("Error fetching documents: \(error)")
                            
                        }
                        else{
                            
                            print("WORKED BUT COME ONNNNN")
                            // Process the documents
                            for document in snapshot!.documents {
                                let data = document.data()
                                //let latitude = data["latitude"] as? Double ?? 0.0
                                //let longitude = data["longitude"] as? Double ?? 0.0
                                print(data)
                                print("FDFFD")
                                // Handle the data as needed...
                            }
                        }
                    }
            }
            catch{
                print("GEOLOC ERROR")
            }
            
            
        }
        else{
            print("NOooooOOOOOOO")
        }
    }

            
        
    
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
