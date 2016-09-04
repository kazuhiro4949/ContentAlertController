//
//  HeadlineAlertController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/13/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

/**
 HeadAlertController is kind of ContentAlertController. The customView has been already put.
 You can set parameters to the custom view.
 
 After configuring the alert controller with the actions and style you want, present it using the presentViewController:animated:completion: method.
 In addition to displaying a message to a user, you can associate actions with your alert controller to give the user a way to respond. For each action you add using the addAction: method, the alert controller configures a button with the action details. When the user taps that action, the alert controller executes the block you provided when creating the action object. Listing 1 shows how to configure an alert with a single action.
 
 ### Usage
 If you wanna show a news headline. you can put the title, detail description and image as follows.
 
 ```
 let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Salvatore_Sirigu.jpg/220px-Salvatore_Sirigu.jpg")!
 
 let alertVC = HeadlineAlertController(
                    title: "Sevilla signs Sirigu on loan from Paris SG", 
                    message: "On Friday, French capital football club Paris Saint-Getmain announced they loaned Italian goalkeeper Salvatore Sirigu to Spanish club Sevilla F.C. till the season end.", 
                    imageUrl: url, preferredStyle: .Alert
               )
 alertVC.addAction(AlertAction(title: "OK", style: .Cancel, handler: nil))
 presentViewController(alertVC, animated: true, completion: nil)
 ```
 */
public class HeadlineAlertController: AlertController {

    /**
     make a ViewController object where you can set a title, message, image
     
     - parameter title:          headline title
     - parameter message:        headline description
     - parameter image:          headline image
     - parameter preferredStyle: Alert or ActionSheet
     - parameter config:         custom design setting
     
     - returns: CotentAlertController object
     */
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
    
    
    /**
     make a ViewController object where you can set a title, message, image from the web
     
     - parameter title:          headline title
     - parameter message:        headline description
     - parameter imageUrl:          headline image url
     - parameter preferredStyle: Alert or ActionSheet
     - parameter config:         custom design setting
     
     - returns: CotentAlertController object
     */
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
