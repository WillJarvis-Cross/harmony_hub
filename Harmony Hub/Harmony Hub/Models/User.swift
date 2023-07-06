//
//  User.swift
//  Harmony Hub
//
//  Created by Will Jarvis-Cross on 2023-07-03.
//

import Foundation

struct User {
    var username: String
    var palette = "main"
    //Can add more colours in the future
    var allColours = {
        "main"; ["Primary", "PrimaryLight", "Secondary", "Tertiary"]
    }
    
}
