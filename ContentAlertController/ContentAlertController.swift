//
//  ContentAlertController.swift
//  ContentAlertController
//
//  Created by Kazuhiro Hayashi on 8/31/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public class ContentAlertController: AlertController {
    public convenience init(customView: UIView, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        self.init(nibName: nil, bundle: nil)
        
        factory = AlertControllerFactory(
            style: preferredStyle,
            customView: customView,
            config: config ?? .defaultConfiguration
        )
    }
}
