//
//  MainAPIOperation.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation

// Completion handler that fires at the end of a `APIOperationCompletionHandler`
public typealias APIOperationCompletionHandler = (Result<[Any]>) -> Void

/**
 Composite class that brings together network requests (`NetworkOperation`),
 JSON parsing (`ParseJSONOperation`) as a single operation.
 */
class MainAPIOperation<T: JSONDecodable>: Operation {
    fileprivate let request: APIRequest
    fileprivate var session: URLSession!
    var completionHandler: APIOperationCompletionHandler?
    fileprivate var parsedObjects: [Any]?
    fileprivate let internalQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "JsonAPIOperation Internal Queue"
        return queue
    }()
    /// The last thing we do before exit.
    fileprivate var finalOperation: BlockOperation!
    
    // MARK: Operation Property Overrides
    private var internalExecuting: Bool = false
    override dynamic var isExecuting: Bool {
        get {
            return internalExecuting
        }
        
        set(newValue) {
            willChangeValue(forKey: "isExecuting")
            internalExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var internalFinished: Bool = false
    override dynamic var isFinished: Bool {
        get {
            return internalFinished
        }
        set (newAnswer) {
            willChangeValue(forKey: "isFinished")
            internalFinished = newAnswer
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    // MARK: Initialization
    init(requestTemplate: APIRequest,
         session: URLSession,
         qos: QualityOfService = .default,
         completionHandler: APIOperationCompletionHandler?) {
        self.request = requestTemplate
        self.session = session
        self.internalQueue.qualityOfService = qos
        self.completionHandler = completionHandler
        super.init()
        
        self.qualityOfService = qos
    }
    
    // MARK: Operation gets started
    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
        
        internalQueue.isSuspended = true
        
        let requestOperation = NetworkOperation(requestTemplate: request, session: session)
        requestOperation.qualityOfService = self.qualityOfService
        requestOperation.completionHandler = { [weak self] result in
            switch (result) {
            case .success(let responseData):
                self?.convertDataToJSON(responseData: responseData)
                break
            case .failure(let error):
                if let completion = self?.completionHandler {
                    completion(Result.failure(error))
                }
                
                self?.isFinished = true
                break
            }
        }
        
        internalQueue.addOperation(requestOperation)
        
        // Send back parsed objects to subscriber block
        finalOperation = BlockOperation(block: { [weak self] in
            if let completion = self?.completionHandler,
                let objects = self?.parsedObjects {
                DispatchQueue.main.async {
                    completion(Result.success(objects))
                }
            }
            
            self?.isFinished = true
        })
        
        internalQueue.isSuspended = false
    }
}



// MARK: Private/Convenience
private extension MainAPIOperation {
    
    //Fire off an internal operation to parse JSON object.
    func convertDataToJSON(responseData: Data) {
        
        
        do {
            /// convert Data to JSON
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
            
            let jsonOperation = ParseJSONOperation<T>(json: jsonData)
            jsonOperation.qualityOfService = self.qualityOfService
            jsonOperation.completionHandler = { [weak self] result in
                switch (result) {
                case .success(let objects):
                    self?.parsedObjects = objects
                    break
                case .failure(let error):
                    if let completion = self?.completionHandler {
                        completion(Result.failure(error))
                    }
                    self?.isFinished = true
                }
            }
            
            finalOperation.addDependency(jsonOperation)
            internalQueue.addOperation(finalOperation)
            
            internalQueue.addOperation(jsonOperation)
        } catch {
            completionHandler?(Result.failure(NetworkError.corruptedData))
        }
    }
}
