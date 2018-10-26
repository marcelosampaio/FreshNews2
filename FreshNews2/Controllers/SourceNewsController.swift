//
//  SourceNewsController.swift
//  FreshNews2
//
//  Created by Marcelo on 19/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//


import UIKit
import CoreData
import Kingfisher


class SourceNewsController: UITableViewController, NewsTableViewCellProtocol {
    
    // MARK: - Properties
    public var moc : NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                favoriteService = FavoriteService(moc: moc)
            }
        }
    }
    public var selectedProviderType : ProviderType = ProviderType.web
    
    private var favoriteService : FavoriteService?
    
    // MARK: - Properties
    public var source : SourceViewModel!

    
    private var articles : ArticlesViewModel!
    private var webService = WebService()
    private var adapter = Adapter()
    private var dataSource : TableViewDataSource<NewsTableViewCell, ArticleViewModel>!
    
    private var cellIdentifier = "Cell"
    private var selectedIndexPath = IndexPath()
    
    private var sourceNewsFactory = SourceNewsFactory()
    

    // MARK: - Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noContentView: UIView!
    @IBOutlet var noContentLabel: UILabel!
    @IBOutlet var noContentImageVIew: UIImageView!
    

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedProviderType == .web {
            self.navigationItem.title = source.name!
        }else{
            self.navigationItem.title = "Favorites"
        }
        
        
        self.tableView.estimatedRowHeight = CGFloat(190)
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.setNoContent(msg: "Loading...")
        self.setActivityIndicator(show: true)
        // load app data
        loadAppData()
        
    }
    
    
    // MARK: - Application Data Source
    private func loadAppData() {

        self.articles = ArticlesViewModel(provider: selectedProviderType, sourceId: source.id!, completion: {
            // completion
            self.dataSource = TableViewDataSource(cellIdentifier: self.cellIdentifier, items:self.articles.articles, configureCell: { (sourceCell, viewModel) in
                // completion
                let isFavorite = self.favoriteArticleExists(url: viewModel.url!) ? true : false
                let cell : NewsTableViewCell = self.sourceNewsFactory.cellContent(cell: sourceCell, viewModel: viewModel, isFavorite: isFavorite)
                cell.delegate = self
    
            })
            self.prepareToReloadData()
        })
        
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        let article = self.articles.articles[indexPath.row].url!
        let url = URL(string: article)
        UIApplication.shared.open(url!, options: [:]) { (success) in
            // completion
        }
    }

    // MARK: - TableView Helper
    private func setNoContent(msg: String) {
        self.noContentLabel.text = msg
        self.noContentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.bounds.size.height)
        self.tableView.tableHeaderView = self.noContentView
    }
    
    private func prepareToReloadData() {
        self.tableView.dataSource = self.dataSource
        // check 3
        if self.articles.articles.count == 0 {
            self.setNoContent(msg: "No articles!")
        }else{
            self.tableView.tableHeaderView = nil
        }
        self.setActivityIndicator(show: false)
        
        // reload data
        self.tableView.reloadData()
        
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
    
    
    @objc private func didSelectShare(notification: NSNotification) {
        
        let rowIndex = notification.object as! String
        let i = Int(rowIndex)
        var content = String()
        var articleTitle = String()
        var articleUrl = String()
        
        if !articles.articles[i!].title!.isEmpty {
            articleTitle = articles.articles[i!].title!
        }
        
        if !articles.articles[i!].url!.isEmpty {
            articleUrl = articles.articles[i!].url!
        }
        content = articleTitle + " - " + articleUrl
        self.displayShareSheet(shareContent: content)
    }
    
    // MARK: - Share Sheet Helper
    private func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    // MARK: - NewsTableViewCell Delegate
    func didSelectShare(rowIndex: Int) {
        
        var content = String()
        var articleTitle = String()
        var articleUrl = String()
        
        if !articles.articles[rowIndex].title!.isEmpty {
            articleTitle = articles.articles[rowIndex].title!
        }
        
        if !articles.articles[rowIndex].url!.isEmpty {
            articleUrl = articles.articles[rowIndex].url!
        }
        content = articleTitle + " - " + articleUrl
        self.displayShareSheet(shareContent: content)
    }
    
    func didChangeFavoriteValue(rowIndex: Int) {

        let articleViewModel = articles?.articles[rowIndex]
        let article = adapter.adaptFromViewModelToBusinessModel(articleViewModel: articleViewModel!)
        
        
        let url = article.url
        if favoriteArticleExists(url: url) {
            // delete article from favorites
            let favArticle = favoriteService?.getArticle(url: url)
            self.favoriteService?.delete(favoriteArticle: favArticle!)
        }else{
            // add article to favorites
            self.favoriteService?.addFavoriteArticle(article, completion: { (success, favoriteArticle) in
                // completion
                if !success {
                    print("** error inserting")
                }
            })
        }
    
        self.tableView.reloadData()
    }
    
    // MARK: - Favorite Helper
    private func favoriteArticleExists(url: String) -> Bool {
        if (self.favoriteService?.getArticle(url: url)) != nil {
            return true
        }else{
            return false
        }
    }
 
}
