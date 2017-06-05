//
//  MoreVC.swift
//  RadioMaximusFm
//
//  Created by Daniel Araújo on 07/05/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import MessageUI
//import SVProgressHUD

class MoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    
    var mais : [Mais] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var more: Mais;
        more = Mais(id: 1, name: "Acesse nosso site", image: #imageLiteral(resourceName: "avaliacao"))
        mais.append(more)
        more = Mais(id: 2, name: "Baixe Paranaíba AM", image: #imageLiteral(resourceName: "avaliacao"))
        mais.append(more)
        more = Mais(id: 3, name: "Nos envie sua opinião", image: #imageLiteral(resourceName: "opniao"))
        mais.append(more)
        more = Mais(id: 4, name: "Nos avalie na App Store", image: #imageLiteral(resourceName: "avaliacao"))
        mais.append(more)
        more = Mais(id: 5, name: "Compartilhar a Rádio", image: #imageLiteral(resourceName: "compartilhar"))
        mais.append(more)

    }
    @IBOutlet weak var tableView: UITableView!

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mais.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let more: Mais = mais[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MaisCelula
        cell.imageMais.image = more.image
        cell.titulo.text = more.name
        return cell;
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
    
    func openUrl(url: String){
        let websiteAddress = NSURL(string: url)
        UIApplication.shared.openURL(websiteAddress! as URL)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let maisSelecionados = self.mais[indexPath.row]
        
        if maisSelecionados.id == 1 {
            self.openUrl(url: "http://www.paranaibamaximus.com.br")
        }else if maisSelecionados.id == 2 {
            
        }else if maisSelecionados.id == 3{
            //Opniao
            self.sendEmail()
            
        }else  if maisSelecionados.id == 4{
            //Aviar
            self.rateApp(appId: "1236604952", completion: { (success) in
                print("RateApp \(success)")
            })
            
        }else if maisSelecionados.id == 5 {
            //Compartilhar
            
            let site = "https://itunes.apple.com/"
            //let site = "https://itunes.apple.com/us/app/hinário-novo-cantico/id1236604952"
            let activitiVC = UIActivityViewController(activityItems: [site], applicationActivities: nil)
            activitiVC.popoverPresentationController?.sourceView = self.view
            self.present(activitiVC, animated: true, completion: nil)
        } else if maisSelecionados.id == 6 {
            
        }
    }
    
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }



}
