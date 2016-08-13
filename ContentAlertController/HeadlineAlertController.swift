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
        guard let view = UINib(nibName: "HeadlineView", bundle: nil).instantiateWithOwner(nil, options: nil).first as? HeadlineView else {
            fatalError("should have HeadlineView class in HeadlineView.nib")
        }
        
        view.titleLabel.text = title
        view.detailLabel.text = message
        view.imageView.image = image
        
        view.frame.size.width = preferredStyle.preferredWidth
        view.contentView.setNeedsLayout()
        view.contentView.layoutIfNeeded()
        view.frame.size = view.contentView.bounds.size
        self.init(customView: view, preferredStyle: preferredStyle, config: config)
    }
}
