//
//  SobreVC.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 29/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import MessageUI

class SobreVC: BaseViewController ,MFMailComposeViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()

    }
    
    override func openUrl(url: String){
        let websiteAddress = NSURL(string: url)
        UIApplication.shared.openURL(websiteAddress! as URL)
    }
    
    
    //Avaliacao na apple store
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    
    
    //Enviar Opiniao
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["daniel.araujos@icloud.com"])
            mail.setMessageBody("<p>Dispositivo: \(UIDevice.current.name)</p>", isHTML: true)
            mail.setSubject("Opinião sobre o aplicativo Maxímus FM")
            
            present(mail, animated: true)
        } else {
            self.showAlert(title: "Ops.", message: "Ocorreu algum problema no envio. Tente novamente mais tarde!")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
    @IBAction func btn_face(_ sender: Any) {
        self.openUrl(url: "https://www.facebook.com/maximusfm101.5")
    }

    @IBAction func btn_twiter(_ sender: Any) {
        self.openUrl(url: "https://twitter.com/radiomaximusfm?ref_src=twsrc%5Etfw&ref_url=http%3A%2F%2Ffm.paranaibamaximus.com.br%2Fsobre-a-radio-paranaiba-maximus%2F")
    }
    
   
    @IBAction func btn_insta(_ sender: Any) {
        self.openUrl(url: "https://www.instagram.com/maximusfm101.5/")
    }
    @IBAction func btn_youtube(_ sender: Any) {
        self.openUrl(url: "https://www.youtube.com/user/paranaibamaximus")
    }
    @IBAction func btn_email(_ sender: Any) {
        self.sendEmail()
    }
    @IBAction func btn_avaliacao(_ sender: Any) {
        self.rateApp(appId: "id1236604952", completion: { (success) in
            print("RateApp \(success)")
        })
    }
}
