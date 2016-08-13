//
//  RegularAlertTableViewCell.swift
//  CustomAlertControllerTest
//
//  Created by 林　和弘 on 2016/07/13.
//  Copyright © 2016年 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class RegularAlertTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let effect = UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: .Light))
        let selectionView = UIVisualEffectView(effect: effect)
        selectionView.frame = bounds
        selectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        let contentView = UIView(frame: selectionView.bounds)
        contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        contentView.backgroundColor = .whiteColor()
        selectionView.contentView.addSubview(contentView)
        selectedBackgroundView = selectionView
        selectionStyle = .Default
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
