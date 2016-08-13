//
//  HeadlineView.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/13/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class HeadlineView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = nil
        detailLabel.text = nil
        imageView.image = nil
    }
}
