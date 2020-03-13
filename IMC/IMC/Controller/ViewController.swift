//
//  ViewController.swift
//  IMC
//
//  Created by 陳駿逸 on 2020/3/12.
//  Copyright © 2020 陳駿逸. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var usersViewModel: [UserViewModel] = [UserViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func loadData() {
        GithubAPI.sharedInstance.getUsers { (successed, users) in
            // MARK: - #1 - App data through ViewModel
            for user in users ?? [UserDataModel]() {
                self.usersViewModel.append(UserViewModel(userDataModel: user))
            }
            self.tableView.reloadData()
            self.tableView.setNeedsDisplay()
        }
    }
}

