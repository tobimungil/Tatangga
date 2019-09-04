//
//  NotificationCollectionViewCell.swift
//  Tatangga
//
//  Created by Adrian Suryo Abiyoga on 03/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class NotificationCollectionViewCell: UITableViewCell {
    
    //MARK: -properties
    
    let profileImageView: UIButton = {
        let iv = UIButton()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.setImage(#imageLiteral(resourceName: "dummy-avatar").withRenderingMode(.alwaysOriginal), for: .normal)
        return iv
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Sheryl ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "Memberikan Komentar di postingan anda ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        attributedText.append(NSAttributedString(string: "2d.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        label.numberOfLines = 2
        return label
    }()
    let lihatButton: UIButton = {
       let button = UIButton()
        button.setTitle("Lihat", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
       // button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(lihatButton)
        lihatButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 90, height: 30)
        lihatButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lihatButton.layer.cornerRadius = 3
        
        addSubview(notificationLabel)
        notificationLabel.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: lihatButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
         notificationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
