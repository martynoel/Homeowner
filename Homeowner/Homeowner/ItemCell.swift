//
//  ItemCell.swift
//  Homeowner
//
//  Created by Mimi Chenyao on 9/13/17.
//  Copyright © 2017 Mimi Chenyao. All rights reserved.
//

import UIKit

/// ItemCell represents a cell on the app's table view of items.

class ItemCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
}
