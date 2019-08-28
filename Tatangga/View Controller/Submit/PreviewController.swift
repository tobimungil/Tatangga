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
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //dismiss(animated: true, completion: nil)
    }
}
