//
//  ResponseExt.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import Foundation
import HTTPStatusCodes
import Alamofire
import SwiftyJSON

let kUnauthorizedNotification = "kUnauthorizedNotification"

extension DataResponse {
    /// Check whether response is successful
    ///
    /// - Returns: true if status code between 200...299
    func isSuccess() -> Bool {
        if let code = response?.statusCode, let statusCode = HTTPStatusCode(rawValue: code) {
            if statusCode == .unauthorized {
                // Show alert or auth screen
            }
            return statusCode.isSuccess
        }
        return false
    }

    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the server data and the response serialization result.
    public var fullDescription: String {
        var output: [String] = []
        output.append(request != nil ? "[Request]: \(request!)" : "[Request]: nil")
        output.append(response != nil ? "[Response]: \(response!)" : "[Response]: nil")
//        output.append("[Data]: \(data?.length ?? 0) bytes")
        output.append("[Result]: \(result.debugDescription)")
        output.append("[Timeline]: \(timeline.debugDescription)")
        if let data = data {
            let responseData = JSON(data: data)
            output.append("[Data]: \(responseData.debugDescription)")
        }
        return output.joined(separator: "\n")
    }
}
