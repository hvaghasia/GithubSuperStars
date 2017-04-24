//
//  ProjectModelTests.swift
//  GithubSuperStars
//
//  Created by Hardik on 24/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import XCTest
@testable import GithubSuperStars




class ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProject() {
        let project = Project(response: ["id": 1000,
                                           "name": "Alamofire",
                                           "description": "This is the alamofire library which make networking easy",
                                           "forks_count": 111,
                                           "stargazers_count": 100000,
                                           "owner": ["login": "alamofire", "id": 123, "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"]])
        
        XCTAssertTrue(project.id == 1000, "Project Id should b 1000")
        XCTAssertTrue(project.name == "Alamofire", "Project name should b Alamofire")
        XCTAssertTrue(project.starsCount == 100000, "Project stars count should b 100000")
        XCTAssertTrue(project.forksCount == 111, "Project forks count should b 111")

    }
    
    func testUser() {
        let user = User(withUserDict: ["login": "alamofire", "id": 123, "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"])
        
        XCTAssertTrue(user.id == 123, "User Id should b 123")
        XCTAssertTrue(user.loginName == "alamofire", "owner name should b alamofire")
    }
    
}
