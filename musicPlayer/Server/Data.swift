//
//  Data.swift
//  musicPlayer
//
//  Created by Alec Jen on 9/12/15.
//  Copyright (c) 2015 Alec Jen. All rights reserved.
//

import Foundation

class Data {
    
    func loadSongs(completion: (([Song])-> Void)!) -> [Song] {
        
        var urlString = "http://localhost:8888/MusicPlayer/songs.php"
        
        let session = NSURLSession.sharedSession()
        let songsUrl = NSURL(string: urlString)
        
        var songs = [Song]()
        
        var task = session.dataTaskWithURL(songsUrl!) {
            (data, response, error) -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            }
            else {
                
                var error: NSError?
                
                var songsData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &error) as NSArray
                
                for song in songsData {
                    let song = Song(data: song as NSDictionary)
                    songs.append(song)
                }
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(songs)
                    }
                }
            }
        }
        task.resume()
        return songs
    }
}