//
//  UserCell.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    var data: User? {
        didSet {
            nameLabel.text = data?.name ?? ""
            usernameLabel.text = data?.username ?? ""
            emailLabel.text = data?.email ?? ""
            addressLabel.text = data?.fullAddress() ?? ""
        }
    }
}
