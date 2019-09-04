//
//  ForumViewController.swift
//  Tatangga
//
//  Created by Adrian Suryo Abiyoga on 03/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let forumBaruCollectionViewCell = "ForumBaruCollectionViewCell"
    
    @IBOutlet weak var forumCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: forumBaruCollectionViewCell, bundle: nil)
        forumCollection.register(nibCell, forCellWithReuseIdentifier: forumBaruCollectionViewCell)

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forumBaruCollectionViewCell, for: indexPath) as! ForumBaruCollectionViewCell
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
