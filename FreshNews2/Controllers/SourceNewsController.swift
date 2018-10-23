//
//  SourceNewsController.swift
//  FreshNews2
//
//  Created by Marcelo on 19/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//


import UIKit
import Kingfisher


class SourceNewsController: UITableViewController {
    
    
    // MARK: - Properties
    public var source : SourceViewModel!
    
    private var articles : ArticlesViewModel!
    private var webService = WebService()
    private var dataSource : TableViewDataSource<NewsTableViewCell, ArticleViewModel>!
    
    private var cellIdentifier = "Cell"
    private var selectedIndexPath = IndexPath()
    
    // MARK: - Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noContentView: UIView!
    @IBOutlet var noContentLabel: UILabel!
    @IBOutlet var noContentImageVIew: UIImageView!
    

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.navigationItem.title = source.name!
        self.tableView.estimatedRowHeight = CGFloat(190)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.setNoContent(msg: "Loading...")
        self.setActivityIndicator(show: true)
        setUpObservers()
        // load app data
        loadAppData()

    }
    
    
    // MARK: Application Data Source
    private func loadAppData() {
        
        self.articles = ArticlesViewModel(sourceId: source.id!, completion: {
            // completion
            var rowIndex = String()
            var i = 0
            self.dataSource = TableViewDataSource(cellIdentifier: self.cellIdentifier, items:self.articles.articles, configureCell: { (cell, vm) in
                // completion
                
                rowIndex = String(i)
                cell.rowIndex = rowIndex
                i = i + 1
                
                
                cell.articleTitle.text = vm.title
                cell.articleDescription.text = vm.description
                cell.articlePublishDate.text = vm.publishedAt
//                cell.articleFavoriteIcon
                
                // article image
                if (vm.urlToImage != nil && vm.urlToImage != "" ) {
                    
                    let imgSrc = vm.urlToImage
                    let url = URL(string: imgSrc!)

                    if imgSrc?.isEmpty == nil  {
                        cell.articleImageView.contentMode = UIView.ContentMode.scaleAspectFit
                        cell.articleImageView.image = UIImage(named: "noContentIcon")

                    }else{
                        cell.articleImageView.kf.indicatorType = .activity
                        cell.articleImageView.kf.setImage(with: url)
                    }
                    
                }else{
                    cell.articleImageView.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.articleImageView.image = UIImage(named: "noContentIcon")
                }
                
                // Favorite Icon
//                if self.favoriteNews[indexPath.row] {
//                    let tempImage = UIImage(named: "FavoriteYes")
//                    cell.articleFavoriteIcon.setImage(tempImage, for: UIControlState.normal)
//                    cell.isFavorite = true
//                }else{
                    let tempImage = UIImage(named: "favoriteNo")
                cell.articleFavoriteIcon.setImage(tempImage, for: UIControl.State.normal)
                cell.isFavorite = false
//                }
                
                
                
    
            })
            self.tableView.dataSource = self.dataSource
            // check 3
            if self.articles.articles.count == 0 {
                self.setNoContent(msg: "No articles!")
            }else{
                self.tableView.tableHeaderView = nil
            }
            self.setActivityIndicator(show: false)
            self.tableView.reloadData()
        })
        
    }
    
    

    // MARK: - TableView Helper
    private func setNoContent(msg: String) {
        self.noContentLabel.text = msg
        self.noContentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.bounds.size.height)
        self.tableView.tableHeaderView = self.noContentView
    }
    
    // MARK: - Activity Indicator
    private func setActivityIndicator(show: Bool) {
        self.activityIndicator.isHidden = !show
        if show {
            self.activityIndicator.startAnimating()
        }else{
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Observer Manager
    private func setUpObservers() {
        
//        // did change favorite value (favorite button was tapped)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(didChangeFavoriteValue),
//                                               name: NSNotification.Name(rawValue: "didChangeFavoriteValue"),
//                                               object: nil)
//
//
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectShare),
                                               name: NSNotification.Name(rawValue: "didSelectShare"),
                                               object: nil)
        
        
        
    }
    
    @objc private func didSelectShare(notification: NSNotification) {
        
        let rowIndex = notification.object as! String
//        var transientObj = FavoriteRow()
//
//        if isFavorites {
//            transientObj = self.favorites[indexPath.row]
//        }else{
//            let article = self.news[indexPath.row]
//            transientObj = convertArticleInfoFavoriteLayout(article: article)
//        }
//
//        let content = transientObj.title! + "   -> " + transientObj.articleUrl!
        
        let i = Int(rowIndex)
        self.displayShareSheet(shareContent: articles.articles[i!].url!)
    }
    
    // MARK: - Share Sheet Helper
    private func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
}
