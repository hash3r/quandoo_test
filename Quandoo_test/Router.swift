//
//  Router.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public typealias PathType = String

public protocol Task {
    func path() -> PathType
    func method() -> Alamofire.HTTPMethod
    func params() -> ParametersType?
}

/// Intermediate REST sources
enum Endpoint {
    case User
    case Post
}

/// Target combines endpoint and task for Router
public struct Target {
    var endpoint: Endpoint
    var task: Task
    
    var fullpath: PathType {
        switch endpoint {
        case .User: return "/users\(task.path())"
        case .Post: return "/posts\(task.path())"
        }
    }
    
    init(_ endpoint: Endpoint, _ task: Task) {
        self.endpoint = endpoint
        self.task = task
    }
}


/// Common REST tasks
enum CRUDTask: Task {

    case Create(ParametersType)
    case Read(PathType)
    case ReadAll
    case Update(PathType, ParametersType)
    case Delete(PathType)

    func path() -> PathType {
        switch self {
        case .Read(let PathType): return "/\(PathType)"
        case .ReadAll: return ""
        case .Update(let PathType, _): return "/\(PathType)"
        case .Delete(let PathType): return "/\(PathType)"
        default: return ""
        }
    }

    func method() -> Alamofire.HTTPMethod {
        switch self {
        case .Create: return .post
        case .Read, .ReadAll: return .get
        case .Update: return .put
        case .Delete: return .delete
        }
    }

    func params() -> ParametersType? {
        switch self {
        case .Create(let params): return params
        case .Read, .ReadAll: return nil
        case .Update(_, let params): return params
        case .Delete: return nil
        }
    }
}

/// Post tasks
enum PostTask: Task {
    case UsersPosts(PathType)

    func path() -> PathType {
        switch self {
        case .UsersPosts(let id): return "?userId=\(id)"
        }
    }

    func method() -> Alamofire.HTTPMethod {
        switch self {
        case .UsersPosts: return .get
        }
    }

    func params() -> ParametersType? {
        switch self {
        case .UsersPosts: return nil
        }
    }
}

/// Router helps to manage requests to specific target
public struct Router: URLRequestConvertible {

    static let baseURLString = Configuration.sharedConfig.baseURL
    static let apiVersion = Configuration.sharedConfig.apiVersion

    var target: Target

    init(_ target: Target) {
        self.target = target
    }

    var baseUrlString: String {
        switch target.endpoint {
        default: return Router.baseURLString + Router.apiVersion
        }
    }

    func encodeRequest(request: URLRequest) -> URLRequest {
        var encodedRequest = request
        if encodedRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            encodedRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let params = target.task.params() {
            let data = try? JSON(params).rawData()
            encodedRequest.httpBody = data
        }
        return encodedRequest
    }

    var fullURL: URL {
        return URL(string: baseUrlString + target.fullpath)!
    }
    
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: fullURL as URL)
        request.httpMethod = target.task.method().rawValue
        return encodeRequest(request: request)
    }
}
