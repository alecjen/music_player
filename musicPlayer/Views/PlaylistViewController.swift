//
//  PlaylistViewController.swift
//  musicPlayer
//
//  Created by Alec Jen on 9/11/15.
//  Copyright (c) 2015 Alec Jen. All rights reserved.
//

import Foundation
import UIKit

class PlaylistViewController: UITableViewController {
    
    @IBOutlet var songTableView: UITableView!
    
    var songs: [Song]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTableView.delegate = self
        songTableView.dataSource = self
    
        //songs = generateSongs()
        let data = Data()
        self.songs = data.loadSongs(didLoadSongs)
    }
    
    func didLoadSongs(songs: [Song]) {
        self.songs = songs
        songTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(myTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    override func tableView(myTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath) as SongCell
        var song: Song
        song = self.songs[indexPath.row]
        cell.titleLabel.text = song.title
        cell.artistLabel.text = song.artist
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSongDetailSegue" {
            if let destination = segue.destinationViewController as? ViewController {
                if let songIndex = tableView.indexPathForSelectedRow()?.row {
                    destination.trTitle = songs[songIndex].title
                    destination.songID = songs[songIndex].id
                    destination.artistName = songs[songIndex].artist
                }
            }
        }
    }
    
    
    @IBAction func unwindSecondView(segue: UIStoryboardSegue) {
        // Here to go back to playlist
    }
/*
    func generateSongs() -> [Song]{
        
        var songs = [Song]()
        var song = Song(title: "one man can change the world")
        songs.append(song)
        song = Song(title: "everybodyknows")
        songs.append(song)
        
        for id in 0...songs.count-1 {
            songs[id].id = id
        }
        
        return songs
    }
*/
}