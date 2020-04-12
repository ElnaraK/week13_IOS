//
//  DetailController.swift
//  TableView
//
//  Created by Elnara  on 4/9/20.
//  Copyright © 2020 Elnara . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        id.text = "id: \(String(model.id))"
        name.text = "name: \(String(model.name))"
        status.text = "status: \(String(model.status))"
        species.text = "species: \(String(model.species))"
        gender.text = "gender: \(String(model.gender))"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ImageService.shared.downloadImage(url: model.image) { image in
            self.image.image = image
        }
    }
}
