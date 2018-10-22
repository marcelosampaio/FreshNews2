//
//  SourceNewsController.swift
//  FreshNews2
//
//  Created by Marcelo on 19/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class SourceNewsController: UITableViewController {
    
    
    // MARK: - Properties
    public var source : SourceViewModel!
    
    private var articles : ArticlesViewModel!
    private var webService = WebService()
    private var dataSource : TableViewDataSource<NewsTableViewCell, ArticleViewModel>!
    
    private var cellIdentifier = "Cell"
    
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
        // load app data
        loadAppData()

    }
    
    
    // MARK: Application Data Source
    private func loadAppData() {
        
        self.articles = ArticlesViewModel(sourceId: source.id!, completion: {
            // completion
            self.dataSource = TableViewDataSource(cellIdentifier: self.cellIdentifier, items:self.articles.articles, configureCell: { (cell, vm) in
                // completion
                cell.articleTitle.text = vm.title
//                cell.articleImageView
                cell.articleDescription.text = vm.description
                cell.articlePublishDate.text = vm.publishedAt
//                cell.articleFavoriteIcon
                
                
            })
            self.tableView.dataSource = self.dataSource
            
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
    
}
