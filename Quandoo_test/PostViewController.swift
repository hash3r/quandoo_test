//
//  PostViewController.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import UIKit
import PromiseKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var userId: Int?
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        requestPosts(for: userId)
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func requestPosts(for userId: Int?) {
        guard let userId = userId else { return }
        let userTarget = Target(.Post, PostTask.UsersPosts("\(userId)"))
        _ = RestInstance.arrayMappableRequest(target: userTarget).then(execute: { (posts: [Post]) -> () in
            self.posts = posts
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.data = posts[indexPath.row]
        return cell
    }
    
}

