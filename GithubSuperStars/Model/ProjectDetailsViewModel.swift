//
//  ProjectDetailsViewModel.swift
//  GithubSuperStars
//
//  Created by Hardik on 23/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

struct ProjectDetailsViewModel {
    let repoName: String
    let username: String
    let description: String
    let starsCount: String
    let forksCount: String
    
    init(project: Project) {
        self.repoName = project.name
        self.description = project.description
        self.starsCount = "\(project.starsCount) stars"
        self.forksCount = "\(project.forksCount) forks"
        self.username = project.user?.loginName ?? ""
    }
}
