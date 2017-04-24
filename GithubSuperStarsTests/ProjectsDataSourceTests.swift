//
//  ProjectsDataSourceTests.swift
//  GithubSuperStars
//
//  Created by Hardik on 24/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import XCTest
@testable import GithubSuperStars

class ProjectsDataSourceTests: XCTestCase {

    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        let projectListVC = Storyboard.projectListViewController()
        tableView = projectListVC.tableView
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProjectListOnTableView() {
        
        let dataSource = ProjectListDataSource(tableView: tableView)
        
        var projects = [Project]()
        projects.append(Project(response: ["id": 1000,
                                           "name": "Alamofire",
                                           "description": "This is the alamofire library which make networking easy",
                                           "forks_count": 111,
                                           "stargazers_count": 100000,
                                           "owner": ["login": "alamofire", "id": 123, "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"]]))
        projects.append(Project(response: ["id": 2000,
                                           "name": "SwiftyJSON",
                                           "description": "Helps to parse JSON easily",
                                           "forks_count": 222,
                                           "stargazers_count": 2000,
                                           "owner": ["login": "alamofire", "id": 123, "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"]]))
        projects.append(Project(response: ["id": 3000,
                                           "name": "RestKit",
                                           "description": "helps to map server response to models and cache them",
                                           "forks_count": 333,
                                           "stargazers_count": 20,
                                           "owner": ["login": "alamofire", "id": 123, "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"]]))
        dataSource.projects = projects
        
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 3, "There should be 3 manufacturers on tableview list")
    }
    
}
