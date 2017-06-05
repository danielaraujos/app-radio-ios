//
//  NoticiaDetalheVC.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 25/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class NoticiaDetalheVC: UIViewController {

    var dados: Noticia!
    var conteudo: String?
    var novo = [Noticia]()
    
    @IBOutlet weak var web: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = dados.title!;

        
        if(Connection.Instance.isConnectedToNetwork()){
            SVProgressHUD.show(withStatus: "Carregando")
            //self.CallAlomo(url: API.Instance.lerUrl(sufix: "noticia&id=\(dados.id!)"))
            
            Alamofire.request(API.Instance.lerUrl(sufix: "noticia&id=\(dados.id!)")).responseJSON { response in
                
                
                if let jsonObject = response.result.value {
                    //print(jsonObject["post_content"]!)
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data
                        
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        // here "decoded" is of type `Any`, decoded from JSON data
                        
                        // you can now cast it with the right type
                        if let dictFromJSON = decoded as? [String:String] {
                            print(dictFromJSON)
                            self.conteudo = dictFromJSON["post_content"];
                            //print(self.conteudo!)
                            self.web.loadHTMLString(self.conteudo!, baseURL: nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
            
            
            
            
            
            SVProgressHUD.dismiss()
            
            
            
            
        }else{
            self.showAlert(title: "Aconteceu algum problema", message: "Realize a conexão com a internet, para receber os dados")
        }

        
        
        //print(API.Instance.lerUrl(sufix: "noticia&id=\(dados.id!)"))
        
        ///web.loadHTMLString(self.conteudo!, baseURL: nil)
       
    
        
    }
    
    
    
    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON { response in
            
            
            if let jsonObject = response.result.value {
                //print(jsonObject["post_content"]!)
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    // here "decoded" is of type `Any`, decoded from JSON data
                    
                    // you can now cast it with the right type
                    if let dictFromJSON = decoded as? [String:String] {
                        //print(dictFromJSON["post_content"])
                        self.conteudo = dictFromJSON["post_content"];
                        print(self.conteudo!)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        
        SVProgressHUD.dismiss()

        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
}
