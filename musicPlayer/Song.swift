//
//  Song.swift
//  musicPlayer
//
//  Created by Alec Jen on 9/11/15.
//  Copyright (c) 2015 Alec Jen. All rights reserved.
//

import Foundation

class Song {
    
    var title: String!
    var artist: String!
    var id: Int!
    
    init(data: NSDictionary) {
        self.title = getStringFromJSON(data, key: "title")
        self.artist = getStringFromJSON(data, key: "artist")
        self.id = data["id"] as Int
    }
    
    func getStringFromJSON(data: NSDictionary, key: String) -> String {
        
        if let info = data[key] as? String {
            return info
        }
        return ""
    }

}