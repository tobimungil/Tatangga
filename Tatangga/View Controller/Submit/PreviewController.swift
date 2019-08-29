//
//  PreviewController.swift
//  Tatangga
//
//  Created by Gabriella Gracia MT on 27/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class PreviewController: UIViewController
{

    @IBOutlet weak var uiImageOurlet: UIImageView!
    var image: UIImage!
    var finalImageURL: URL? = nil
    var encoded64Photo: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        uiImageOurlet.image = self.image
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any)
    {
        dismiss(animated: (true), completion: nil)
    }

    
    @IBAction func saveButton(_ sender: Any)
    {
        performSegue(withIdentifier: "setPhoto", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if image != nil {
            if segue.identifier == "setPhoto" {
                let nav = segue.destination as! UINavigationController
                let formView = nav.topViewController as! SubmitViewController
                formView.photoPreview = self.image
                formView.imageEncoded64 = encoded64Photo
            }
        }
    }
}
