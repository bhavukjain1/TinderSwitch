//
//  ProgressIndicator.swift
//  ORS
//
//  Created by Bhavuk Jain on 31/05/17.
//  Copyright © 2017 Bhavuk Jain. All rights reserved.
//

import Foundation
import UIKit

public class ProgressIndicator{
    
    private var overlayView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    private var titleLabel = UILabel()
    private weak var currentSuperView:UIView?
    static let shared = ProgressIndicator()
    
    public func show(view: UIView) {
        
        currentSuperView = view
        currentSuperView?.isUserInteractionEnabled = false
        overlayView.frame = CGRect(x: 0, y: 0, width: 120.0, height: 120.0)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width/2, y: overlayView.bounds.height/2)
        activityIndicator.startAnimating()
        
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 90, width: 120.0, height: 20.0)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Loading..."
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        
        overlayView.addSubview(titleLabel)
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
    }
    
    public func hide() {
        currentSuperView?.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
