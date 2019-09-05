//
//  SignUpVC.swift
//  MiniChallange3
//
//  Created by Adrian Suryo Abiyoga on 23/08/19.
//  Copyright © 2019 Adrian Suryo Abiyoga. All rights reserved.
//

import UIKit
import CloudKit

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageSelected = false
    var imgURL: URL?
    
    let plusPhotoBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "camera").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
        return button
    }()
    let masukText: UILabel = {
        let label = UILabel()
        label.text = "Sudah Punya akun?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let fullNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nama Lengkap"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let statusTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Warga / Admin"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let alamatTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Alamat"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let confirmPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Konfirmasi Kata Sandi"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let signUp: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daftar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
        
    }()
    
    
    let signIn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Masuk", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(plusPhotoBtn)
        
        plusPhotoBtn.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        configureViewComponents()
        
        
        view.addSubview(signUp)
        signUp.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 549, paddingLeft: 107, paddingBottom: 0, paddingRight: 107, width: 200, height: 45)
        
        view.addSubview(signIn)
        signIn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 682, paddingLeft: 107, paddingBottom: 0, paddingRight: 107, width: 200, height: 45)
        
        view.addSubview(masukText)
        masukText.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 649, paddingLeft: 28, paddingBottom: 0, paddingRight: 28, width: 357, height: 27)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // selected image
        guard let profileImage = info[.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            imgURL = imageURL
        }
        
        // set imageSelected to true
        imageSelected = true
        
        // configure plusPhotoBtn with selected image
        plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        plusPhotoBtn.layer.masksToBounds = true
        plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
        plusPhotoBtn.layer.borderWidth = 2
        plusPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelectProfilePhoto(){
        //configure image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        //present image picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin(){
        _ = navigationController?.popViewController(animated: true)
//        let loginVC = LoginVC()
//        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func handleSignUp(){
        // properties
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let username = userNameTextField.text?.lowercased() else { return }
        guard let status = statusTextField.text?.lowercased() else { return }

        let recordUser = CKRecord(recordType: RemoteRecords.user)
        if let imgURL = imgURL {
            let assetImg: CKAsset = CKAsset(fileURL: imgURL)
            recordUser[RemoteUser.photoUser] = assetImg
        }
        recordUser[RemoteUser.status] = status
        recordUser[RemoteUser.email] = email
        recordUser[RemoteUser.fullName] = fullName
        recordUser[RemoteUser.password] = password
        recordUser[RemoteUser.username] = username

        
        CKContainer.init(identifier: RemoteURL.url).publicCloudDatabase.save(recordUser) {
            records, error in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
//        recordUser[RemoteUser.status] =
//        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
//
//            // handle error
//            if let error = error {
//                print("DEBUG: Failed to create user with error: ", error.localizedDescription)
//                return
//            }
//            //set profile img
//            guard let profileImg = self.plusPhotoBtn.imageView?.image else { return }
//            //upload data
//            guard let uploadData = profileImg.jpegData(compressionQuality: 0.3) else { return }
//
//            let filename = NSUUID().uuidString
//
//            // UPDATE: - In order to get download URL must add filename to storage ref like this
//            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
//
//            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
//
//                // handle error
//                if let error = error {
//                    print("Failed to upload image to Firebase Storage with error", error.localizedDescription)
//                    return
//                }
//
//                // UPDATE: - Firebase 5 must now retrieve download url
//                storageRef.downloadURL(completion: { (downloadURL, error) in
//                    guard let profileImageUrl = downloadURL?.absoluteString else {
//                        print("DEBUG: Profile image url is nil")
//                        return
//                    }
//
//                    // user id
//                    guard let uid = authResult?.user.uid else { return }
//                    //guard let fcmToken = Messaging.messaging().fcmToken else { return }
//
//                    let dictionaryValues = ["name": fullName,
//                                            //"fcmToken": fcmToken,
//                                            "username": username,
//                                            "profileImageUrl": profileImageUrl]
//
//                    let values = [uid: dictionaryValues]
//
//                    // save user info to database
//                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
//                        print("Succesfully created user and saved info to database")
//                        guard let mainTabVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else { return }
//
//
//                         //configure view controllers in maintabvc
//                        mainTabVC.configureViewControllers()
//                        //mainTabVC.isInitialLoad = true
//
//                        // dismiss login controller
//                        self.dismiss(animated: true, completion: nil)
//
//
//                    })
//                })
//            })
//        }
//        let masuk = BeritaViewController()
//        navigationController?.pushViewController(masuk, animated: true)
    }
    

    
    
    @objc func formValidation(){
        guard emailTextField.hasText, passwordTextField.hasText , fullNameTextField.hasText, userNameTextField.hasText, statusTextField.hasText,alamatTextField.hasText, confirmPasswordTextField.hasText else {
            signUp.isEnabled = false
            signUp.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            return
        }
        signUp.isEnabled = true
        signUp.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    
    func configureViewComponents(){
        let stackView = UIStackView(arrangedSubviews: [emailTextField,fullNameTextField,userNameTextField,statusTextField,alamatTextField,passwordTextField,confirmPasswordTextField])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution  = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 240)
    }
}
