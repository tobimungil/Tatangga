//
//  FilterViewController.swift
//  Tatangga
//
//  Created by Andi Ikhsan Eldrian on 04/09/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    // Outlet
    @IBOutlet weak var semuaImage: UIImageView!
    @IBOutlet weak var belumDibacaImage: UIImageView!
    @IBOutlet weak var semuaCentang: UIImageView!
    @IBOutlet weak var tigaHariCentang: UIImageView!
    @IBOutlet weak var tujuhHariCentang: UIImageView!
    @IBOutlet weak var empatBelasHariCentang: UIImageView!
    @IBOutlet weak var tigaPuluhHariCentang: UIImageView!
    
    //Function
    @IBAction func semuaImageButton(_ sender: Any) {
        semuaImage.image = UIImage(named: "option-semua-centang")
        belumDibacaImage.image = UIImage(named: "option-unread")
    }
    
    @IBAction func belumDibacaButton(_ sender: Any) {
        semuaImage.image = UIImage(named: "option-semua")
        belumDibacaImage.image = UIImage(named: "option-unread-centang")
    }
    
    @IBAction func semuaCentangButton(_ sender: Any) {
        semuaCentang.image = UIImage(named: "Yes")
        tigaHariCentang.image = UIImage(named: "white-box")
        tujuhHariCentang.image = UIImage(named: "white-box")
        empatBelasHariCentang.image = UIImage(named: "white-box")
        tigaPuluhHariCentang.image = UIImage(named: "white-box")
    }
    
    @IBAction func tigaHariCentangButton(_ sender: Any) {
        semuaCentang.image = UIImage(named: "white-box")
        tigaHariCentang.image = UIImage(named: "Yes")
        tujuhHariCentang.image = UIImage(named: "white-box")
        empatBelasHariCentang.image = UIImage(named: "white-box")
        tigaPuluhHariCentang.image = UIImage(named: "white-box")
    }
    
    @IBAction func tujuhHariCentangButton(_ sender: Any) {
        semuaCentang.image = UIImage(named: "white-box")
        tigaHariCentang.image = UIImage(named: "white-box")
        tujuhHariCentang.image = UIImage(named: "Yes")
        empatBelasHariCentang.image = UIImage(named: "white-box")
        tigaPuluhHariCentang.image = UIImage(named: "white-box")
    }
    
    @IBAction func empatBelasHariCentangButton(_ sender: Any) {
        semuaCentang.image = UIImage(named: "white-box")
        tigaHariCentang.image = UIImage(named: "white-box")
        tujuhHariCentang.image = UIImage(named: "white-box")
        empatBelasHariCentang.image = UIImage(named: "Yes")
        tigaPuluhHariCentang.image = UIImage(named: "white-box")
    }
    
    @IBAction func tigaPuluhHariCentangButton(_ sender: Any) {
        semuaCentang.image = UIImage(named: "white-box")
        tigaHariCentang.image = UIImage(named: "white-box")
        tujuhHariCentang.image = UIImage(named: "white-box")
        empatBelasHariCentang.image = UIImage(named: "white-box")
        tigaPuluhHariCentang.image = UIImage(named: "Yes")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
