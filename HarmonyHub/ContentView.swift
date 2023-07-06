import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isUserLoggedIn = false

    var body: some View {
        Group {
            if (isUserLoggedIn) {
                // User is signed in.
                NavigationView {
                    HomepageView()
                }
            } else {
                // No user is signed in.
                NavigationView {
                    LoginSignView()
                }
            }
        }
        .onAppear(perform: refreshRootView)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("RefreshRootView"))) { _ in
            refreshRootView()
        }
    }

    func refreshRootView() {
        Auth.auth().currentUser?.reload(completion: { _ in
                    DispatchQueue.main.async {
                        isUserLoggedIn = Auth.auth().currentUser != nil
                    }
                })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
