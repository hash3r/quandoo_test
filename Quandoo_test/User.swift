//
//  User.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var userId: Int?
    var name: String?
    var username: String?
    var email: String?
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?

    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        userId <- map["id"]
        name <- map["name"]
        username <- map["username"]
        email <- map["email"]
        street <- map["address.street"]
        suite <- map["address.suite"]
        city <- map["address.city"]
        zipcode <- map["address.zipcode"]
    }
}

extension User {
    
    /// Generate full address from details
    ///
    /// - Returns: Concatenated address details
    func fullAddress() -> String {
        var address = ""
        if let street = street {
            address += street
        }
        if let suite = suite {
            address = address.isEmpty == false ? address + ", " + suite : suite
        }
        if let city = city {
            address = address.isEmpty == false ? address + ", " + city : city
        }
        if let zipcode = zipcode {
            address = address.isEmpty == false ? address + ", " + zipcode : zipcode
        }
        return address
    }

}
