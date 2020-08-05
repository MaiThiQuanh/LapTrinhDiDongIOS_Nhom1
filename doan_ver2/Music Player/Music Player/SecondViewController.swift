//
//  SecondViewController.swift
//  Music Player
//
//  Created by TuongVy on 7/23/20.
//  Copyright © 2020 TuongVy. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    @IBOutlet weak var lbltheSong: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("thissong \(thisSong)")
        print("size \(songs.count)")
        //lbltheSong.text = songs[thisSong]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func play(_ sender: Any) {
        if audioStuffed == false && audioPlayer.isPlaying == false {
            audioPlayer.play()
        }
    }
    
    
    @IBAction func pause(_ sender: Any) {
        if audioStuffed == true && audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    
    @IBAction func prev(_ sender: Any) {
        if thisSong != 0 && audioStuffed == true {
            playThis(thisOne: songs[thisSong-1])
            thisSong -= 1
            lbltheSong.text = songs[thisSong]
        }
        else {
            print("Can not play the song!")
        }
    }
    
    
    @IBAction func next(_ sender: Any) {
        if thisSong < songs.count-1 && audioStuffed == true {
            playThis(thisOne: songs[thisSong+1])
            thisSong += 1
            lbltheSong.text = songs[thisSong]
        }
        else {
            print("Can not play the song!")
        }
    }
    
    func playThis(thisOne:String) {
        do {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        }
        catch {
            print("ERROR")
            
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        if audioStuffed == true {
            audioPlayer.volume = sender.value
        }
    }
    
    @IBAction func addVolume(_ sender: UIButton) {
        if audioStuffed == true {
            audioPlayer.volume += 1
            slider.value += 1
        }
    }
    
    @IBAction func replay(_ sender: Any) {
        audioPlayer.currentTime = 0
    }
    
}

