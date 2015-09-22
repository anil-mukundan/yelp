//
//  CategoryFilterCell.swift
//  Yelp
//
//  Created by Anil Mukundan on 9/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol CategoryFilterCellDelegate {
    func categoryFilterCell(CategoryFilterCell: CategoryFilterCell, didChangeValue value: Bool)
}

class CategoryFilterCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categorySwitch: UISwitch!
    
    var delegate: CategoryFilterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categorySwitch.addTarget(self, action: "onCategorySelection", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onCategorySelection() {
        delegate?.categoryFilterCell(self, didChangeValue: categorySwitch.on)
    }

}
