//
//  BeritaViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 21/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

let beritaCollectionViewCell = "BeritaCollectionViewCell"

class BeritaViewController: UIViewController {

    @IBOutlet weak var beritaCollection: UICollectionView!
    var userData: CKRecord!
    var userPostData = [CKRecord]()
    var postRecordData = [CKRecord]()
    let recordName = UserDefaults.standard.string(forKey: "recordNameUser")
    var key: String?
    
    //  Casue Account Authentication not ready yet => isLogin Manually
    
//    let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
    let islogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Custom Berita Cell
        setView()
        getData()
    }
    
    func setView() {
        let nibCell = UINib(nibName: beritaCollectionViewCell, bundle: nil)
        beritaCollection.register(nibCell, forCellWithReuseIdentifier: beritaCollectionViewCell)
        beritaCollection.dataSource = self
        beritaNavbar()
    }
    
    func getData() {
        
        // GET POST DATA
        let predicate = NSPredicate(value: true)
        let queryPost = CKQuery(recordType: RemoteRecords.post, predicate: predicate)
        if islogin {
            CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryPost, inZoneWith: nil) {
                records, error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    guard let records = records else { return }
                    for record in records {
                        self.postRecordData.append(record)
                        let user = record.object(forKey: "User") as! CKRecord.Reference
                        self.key = user.recordID.recordName
                        OperationQueue.main.addOperation {
                            self.getDataUser(self.key!)
                            print(self.key)
                        }
                    }
                }
            }
        }
        
        
        // CHECK GROUP USER
        
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
//                            print(data["Group"])
                        } else {
                            print("Not OK")
                        }
                    }
                }
            }
        }
    }
    
    func getDataUser(_ recordName: String) {
        let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName))
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
        print(islogin)
        if islogin {
//            if (recordName != nil) {
                CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryUser, inZoneWith: nil) {
                    record, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        guard let record = record else { return }
                        self.userPostData.append(record.first!)
                        DispatchQueue.main.async {
                            self.beritaCollection.reloadData()
                        }
                        print(record)
                    }
                }
//            }
        }
    }
    
    // Setup Custom Berita Navigation Bar Title
    func beritaNavbar(){
        let beritaLabel = UILabel()
        beritaLabel.text = "Berita Sekitar"
        beritaLabel.font = UIFont(name: "SF-Pro-Rounded-Bold", size: 23)
        beritaLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: beritaLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
    }

}

//Code buat Collection View
extension BeritaViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemCount: Int?
        if islogin {
            itemCount = self.postRecordData.count
        } else {
            itemCount = 3
        }
        return itemCount!
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: beritaCollectionViewCell, for: indexPath) as! BeritaCollectionViewCell
        if islogin {
            let dataPost = postRecordData[indexPath.row]
            if userPostData.count > 0 && indexPath.row < userPostData.count {
                let dataUserPost = userPostData[indexPath.row]
                cell.lblPostTitleUser.text = dataUserPost[RemoteUser.fullName]
                cell.lblPostStatusUser.text = dataUserPost[RemoteUser.status]
            }
            cell.lblPostStatusUser.text = dataPost[RemotePost.statusReport]
            cell.lblPostTitle.text = dataPost[RemotePost.titlePost]
            cell.lblPostDescription.text = dataPost[RemotePost.descriptionPost]
            
            
            if let asset = dataPost[RemotePost.photoPost] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!) {
                cell.imgPost.image = UIImage(data: data)
            }
            cell.lblDatePost.text = dateFormatter(date: dataPost.modificationDate!)
        } else {
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.5
        }
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
}
