//
//  ViewController.swift
//  CeyizListesi
//
//  Created by MacBook Pro on 28.02.2022.
//


import UIKit
import CoreData



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBAction func BarButtonItem(_ sender: UIBarButtonItem) {
    }
    @IBOutlet weak var tableView: UITableView!
   var alinacaklar = [String]()
    var secilenAlinacaklar = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        alinacaklar.append("Buzdolabı")
        alinacaklar.append("Çamaşır Makinası")
        alinacaklar.append("Bulaşık Makinası")
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(eklemeButtonuTiklandi))
    }

    
    
    @objc func eklemeButtonuTiklandi(){
        performSegue(withIdentifier:"toDetailsVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alinacaklar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.textLabel?.text = alinacaklar[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secilenAlinacaklar = alinacaklar[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.tiklenenalinacaklar = secilenAlinacaklar
            
        }
    }
}

