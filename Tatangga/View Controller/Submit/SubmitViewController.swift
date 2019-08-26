//
//  SubmitViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 23/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var kategoriPicker: UITextField!
    @IBOutlet weak var lokasiTxt: UITextField!
    @IBOutlet weak var judulTxt: UITextField!
    @IBOutlet weak var descTxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        descTxt.text = "Deskripsi"
        descTxt.textColor = UIColor.lightGray
        
        setupTxtField()
        textViewDidBeginEditing(descTxt)
        textViewDidEndEditing(descTxt)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    //Setup Text View Attributes
    func setupTxtField(){
        self.descTxt.layer.borderColor = UIColor.lightGray.cgColor
        self.descTxt.layer.borderWidth = 0.5
        self.descTxt.layer.cornerRadius = 5
    }
    @IBAction func fotoBtn(_ sender: UIButton) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Deskripsi"
            textView.textColor = UIColor.lightGray
        }
    }
}
