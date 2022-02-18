//
//  NotDetayViewController.swift
//  NotUygulamasi
//
//  Created by Berat Yavuz on 15.02.2022.
//

import UIKit

class NotDetayViewController: UIViewController {

    @IBOutlet weak var textfieldDersAdi: UITextField!
    @IBOutlet weak var textfieldNot1: UITextField!
    @IBOutlet weak var textFieldNot2: UITextField!
    var not:Notlar?
    
    override func viewDidLoad() {
        //gelen deger bos değilse
        if let n = not{
            
            textfieldDersAdi.text = n.ders_adi
            textfieldNot1.text = String(n.not1!)
            textFieldNot2.text = String(n.not2!)

            
        }
        
        super.viewDidLoad()

        
    }
    
    @IBAction func notSil(_ sender: Any) {
        if let n = not{
            Notlardao().notSil(not_id: n.not_id!)
        }
    }
    
    
    @IBAction func notGuncelle(_ sender: Any) {
        if let n = not,let ad = textfieldDersAdi.text,let not1 = textfieldNot1.text,let not2 = textFieldNot2.text{
            
            if let n1=Int(not1), let n2 = Int(not2){
                Notlardao().notGuncelle(not_id: n.not_id!, ders_adi: ad, not1: n1, not2: n2)
            }
            
            
        }
    
    }
}
