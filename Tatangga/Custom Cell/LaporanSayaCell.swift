//
//  LaporanSayaCell.swift
//  Tatangga
//
//  Created by Qiarra on 04/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

class LaporanSayaCell: UITableViewCell {
    
    var data: CKRecord!
    
    var reportImg : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "dummy-berita")
        return img
    }()
    
    var reportTitle : UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    var commentResponLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "2 respon"
        return lbl
    }()
    
    var seeResponLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "4 dilihat"
        return lbl
    }()
    
    var commentImg : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "comment")
        return img
    }()
    
    var seeReportImg : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "mata")
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
//        reportImg.frame = CGRect(x: 5, y: 0, width: self.contentView.frame.height, height: self.contentView.frame.height)
//        reportImg.image = data[RemotePost.photoPost] as? UIImage
//        reportImg.contentMode = .scaleAspectFill
//        reportTitle.text = data[RemotePost.titlePost]! as String
//        commentImg.image = data[RemotePost.photoPost] as? UIImage
//        seeReportImg.image = data[RemotePost.photoPost] as? UIImage
        addSubview(reportImg)
        addSubview(commentImg)
        addSubview(seeReportImg)
        addSubview(reportTitle)
        addSubview(commentResponLbl)
        addSubview(seeResponLbl)
        
        reportImg.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 108, height: 72)
        reportTitle.anchor(top: topAnchor, left: reportImg.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 15, paddingBottom: 0, paddingRight: 30, width: 194, height: 21)
        commentImg.anchor(top: reportTitle.bottomAnchor, left: reportImg.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 30, width: 16, height: 14)
        seeReportImg.anchor(top: commentImg.bottomAnchor, left: reportImg.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 30, width: 16, height: 14)
        commentResponLbl.anchor(top: reportTitle.bottomAnchor, left: commentImg.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 75, height: 21)
        seeResponLbl.anchor(top: commentImg.bottomAnchor, left: seeReportImg.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 75, height: 21)
        
    }
}

