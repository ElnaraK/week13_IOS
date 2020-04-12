//
//  Cell.swift
//  TableView
//
//  Created by Elnara  on 4/9/20.
//  Copyright © 2020 Elnara . All rights reserved.
//
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var model: Model! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        self.titleLabel.text = model.name
        self.yearLabel.text = model.status
        
        ImageService.shared.downloadImage(url: model.image) { image in
            self.posterImageView.image = image
        }
    }
}
