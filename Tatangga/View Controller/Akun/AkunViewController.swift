//
//  AkunViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 23/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

class AkunViewController: UIViewController {

     var userRecord = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let login = LoginVC()
        navigationController?.pushViewController(login, animated: true)
    }
    

    func authentication() {
        for index in 1...userRecord.count {
            let user = userRecord[index - 1]
            let email = user[RemoteUser.email] as! String
            let password = user[RemoteUser.password] as! String
            OperationQueue.main.addOperation {
                //                if (email == self.edtEmail.text && password == self.edtPassword.text) {
                // When Data Email & Password Input == Database data
                // Success
                //                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                    let viewCon = storyBoard.instantiateViewController(withIdentifier: "mainTabBar")
                //                    self.present(viewCon, animated: true, completion: nil)
                //                    UserDefaults.standard.set(true, forKey: "isLogin")
                //                    UserDefaults.standard.set(String(user.recordID.recordName), forKey: "recordNameUser")
                //                    let archivedData = NSMutableData()
                //                    do {
                //                        let archiver = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: true)
                //                        let userDefaults = UserDefaults.standard
                //                        userDefaults.set(archiver, forKey: "use rRecord")
                //                        userDefaults.synchronize()
                //                    } catch {
                //                        print(error)
                //                    }
                //                } else {
                // Error Login
                //                }
            }
        }
    }
}
