//
//  LocationService.swift
//  TinderSwitch
//
//  Created by Bhavuk Jain on 12/04/17.
//  Copyright © 2017 Bhavuk Jain. All rights reserved.
//

import Foundation


class LocationService {
    
    typealias LocationServiceMobileNumberCompletition = (Error?,Bool) -> Void
    class func updateLocation(lat:Double, long:Double, completition: @escaping LocationServiceMobileNumberCompletition) {
        
        let params:[String:String] = ["lat":"\(lat)",
                                   "lon":"\(long)"]
        let token = UserDefaults.standard.object(forKey: TINDER_AUTH_TOKEN) as! String
        let headers:[String:String] = ["X-Auth-Token":token]
        NetworkHandler.composePostRequest(withMethod: "ping", params: params, headers:headers) { (response,error, success) in
            
            if success {
                
                if let JSON = response as? [String:Any] {
                    if  JSON["status"] as? Int == 200
                    {
                        if let message = JSON["error"] as? String {
                            let error = NetworkHandler.gotError(msg: message)
                            completition(error,false)
                        }else {
                            completition(nil,true)
                        }
                        
                        
                    }else {
                        let error = NetworkHandler.gotError(msg: JSON["message"] as? String)
                        completition(error,false)
                    }
                }else {
                    
                    // Error Undesired data in response
                    let error = NetworkHandler.gotError(msg: "Network Error")
                    completition(error,false)
                }
            }else {
                
                // Error in request
                completition(error,false)
                
            }
        }
    }
    
    
    
    typealias LocationServiceLoginCompletition = (Error?,Bool) -> Void
    class func tinderLogin(completition: @escaping LocationServiceLoginCompletition) {
        
        let token = UserDefaults.standard.object(forKey: FB_AUTH_TOKEN) as! String
        let fbId = UserDefaults.standard.object(forKey: FB_USER_ID) as! String
        
        let params:[String:Any] = ["locale":"en-IN",
                                      "force_refresh": false,
                                      "facebook_token":token,
                                      "facebook_id":fbId]
        NetworkHandler.composePostRequest(withMethod: "auth", params: params, headers:nil) { (response,error, success) in
            
            if success {
                
                if let JSON = response as? [String:Any] {
                    if  let token = JSON["token"] as? String
                    {
                        UserDefaults.standard.set(token, forKey: TINDER_AUTH_TOKEN)
                        completition(nil,true)
                    }else {
                        let error = NetworkHandler.gotError(msg: JSON["message"] as? String)
                        completition(error,false)
                    }
                }else {
                    
                    // Error Undesired data in response
                    let error = NetworkHandler.gotError(msg: "Network Error")
                    completition(error,false)
                }
            }else {
                
                // Error in request
                completition(error,false)
                
            }
        }
    }
    
    
    
    class func updateTokenToServer(completition: @escaping LocationServiceLoginCompletition) {
        
        
        let token = UserDefaults.standard.object(forKey: FB_AUTH_TOKEN) as! String
        let name = UserDefaults.standard.object(forKey: FB_USER_NAME) as! String
        
        let params:[String:String] = ["token":token,
                                      "name":name]
        
        NetworkHandler.composePostRequest2(withMethod: "addUser", params: params, headers:nil) { (response,error, success) in
            
            if success {
                
                if let JSON = response as? [String:Any] {
                    if  let token = JSON["token"] as? String
                    {
                        UserDefaults.standard.set(token, forKey: TINDER_AUTH_TOKEN)
                        completition(nil,true)
                    }else {
                        let error = NetworkHandler.gotError(msg: JSON["message"] as? String)
                        completition(error,false)
                    }
                }else {
                    
                    // Error Undesired data in response
                    let error = NetworkHandler.gotError(msg: "Network Error")
                    completition(error,false)
                }
            }else {
                
                // Error in request
                completition(error,false)
                
            }
        }
    }
}
