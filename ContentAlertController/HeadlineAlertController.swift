//
//  HeadlineAlertController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/13/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public class HeadlineAlertController: AlertController {

    public convenience init(title: String, message: String, image: UIImage, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        let view = HeadlineAlertController.customView
        view.titleLabel.text = title
        view.detailLabel.text = message
        view.imageView.image = image
        
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame.size.width = preferredStyle.preferredWidth
        view.contentView.setNeedsLayout()
        view.contentView.layoutIfNeeded()
        view.frame.size = view.contentView.bounds.size
        
        self.init(nibName: nil, bundle: nil)
        
        factory = AlertControllerFactory(
            style: preferredStyle,
            customView: view,
            config: config ?? .defaultConfiguration
        )
    }
    
    public convenience init(title: String, message: String, imageUrl: NSURL, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        let view = HeadlineAlertController.customView
        view.titleLabel.text = title
        view.detailLabel.text = message
        
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame.size.width = preferredStyle.preferredWidth
        view.contentView.setNeedsLayout()
        view.contentView.layoutIfNeeded()
        view.frame.size = view.contentView.bounds.size
        
        let session = NSURLSession(configuration: .defaultSessionConfiguration(), delegate: nil, delegateQueue: .mainQueue())
        session.dataTaskWithURL(imageUrl) { (data, resp, error) in
            guard let data = data else {
                return
            }
            
            view.imageView.image = UIImage(data: data)
        }
        .resume()
        
        self.init(nibName: nil, bundle: nil)
        
        factory = AlertControllerFactory(
            style: preferredStyle,
            customView: view,
            config: config ?? .defaultConfiguration
        )
    }
    
    private static var customView: HeadlineView {
        return UINib(
            nibName: "HeadlineView",
            bundle: NSBundle(forClass: HeadlineAlertController.self)
        )
        .instantiateWithOwner(nil, options: nil).first as! HeadlineView
    }
}
