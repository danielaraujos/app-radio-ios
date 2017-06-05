//
//  NoticiasVC.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 09/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD

class NoticiasVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var noticias = [Noticia]();
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NoticiasVC.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSlideMenuButton()
        
//        if(Connection.Instance.isConnectedToNetwork()){
//            SVProgressHUD.show(withStatus: "Carregando")
//            self.CallAlomo(url: API.Instance.lerUrl(sufix: "noticias"));
//        }else{
//            self.showAlert(title: "Aconteceu algum problema", message: "Realize a conexão com a internet, para receber os dados")
//        }
        
        self.tableView.addSubview(self.refreshControl)
    

        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(Connection.Instance.isConnectedToNetwork()){
            SVProgressHUD.show(withStatus: "Carregando")
            self.CallAlomo(url: API.Instance.lerUrl(sufix: "noticias"));
        }else{
            self.showAlert(title: "Aconteceu algum problema", message: "Realize a conexão com a internet, para receber os dados")
        }

    }
    
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        noticias = [];
        self.CallAlomo(url: API.Instance.lerUrl(sufix: "noticias"));
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            print(response.data!)
            self.parseData(JSONData: response.data!)
        });
        
    }
    
    func parseData(JSONData: Data){
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.mutableContainers)
            let buildingDictionaries = json as! [[String:AnyObject]]
            for buildingDictionary in buildingDictionaries{
                let newBuilding = Noticia(array: buildingDictionary)
                self.noticias.append(newBuilding)
            }
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
            
        } catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")

        }
        
        
    }
    
    
    override func openUrl(url: String){
        let websiteAddress = NSURL(string: url)
        UIApplication.shared.openURL(websiteAddress! as URL)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count;
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let b = self.buildings[indexPath.row]
//        let celula = tableView.dequeueReusableCell(withIdentifier: "CellBuilding", for: indexPath) as! BuildingCelula
//        
//        
//        Alamofire.request(UrlProvider.Instance.letImage(sufix:"\(b.dir!)\(b.image!)")).responseImage { response in
//            if let image = response.result.value {
//                celula.imageBuilding.image = image
//            }
//        }
//
//        celula.lblTitle.text = b.name;
//        celula.lblSubTitle.text = b.sub_name
//        return celula;
//        
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let b = self.noticias[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CelulaNoticia
        
        
        Alamofire.request(API.Instance.lerImagem(sufix:"\(b.imagem!)")).responseImage { response in
            if let image = response.result.value {
                cell.imagemCelula.image = image
            }
        }
        //print(API.Instance.lerImagem(sufix:"\(b.imagem!)"))
        
        
        cell.tituloCelula.text = b.title;
        //print(noticias[indexPath.row].id!)
        //print(noticias[indexPath.row].title!)
        //cell.imagemCelula.image = noticias[indexPath.row].imagem as! UIImageView;
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let buildingSelect = self.noticias[indexPath.row].id!
        self.openUrl(url: "http://fm.paranaibamaximus.com.br/?p=\(buildingSelect)" )

        //self.openUrl(url: API.Instance.lerUrl(sufix: )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //if segue.identifier == "SegueDetalhe"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let buildingSelect = self.noticias[indexPath.row].id!
                self.openUrl(url: "http://fm.paranaibamaximus.com.br/p=?\(buildingSelect)" )
            }
        //}
    }

    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
    


}
