//
//  ProjectViewModel.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation


struct ProjectViewModel {
    let name: String
    let description: String
    let starsCount: String
    
    init(project: Project) {
        self.name = project.name
        self.description = project.description
        self.starsCount = "\(project.starsCount) stars"
    }
}
