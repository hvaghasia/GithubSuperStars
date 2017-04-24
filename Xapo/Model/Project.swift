//
//  Project.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init(response: Any)
}

/// Class to hold Project information
final class Project {
    fileprivate(set) var id: Int = -1
    fileprivate(set) var name: String = ""
    fileprivate(set) var starsCount: Int = 0
    fileprivate(set) var forksCount: Int = 0
    fileprivate(set) var description: String = ""
    
    fileprivate(set) var user: User?
}

extension Project: JSONDecodable {
    public convenience init(response: Any) {
        self.init()
        
        if let responseDictionary = response as? [String: Any],
            let id = responseDictionary[Constants.WebserviceResponseKey.id] as? Int,
            let projectName = responseDictionary[Constants.WebserviceResponseKey.name] as? String,
            let starsCount = responseDictionary[Constants.WebserviceResponseKey.starCount] as? Int,
            let forksCount = responseDictionary[Constants.WebserviceResponseKey.forksCount] as? Int,
            let description = responseDictionary[Constants.WebserviceResponseKey.description] as? String,
            let userDict = responseDictionary[Constants.WebserviceResponseKey.owner] as? [String: Any] {
            self.id = id
            self.name = projectName
            self.description = description
            self.forksCount = forksCount
            self.starsCount = starsCount
            
            user = User(withUserDict: userDict)
        }
    }
}
