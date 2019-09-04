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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        groupName.frame = CGRect(x: groupMember.frame.maxX + 10, y: self.contentView.frame.height  /  2 - 15, width: self.contentView.frame.width - 5 - groupMember.frame.width - 10 - 10, height: 30)
        groupName.text = group.groupName
        self.contentView.addSubview(groupName)
        
        groupMember.frame = CGRect(x: groupName.frame.origin.x, y: groupName.frame.maxY, width: groupName.frame.width, height: 20)
        groupMember.text = group.groupMember
        self.contentView.addSubview(groupMember)
    }

}
