//
//  AlertControllerConfiguration.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/14/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public struct AlertControllerConfiguration {
    public let backgroundColor: UIColor
    public let blurEffectStyle: UIBlurEffectStyle?
    public let cornerRadius: CGFloat?
    
    public static var defaultConfiguration: AlertControllerConfiguration {
        return AlertControllerConfiguration(
            backgroundColor: .clearColor(),
            blurEffectStyle: .ExtraLight,
            cornerRadius: nil
        )
    }
}
