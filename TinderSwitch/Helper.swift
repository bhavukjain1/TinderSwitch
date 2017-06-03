//
//  Helper.swift
//  HouseJoy
//
//  Created by Bhavuk Jain on 27/11/16.
//  Copyright © 2016 Bhavuk Jain. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    class func showAlert(withTitle:String, message:String?, controller:UIViewController) {
        
        let alertController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
