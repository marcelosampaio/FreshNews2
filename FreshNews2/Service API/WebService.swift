//
//  WebService.swift
//  FreshNews2
//
//  Created by Marcelo on 19/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation


class WebService {
    
    // MARK: - Data Retrieval
    func getNewsSources(completion: @escaping (WebContent) -> ()) {
        // get url
        let url = URL(string: WebService.getEndpoint("getSources"))
        
        // request web service
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dataDic : NSDictionary = json as! NSDictionary
                DispatchQueue.main.async {
                    completion(WebContent(dictionary: dataDic))
                }
            }
            }.resume()
    }
    
    
    
    // MARK: - Class Helper
    class func getEndpoint(_ identifier: String) -> String {
        
        var result = String()
        
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            
            // file root is a dictionary
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                print ("****** dic = \(dic)")
                
                result = dic[identifier] as! String
                
                
            }
        }
        print("***2*** ACTION: \(identifier)")
        return result
    }
    
    
}

