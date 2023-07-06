import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isRootViewLoaded = false

    var body: some View {
        Group {
            if (Auth.auth().currentUser != nil || isRootViewLoaded) {
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
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("RefreshRootView"))) { _ in
            refreshRootView()
        }
    }

    func refreshRootView() {
        // Perform refresh actions and update the state variable
        isRootViewLoaded.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
