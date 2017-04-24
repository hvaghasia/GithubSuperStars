//
//  Constants.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

struct Constants {
    // Headers
    static let accept = "Accept"
    static let contentType = "Content-Type"
    
    // Values
    static let applicationJSON = "application/json"
    
    // Servers
    static let APIServer = "https://api.github.com/"
    
    // Resourse path
    static let getStarrProjects = "search/repositories"
    
    // Resourse path
    static let getReadMe = "repos/%@/%@/readme"

    // webservice response keys
    struct WebserviceResponseKey {
        static let items = "items"
        
        // Project data
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let starCount = "stargazers_count"
        static let forksCount = "forks_count"

        // Owner/user data
        static let owner = "owner"
        static let login = "login"
        static let avatar_url = "avatar_url"
        
        //ReadMe data
        static let htmlUrl = "html_url"
        static let downloadUrl = "download_url"
    }
    
    struct RequestParameter {
        static let sort = "sort"
        static let order = "order"
        static let query = "q"
    }
    
    struct RequestParameterValue {
        static let sortValue = "stars"
        static let orderValue = "desc"
        static let qValue = "language:swift"
        
    }
    
    struct SegueIdentifier {
        static let showProjectDetails = "ShowProjectDetails"
    }
    
    struct ScreenTitle {
        static let projectList = "Github Trends"
    }
    
    struct AlertViewActionButtonTitle {
        static let ok = "Ok"
    }
    
    struct StoryboardType {
        static let main = "Main"
    }
}

enum HTTPMethod: String {
    case GET = "GET"
    
    func toString() -> String {
        return self.rawValue
    }
}

enum ResponseType {
    case data
    case json
}

enum NetworkError: Error {
    case corruptedData
    case unexpected
    
    var localizedDescription: String {
        switch self {
        case .corruptedData:
            return "Corrupted data received"
        case .unexpected:
            return "Unexpected Error"
        }
    }
}
