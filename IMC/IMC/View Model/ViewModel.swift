//
//  ViewModel.swift
//  IMC
//
//  Created by 陳駿逸 on 2020/3/12.
//  Copyright © 2020 陳駿逸. All rights reserved.
//

import UIKit

/**
 #1 - Define a closure TYPE for updating a UIImageView once an image downloads.
 
 - parameter imageData: raw NSData making up the image
 */
public typealias ImageDownloadCompletionClosure = (_ imageData: NSData ) -> Void



// MARK: - #2 - View Model
class UserViewModel {
    // #3 - I use some private properties solely for
    // preparing data for presentation in the UI.
    private let userDataModel: UserDataModel
    
    private var imageURL: URL
    
    private var updateData: Date?
    
    init(userDataModel: UserDataModel) {
        self.userDataModel = userDataModel
        self.imageURL = URL(string: userDataModel.avatar_url)!
    }
    
    public var login: String {
        return userDataModel.login
    }
    
    public var siteAdmin: Bool {
        return userDataModel.site_admin
    }
    
    // #4 - Controversial? Is passing a completion handler into the view
    // model problematic? Should I use KVO or delegation? All's I'm
    // doing is getting some NSData/Data.
    func download(completionHanlder: @escaping ImageDownloadCompletionClosure)
    {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:imageURL)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let rawImageData = NSData(contentsOf: tempLocalUrl)
                    completionHanlder(rawImageData!)
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(String(describing: error?.localizedDescription))")
            }
        } // end let task
        
        task.resume()
        
    } // end func download
}
