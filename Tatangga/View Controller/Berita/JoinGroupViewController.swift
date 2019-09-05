//
//  JoinGroupViewController.swift
//  Tatangga
//
//  Created by Qiarra on 05/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

class JoinGroupViewController: UIViewController {
    
    @IBOutlet weak var tfUniqueID: UITextField!
    var group: CKRecord!
    var userData: CKRecord!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let recordName = UserDefaults.standard.string(forKey: "recordNameUser")
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
        
        guard recordName != nil else { return }
        let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName!))
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
        print(islogin)
        if islogin {
            if (recordName != nil) {
                CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryUser, inZoneWith: nil) {
                    record, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        guard let record = record else { return }
                        let data = record[0]
                        self.userData = record[0]
                        let dataGroup = data["Group"]
                        if dataGroup != nil {
                            print(data["Group"])
                        } else {
                            print("Not OK")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func btnSubmitGroup(_ sender: UIButton) {
        var uniqueID = tfUniqueID.text
        let groupPredicate = NSPredicate(format: "uniqueID = %@", uniqueID!)
        let groupQuery = CKQuery(recordType: "Group", predicate: groupPredicate)
        CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(groupQuery, inZoneWith: nil) {
            records, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                guard let records = records else {
                    return
                }
                self.group = records.first
                let reference = CKRecord.Reference(record: self.group, action: .none)
                let groups = [reference]
                self.userData["Group"] = groups as NSArray
                CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.save(self.userData) {
                    record, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        print("Success Join Group")
                    }
                }
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
