//
//  VC-Extension+TableViewDataSource.swift
//  IMC
//
//  Created by 陳駿逸 on 2020/3/13.
//  Copyright © 2020 陳駿逸. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersViewModel.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell

        cell.userImage.alpha = 0.0
        // #1 - Define a closure (completion block) INSTANCE for updating a UIImageView
        // once an image downloads.
        let imageCompletionClosure = { (imageData: NSData) -> Void in
            // #2 - Download occurs on background thread, but UI update
            // MUST occur on the main thread.
            DispatchQueue.main.async {
                
                // #3 - Animate the appearance of the Messier image.
                UIView.animate(withDuration: 1.0, animations: {
                    cell.userImage.alpha = 1.0
                    cell.userImage?.image = UIImage(data: imageData as Data)
                    self.view.setNeedsDisplay()
                })
                
                // #4 - Stop and hide the activity spinner as the
                // image has finished downloading
                cell.activitySpinner.stopAnimating()
                
            } // end DispatchQueue.main.async
        }
        // #5 - Start and show the activity spinner as the
        // image is about to start downloading in background.
        cell.activitySpinner.startAnimating()
        
        // #6 - Update the UI with info from the Messier object
        // Configure the cell...
        cell.name.text = usersViewModel[indexPath.row].login
        cell.staff.isHidden = usersViewModel[indexPath.row].siteAdmin
        
        // #7 - Start image downloading in background.
        usersViewModel[indexPath.row].download(completionHanlder: imageCompletionClosure)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

}
