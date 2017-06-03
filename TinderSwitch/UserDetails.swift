//
//  User.swift
//  GoogleLoginDemo
//
//  Created by Bhavuk Jain on 16/11/16.
//  Copyright © 2016 Bhavuk Jain. All rights reserved.
//

import Foundation

class UserDetails {
    

    var facebookID:String
    var fbToken:String
    
    init(facebookID:String, fbToken:String) {
    
        self.facebookID = facebookID
        self.fbToken = fbToken
    }
}
