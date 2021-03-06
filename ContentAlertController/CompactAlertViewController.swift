//
//  CompactAlertViewController.swift
//  CustomAlertControllerTest
//
//  Created by 林　和弘 on 2016/07/15.
//  Copyright © 2016年 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class CompactAlertViewController: UIViewController {

    private var upperLimitHeight: CGFloat {
        let windowHeight = UIApplication.sharedApplication().keyWindow?.bounds.height ?? CGFloat(0)
        return windowHeight - CGFloat(24)
    }
    
    let preferredWidth: CGFloat = 270
    var configuration: AlertControllerConfiguration?
    
    var customView: UIView? {
        didSet {
            guard let customView = customView else { return }

            customView.translatesAutoresizingMaskIntoConstraints = false
            contentScrollView.addSubview(customView)
            let customViewSizeRatio = customView.frame.height / customView.frame.width
            customView.widthAnchor.constraintEqualToConstant(preferredWidth).active = true
            customView.heightAnchor.constraintEqualToConstant(preferredWidth * customViewSizeRatio).active = true
            customView.topAnchor.constraintEqualToAnchor(contentScrollView.topAnchor).active = true
            customView.leadingAnchor.constraintEqualToAnchor(contentScrollView.leadingAnchor).active = true
            customView.bottomAnchor.constraintEqualToAnchor(contentScrollView.bottomAnchor).active = true
            customView.trailingAnchor.constraintEqualToAnchor(contentScrollView.trailingAnchor).active = true
        }
    }

    var actions = [AlertAction]() {
        didSet {
            switch actions.count {
            case 0:
                contentScrollViewBottomToParentConstraint.priority = 751
                leftButtonTrailingConstraint.priority = 999
                buttonContainerView.hidden = true
            case 1:
                contentScrollViewBottomToParentConstraint.priority = 250
                leftButtonTrailingConstraint.priority = 999
                let action = actions.first
                alertButtonLabel.first?.text = action?.title
                alertButtonLabel.first?.textColor = action?.configuration.textColor
                alertButtonLabel.first?.backgroundColor = action?.configuration.backgroundColor
                alertButtonLabel.first?.font = action?.configuration.font
                buttonContainerView.hidden = false
            case 2:
                contentScrollViewBottomToParentConstraint.priority = 250
                leftButtonTrailingConstraint.priority = 250
                alertButtonLabel.enumerate().forEach({ (index, label) in
                    label.text = actions[index].title
                    label.textColor = actions[index].configuration.textColor
                    label.backgroundColor = actions[index].configuration.backgroundColor
                    label.font = actions[index].configuration.font
                })
                buttonContainerView.hidden = false
            default:
                assertionFailure("")
            }
        }
    }
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var buttonContainerView: UIView!

    @IBOutlet weak var leftButtonTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentScrollViewBottomToParentConstraint: NSLayoutConstraint!

    @IBOutlet var alertButtonLabel: [UILabel]!
    
    @IBAction func didTouchUpAlertButton(sender: CompactAlertButton) {
        let buttonIndex = sender.tag
        let action = actions[buttonIndex]
        dismissViewControllerAnimated(true) {
            action.handler?(action)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var contentHeight: CGFloat {
        return contentScrollView.contentSize.height + buttonContainerView.bounds.height
    }
    
    override var preferredContentSize: CGSize {
        set {
            assertionFailure("cannot set preferredContentSize")
        }
        get {
            contentScrollView.layoutIfNeeded()
            let scrollViewHeight = min(customView?.bounds.height ?? CGFloat(0), upperLimitHeight)
            let buttonHeight = actions.isEmpty ? CGFloat(0) : buttonContainerView.bounds.height
            return CGSize(width: preferredWidth, height: scrollViewHeight + buttonHeight)
        }
    }
}
