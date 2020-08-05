//
//  FirstViewController.swift
//  Music Player
//
//  Created by TuongVy on 7/23/20.
//  Copyright © 2020 TuongVy. All rights reserved.
//

import UIKit
import AVFoundation

var songs:[String] = []
var audioPlayer = AVAudioPlayer()
var thisSong = 0
var audioStuffed = false

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            audioStuffed = true
        }
        catch {
            print("ERROR")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gettingSongName()
    }
    
    func gettingSongName() {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        print("url \(folderURL)")
        
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for song in songPath{
                var mySong = song.absoluteString
                if mySong.contains(".mp3") {
                   let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                }
            }
            myTableView.reloadData()
        }
        catch{
            
        }
    }

}

