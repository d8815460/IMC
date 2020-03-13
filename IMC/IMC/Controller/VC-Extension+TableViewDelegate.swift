//
//  VC-Extension+TableViewDelegate.swift
//  IMC
//
//  Created by 陳駿逸 on 2020/3/13.
//  Copyright © 2020 陳駿逸. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
