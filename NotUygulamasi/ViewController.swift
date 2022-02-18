//
//  ViewController.swift
//  NotUygulamasi
//
//  Created by Berat Yavuz on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var notTableView: UITableView!
    var notlarListesi=[Notlar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veritabaniKopyala()

        
        notTableView.delegate=self
        notTableView.dataSource=self
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        notlarListesi=Notlardao().tumNotlarAl()
        var toplam = 0
        for n in notlarListesi{
            toplam = toplam+(n.not1!+n.not2!)/2
        }
        if notlarListesi.count != 0 {
            navigationItem.prompt = "Ortalama: \(toplam / notlarListesi.count)"
        }
        else{
            navigationItem.prompt = "Ortalama : Yok"
        }
        notTableView.reloadData()
        notTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
    
        if segue.identifier == "toNotDetay"{
            
            let gidilecekVC = segue.destination as! NotDetayViewController
            gidilecekVC.not = notlarListesi[indeks!]
        }
    }
    func veritabaniKopyala(){
           
           let bundleYolu = Bundle.main.path(forResource: "notlar", ofType: ".sqlite")
           
           let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
           
           let fileManager = FileManager.default
           
           let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
           
           if fileManager.fileExists(atPath: kopyalanacakYer.path) {
               print("Veritabanı zaten var.Kopyalamaya gerek yok")
           }else{
               do {
                   
                   try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                   
               }catch{
                   print(error)
               }
           }
       }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListesi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let not = notlarListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "notHucre",for: indexPath) as! NotHucreTableViewCell
    
        cell.labelDersAdi.text=not.ders_adi
        cell.labelNot1.text=String(not.not1!)
        cell.labelNot2.text=String(not.not2!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toNotDetay", sender: indexPath.row)
    }
}
