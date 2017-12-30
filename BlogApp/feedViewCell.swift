//
//  feedViewCell.swift
//  BlogApp
//
//  Created by Subhamoy Paul on 12/31/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit

class feedViewCell: UITableViewCell {

    @IBOutlet weak var customCellView: UIView!
    
    @IBOutlet weak var headerText: UITextField!
    
    @IBOutlet weak var contentText: UITextField!
    
    @IBOutlet weak var timestampsText: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
