//
//  PopupViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 02/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

class PopupViewController: UIViewController {
    
    @IBOutlet weak var imgDetailPost: UIImageView!
    var latitude: Double? = nil
    @IBOutlet weak var lblTitleDetailPost: UILabel!
    @IBOutlet weak var lblDescriptionDetailPost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataNewsDetail()
    }
    
    func getDataNewsDetail() {
        print(latitude)
        let postPredicate = NSPredicate(format: "latitude == (\(latitude!))")
        let postQuery = CKQuery(recordType: RemoteRecords.post, predicate: postPredicate)
        CKContainer.init(identifier: RemoteURL.url).publicCloudDatabase.perform(postQuery, inZoneWith: nil) {
            record, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    print(record)
                    self.setView(record![0])
                }
            }
        }
    }
    
    func setView(_ record: CKRecord) {
        lblTitleDetailPost.text = record[RemotePost.titlePost]
        lblDescriptionDetailPost.text = record[RemotePost.descriptionPost]
        if let asset = record[RemotePost.photoPost] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!) {
            imgDetailPost.image = UIImage(data: data)
        }
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
