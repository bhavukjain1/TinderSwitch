//
//  LoginViewController.swift
//  TinderSwitch
//
//  Created by Bhavuk Jain on 18/04/17.
//  Copyright © 2017 Bhavuk Jain. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginAction(_ sender: Any) {
        fbLogin()
    }
}


extension LoginViewController {
    
    fileprivate func fbLogin() {
        
        let fbWrapper = FacebookLoginWrapper(presentingController: self)
        fbWrapper.login {[weak self] (user, error, success) in
            guard let strongSelf = self else {return}
            if success {
                UserDefaults.standard.set(user!.facebookID, forKey: FB_USER_ID)
                UserDefaults.standard.set(user!.fbToken, forKey: FB_AUTH_TOKEN)
                UserDefaults.standard.set(UIDevice.current.name, forKey: FB_USER_NAME)
                strongSelf.tinderLogin()
            }else {
                Helper.showAlert(withTitle: "Error", message: error?.localizedDescription, controller: strongSelf)
            }
            
        }
        
    }
    
    private func tinderLogin() {
        
        ProgressIndicator.shared.show(view: self.view)
        LocationService.tinderLogin {[weak self] (error, success) in
            ProgressIndicator.shared.hide()
            if let strongSelf = self {
                if success {
                    UserDefaults.standard.set(true, forKey: USER_LOOGED_IN)
                    strongSelf.updateTokenToServer()
                    strongSelf.performSegue(withIdentifier: "loginSegue", sender: self)
                }else {
                    Helper.showAlert(withTitle: "Error", message: error?.localizedDescription, controller: strongSelf)
                }
            }
        }
        
    }
    
    private func updateTokenToServer() {
            LocationService.updateTokenToServer { (error, success) in
        }
    }
}
