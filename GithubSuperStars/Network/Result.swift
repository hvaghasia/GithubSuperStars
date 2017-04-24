//
//  Result.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation


public enum Result<T> {
    case success(T)
    case failure(Error)
}
