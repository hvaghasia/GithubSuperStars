//
//  WebserviceTests.swift
//  GithubSuperStars
//
//  Created by Hardik on 24/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import XCTest
@testable import GithubSuperStars

class WebserviceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testGetStarProjects() {
        let expectation = self.expectation(description: "GetGithubStarProjects")
        
        NetworkManager.default.getStarProjects {(result) in
            switch (result) {
            case .success(let projects):
                XCTAssertTrue(projects.count != 0, "Project list count should not zero")
            case .failure(let error):
                XCTAssert(false, error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler:nil)
    }
    
    func testGetReadMe() {
        
        let project = Project(response: ["id": 3081286,
                                         "name": "Tetris",
                                         "description": "A C implementation of Tetris using Pennsim through LC4",
                                         "forks_count": 0,
                                         "stargazers_count": 1,
                                         "owner": ["login": "dtrupenn", "id": 872147, "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"]])

        
        let expectation = self.expectation(description: "GetReadMe")
        
        NetworkManager.default.getReadMe(forProject: project, completionHandler: { result in
            switch (result) {
            case .success(let readMeArray):
                XCTAssertTrue(readMeArray.count != 0, "ReadMe objects count should not b zero")
                
            case .failure(let error):
                XCTAssert(false, error.localizedDescription)
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10.0, handler:nil)
    }
    
}
