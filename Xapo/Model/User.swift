//
//  User.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

typealias UserDictionary = [String: Any]

class User {
    
    fileprivate(set) var id: Int = -1
    fileprivate(set) var loginName: String = ""
    fileprivate(set) var avtarURLString: String = ""

    init(withUserDict userDictionary: UserDictionary) {
        if let id = userDictionary[Constants.WebserviceResponseKey.id] as? Int,
            let loginName = userDictionary[Constants.WebserviceResponseKey.login] as? String,
            let avtarURLString = userDictionary[Constants.WebserviceResponseKey.avatar_url] as? String {
            self.id = id
            self.loginName = loginName
            self.avtarURLString = avtarURLString
        }
    }
}
