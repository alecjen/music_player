//
//  SongCell.swift
//  musicPlayer
//
//  Created by Alec Jen on 9/11/15.
//  Copyright (c) 2015 Alec Jen. All rights reserved.
//

import Foundation
import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        titleLabel.textColor = UIColor.blackColor()
        artistLabel.textColor = UIColor(white: 0.45, alpha: 1.0)
        
    }

}