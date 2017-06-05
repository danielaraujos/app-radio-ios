//
//  Musica.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 31/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Musica {
    
    var artist: String?
    var song: String?
    
    
    let array = [String]()
    
    typealias JSONStandard = Dictionary<String, AnyObject>
    
    
    init(artist: String, song:String){
        self.song = song;
        self.artist = artist;
    }
    
    init(array:[String: AnyObject]) {
        song = array["song"] as? String
        artist = array["artist"] as? String
    }
    
    
}
