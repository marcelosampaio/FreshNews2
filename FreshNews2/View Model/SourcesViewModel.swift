//
//  SourcesViewModel.swift
//  SwiftNetwokingLayer
//
//  Created by Marcelo on 23/09/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class SourcesViewModel {
    var sources : [SourceViewModel] = [SourceViewModel]()
    private var webService = WebService()
    
    init(completion: @escaping () -> ()) {
        webService.getNewsSources { (webContent) in
            // completion
            if webContent.status == "ok" && webContent.sources.count > 0 {
                self.sources = webContent.sources.map(SourceViewModel.init)
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    
}
