//
//  SourceTableViewCell.swift
//  FreshNews
//
//  Created by Marcelo Sampaio on 3/22/17.
//  Copyright © 2017 Marcelo Sampaio. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet var sourceImageView: UIImageView!
    @IBOutlet var sourceDescription: UILabel!
    @IBOutlet var sourceCategory: UILabel!
    @IBOutlet var sourceDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
