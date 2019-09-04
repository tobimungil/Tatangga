//
//  ContactList.swift
//  Tatangga
//
//  Created by Gabriella Gracia MT on 04/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class ContactListCell
{
    var contactName: String!
    var contactProfile: UIImage!
    var contactStatus: String!
    
    init(contactName: String, contactProfile: UIImage, contactStatus: String)
    {
        self.contactName = contactName
        self.contactProfile = contactProfile
        self.contactStatus = contactStatus
    }
}
