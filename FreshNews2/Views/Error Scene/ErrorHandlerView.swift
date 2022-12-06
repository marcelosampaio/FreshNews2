//
//  ErrorHandlerView.swift
//  FreshNews2
//
//  Created by Marcelo on 26/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class ErrorHandlerView: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var refreshButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observers
        observerManager()
        
        // UI Button Config
        refreshButton.layer.borderColor = UIColor.superLightGrayColor.cgColor
        refreshButton.layer.borderWidth = 1.0
        refreshButton.layer.cornerRadius = 8
        refreshButton.layer.masksToBounds = true
        
        
    }
    
    
    // MARK: UI Actions
    @IBAction func refreshAction(_ sender: Any) {
        print("♻️ refresh connection")
        
        if AppSettings.standard.internetConnectionStatus() {
            
            // dismiss view controller
            dismissErrorHandlerView()
            
        }
        
        
    }
    
    
    // MARK: - Navigation Helpers
    private func dismissErrorHandlerView() {
        // dismiss view controller
        navigationController?.dismiss(animated: true
            , completion: {
                // completion
        })
    }
    
    
    
    // MARK: - Observers
    private func observerManager() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didConnectToInternet),
                                               name: NSNotification.Name(rawValue: "didConnectToInternet"),
                                               object: nil)
    }
    
    // observer actions
    @objc private func didConnectToInternet() {
        
        print("🇧🇷 did Connect To Internet 👍")
        // dismiss view controller
        dismissErrorHandlerView()
        
    }
}
