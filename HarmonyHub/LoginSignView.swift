import SwiftUI

struct LoginSignView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: SignUpView(),
                               label:{ Text("Sign Up")
                        .font(.title)
                        .frame(width: 100.0)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("Primary"))
                        .cornerRadius(10)})
                
                
                NavigationLink(destination: LoginView(),
                               label:{ Text("Login")
                        .font(.title)
                        .frame(width: 100.0)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("Primary"))
                        .cornerRadius(10)})
                
                Button(action: {
                    // Call the function to start Spotify authentication directly
                    SpotifyLoginController().startSpotifyAuthentication()
                }) {
                    Text("Spotify Login")
                        .font(.title)
                        .frame(width: 100.0)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("Primary"))
                        .cornerRadius(10)
                }
            }
            
            .padding()
        }
    }
}



struct LoginSignView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignView()
    }
}
