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
    
    private var favoriteService : FavoriteService?
    
    // MARK: - Properties
    public var source : SourceViewModel!
    
    private var articles : ArticlesViewModel!
    private var webService = WebService()
    private var adapter = Adapter()
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
        
        
        coreDataEngine()
        print("......... end of query all core data entity")
        
        self.navigationItem.title = source.name!
        self.tableView.estimatedRowHeight = CGFloat(190)
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.setNoContent(msg: "Loading...")
        self.setActivityIndicator(show: true)
        // load app data
        loadAppData()
        
    }
    
    
    // MARK: - Application Data Source
    private func loadAppData() {

        self.articles = ArticlesViewModel(sourceId: source.id!, completion: {
            // completion
            self.dataSource = TableViewDataSource(cellIdentifier: self.cellIdentifier, items:self.articles.articles, configureCell: { (cell, vm) in
                // completion
                
                cell.delegate = self
                cell.articleTitle.text = vm.title
                cell.articleDescription.text = vm.description
                cell.articlePublishDate.text = vm.publishedAt

                
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
                print("> row: \(cell.tag)")
                if self.favoriteArticleExists(url: vm.url!) {
                    let tempImage = UIImage(named: "FavoriteYes")
                    cell.articleFavoriteIcon.setImage(tempImage, for: UIControl.State.normal)
                    cell.isFavorite = true
                }else{
                    let tempImage = UIImage(named: "favoriteNo")
                    cell.articleFavoriteIcon.setImage(tempImage, for: UIControl.State.normal)
                    cell.isFavorite = false
                }
    
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
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        let article = self.articles.articles[indexPath.row].url!
        let url = URL(string: article)
        UIApplication.shared.open(url!, options: [:]) { (success) in
            // completion
        }
//        UIApplication.shared.openURL(url!)
        
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
        if let fa = self.favoriteService?.getArticle(url: url) {
            return true
        }else{
            return false
        }
    }
    
    
    // MARK: - Core Data
    private func coreDataEngine() {
        
//        // INSERT
//        let article = Article(dictionary: NSDictionary())
//        article.title = "Papai Noel dos sonhos"
//        article.description = "Com a chegada do fim de ano é esperado um aumento nas vendas do setor de comercio"
//        article.author = "MAS"
//        article.publishedAt = "2010-01-01"
//        article.url = "http://mundinews.com"
//        article.urlToImage = "imageUrl"
//
//        self.favoriteService?.addFavoriteArticle(article, completion: { (success, articles) in
//            // completion
//            if success {
//                for article in articles {
//                    print("** after insert ** title: \(String(describing: article.title!))")
//                }
//            }
//        })
//
//
//        // READ ALL with delete first
//        let articles = self.favoriteService?.getAllArticles()
//        for article in articles! {
//            print("** read all with delete first ** title: \(article.title!)")
//
//            // DELETE
//            self.favoriteService?.delete(favoriteArticle: article)
//        }
//
//
        // READ ALL
        let articlesX = self.favoriteService?.getAllArticles()
        var i = 1
        for article in articlesX! {
            
            print("** read all <><><>  \(i)  <><><> ** title: \(article.title!)  objId: \(article.objectID)")
            i = i + 1
        }
//
//        // READ BY KEY
//        let articleY = self.favoriteService?.getArticle(url: "http://mundinews.com")
//        let title = articleY?.title!
//        print("** getArticle title: \(title!)")
        
    }
    
    
    
}
