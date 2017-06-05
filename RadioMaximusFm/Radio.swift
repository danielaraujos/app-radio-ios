//
//  Radio.swift
//  Betel Music
//
//  Created by Daniel Araújo on 14/04/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation
import AVFoundation

class Radio {
    
    private static var _instance = Radio()
    static var Instance : Radio {
        return _instance
    }
    
    //AM
    //private var player = AVPlayer(url: NSURL(string: "http://srv01.brasilstream.com.br:2440/stream")! as URL)
    //FM
    private var player = AVPlayer(url: NSURL(string: "http://srv01.brasilstream.com.br:5440/stream")! as URL)

    
    
    private var isPlaying = false
    
    func play(){
        player.play()
        isPlaying = true
    }
    
    func pause(){
        player.pause()
        isPlaying = false
    }
    
    func toggle(){
        if isPlaying == true{
            pause()
        }else{
            play()
        }
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }

   
    
}
