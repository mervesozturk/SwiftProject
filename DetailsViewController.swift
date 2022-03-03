//
//  DetailsViewController.swift
//  CeyizListesi
//
//  Created by MacBook Pro on 28.02.2022.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var fiyatTextField: UITextField!
    @IBOutlet weak var kategoriTextField: UITextField!
    
    var tiklenenalinacaklar = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      isimTextField.text = tiklenenalinacaklar
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyikapat))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    @objc func klavyeyikapat() {
        view.endEditing(true)
    }
    @objc func gorselSec(){
       let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func kaydetButonTiklandi(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let ceyiz = NSEntityDescription.insertNewObject(forEntityName: "Ceyiz", into: context)
        ceyiz.setValue(isimTextField.text!, forKey: "isim")
        ceyiz.setValue(kategoriTextField, forKey: "kategori")
        
        if let fiyat = Int(fiyatTextField.text!){
            ceyiz.setValue(fiyat, forKey: "fiyat")
        }
        ceyiz.setValue(UUID(), forKey: "id")
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        ceyiz.setValue(data, forKey: "gorsel")
        do{
            try context.save()
            print("kayit edildi.")
        } catch {
            print("hata var")
        }
        
    }
}
