//
//  PhotoCell.swift
//  tumblr2.0
//
//  Created by Matthew Rodriguez on 2/13/19.
//  Copyright © 2019 Matthew Rodriguez. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
