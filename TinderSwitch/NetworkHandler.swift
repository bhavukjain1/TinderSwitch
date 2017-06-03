//
//  NetworkHandler.swift
//  GoogleLoginDemo
//
//  Created by Bhavuk Jain on 16/11/16.
//  Copyright © 2016 Bhavuk Jain. All rights reserved.
//

import Foundation
import Alamofire


let BASE_URL = "https://api.gotinder.com/user/"
let BASE_URL2 = "https://limitless-taiga-15305.herokuapp.com/"

class NetworkHandler {
    
    typealias completitionBlock = (Any?,Error?,Bool) -> Void
    
    class func composePostRequest(withMethod:String, params:[String:Any]?, headers:[String:String]?, completiton:@escaping completitionBlock) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let finalURL = BASE_URL + withMethod
            
            
            Alamofire.request(finalURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
                
                if let JSON = response.result.value {
                    DispatchQueue.main.async {
                        print("\(JSON)")
                        completiton(JSON,nil,true)
                    }
                }else {
                    
                    DispatchQueue.main.async {
                        completiton(nil,response.error,false)
                    }
                    
                }
            }
        }
  
    }
    
    
    class func composePostRequest2(withMethod:String, params:[String:Any]?, headers:[String:String]?, completiton:@escaping completitionBlock) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let finalURL = BASE_URL2 + withMethod
            
            Alamofire.request(finalURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (response) in
                
                if let JSON = response.result.value {
                    DispatchQueue.main.async {
                        print("\(JSON)")
                        completiton(JSON,nil,true)
                    }
                }else {
                    
                    DispatchQueue.main.async {
                        completiton(nil,response.error,false)
                    }
                    
                }
            }
        }
        
    }
    
    class func composeGetRequest(withMethod:String, params:[String:Any]?,completiton:@escaping completitionBlock) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let finalURL = BASE_URL + withMethod
            
            Alamofire.request(finalURL, method: .get, parameters: params, encoding: URLEncoding.default).validate().responseJSON { (response) in
                
                if let JSON = response.result.value {
                    DispatchQueue.main.async {
                        print("\(JSON)")
                        completiton(JSON,nil,true)
                    }
                }else {
                    let error = NetworkHandler.gotError(msg: "Network Handler")
                    DispatchQueue.main.async {
                        completiton(nil,error,false)
                    }
                    
                }
            }
        }
        
    }
    
    class func gotError(msg:String?) -> Error {
        
        var errMsg = "Unknown Error Occurred"
        if msg != nil {
            errMsg = msg!
        }
        let userInfo: [AnyHashable : Any] =
            [
                NSLocalizedDescriptionKey :  NSLocalizedString(errMsg, comment: errMsg),
                NSLocalizedFailureReasonErrorKey : NSLocalizedString(errMsg, comment: errMsg)
        ]
        let error = NSError(domain: "requestError", code: 421, userInfo: userInfo)
        
        return error
    }
}
