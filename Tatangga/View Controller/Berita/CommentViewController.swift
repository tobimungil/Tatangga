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
    
    
    static var commentTxt: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Tulis Komentar..."
        tf.font = UIFont.systemFont(ofSize: 15)
        return tf
    }()
    
    static var commentView:  UIView = {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        commentView.addSubview(commentTxt)
        commentTxt.anchor(top: commentView.topAnchor, left: commentView.leftAnchor, bottom: nil, right: commentView.rightAnchor, paddingTop: 35, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        
        commentView.addSubview(sendBtn)
        sendBtn.anchor(top: commentView.topAnchor, left: nil, bottom: nil, right: commentView.rightAnchor, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 25, height: 25)
        return commentView
    }()
    
    static var sendBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        return btn
    }()
    
    
    
    @IBOutlet weak var commentCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override var inputAccessoryView: UIView?{
        get{
            return CommentViewController.commentView
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
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
        return 9
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
