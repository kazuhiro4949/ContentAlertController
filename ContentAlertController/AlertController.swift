//
//  AlertController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 8/7/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    public static func systemBlueColor() -> UIColor {
        return UIColor(colorLiteralRed: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)
    }
    
    public static func systemRedColor() -> UIColor {
        return UIColor(colorLiteralRed: 1.0, green: 0.07, blue: 0.00, alpha: 1.0)
    }
}

public class AlertController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private let factory: AlertControllerFactory
    private var displayedViewController: UIViewController?
    
    public init(customView: UIView, preferredStyle: Style, config: AlertControllerConfiguration? = nil) {
        factory = AlertControllerFactory(
            style: preferredStyle,
            customView: customView,
            config: config ?? .defaultConfiguration
        )
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
    
    public func addAction(action: AlertAction) {
        factory.actions.append(action)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        factory = AlertControllerFactory(style: .Alert, customView: UIView(), config: .defaultConfiguration)
        
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        factory = AlertControllerFactory(style: .Alert, customView: UIView(), config: .defaultConfiguration)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        displayedViewController = factory.generate()
        
        if let vc = displayedViewController {
            self.addChildViewController(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = true
            vc.view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            self.view.addSubview(vc.view)
            vc.didMoveToParentViewController(self)
        }        
    }

    public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return factory.style.presentationController(presented: presented, presenting: presenting)
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return factory.style.presentAnimator()
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return factory.style.dismissAnimator()
    }
    
    override public var preferredContentSize: CGSize {
        set {
            assertionFailure("cannot set preferredContentSize")
        }
        get {
            return displayedViewController?.preferredContentSize ?? CGSize.zero
        }
    }
}

public extension AlertController {
    public enum Style {
        case ActionSheet
        case Alert
        
        func presentationController(presented presented: UIViewController, presenting: UIViewController) -> UIPresentationController? {
            switch self {
            case .Alert:
                return AlertPresentationController(presentedViewController: presented, presentingViewController: presenting)
            case .ActionSheet:
                return ActionSheetPresentationController(presentedViewController: presented, presentingViewController: presenting)
            }
        }
        
        func presentAnimator() -> UIViewControllerAnimatedTransitioning? {
            switch self {
            case .Alert:
                return AlertAnimator(style: .present)
            case .ActionSheet:
                return nil
            }
        }
        
        func dismissAnimator() -> UIViewControllerAnimatedTransitioning? {
            switch self {
            case .Alert:
                return AlertAnimator(style: .dismiss)
            case .ActionSheet:
                return nil
            }
        }
        
        var preferredWidth: CGFloat {
            switch self {
            case .Alert:
                return 270
            case .ActionSheet:
                let windowSize = UIApplication.sharedApplication().keyWindow?.bounds.size ?? CGSize.zero
                let preferredWidth = min(windowSize.width, windowSize.height)
                return preferredWidth - CGFloat(16)
            }
        }
    }
}