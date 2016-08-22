//
//  AlertActionConfiguration.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/14/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public struct AlertActionConfiguration {
    public let textColor: UIColor
    public let font: UIFont
    public let backgroundColor: UIColor
    
    public static var defaultConfig: AlertActionConfiguration {
        return AlertActionConfiguration(
            textColor: .systemBlueColor(),
            font: .systemFontOfSize(17),
            backgroundColor: .clearColor()
        )
    }
    
    public static var cancelConfig: AlertActionConfiguration {
        return AlertActionConfiguration(
            textColor: .systemBlueColor(),
            font: .boldSystemFontOfSize(17),
            backgroundColor: .clearColor()
        )
    }
    
    public static var destructiveConfig: AlertActionConfiguration {
        return AlertActionConfiguration(
            textColor: .systemRedColor(),
            font: .boldSystemFontOfSize(17),
            backgroundColor: .clearColor()
        )
    }
}
