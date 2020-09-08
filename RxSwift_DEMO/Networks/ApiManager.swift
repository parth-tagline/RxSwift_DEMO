//
//  ApiManager.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftSpinner

class ApiManager {
    
    static var shared = ApiManager()
    var ALFManager : SessionManager!
    
    //MARK:- POST METHOD API CALL
    
    
    func PostApiCall(params : [String:Any],url: String, completion: @escaping (_ success: Bool, _ data: NSDictionary? , _ errorMsg: String) -> Void) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3000
        ALFManager = Alamofire.SessionManager(configuration: configuration)
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("HEADER : ==>",headers , params)
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response) in
                print("API CALLED")
                print(response)
                print(response.result)
                print(response.data)
                print(response.description)
                switch (response.result) {
                case .success:
                    SwiftSpinner.hide()
                  let responseObj = response.result.value as! NSDictionary
                    
                    
                    completion(true , responseObj , "Success" )
                case .failure:
                    print("IN failure")
                    SwiftSpinner.hide()
                    completion(false, nil,  response.error!.localizedDescription)
                    break
                }
        }
        
        
    }
    
    
    func GetApiCall(url: String, completion: @escaping (_ success: Bool, _ data: NSDictionary? , _ errorMsg: String) -> Void) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3000
        ALFManager = Alamofire.SessionManager(configuration: configuration)
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print("HEADER : ==>",headers )
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response) in
                print(response)
                switch (response.result) {
                case .success:
                    SwiftSpinner.hide()
                  let responseObj = response.result.value as! NSDictionary
                    
                    
                    completion(true , responseObj , "Success" )
                case .failure:
                    print("IN failure")
                    completion(false, nil,  "Sorry. There seem to be some technical issues. Try refresh the page again- sometime it works. :)")
                    break
                }
        }
    }
}
