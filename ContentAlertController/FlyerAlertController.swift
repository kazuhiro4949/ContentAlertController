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
}
