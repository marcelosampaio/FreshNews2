//
//  NewsTableViewCell.swift
//  FreshNews
//
//  Created by Marcelo Sampaio on 3/22/17.
//  Copyright © 2017 Marcelo Sampaio. All rights reserved.
//

import UIKit


protocol NewsTableViewCellProtocol: class {
    func didSelectShare(rowIndex: Int)
    func didChangeFavoriteValue(rowIndex: Int)
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
    public var rowIndex = Int()
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
        delegate?.didChangeFavoriteValue(rowIndex: self.tag)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        delegate?.didSelectShare(rowIndex: self.tag)
    }

    
}
