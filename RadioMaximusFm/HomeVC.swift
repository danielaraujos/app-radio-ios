//
//  HomeVC.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 07/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Contacts
import ContactsUI
import MessageUI
import Alamofire
import Foundation

class HomeVC: BaseViewController,MFMailComposeViewControllerDelegate{
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var nomeMusica: UILabel!
    
    
    var iniciado = true;
    var cont = 0;
    
    var musicas = [Musica]();
    

    @IBOutlet weak var volume: MPVolumeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSlideMenuButton()
        
        
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            let image1:UIImage = UIImage(named: "2.fw")!
            let albumArt = MPMediaItemArtwork(image: image1)
            
            let songInfo = [
                MPMediaItemPropertyTitle: "Rádio Maximus FM",
                MPMediaItemPropertyArtist: "ZYT 569 - 101,5 Mhz",
                MPMediaItemPropertyArtwork: albumArt,
            ] as [String : Any]
            MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo
        }
        
        if(Connection.Instance.isConnectedToNetwork() == true){
            if(self.iniciado){
                self.playRadio()
                self.iniciado = false;
            }
            
        }else{
            self.showAlert(title: "Aconteceu algum problema", message: "Realize a conexão com a internet, para ouvir o áudio!")
            print("Sem conexao com a internet");
        }
    }


    
    
    override func viewDidAppear(_ animated: Bool) {
        
//        Alamofire.request(API.Instance.lerJson(sufix: "fm")).responseJSON { response in
//            if let jsonObject = response.result.value as? [String:Any]{
//                print("ESTOU AQUI")
//                self.nomeMusica.text = "\(jsonObject["song"]!)"
//                
//            }
//        }
                
        do{
            let audioSession = AVAudioSession.sharedInstance()
            try  audioSession.setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            print("Rodando Radio")
            
            
        }catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")
            self.showAlert(title: "Ops", message: "Aconteceu um erro de sessão! O Streaming que é requerido pelo app, não está sendo recebido!")
        }

    }
    

    
    @IBAction func eventPlay(_ sender: Any) {
        
        if(Connection.Instance.isConnectedToNetwork() == true){
            toggle()
        }else{
            self.showAlert(title: "Aconteceu algum problema", message: "Realize a conexão com a internet, para ouvir o áudio!")
            print("Sem conexao com a internet");
        }
    }
    
    
    
    func toggle(){
        if Radio.Instance.currentlyPlaying() {
            self.nomeMusica.text = "Seja bem vindo!"
            pauseRadio()
        } else {
            self.nomeMusica.text = "Você está ouvindo a Máximus Fm!"
            playRadio()
        }
    }
    
    func pauseRadio(){
        Radio.Instance.pause()
        btnPlay.setImage(#imageLiteral(resourceName: "play11"), for: UIControlState.normal)
    }
    
    func playRadio(){
        Radio.Instance.play()
        btnPlay.setImage(#imageLiteral(resourceName: "pause11"), for: UIControlState.normal)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    override func openUrl(url: String){
        let websiteAddress = NSURL(string: url)
        UIApplication.shared.openURL(websiteAddress! as URL)
    }
    
    
    @IBAction func what(_ sender: Any) {

        let number = "+553499379465"
        let urlWhats = "whatsapp://send?phone=\(number)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in
                            
                        })
                    } else {
                        self.openUrl(url: urlWhats)
                    }
                } else {
                    self.showAlert(title: "Ops!", message: "Instale o Whatsapp, para conseguir enviar mensagem!")
                }
            }
        }
        
    }
    
    @IBAction func btnCompartilhar(_ sender: Any) {
        let site = "Eu estou ouvindo Rádio Maxímus FM no aplicativo para iOS! Faça o Download do app : https://itunes.apple.com/us/app/radio-máximus-fm/id1236604952"
        //let site = "https://itunes.apple.com/us/app/hinário-novo-cantico/id1236604952"
        let activitiVC = UIActivityViewController(activityItems: [site], applicationActivities: nil)
        activitiVC.popoverPresentationController?.sourceView = self.view
        self.present(activitiVC, animated: true, completion: nil)
        
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["contato@paranaibamaximus.com.br"])
            //mail.setMessageBody("<p>Dispositivo: \(UIDevice.current.name)</p>", isHTML: true)
            mail.setSubject("Maxímus FM: ")
            
            present(mail, animated: true)
        } else {
            self.showAlert(title: "Ops.", message: "Ocorreu algum problema no envio. Tente novamente mais tarde!")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    
    
    @IBAction func btnEmail(_ sender: Any) {
        self.sendEmail()
    }
    
    @IBAction func website(_ sender: Any) {
        self.openUrl(url: "http://fm.paranaibamaximus.com.br")
    }
    
   }
