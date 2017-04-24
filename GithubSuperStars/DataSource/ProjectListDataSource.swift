//
//  ProjectListDataSource.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation
import UIKit

class ProjectListDataSource: NSObject {
    // The tableview to display projects list
    fileprivate weak var tableView: UITableView!
    
    // Array of Project model which holds repository details
    var projects = [Project]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // Initializer
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
}

//// MARK: - Table view data source
extension ProjectListDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(cellClass: ProjectListCell.self, forIndexPath: indexPath)
        let project = projects[indexPath.row]
        let modelViewModel = ProjectViewModel(project: project)
        cell.configure(withViewModel: modelViewModel, atIndexPath: indexPath)
        return cell
    }
}
