//
//  GroupListCell.swift
//  Tatangga
//
//  Created by Gabriella Gracia MT on 04/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class GroupListCell: UITableViewCell
{
    var btnDetail: (() ->  Void)? = nil
    
    let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lihat", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleDetail(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    var group: GroupList!
    
    var groupName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var groupMember: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, group: GroupList)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.group = group
        addSubview(groupName)
        //        groupName.frame = CGRect(x: groupMember.frame.maxX + 10, y: self.contentView.frame.height  /  2 - 15, width: self.contentView.frame.width - 5 - groupMember.frame.width - 10 - 10, height: 30)
        groupName.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 100, height: 20)
        groupName.text = group.groupName
        
        //        groupMember.frame = CGRect(x: groupName.frame.origin.x, y: groupName.frame.maxY, width: groupName.frame.width, height: 20)
        addSubview(groupMember)
        groupMember.anchor(top: groupName.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 100, width: 100, height: 20)
        groupMember.text = group.groupMember
        
        addSubview(detailButton)
        detailButton.anchor(top: nil, left: groupName.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 40)
        detailButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        detailButton.layer.cornerRadius  = 3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {

    }
    
    @objc func handleDetail(_ sender: UIButton)
    {
        print("Hilih")
    }
}
