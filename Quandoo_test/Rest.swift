//
//  Rest.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON
import HTTPStatusCodes
import PromiseKit

let RestInstance = Rest.sharedInstance

typealias Success = (JSON) -> ()
typealias Failure = (NSError?) -> ()
public typealias ParametersType = AnyObject // [String: AnyObject]

/// REST singleton class for communicating with the services
public class Rest {

    /// A shared instance of `RestAPI`, used by top-level request methods
    static let sharedInstance = Rest()

    /// Alamofire manager  that responsible for creating and managing `Request` objects
    private let manager = Alamofire.SessionManager.default

    /// Perform request to specific target
    ///
    /// - Parameter target: Specific target
    /// - Returns: Promise with result or error
    @discardableResult func request(target: Target) -> Promise <JSON> {
        return Promise { fulfill, reject in
            let router = Router(target)
            let request = manager.request(router)
            debugPrint(request)
            request.responseJSON { response in
                if let data = response.data {
                    let responseData = JSON(data: data)
                    debugPrint(responseData)
                }
                if let value = response.result.value, response.isSuccess() {
                    fulfill(JSON(value))
                } else {
                    debugPrint(response.fullDescription)
                    if let error = response.result.error {
                        reject(error)
                    } else {
                        reject(self.defaultRestErrorWith(code: response.response?.statusCode))
                    }
                }
            }
        }
    }

    /// Generate REST error
    ///
    /// - Parameter code: Error code
    /// - Returns: Error object
    private func defaultRestErrorWith(code: Int?) -> NSError {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: code ?? 0, userInfo: [NSLocalizedDescriptionKey: "See response above"])
    }

    /// Perform request with mappable type
    ///
    /// - Parameter target: Specific target
    /// - Returns: Promise with result or error
    @discardableResult func mappableRequest<T: Mappable>(target: Target) -> Promise <T> {
        return Promise { fulfill, reject in
            let router = Router(target)
            let request = manager.request(router)
            debugPrint(request)
            request.responseObject { (response: DataResponse<T>) -> Void in
                if let data = response.data {
                    let responseData = JSON(data: data)
                    debugPrint(responseData)
                }
                if let value = response.result.value, response.isSuccess() {
                    fulfill(value)
                } else {
                    debugPrint(response.fullDescription)
                    if let error = response.result.error {
                        reject(error)
                    } else {
                        reject(self.defaultRestErrorWith(code: response.response?.statusCode))
                    }
                }
            }
        }
    }

    /// Perform request with mappable type
    ///
    /// - Parameter target: Specific target
    /// - Returns: Promise with array result or error
    @discardableResult func arrayMappableRequest<T: Mappable>(target: Target) -> Promise < [T] > {
        return Promise { fulfill, reject in
            let router = Router(target)
            let request = manager.request(router)
            debugPrint(request)
            request.responseArray { (response: DataResponse<[T]>) -> Void in
                if let data = response.data {
                    let responseData = JSON(data: data)
                    debugPrint(responseData)
                }
                if let value = response.result.value, response.isSuccess() {
                    fulfill(value)
                } else {
                    debugPrint(response.fullDescription)
                    if let error = response.result.error {
                        reject(error)
                    } else {
                        reject(self.defaultRestErrorWith(code: response.response?.statusCode))
                    }
                }
            }
        }
    }
}
