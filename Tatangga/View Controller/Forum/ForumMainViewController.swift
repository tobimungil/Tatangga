//
//  NotificationViewController.swift
//  Tatangga
//
//  Created by Adrian Suryo Abiyoga on 03/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "NotificationCollectionViewCell"
class ForumMainViewController: UIViewController {

    @IBOutlet weak var notificationButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    @IBAction func notificationBtnAct(_ sender: UIButton) {
        let notifVC = NotificationTableViewController()
    navigationController?.pushViewController(notifVC, animated: true)
    }
    
//    @IBAction func notificationBtnAct(_ sender: UIButton) {
//        let notifVC = NotificationTableViewController()
//        navigationController?.pushViewController(notifVC, animated: true)
//    }
}
