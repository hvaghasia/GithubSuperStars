//
//  ProjectsListViewController.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import UIKit

class ProjectsListViewController: UITableViewController {
    
    var datasource: ProjectListDataSource?
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.ScreenTitle.projectList
        
        datasource = ProjectListDataSource(tableView: tableView)
        tableView.dataSource = datasource
        
        fetchStarProjects()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let projectDatasource = datasource,
            let indexpath = sender as? IndexPath,
            segue.identifier == Constants.SegueIdentifier.showProjectDetails {
            let selectedProject = projectDatasource.projects[indexpath.row]
            let detailsViewController = segue.destination as! ProjectDetailsViewController
            detailsViewController.project = selectedProject
        }
    }
}

//// MARK: - Table view delegate
extension ProjectsListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifier.showProjectDetails,
                     sender: indexPath)

    }
}

//MARK: webservice call
extension ProjectsListViewController {
    func fetchStarProjects() {
        progressIndicator.startAnimating()
        NetworkManager.default.getStarProjects { [weak self] (result) in

            guard let weakSelf = self else { return }
            
            weakSelf.progressIndicator.stopAnimating()
            
            switch (result) {
            case .success(let projects):
                weakSelf.datasource?.projects = projects as! [Project]
            case .failure(let error):
                weakSelf.showAlert(title: "", message: error.localizedDescription)
            }
        }
    }
}

