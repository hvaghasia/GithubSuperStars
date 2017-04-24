//
//  GetGitProjectsRequest.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

struct GetStarProjectsRequest: APIRequest {
    var path: String
    var parameters = Dictionary<String, String>()
    var responseType = ResponseType.json
    
    init() {
        self.path = Constants.getStarrProjects
        self.parameters = [Constants.RequestParameter.query: Constants.RequestParameterValue.qValue,
                           Constants.RequestParameter.sort: Constants.RequestParameterValue.sortValue,
                           Constants.RequestParameter.order: Constants.RequestParameterValue.orderValue]
    }
}
