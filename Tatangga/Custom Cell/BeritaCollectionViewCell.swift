//
//  BeritaCollectionViewCell.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 24/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class BeritaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgPostProfile: UIImageView!
    @IBOutlet weak var lblPostTitleUser: UILabel!
    @IBOutlet weak var lblPostStatusUser: UILabel!
    @IBOutlet weak var lblDatePost: UILabel!
    @IBOutlet weak var lblThumbsUpCount: UILabel!
    @IBOutlet weak var imgStatusReport: UIImageView!
    @IBOutlet weak var lblPostTitle: UILabel!
    @IBOutlet weak var lblPostDescription: UILabel!
    
    var actionClick: (() -> Void)? = nil
    var diskusiClick: (() -> Void)? = nil
    
    @IBAction func btnLike(_ sender: UIButton) {
        actionClick?()
    }
    
    @IBAction func btnDiskusi(_ sender: UIButton) {
        diskusiClick?()
    }
}
