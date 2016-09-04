//
//  AlertAction.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/14/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

/**
 A AlertAction object represents an action that can be taken when tapping a button in an alert.
 You use this class to configure information about a single action, including the title to display in the button,
 any styling information, and a handler to execute when the user taps the button. After creating an alert action object,
 add it to a ContentAlertController object before displaying the corresponding alert to the user.
 
 */
public struct AlertAction {
    public enum Style {
        case Default
        case Cancel
        case Destructive
    }
    
    /**
     make and return an action with the specified title and behavior.
     
     - parameter title:   The text to use for the button title. The value you specify should be localized for the user’s current language.
     - parameter style:   Additional styling information to apply to the button. Use the style information to convey the type of action that is performed by the button. For a list of possible values, see the constants in AlertActionStyle.
     - parameter config:  A configuration to customize button design. Avairable configuration is described in AlertActionConfiguration
     - parameter handler: A block to execute when the user selects the action. This block has no return value and takes the selected action object as its only parameter.
     
     */
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