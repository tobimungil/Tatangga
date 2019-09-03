//
//  SubmitViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 23/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit
import MapKit

class SubmitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var selectedKategori: String?
    var kategoriTypes = ["Sampah", "Keamanan", "Ketertiban", "Infrastruktur", "Personal", "Lain-lain"]
    var latitude: Double = 0
    var longitude: Double = 0
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var kategoriPicker: UITextField!
    @IBOutlet weak var lokasiTxt: UITextField!
    @IBOutlet weak var judulTxt: UITextField!
    @IBOutlet weak var descTxt: UITextView!
    @IBOutlet weak var btnPict: UIButton!
    
    var photoPreview: UIImage?
    var imageEncoded64: String?
    let documentsDirectoryPath:NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    var imageURL: URL!
    let tempImageName = "Image2.jpg"
    var userData: CKRecord!
    
    // It must be recordname from local data.
    let recordName = "B8A45061-7CAB-47AD-9491-17EC0B1B2CD3"
    let islogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descTxt.text = "Deskripsi"
        descTxt.textColor = UIColor.lightGray
        
        setupTxtField()
        textViewDidBeginEditing(descTxt)
        textViewDidEndEditing(descTxt)
        
        createPickerView()
        dismissPickerView()
        
        setImage()
        setLocation()
        
        // Do any additional setup after loading the view.
    }
    
    func setLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    func setImage() {
        if let imageEncoded64 = self.imageEncoded64 {
            let dataDecoded: NSData = NSData(base64Encoded: imageEncoded64, options: .ignoreUnknownCharacters)!
            let decodedImage = UIImage(data: dataDecoded as Data)
            let originalImage = decodedImage!.withRenderingMode(.alwaysOriginal)
            btnPict.setImage(originalImage, for: .normal)
            photoPreview = originalImage
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kategoriTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kategoriTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedKategori = kategoriTypes[row]
        kategoriPicker.text = selectedKategori
    }
    
    func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        kategoriPicker.inputView = pickerView
    }
    
    func dismissPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        kategoriPicker.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    //Setup Text View Attributes
    func setupTxtField(){
        self.descTxt.layer.borderColor = UIColor.lightGray.cgColor
        self.descTxt.layer.borderWidth = 0.5
        self.descTxt.layer.cornerRadius = 5
        self.descTxt.delegate = self
        self.lokasiTxt.delegate = self
    }

    @IBAction func btnAddPost(_ sender: UIButton) {
//        getUserData()
        let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName))
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
//        if islogin {
//            if (recordName != nil) {
                CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryUser, inZoneWith: nil) {
                    record, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        guard let record = record else { return }
                        self.userData = record[0]
                    }
                }
        
//            }
//        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewCon = storyBoard.instantiateViewController(withIdentifier: "main")
        
//        DispatchQueue.global(qos: .background).async {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                let reference = CKRecord.Reference(record: self.userData, action: .none)
                let record = CKRecord(recordType: RemoteRecords.post)
                let imageData: Data = ((self.photoPreview?.jpegData(compressionQuality: 1.0)!)!)
                let path: String = self.documentsDirectoryPath.appendingPathComponent(self.tempImageName)
                try? imageData.write(to: URL(fileURLWithPath: path), options: [.atomic])
                self.imageURL = URL(fileURLWithPath: path)
                let file :CKAsset? = CKAsset(fileURL: URL(fileURLWithPath: path))
                
                record[RemotePost.titlePost] = self.judulTxt.text! as NSString
                record[RemotePost.descriptionPost] = self.descTxt.text! as NSString
                record[RemotePost.photoPost] = file
                record[RemotePost.User] = reference
                record[RemotePost.category] = self.kategoriPicker.text! as NSString
                record[RemotePost.statusReport] = "Open" // Default
                record[RemotePost.latitude] = self.latitude
                record[RemotePost.longitude] = self.longitude
                record[RemotePost.thumbsUp] = 0
                
                CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.save(record) {
                    record, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        print("success")
                        DispatchQueue.main.async {
                            self.present(viewCon, animated: true, completion: nil)
                        }
                    }
                }
            }
    }
    
    func getUserData() {
        
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

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIViewController: UITextViewDelegate {
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}

extension SubmitViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue: CLLocationCoordinate2D = manager.location!.coordinate
        print("lat = \(locValue.latitude) , long = \(locValue.longitude) ")
        latitude = locValue.latitude
        longitude = locValue.longitude
    }
}
