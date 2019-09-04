//
//  ContactListTableViewCell.swift
//  Tatangga
//
//  Created by Gabriella Gracia MT on 04/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var contact: ContactList!
    
    var contactProfile: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var contactName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFCompactDisplay", size: 25)
        return label
    }()
    
    var contactStatus: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = UIFont(name: "SFCompactDisplay", size: 5)
        return label
    }()
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, contact: ContactList)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contact = contact
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        contactProfile.frame = CGRect(x: 5, y: 0, width: self.contentView.frame.height, height: self.contentView.frame.height)
        contactProfile.image = contact.contactProfile
        contactProfile.contentMode = .scaleAspectFill
        contactProfile.layer.cornerRadius = contactProfile.frame.width / 2
        contactProfile.layer.masksToBounds = true
        self.contentView.addSubview(contactProfile)
        
        contactName.frame = CGRect(x: contactProfile.frame.maxX + 10, y: self.contentView.frame.height  /  2 - 15, width: self.contentView.frame.width - 5 - contactProfile.frame.width - 10 - 10, height: 30)
        contactName.text = contact.contactName
        self.contentView.addSubview(contactName)
        
        contactStatus.frame = CGRect(x: contactName.frame.origin.x, y: contactName.frame.maxY, width: contactName.frame.width, height: 20)
        contactStatus.text = contact.contactStatus
        self.contentView.addSubview(contactStatus)
        
    }

}
