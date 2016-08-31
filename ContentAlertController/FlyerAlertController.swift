//
//  FlyerAlertController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/13/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public class FlyerAlertController: AlertController {
    public convenience init(image: UIImage, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        let view = UINib(
            nibName: "FlyerView",
            bundle: NSBundle(forClass: FlyerAlertController.self)
            ).instantiateWithOwner(nil, options: nil).first as! FlyerView
        view.imageView.image = image
        view.frame.size = image.size
        self.init(customView: view, preferredStyle: preferredStyle, config: config)
    }
    
    public convenience init(imageURL: NSURL, size: CGSize, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        let view = UINib(
            nibName: "FlyerView",
            bundle: NSBundle(forClass: FlyerAlertController.self)
            ).instantiateWithOwner(nil, options: nil).first as! FlyerView
        
        view.frame.size = size
        
        let session = NSURLSession(configuration: .defaultSessionConfiguration(), delegate: nil, delegateQueue: .mainQueue())
        session.dataTaskWithURL(imageURL) { (data, resp, error) in
            guard let data = data else {
                return
            }
            
            view.imageView.image = UIImage(data: data)
        }
        .resume()
        
        self.init(customView: view, preferredStyle: preferredStyle, config: config)
    }

}
