//
//  CoffeeShopsTableViewCell.swift
//  CoffeeShops
//
//  Created by Yin Hua on 3/05/2016.
//  Copyright © 2016 Yin Hua. All rights reserved.
//

import UIKit

class CoffeeShopsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    

}
