//
//  ViewModelTests.swift
//  GithubSuperStars
//
//  Created by Hardik on 24/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import XCTest
@testable import GithubSuperStars

class ViewModelTests: XCTestCase {
    
    var project: Project?
    
    override func setUp() {
        super.setUp()
        
        project = Project(response: ["id": 3081286,
                                     "name": "Tetris",
                                     "description": "A C implementation of Tetris using Pennsim through LC4",
                                     "forks_count": 11,
                                     "stargazers_count": 111,
                                     "owner": ["login": "dtrupenn", "id": 872147, "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"]])
    }
    
    override func tearDown() {
        super.tearDown()
        project = nil
    }
    
    func testProjectListViewModel() {
        if let project = project {
            let projectViewModel = ProjectViewModel(project: project)
            
            XCTAssertTrue(projectViewModel.name == "Tetris", "Project name  should b Tetris")
            XCTAssertTrue(projectViewModel.starsCount == "111 stars", "Project star count  should b 11 stars")
            XCTAssertTrue(projectViewModel.description == "A C implementation of Tetris using Pennsim through LC4", "Project description does not match")
        }
        
    }
    
    func testProjectDetailsViewModel() {
        if let project = project {
            let projectDetailsViewModel = ProjectDetailsViewModel(project: project)
            
            XCTAssertTrue(projectDetailsViewModel.repoName == "Tetris", "Project name  should b Tetris")
            XCTAssertTrue(projectDetailsViewModel.starsCount == "111 stars", "Stars count string does not match")
            XCTAssertTrue(projectDetailsViewModel.forksCount == "11 forks", "Forks count string does not match")
            XCTAssertTrue(projectDetailsViewModel.username == "dtrupenn", "owner name should b dtrupenn")
            XCTAssertTrue(projectDetailsViewModel.description == "A C implementation of Tetris using Pennsim through LC4", "Project description does not match")
        }
    }
    
    ///MARK: Test failed cases
    func testWrongProjectDetailsViewModel() {
        if let project = project {
            let projectDetailsViewModel = ProjectDetailsViewModel(project: project)
            
            XCTAssertTrue(projectDetailsViewModel.repoName == "Tarris", "Project name  should b Tetris")
            XCTAssertTrue(projectDetailsViewModel.starsCount == "222 stars", "Stars count string does not match")
            XCTAssertTrue(projectDetailsViewModel.starsCount == "111", "Stars count string does not match")
            XCTAssertTrue(projectDetailsViewModel.forksCount == "111 forks", "Forks count string does not match")
            XCTAssertTrue(projectDetailsViewModel.username == "hvaghasia", "owner name should b dtrupenn")
            XCTAssertTrue(projectDetailsViewModel.description == "A C implementation of Tetris using Pennsim through LC4", "Project description does not match.")
        }
    }
    
}
