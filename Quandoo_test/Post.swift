//
//  Post.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post: Mappable {
    var userId: String?
    var postId: String?
    var title: String?
    var body: String?
    
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        userId <- map["userId"]
        postId <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
}
