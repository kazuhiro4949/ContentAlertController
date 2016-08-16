//
//  AlertControllerFactory.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/14/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class AlertControllerFactory {
    let style: AlertController.Style
    let customView: UIView
    var actions = [AlertAction]()
    var configuration: AlertControllerConfiguration
    
    init(style: AlertController.Style, customView: UIView, config: AlertControllerConfiguration) {
        self.style = style
        self.customView = customView
        configuration = config
    }
    
    func generate() -> UIViewController {
        let bundle = NSBundle(path: NSBundle.mainBundle().pathForResource("ContentAlertController", ofType: "bundle")!)

        switch style {
        case .Alert where (0...2) ~= actions.count:
            let vc = UINib(nibName: "CompactAlertViewController", bundle: bundle).instantiateWithOwner(nil, options: nil)[0] as! CompactAlertViewController
            vc.customView = customView
            vc.actions = actions
            vc.configuration = configuration
            return vc
        case .Alert:
            let vc = UIStoryboard(name: "RegularAlertController", bundle: bundle).instantiateInitialViewController() as! RegularAlertController
            vc.customView = customView
            vc.style = .Alert
            vc.actions = actions
            vc.configuration = configuration
            return vc
        case .ActionSheet:
            let vc = UIStoryboard(name: "RegularAlertController", bundle: bundle).instantiateInitialViewController() as! RegularAlertController
            vc.customView = customView
            vc.style = .ActionSheet
            vc.actions = actions
            vc.configuration = configuration
            return vc
        }
    }
}