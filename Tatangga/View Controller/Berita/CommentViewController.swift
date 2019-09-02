//
//  CommentViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 02/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let commentCollectionViewCell = "CommentCollectionViewCell"
    
    @IBOutlet weak var commentCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setView(){
        let nibCell = UINib(nibName: commentCollectionViewCell, bundle: nil)
        commentCollection.register(nibCell, forCellWithReuseIdentifier: commentCollectionViewCell)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCollectionViewCell, for: indexPath) as! CommentCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
