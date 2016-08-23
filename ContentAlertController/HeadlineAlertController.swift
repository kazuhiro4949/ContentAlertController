//
//  HeadlineAlertController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/13/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public class HeadlineAlertController: AlertController {
    private static let headlineView = {
        UINib(nibName: "HeadlineView", bundle: NSBundle(forClass: HeadlineAlertController.self)).instantiateWithOwner(nil, options: nil).first as! HeadlineView
    }()
    
    public convenience init(title: String, message: String, image: UIImage, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        let view = HeadlineAlertController.headlineView
        
        view.titleLabel.text = title
        view.detailLabel.text = message
        view.imageView.image = image
        
        view.contentView.frame.size.width = preferredStyle.preferredWidth
        view.contentView.setNeedsLayout()
        view.contentView.layoutIfNeeded()
        view.frame.size = view.contentView.bounds.size
        self.init(customView: view, preferredStyle: preferredStyle, config: config)
    }
}
