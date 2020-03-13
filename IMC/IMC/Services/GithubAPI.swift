//
//  GithubAPI.swift
//  IMC
//
//  Created by 陳駿逸 on 2020/3/12.
//  Copyright © 2020 陳駿逸. All rights reserved.
//

import UIKit
import Alamofire

class GithubAPI {
    
    // MARK: API init & setting
    
    static let sharedInstance = GithubAPI()
    fileprivate let alamoFireManager : Alamofire.SessionManager!
    
    init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // seconds
        configuration.timeoutIntervalForResource = 60
        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    fileprivate func getStatusCodeFrom(_ response: DataResponse<Any>  ) -> Int {
        if let httpError = response.result.error?._code {
            return httpError
        } else {
            return (response.response?.statusCode)!
        }
    }
    
    fileprivate func validateResponseSuccess(_ response: DataResponse<Any>) -> Bool {
        print("Request: \(response.request!)")
        let success = response.result.isSuccess && (self.getStatusCodeFrom(response) == 200)
        print(success ? "SUCCESS" : "FAILURE")
        return success
    }
    
    
    // MARK: API Calls
    func getUsers(handler: @escaping (_ success: Bool, _ response: [UserDataModel]?) -> Void) {
        
        self.alamoFireManager.request(baseUrl+getUsersPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).validate(contentType: ["application/json"]).responseJSON { (response) in
            
            let success = self.validateResponseSuccess(response)
            
            if (success) {
                do {
                    let users = try JSONDecoder().decode([UserDataModel].self, from: response.data!)
                    handler(true, users)
                } catch {
                    handler(false, nil)
                }
            } else {
                handler(false, nil)
            }
        }
    }
}
