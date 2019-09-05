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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                print(records)
                self.navigationController?.popViewController(animated: true)
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
