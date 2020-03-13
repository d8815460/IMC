//
//  ViewController.swift
//  IMC
//
//  Created by 陳駿逸 on 2020/3/12.
//  Copyright © 2020 陳駿逸. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }

    func loadData() {
        GithubAPI.sharedInstance.getUsers { (successed, response) in
            print("response")
        }
    }
}

