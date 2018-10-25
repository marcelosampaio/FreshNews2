//
//  SourceNewsFactory.swift
//  FreshNews2
//
//  Created by Marcelo on 25/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import UIKit

class SourceNewsFactory {

    func cellContent(cell: NewsTableViewCell, viewModel: ArticleViewModel, isFavorite: Bool) -> NewsTableViewCell {

        
        cell.articleTitle?.text = viewModel.title!
        cell.articleDescription?.text = viewModel.description
        cell.articlePublishDate?.text = viewModel.publishedAt
        
        
        // article image
        if (viewModel.urlToImage != nil && viewModel.urlToImage != "" ) {
            
            let imgSrc = viewModel.urlToImage
            let url = URL(string: imgSrc!)
            
            if imgSrc?.isEmpty == nil  {
                cell.articleImageView?.contentMode = UIView.ContentMode.scaleAspectFit
                cell.articleImageView?.image = UIImage(named: "noContentIcon")
                
            }else{
                cell.articleImageView?.kf.indicatorType = .activity
                cell.articleImageView?.kf.setImage(with: url)
            }
            
        }else{
            cell.articleImageView?.contentMode = UIView.ContentMode.scaleAspectFit
            cell.articleImageView?.image = UIImage(named: "noContentIcon")
        }
        
        // Favorite Icon
        if isFavorite {
            let tempImage = UIImage(named: "FavoriteYes")
            cell.articleFavoriteIcon?.setImage(tempImage, for: UIControl.State.normal)
            cell.isFavorite = true
        }else{
            let tempImage = UIImage(named: "favoriteNo")
            cell.articleFavoriteIcon?.setImage(tempImage, for: UIControl.State.normal)
            cell.isFavorite = false
        }
        
        return cell
    }
    
}
