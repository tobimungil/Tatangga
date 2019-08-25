//
//  BeritaViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 21/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

    let beritaCollectionViewCell = "BeritaCollectionViewCell"

class BeritaViewController: UIViewController {

    @IBOutlet weak var beritaCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Custom Berita Cell
        let nibCell = UINib(nibName: beritaCollectionViewCell, bundle: nil)
        beritaCollection.register(nibCell, forCellWithReuseIdentifier: beritaCollectionViewCell)
        
        
        beritaNavbar()
    }
    
    // Setup Custom Berita Navigation Bar Title
    func beritaNavbar(){
        let beritaLabel = UILabel()
        beritaLabel.text = "Berita Sekitar"
        beritaLabel.font = UIFont(name: "SF-Pro-Rounded-Bold", size: 23)
        beritaLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: beritaLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
    }

}

//Code buat Collection View
extension UIViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: beritaCollectionViewCell, for: indexPath) as! BeritaCollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
}
