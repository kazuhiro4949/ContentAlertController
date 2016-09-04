//
//  ContentAlertController.swift
//  ContentAlertController
//
//  Created by Kazuhiro Hayashi on 8/31/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit


/**
 ContentAlertController likes UIAlertController. You can show any custom view on AlertView and ActionSheet.
 
 After configuring the alert controller with the actions and style you want, present it using the presentViewController:animated:completion: method.
 In addition to displaying a message to a user, you can associate actions with your alert controller to give the user a way to respond. For each action you add using the addAction: method, the alert controller configures a button with the action details. When the user taps that action, the alert controller executes the block you provided when creating the action object. Listing 1 shows how to configure an alert with a single action.
 
 ### Usage
 If you wanna show a view that has red background color. you can put the custom view as follows.
 ```
 let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
 view.backgroundColor = .redColor()
 
 let alertVC = ContentAlertController(customView: view, preferredStyle: .Cancel)
 alertVC.addAction(AlertAction(title: "Cancel", style: .Cancel, handler: nil))
 presentViewController(alertVC, animated: true, completion: nil)
 ```
 */
public class ContentAlertController: AlertController {
    /**
     make a ViewController object where you can put custom view.
     
     - parameter customView:     any view you wanna put
     - parameter preferredStyle: Alert or ActionSheet
     - parameter config:         custom design setting
     
     - returns: CotentAlertController object
     */
    public convenience init(customView: UIView, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        self.init(nibName: nil, bundle: nil)
        
        factory = AlertControllerFactory(
            style: preferredStyle,
            customView: customView,
            config: config ?? .defaultConfiguration
        )
    }
}
