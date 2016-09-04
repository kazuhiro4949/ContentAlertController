//
//  FlyerAlertController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/13/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

/**
 FlyerAlertController is kind of ContentAlertController. The customView has been already put.
 You can set parameters to the custom view.
 
 After configuring the alert controller with the actions and style you want, present it using the presentViewController:animated:completion: method.
 In addition to displaying a message to a user, you can associate actions with your alert controller to give the user a way to respond. For each action you add using the addAction: method, the alert controller configures a button with the action details. When the user taps that action, the alert controller executes the block you provided when creating the action object. Listing 1 shows how to configure an alert with a single action.
 
 ### Usage
 If you wanna show a news headline. you can put the image.
 
 ```
 let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Salvatore_Sirigu.jpg/220px-Salvatore_Sirigu.jpg")!
 
 let alertVC = FlyerAlertController(
                    imageUrl: url,
                    preferredStyle: .Alert
               )
 alertVC.addAction(AlertAction(title: "OK", style: .Cancel, handler: nil))
 presentViewController(alertVC, animated: true, completion: nil)
 ```
 */
public class FlyerAlertController: AlertController {
    /**
     make a ViewController object where you can set a image
     
     - parameter image:          any image you wanna put
     - parameter preferredStyle: Alert or ActionSheet
     - parameter config:         custom design setting
     
     - returns: CotentAlertController object
     */
    public convenience init(image: UIImage, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        let view = FlyerAlertController.customView
        view.imageView.image = image
        view.frame.size = image.size
        
        self.init(nibName: nil, bundle: nil)
        
        factory = AlertControllerFactory(
            style: preferredStyle,
            customView: view,
            config: config ?? .defaultConfiguration
        )
    }
    
    /**
     make a ViewController object where you can set a image from the web
     
     - parameter imageURL:          any image you wanna put
     - parameter size:              image size
     - parameter preferredStyle: Alert or ActionSheet
     - parameter config:         custom design setting
     
     - returns: CotentAlertController object
     */
    public convenience init(imageURL: NSURL, size: CGSize, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        let view = FlyerAlertController.customView
        view.frame.size = size
        
        let session = NSURLSession(configuration: .defaultSessionConfiguration(), delegate: nil, delegateQueue: .mainQueue())
        session.dataTaskWithURL(imageURL) { (data, resp, error) in
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
    
    private static var customView: FlyerView {
        return UINib(
            nibName: "FlyerView",
            bundle: NSBundle(forClass: FlyerAlertController.self)
        ).instantiateWithOwner(nil, options: nil).first as! FlyerView
    }

}
