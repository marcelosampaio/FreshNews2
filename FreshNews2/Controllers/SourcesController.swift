//
//  SourcesController.swift
//  FreshNews2
//
//  Created by Marcelo on 19/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class SourcesController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noContentView: UIView!
    @IBOutlet var noContentLabel: UILabel!
    
    // MARK: - Properties
    private var sources : SourcesViewModel!
    private var dataSource : TableViewDataSource<SourceTableViewCell,SourceViewModel>!
    private var cellIdentifier = "Cell"

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News Feed"
        self.tableView.estimatedRowHeight = CGFloat(190)
        self.tableView.rowHeight = UITableView.automaticDimension
        // load app data
        loadAppData()
    }
    
    // MARK: App Data Source
    private func loadAppData() {
        self.sources = SourcesViewModel(completion: {
            // completion
            self.dataSource = TableViewDataSource(cellIdentifier: self.cellIdentifier, items: self.sources.sources, configureCell: { (cell, vm) in
                // completion
            
//                cell.sourcesTitle.text = vm.name
//                cell.sourcesDescription.text = vm.description
                cell.sourceName.text = vm.name
                cell.sourceDescription.text = vm.description
                cell.sourceCategory.text = vm.category
                cell.sourceDate.text = vm.country
            
                
            })
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        })
        
    }

}
