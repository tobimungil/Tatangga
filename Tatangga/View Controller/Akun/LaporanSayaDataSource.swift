//
//  LaporanSayaDataSource.swift
//  Tatangga
//
//  Created by Qiarra on 05/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

class LaporanSayaDataSource: NSObject {
    var data: [CKRecord] = []
    let cellLaporanID = "cellLaporanID"
    
    init(data: [CKRecord]) {
        self.data = data
    }
}

extension LaporanSayaDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = LaporanSayaCell()
        if (data.count > 0) && (indexPath.row > 0) {
            let dataPost = data[indexPath.row]
            print(dataPost[RemotePost.titlePost])
            cell = LaporanSayaCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellLaporanID)
            cell.reportTitle.text = dataPost[RemotePost.titlePost] as? String
            if let asset = dataPost[RemotePost.photoPost] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!) {
                cell.reportImg.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension LaporanSayaDataSource: UITableViewDelegate {
    
}
