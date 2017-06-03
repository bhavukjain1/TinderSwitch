//
//  FacebookLoginWrapper.swift
//  GoogleLoginDemo
//
//  Created by Bhavuk Jain on 17/11/16.
//  Copyright © 2016 Bhavuk Jain. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

typealias FacebookCompletition = (UserDetails?,Error?,Bool) -> Void

class FacebookLoginWrapper {
    
    weak var presentingController:UIViewController?
    
    init(presentingController:UIViewController) {
        self.presentingController = presentingController
    }
    
    
    func login(completition:@escaping FacebookCompletition) {
        
        let login = FBSDKLoginManager()
        login.logOut()
        login.loginBehavior = .browser
        login.logIn(withReadPermissions: ["public_profile","email","user_friends","user_birthday"], from: self.presentingController, handler: { (result, error) -> Void in
            if let newResult = result, error == nil, !newResult.isCancelled {
                let user = UserDetails(facebookID: "", fbToken:FBSDKAccessToken.current().tokenString)
                
                completition(user,nil,true)
            }else {
                completition(nil,error,false)
            }
        })
        
    }
    
    
}
