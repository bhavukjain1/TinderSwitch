//
//  ViewController.swift
//  TinderSwitch
//
//  Created by Bhavuk Jain on 12/04/17.
//  Copyright © 2017 Bhavuk Jain. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationLabel.text = ""
        self.tinderLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectLocation(_ sender: Any) {
        openGoogleMaps()
    }
    
    @IBAction func openTinder(_ sender: Any) {
        if let url = URL(string: "tinder://") {
            if UIApplication.shared.canOpenURL(url) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

extension ViewController:GMSAutocompleteViewControllerDelegate {
    
    fileprivate func openGoogleMaps() {
        
        let controller = GMSAutocompleteViewController()
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: GoogleMaps AutoComplete Delegate Methods
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        
        //        selectedLocationAddress = place.formattedAddress
        let latitude = place.coordinate.latitude
        let longitude = place.coordinate.longitude
        activityIndicator.startAnimating()
        self.updateLocation(lat: latitude, long: longitude, placeName: place.name)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
        Helper.showAlert(withTitle: "Message", message: error.localizedDescription, controller: self)
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    
    fileprivate func updateLocation(lat:Double, long:Double, placeName:String) {
        
        LocationService.updateLocation(lat: lat, long: long) {[weak self] (error, success) in
            if let strongSelf = self {
                strongSelf.activityIndicator.stopAnimating()
                if success {
                    strongSelf.locationLabel.text = placeName
                }else {
                    Helper.showAlert(withTitle: "Message", message: error?.localizedDescription, controller: strongSelf)
                }
            }
        }
    }
    
    fileprivate func tinderLogin() {
        
        LocationService.tinderLogin {[weak self] (error, success) in
            if let _ = self {
                if success {
                    UserDefaults.standard.set(true, forKey: USER_LOOGED_IN)
                }
            }
        }
        
    }
    
}


