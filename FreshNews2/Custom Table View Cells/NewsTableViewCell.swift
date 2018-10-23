//
//  NewsTableViewCell.swift
//  FreshNews
//
//  Created by Marcelo Sampaio on 3/22/17.
//  Copyright © 2017 Marcelo Sampaio. All rights reserved.
//

import UIKit


protocol NewsTableViewCellProtocol: class {
    func didSelectShare(rowIndex: String)
}


class NewsTableViewCell: UITableViewCell {

    // MARK: - Properties
    weak var delegate: NewsTableViewCellProtocol?
    
    
    // MARK: - Outlets
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleDescription: UILabel!
    @IBOutlet var articlePublishDate: UILabel!
    @IBOutlet var articleFavoriteIcon: UIButton!
    
    // MARK: - Parameters
    public var rowIndex = String()
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

    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        delegate?.didSelectShare(rowIndex: rowIndex)
    }

    
}
