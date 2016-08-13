//
//  AlertAction.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/14/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

public struct AlertAction {
    public enum Style {
        case Default
        case Cancel
        case Destructive
    }
    
    public init(title: String?, style: Style, config: AlertActionConfiguration? = nil, handler: ((AlertAction) -> Void)?) {
        self.title = title
        self.style = style
        self.handler = handler
        self.enabled = true
        switch style {
        case .Default:
            self.configuration = config ?? .defaultConfig
        case .Cancel:
            self.configuration = config ?? .cancelConfig
        case .Destructive:
            self.configuration = config ?? .destructiveConfig
        }
    }
    
    public let title: String?
    public let style: Style
    let handler: ((AlertAction) -> Void)?
    public let enabled: Bool
    let configuration: AlertActionConfiguration
}