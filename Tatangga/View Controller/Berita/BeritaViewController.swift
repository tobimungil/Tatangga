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
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var btnGrouJoin: UIButton!
    @IBOutlet weak var lblGroup: UILabel!
    
    let refreshControl = UIRefreshControl()
    var userData: CKRecord!
    var userPostData = [CKRecord]()
    var postRecordData = [CKRecord]()

    var key: String?
    
    //  Casue Account Authentication not ready yet => isLogin Manually
    
    override func viewDidAppear(_ animated: Bool) {
        btnGrouJoin.isHidden = true
        lblGroup.isHidden = true
        getData()
    }
    
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
        beritaCollection.prefetchDataSource = self
        beritaNavbar()
        refreshControl.layer.zPosition = -1
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        beritaCollection?.refreshControl = refreshControl
    }
    
    @objc func pullToRefresh() {
        self.postRecordData.removeAll()
        getData()
        beritaCollection.reloadData()
        refreshControl.endRefreshing()
    }
    
    func getData() {
        indicatorLoading.isHidden = false
        indicatorLoading.startAnimating()
        beritaCollection.isHidden = true
        
        // CHECK GROUP USER
        let recordName = UserDefaults.standard.string(forKey: "recordNameUser")
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
        guard recordName != nil else { return }
        let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName!))
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
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
                            UserDefaults.standard.set(true, forKey: "groupAvailable")
                            self.getDataPost()
                        } else {
                            UserDefaults.standard.set(false, forKey: "groupAvailable")
                            DispatchQueue.main.async {
                                self.beritaCollection.isHidden = true
                                self.btnGrouJoin.isHidden = false
                                self.lblGroup.isHidden = false
                                self.indicatorLoading.isHidden = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getDataPost() {
        // GET POST DATA
        let predicate = NSPredicate(value: true)
        let queryPost = CKQuery(recordType: RemoteRecords.post, predicate: predicate)
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
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
        } else {
            postRecordData.removeAll()
            beritaCollection.isHidden = false
            beritaCollection.reloadData()
        }
    }
    
    func getDataUser(_ recordName: String) {
        let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName))
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
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
                            self.beritaCollection.isHidden = false
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
    
    func updateLike(_ data: CKRecord, thumbsUp: Int) {
        let thumbs = Double(thumbsUp)
        data[RemotePost.thumbsUp] = thumbs as Double
        CKContainer.init(identifier: RemoteURL.url).publicCloudDatabase.save(data) {
        record, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Like berhasil update")
            }
        }
    }

}

//Code buat Collection View
extension BeritaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemCount: Int?
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
        if islogin {
            itemCount = self.postRecordData.count
        } else {
            itemCount = 3
        }
        return itemCount!
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.indicatorLoading.isHidden = true
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: beritaCollectionViewCell, for: indexPath) as! BeritaCollectionViewCell
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
        if islogin {
//            if guard let postRecordData = postRecordData {
//                
//            }
            print(postRecordData)
            let dataPost = postRecordData[indexPath.row]
            if userPostData.count > 0 && indexPath.row < userPostData.count {
                let dataUserPost = userPostData[indexPath.row]
                cell.lblPostTitleUser.text = dataUserPost[RemoteUser.fullName]
                cell.lblPostStatusUser.text = dataUserPost[RemoteUser.status]
                if let asset = userData[RemoteUser.photoUser] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!) {
                    cell.imgPostProfile.image = UIImage(data: data)
                }
            }
            cell.lblPostStatusUser.text = dataPost[RemotePost.statusReport]
            cell.lblPostTitle.text = dataPost[RemotePost.titlePost]
            cell.lblPostDescription.text = dataPost[RemotePost.descriptionPost]
            if dataPost[RemotePost.thumbsUp]! == 0 && dataPost[RemotePost.thumbsUp]! == 1 {
                 cell.lblThumbsUpCount.text = "\(dataPost[RemotePost.thumbsUp]!) like"
            } else {
                cell.lblThumbsUpCount.text = "\(dataPost[RemotePost.thumbsUp]!) likes"
            }
            
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
        cell.actionClick = {
            let dataPost = self.postRecordData[indexPath.row]
            var thumbsUp: Int = dataPost[RemotePost.thumbsUp]! as Int
            thumbsUp += 1
            cell.lblThumbsUpCount.text = "\(thumbsUp) likes"
            self.updateLike(dataPost, thumbsUp: thumbsUp as Int)
        }
        return cell
    }
}
