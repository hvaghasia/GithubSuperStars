//
//  GetReadMe.swift
//  GithubSuperStars
//
//  Created by Hardik on 23/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

struct GetReadMeRequest: APIRequest {
    var path: String
    var parameters = Dictionary<String, String>()
    var responseType = ResponseType.json
    
    init(withProject project: Project) {
        self.path = String(format: Constants.getReadMe, project.user?.loginName ?? "", project.name)
    }
}
