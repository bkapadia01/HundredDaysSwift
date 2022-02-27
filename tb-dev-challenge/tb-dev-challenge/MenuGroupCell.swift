//
//  MenuGroupCell.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-19.
//

import UIKit

class MenuGroupCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var menuGroupName: UILabel!
    @IBOutlet var editLabel: UILabel!
    
    var isEditing: Bool = false {
        didSet {
            editLabel.isHidden = !isEditing
        }
        
    }
}
