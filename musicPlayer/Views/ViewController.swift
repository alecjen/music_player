//
//  ViewController.swift
//  musicPlayer
//
//  Created by Alec Jen on 9/11/15.
//  Copyright (c) 2015 Alec Jen. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    // Track Name/ Time elapsed labels
    @IBOutlet var trackTitle: UILabel!
    @IBOutlet var playedTime: UILabel!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var timeProgress: UIProgressView!
    @IBOutlet var artistNameLabel: UILabel!
    
    var audioPlayer = AVPlayer()
    var audioItem = AVPlayerItem()
    var songID = Int()
    var isPlaying = false
    var timer:NSTimer!
    
    var trTitle = String()
    var artistName = String()
    
    @IBAction func changeVolume(sender: AnyObject) {
        audioPlayer.volume = volumeSlider.value
    }
    
    @IBAction func btnBack(sender: AnyObject) {
        isPlaying = false
        audioPlayer.pause()
    }
    
    // Play/Pause action and stop music action
    @IBAction func playOrPauseMusic(sender: AnyObject) {
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
        }
        else {
            audioPlayer.play()
            isPlaying = true
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func stopMusic(sender: AnyObject) {
        audioPlayer.pause()
        isPlaying = false
        audioPlayer.seekToTime(kCMTimeZero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trackTitle.text = trTitle
        artistNameLabel.text = artistName
        artistNameLabel.textColor = UIColor(white: 0.45, alpha: 1.0)
        
        var url = "http://localhost:8888/MusicPlayer/Songs/" + String(songID) + ".mp3"
        let pathURL = NSURL(string: url)
        audioItem = AVPlayerItem(URL: pathURL!)
        audioPlayer = AVPlayer(playerItem: audioItem)
        audioPlayer.seekToTime(kCMTimeZero)
        //var path = NSBundle.mainBundle().URLForResource(pathURL, withExtension: "mp3")
        var error:NSError?
        
        //audioPlayer = AVPlayer(URL: path!)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateTime() {
        var currentTime = (CMTimeGetSeconds(audioPlayer.currentTime()))
        var minutes = Int(currentTime / 60)
        var seconds = Int(currentTime) - (minutes * 60)
        playedTime.text = NSString(format: "%02d:%02d", minutes, seconds) as String
        
        timeProgress.progress = Float(currentTime) / Float((CMTimeGetSeconds((audioPlayer.currentItem.asset.duration))))
    }


}

