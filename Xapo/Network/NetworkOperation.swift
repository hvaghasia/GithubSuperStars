//
//  NetworkOperation.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation


/// Completion handler to b called when network operation gets completed
public typealias NetworkOperationCompletionHandler = (Result<Data>) -> Void

/// Operation which sends request to server
internal final class NetworkOperation: Operation {
    var completionHandler: NetworkOperationCompletionHandler?
    /// The template for the NSURLRequest that is to be passed to network queue
    fileprivate var requestTemplate: APIRequest?
    fileprivate var session: URLSession!
    fileprivate var sessionTask: URLSessionTask?
    
    // MARK: Operation Property Overrides
    override var isAsynchronous: Bool {
        return true
    }
    
    private var internalFinished: Bool = false
    override dynamic var isFinished: Bool {
        get {
            return internalFinished
        }
        set (newValue) {
            willChangeValue(forKey: "isFinished")
            internalFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    // MARK: Initializers
    // Initialize an NetworkOperation based off an `APIRequest`
    init(requestTemplate: APIRequest, session: URLSession, qos: QualityOfService = .default) {
        super.init()
        self.requestTemplate = requestTemplate
        self.qualityOfService = qos
        self.session = session
    }
    
    // MARK: Operation gets started
    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
        
        guard let request = requestTemplate?.constructRequest() else {
            isFinished = true
            return
        }
        
        sessionTask = session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let weakSelf = self else { return }
            
            if weakSelf.isCancelled {
                weakSelf.isFinished = true
                weakSelf.sessionTask?.cancel()
                return
            }
            
            if let e = error {
                weakSelf.completionHandler?(Result.failure(e))
                weakSelf.isFinished = true
                return
            }
            
            // If we have a completion handler, we should go ahead and pass the result back to parse JSON
            if let completion = weakSelf.completionHandler,
                let data = data {
                completion(Result.success(data))
            }
            
            weakSelf.isFinished = true
        })
        sessionTask?.resume()
    }
}
