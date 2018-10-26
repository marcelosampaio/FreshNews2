//
//  SourcesController.swift
//  FreshNews2
//
//  Created by Marcelo on 19/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData

class SourcesController: UITableViewController {
    
    // MARK: - Properties
    public var moc : NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                favoriteService = FavoriteService(moc: moc)
            }
        }
    }
    private var favoriteService : FavoriteService?
    
    
    // MARK: - Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noContentView: UIView!
    @IBOutlet var noContentLabel: UILabel!
    
    // MARK: - Properties
    private var sources : SourcesViewModel!
    private var dataSource : TableViewDataSource<SourceTableViewCell, SourceViewModel>!
    private var cellIdentifier = "Cell"

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News Feed"
        self.tableView.estimatedRowHeight = CGFloat(190)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.setNoContent(msg: "Loading...")
        self.setActivityIndicator(show: true)
        // load app data
        loadAppData()
    }
    
    // MARK: - App Data Source
    private func loadAppData() {
        self.sources = SourcesViewModel(completion: {
            // completion
            self.dataSource = TableViewDataSource(cellIdentifier: self.cellIdentifier, items: self.sources.sources, configureCell: { (cell, vm) in
                // completion
                cell.sourceName.text = vm.name
                cell.sourceDescription.text = vm.description
                cell.sourceCategory.text = vm.category
                cell.sourceDate.text = vm.country
            })
            self.prepareToReloadData()
        })
        
    }
    
    // MARK: - UI Action
    @IBAction func favoriteAction(_ sender: Any) {
        performSegue(withIdentifier: "showFavorites", sender: self)
    }
    

    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSourceNews", sender: self)
    }
    
    
    // MARK: - TableView Helper
    private func setNoContent(msg: String) {
        self.noContentLabel.text = msg
        self.noContentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.bounds.size.height)
        self.tableView.tableHeaderView = self.noContentView
    }
    
    private func prepareToReloadData() {
        self.tableView.dataSource = self.dataSource
        if self.sources.sources.count == 0 {
            self.setNoContent(msg: "No news!")
        }else{
            self.tableView.tableHeaderView = nil
        }
        self.setActivityIndicator(show: false)
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showSourceNews" {
            let controller = segue.destination as! SourceNewsController
            let indexPath = tableView.indexPathForSelectedRow
            var selectedSource : SourceViewModel!
            selectedSource = sources.sources[indexPath!.row]
            controller.source = selectedSource
            controller.moc = moc
            controller.selectedProviderType = ProviderType.web
        }else if segue.identifier == "showFavorites" {
            let controller = segue.destination as! SourceNewsController
            controller.selectedProviderType = ProviderType.database
            let dummySource : SourceViewModel! = SourceViewModel(source: Source(dictionary: NSDictionary()))
            dummySource.category = ""
            controller.source = dummySource
        }
        
    }

}
