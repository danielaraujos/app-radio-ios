//
//  API.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 25/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class API{
    private static let _instance = API();
    
    static var Instance: API{
        return _instance;
    }
    
    func lerUrl (sufix:String)-> String{
        let url = "http://danielaraujos.com/radioparanaiba-wp/index.php?app=fm&info="
        return "\(url)\(sufix)"
    }
    
    
    func lerImagem (sufix:String)-> String{
        let url = "http://fm.paranaibamaximus.com.br/wp-content/uploads/"
        return "\(url)\(sufix)"
    }
    
    func lerJson (sufix:String)-> String{
       return "http://paranaibamaximus.com.br/streaming/musica-\(sufix)/cadena-noar.json"
       
    }
    
    
    
}
