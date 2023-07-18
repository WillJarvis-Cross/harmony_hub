//
//  SpotifyLogin.swift
//  HarmonyHub
//
//  Created by Will Jarvis-Cross on 2023-07-17.
//

import Foundation
import SafariServices

class SpotifyLoginController: UIViewController {
    let spotifyClientID = "cf94f90768674db19ade2b16283d031d"
    let redirectURI = "harmonyhub%3A%2F%2Fcallback"
    var spotifyAccessToken = "" // I think this should be unique for each user so this should be stored in user object
    
    
    @IBAction func spotifyLoginButtonTapped(_ sender: UIButton) {
        startSpotifyAuthentication()
    }
    
    func startSpotifyAuthentication() {
        print("fsfafsad")
        var authURLComponents = URLComponents(string: "https://accounts.spotify.com/authorize")
        authURLComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: spotifyClientID),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "scope", value: "user-read-private user-read-email") // Add any additional scopes here
        ]
        
        if let authURL = authURLComponents?.url {
            let safariViewController = SFSafariViewController(url: authURL)
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Error: Unable to construct the authentication URL.")
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "harmonyhub" {
            // Extract the access token from the URL and handle it
            handleSpotifyRedirect(url: url)
        }
        return true
    }
    
    func handleSpotifyRedirect(url: URL) {
        if let accessToken = extractAccessToken(from: url) {
            spotifyAccessToken = accessToken
            // Store the access token for use in your app
            // You can save it in UserDefaults or a secure storage method
        } else {
            // Handle error or display an error message to the user
        }
        
        // Dismiss the Safari View Controller after handling the redirect
        if let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
            presentedViewController.dismiss(animated: true, completion: nil)
        } else {
            print("Error: Could not find the presented view controller.")
        }
    }
    
    func extractAccessToken(from url: URL) -> String? {
        guard let fragment = url.fragment else { return nil }
        
        let parameters = fragment.components(separatedBy: "&")
        for parameter in parameters {
            let keyValue = parameter.components(separatedBy: "=")
            if keyValue.count == 2 && keyValue[0] == "access_token" {
                return keyValue[1]
            }
        }
        
        return nil
    }
    
    func fetchUserProfile() {
        guard let accessToken = getStoredAccessToken() else {
            // Handle the case when the access token is not available or has expired
            return
        }
        
        let url = URL(string: "https://api.spotify.com/v1/me")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle the response here
        }
        
        task.resume()
    }
    
    func getStoredAccessToken() -> String? { // this should be in user object
        return spotifyAccessToken
    }
}
