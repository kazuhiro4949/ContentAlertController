//
//  RegularAlertController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 7/11/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit
import ObjectiveC

class RegularAlertController: UIViewController {
    enum Style {
        case Alert
        case ActionSheet
    }
    
    var customView: UIView?
    var style: AlertController.Style = .Alert
    var configuration: AlertControllerConfiguration = .defaultConfiguration

    private var tableVC: RegularAlertTableViewController?
    
    private var upperLimitHeight: CGFloat {
        let windowHeight = UIApplication.sharedApplication().keyWindow?.bounds.height ?? CGFloat(0)
        return windowHeight - CGFloat(24)
    }
    
    var actions = [AlertAction]()
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var separatorContainerView: UIVisualEffectView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var tableContainerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentContainerView: UIVisualEffectView!
    
    // for ActionSheet Style
    @IBOutlet weak var cancelContainerView: UIVisualEffectView!
    @IBOutlet weak var cancelContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonLabel: UILabel!
    @IBOutlet weak var contentContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentContainerBottomToParentConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cancelButtonHighlightView: UIVisualEffectView!
    
    
    @IBOutlet weak var alertButton: CompactAlertButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelContainerView.effect = configuration.blurEffectStyle.map { UIBlurEffect(style: $0) }
        cancelContainerView.backgroundColor = configuration.backgroundColor
        contentContainerView.backgroundColor = configuration.backgroundColor
        cancelContainerView.effect = configuration.blurEffectStyle.map { UIBlurEffect(style: $0) }
        contentContainerView.effect = configuration.blurEffectStyle.map { UIBlurEffect(style: $0) }
        
        if let customView = customView {
            contentScrollView.addSubview(customView)
            
            customView.translatesAutoresizingMaskIntoConstraints = false
            
            let customViewSizeRatio = customView.frame.height / customView.frame.width
            let widthInScrollView  = style.preferredWidth
            let heightInScrollView = style.preferredWidth * customViewSizeRatio
            customView.widthAnchor.constraintEqualToConstant(widthInScrollView).active = true
            customView.heightAnchor.constraintEqualToConstant(heightInScrollView).active = true
            
            customView.topAnchor.constraintEqualToAnchor(contentScrollView.topAnchor).active = true
            customView.leadingAnchor.constraintEqualToAnchor(contentScrollView.leadingAnchor).active = true
            customView.bottomAnchor.constraintEqualToAnchor(contentScrollView.bottomAnchor).active = true
            customView.trailingAnchor.constraintEqualToAnchor(contentScrollView.trailingAnchor).active = true
        }
        contentScrollView.layoutSubviews()

        cancelContainerView.layer.cornerRadius = 12
        cancelContainerView.layer.masksToBounds = true
        
        switch style {
        case .Alert:
            let cancel = actions.filter({ (action: AlertAction) -> Bool in
                return action.style == .Cancel
            })
            let others = actions.filter({ (action: AlertAction) -> Bool in
                return action.style != .Cancel
            })
            tableVC?.actions = others + cancel
            tableVC?.cellHeight = CGFloat(44)
            contentContainerViewBottomConstraint.active = false
            contentContainerView.layer.cornerRadius = configuration.cornerRadius ?? 12
            contentContainerView.layer.masksToBounds = true
            cancelContainerView.hidden = true
        case .ActionSheet:
            let cancel = actions.filter({ (action: AlertAction) -> Bool in
                return action.style == .Cancel
            }).first
            if let cancel = cancel {
                cancelButtonLabel.text = cancel.title
                cancelButtonLabel.textColor = cancel.configuration.textColor
                cancelButtonLabel.font = cancel.configuration.font
                cancelButtonLabel.backgroundColor = cancel.configuration.backgroundColor
                alertButton.tapGesture = { [weak self] _ in
                    self?.dismissViewControllerAnimated(true, completion: { 
                        cancel.handler?(cancel)
                    })
                }
                cancelContainerView.hidden = false
                contentContainerBottomToParentConstraint.priority = 250
            } else {
                cancelContainerView.hidden = true
                contentContainerBottomToParentConstraint.priority = 751
            }
            let others = actions.filter({ (action: AlertAction) -> Bool in
                return action.style != .Cancel
            })
            tableVC?.actions = others
            tableVC?.cellHeight = CGFloat(57)
            contentContainerView.layer.cornerRadius = configuration.cornerRadius ?? 12
            contentContainerView.layer.masksToBounds = true
            cancelContainerView.hidden = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var contentScrollViewHeight = CGFloat(0)
    
    override func updateViewConstraints() {
        alightHeight()
        
        super.updateViewConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let vc = segue.destinationViewController as? RegularAlertTableViewController {
            tableVC = vc
        }
    }
    
    override var preferredContentSize: CGSize {
        set {
            assertionFailure("cannot set preferredContentSize")
        }
        get {
            tableVC?.tableView.layoutIfNeeded()
            separatorView.layoutIfNeeded()
            contentScrollView.layoutSubviews()
            
            let tableViewHeight = tableContainerViewHeightConstraint.constant ?? CGFloat(0)
            let separatorHeight = separatorView.bounds.height
            let cancelButtonHeight = (style == .ActionSheet) ? cancelContainerViewHeightConstraint.constant : CGFloat(0)
            
            let alertViewHeight = tableViewHeight + contentScrollViewHeight + separatorHeight + cancelButtonHeight
            return CGSize(width: style.preferredWidth, height: alertViewHeight)
        }
    }
    
    private func alightHeight() {
        let preferedTableHeight = tableVC?.preferredContentSize.height ?? CGFloat(0)
        let preferedScrollHeight = customView?.frame.height ?? CGFloat(0)
        
        let upperBoundTableHeight = upperLimitHeight * 3 / 8
        let upperBoundScrollHeight = upperLimitHeight - upperBoundTableHeight
        var totalHeight = upperLimitHeight - separatorView.bounds.height
        
        if case .ActionSheet = style {
            totalHeight -= cancelContainerViewHeightConstraint.constant
        }
        
        if preferedTableHeight + preferedScrollHeight < totalHeight { // not over screen height
            contentScrollViewHeight = preferedScrollHeight
            tableContainerViewHeightConstraint.constant = preferedTableHeight
        } else { // over screen height
            if upperBoundScrollHeight < preferedScrollHeight && preferedTableHeight < upperBoundTableHeight { // need to align scrollview height
                contentScrollViewHeight = totalHeight - preferedTableHeight
                tableContainerViewHeightConstraint.constant = preferedTableHeight
            } else if preferedScrollHeight < upperBoundScrollHeight && upperBoundTableHeight < preferedTableHeight { // need to align tableview height
                contentScrollViewHeight = preferedScrollHeight
                tableContainerViewHeightConstraint.constant = totalHeight - preferedScrollHeight
            } else { // need to align both height
                contentScrollViewHeight = upperBoundScrollHeight
                tableContainerViewHeightConstraint.constant = upperBoundTableHeight
            }
        }
    }
}
