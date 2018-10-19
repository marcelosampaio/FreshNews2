//
//  NewsTableViewCell.swift
//  FreshNews
//
//  Created by Marcelo Sampaio on 3/22/17.
//  Copyright © 2017 Marcelo Sampaio. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    // MARK: - Outlets
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleDescription: UILabel!
    @IBOutlet var articlePublishDate: UILabel!
    @IBOutlet var articleFavoriteIcon: UIButton!
    
    // MARK: - Parameters
    public var indexPath = NSIndexPath()
    public var isFavorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // MARK: - UI Actions
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        print("******* FAVORITE BUTTON WAS TAPPED  row: \(indexPath.row)")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didChangeFavoriteValue"),
                                        object: indexPath,
                                        userInfo: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        print("******* SHARE BUTTON WAS TAPPED  row: \(indexPath.row)")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectShare"),
                                        object: indexPath,
                                        userInfo: nil)
        
    }

    
}
