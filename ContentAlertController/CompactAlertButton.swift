//
//  CompactAlertButton.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 7/19/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class CompactAlertButton: UIControl {

    var tapGesture: ((sender: CompactAlertButton) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var highlighted: Bool {
        didSet {
            if highlighted {
                backgroundColor = .whiteColor()
            } else {
                backgroundColor = .clearColor()
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        tapGesture?(sender: self)
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}
