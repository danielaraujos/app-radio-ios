//
//  Noticia.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 25/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation


class Noticia {
    
    var id: String?
    var title: String?
    var date: String?
    //var conteudo: String?
    var imagem: String?
    
 
    let array = [String]()
    
     typealias JSONStandard = Dictionary<String, AnyObject>
    
    
    init(id: String, title:String, date:String,imagem:String){
        self.id = id;
        self.title = title;
        self.date = date;
        self.imagem = imagem;
    }
    
    init(array:[String: AnyObject]) {
        id = array["ID"] as? String
        title = array["title"] as? String
        date = array["date"] as? String
        //conteudo = array["text"] as? String
        imagem = array["image_url"] as? String
    }

    
}
