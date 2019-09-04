//
//  LaporanSayaVC.swift
//  Tatangga
//
//  Created by Qiarra on 04/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

class LaporanSayaVC: UIViewController {
    
    let cellLaporanID = "cellLaporanID"
    var dataPost = [CKRecord]()
    var userData: CKRecord!
    
    var laporanTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        laporanTableView.frame = view.frame
        laporanTableView.delegate = self
        laporanTableView.dataSource = self
        laporanTableView.register(LaporanSayaCell.self, forCellReuseIdentifier: cellLaporanID)
    
        getDataPost()
        
    }
    
    func getDataPost() {
        let recordName = UserDefaults.standard.string(forKey: "recordNameUser")!
        let groupPredicate = NSPredicate(format: "User = %@", recordName)
        let query = CKQuery(recordType: RemoteRecords.post, predicate: groupPredicate)
        CKContainer.init(identifier: RemoteURL.url).publicCloudDatabase.perform(query, inZoneWith: nil) {
            records, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.dataPost = records!
                print(self.dataPost)
            }
        }
    }
}

extension LaporanSayaVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = dataPost[indexPath.row]
        let cell: LaporanSayaCell = LaporanSayaCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellLaporanID, data: data)
        cell.reportTitle.text = data[RemotePost.titlePost]! as String
        if let asset = data[RemotePost.photoPost] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!) {
            cell.reportImg.image = UIImage(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
