//
//  DalemKategoriViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 25/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit


    let forumCollectionViewCell = "ForumCollectionViewCell"

class DalemKategoriViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var forumCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register Custom Berita Cell
        let nibCell = UINib(nibName: forumCollectionViewCell, bundle: nil)
        forumCollection.register(nibCell, forCellWithReuseIdentifier: forumCollectionViewCell)
        
    }
    
    func forumNavbar(){
        let forumLabel = UILabel()
        forumLabel.text = "Forum"
        forumLabel.font = UIFont(name: "SF-Pro-Rounded-Bold", size: 23)
        forumLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: forumLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forumCollectionViewCell, for: indexPath) as! ForumCollectionViewCell
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
}
