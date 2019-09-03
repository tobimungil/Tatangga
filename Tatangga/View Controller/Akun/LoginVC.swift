//
//  LoginVC.swift
//  MiniChallange3
//
//  Created by Adrian Suryo Abiyoga on 23/08/19.
//  Copyright © 2019 Adrian Suryo Abiyoga. All rights reserved.
//

import UIKit
import CloudKit

class LoginVC: UIViewController {
    
    var userRecord = [CKRecord]()
    
    let masukText: UILabel = {
        let label = UILabel()
        label.text = "Masuk untuk mengakses semua fitur"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    let daftarText: UILabel = {
        let label = UILabel()
        label.text = "Belum Punya akun?"
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
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Kata Sandi"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Masuk", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let signUpBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daftar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        
        return button
    }()
    
    let aksesSemuaFiturLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color
        view.backgroundColor = .white
        
        // hide nav bar
        navigationController?.navigationBar.isHidden = true
        // disable specific tabbar = akun tabbar
        if tabBarController?.selectedIndex == 5 {
            tabBarController?.tabBar.isUserInteractionEnabled
        }
        
        //configureViewComponents()
        
        view.addSubview(masukText)
        masukText.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 333, paddingLeft: 28, paddingBottom: 0, paddingRight: 28, width: 357, height: 27)
        
        view.addSubview(daftarText)
        daftarText.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 649, paddingLeft: 28, paddingBottom: 0, paddingRight: 28, width: 357, height: 27)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 549, paddingLeft: 107, paddingBottom: 0, paddingRight: 107, width: 200, height: 45)
        
        view.addSubview(signUpBtn)
        signUpBtn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 682, paddingLeft: 107, paddingBottom: 0, paddingRight: 107, width: 200, height: 45)
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 379, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 350, height: 45)
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 464, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 350, height: 45)
        if (navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
       
        
    }
    @objc func handleShowSignUp(){
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleLogin(){
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: NSPredicate(value: true))
        CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryUser, inZoneWith: nil) {
            records, error in
            guard let records = records else { return }
            for record in records {
                self.userRecord.append(record)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.authentication(record)
                }
            }
        }
        
        
//        // properties
//        guard
//            let email = emailTextField.text,
//            let password = passwordTextField.text else { return }
//        
//        // sign user in with email and password
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//            
//            // handle error
//            if let error = error {
//                print("Unable to sign user in with error", error.localizedDescription)
//                return
//            }
//            
//            //handle success
//            print("Successfully signed user in")
            
//            guard let mainTabVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else { return }
//
//            mainTabVC.configureViewControllers()
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    // Cek apakah ada data yang sama antara password dan email inputan dari user
    
    func authentication(_ record: CKRecord) {
//        for index in 1...userRecord.count {
//            let user = userRecord[index - 1]
            let email = record[RemoteUser.email] as! String
            let password = record[RemoteUser.password] as! String
            OperationQueue.main.addOperation {
                if (email == self.emailTextField.text && password == self.passwordTextField.text) {
                    print("Berhasil Login")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    UserDefaults.standard.set(String(record.recordID.recordName), forKey: "recordNameUser")
                    let masuk = AkunViewController()
                    if self.navigationController != masuk {
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                } else {
                    print("WKWKWKW LO BGST")
                }
            }
            print(index)
//        }
    }

    
    @objc func formValidation(){
        
        // ensures that email and password text fields have text
        guard
            emailTextField.hasText,
            passwordTextField.hasText else {
                
                // handle case for above conditions not met
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                return
        }
        
        // handle case for conditions were met
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    func configureViewComponents(){
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])

        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution  = .fillEqually

        view.addSubview(stackView)
    }


}
