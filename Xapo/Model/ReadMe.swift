//
//  ReadMe.swift
//  GithubSuperStars
//
//  Created by Hardik on 23/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

/// Class to hold ReadMe information
final class ReadMe {
    fileprivate(set) var name: String = ""
    fileprivate(set) var htmlUrl: String = ""
    fileprivate(set) var downloadUrl: String = ""
}

extension ReadMe: JSONDecodable {
    public convenience init(response: Any) {
        self.init()
        
        if let responseDictionary = response as? [String: Any],
            let name = responseDictionary[Constants.WebserviceResponseKey.name] as? String,
            let htmlURLString = responseDictionary[Constants.WebserviceResponseKey.htmlUrl] as? String,
            let downloadURLString = responseDictionary[Constants.WebserviceResponseKey.downloadUrl] as? String {
            self.name = name
            self.htmlUrl = htmlURLString
            self.downloadUrl = downloadURLString

        }
    }
}
