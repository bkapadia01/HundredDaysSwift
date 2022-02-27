//
//  ItemTableViewCell.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet var menuItemPrice: UILabel!
    @IBOutlet var menuItemName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
