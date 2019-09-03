//
//  NotificationTableViewController.swift
//  Tatangga
//
//  Created by Adrian Suryo Abiyoga on 04/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NotificationCollectionViewCell"
class NotificationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                //title
         navigationItem.title = "Notifikasi"
                //clear separartor lines
                tableView.separatorColor = .clear
        
                //register cell class
                tableView.register(NotificationCollectionViewCell.self, forCellReuseIdentifier: reuseIdentifier)
      
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCollectionViewCell
            return cell
        }

}
