//
//  NetworkManager.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

final class NetworkManager {
    ///Higher priority work to be processed.
    fileprivate let foregroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Foreground Network Queue"
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    /// Lower priority units of work to be processed.
    fileprivate let backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Background Network Queue"
        queue.qualityOfService = .background
        return queue
    }()
    
    /// The `URLSession` object you want to use to work with the API.
    private let session: URLSession
    
    // MARK: Initialization
    init(session: URLSession) {
        self.session = session
    }
    
    /// NetworkManager shared instance
    static let `default`: NetworkManager = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return NetworkManager(session: session)
    }()
    
    
    ///Retrieve star project list.
    @discardableResult
    func getStarProjects(completionHandler: APIOperationCompletionHandler?) -> Operation {
        let template = GetStarProjectsRequest()
        let operation = MainAPIOperation<Project>(requestTemplate: template, session: session, completionHandler: completionHandler)
        addToQueue(operation: operation)
        return operation
    }
    
    ///Retrieve readme.
    @discardableResult
    func getReadMe(forProject project: Project,
                   completionHandler: APIOperationCompletionHandler?) -> Operation {
        let template = GetReadMeRequest(withProject: project)
        let operation = MainAPIOperation<ReadMe>(requestTemplate: template, session: session, completionHandler: completionHandler)
        addToQueue(operation: operation)
        return operation
    }
   
    
    
}

// MARK: Private/Convenience
private extension NetworkManager {
    ///Add the Operation to a prioritized operation queue.
    func addToQueue(operation: Operation) {
        if (operation.queuePriority == .low || operation.queuePriority == .veryLow) {
            backgroundQueue.addOperation(operation)
            return
        }
        
        foregroundQueue.addOperation(operation)
    }
}
