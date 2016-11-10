//
//  PostCell.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    var data: Post? {
        didSet {
            titleLabel.text = data?.title ?? ""
            bodyLabel.text = data?.body ?? ""
        }
    }
}
