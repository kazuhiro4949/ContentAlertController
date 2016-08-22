//
//  ActionSheetPresentationController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 7/31/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class ActionSheetPresentationController: UIPresentationController {
    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ActionSheetPresentationController.didTapOverlayView(_:)))
        view.addGestureRecognizer(recognizer)
        return view
    }()
    
    private var upperLimitHeight: CGFloat {
        let windowHeight = UIApplication.sharedApplication().keyWindow?.bounds.height ?? CGFloat(0)
        return windowHeight - 24
    }
    
    func didTapOverlayView(sender: UITapGestureRecognizer) {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }    

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        overlayView.alpha = 0
        containerView?.insertSubview(overlayView, atIndex: 0)
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition(
            { [weak self] (context) in
                self?.overlayView.alpha = 0.3
            },
            completion: { (_) in }
        )
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition(
            { [weak self] (context) in
                self?.overlayView.alpha = 0
            },
            completion: { (_) in }
        )
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        var size = container.preferredContentSize
        size.height = min(upperLimitHeight, size.height)
        return size
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard let containerViewBounds = containerView?.bounds else {
            return CGRect.zero
        }
        
        var presentedViewFrame = containerViewBounds
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerViewBounds.size)
        presentedViewFrame.origin.x = (containerViewBounds.width - presentedViewFrame.size.width) / 2
        presentedViewFrame.origin.y = (containerViewBounds.height - presentedViewFrame.height - CGFloat(8.0))
        return presentedViewFrame
    }
    
    
    override func containerViewWillLayoutSubviews() {
        overlayView.frame = containerView?.frame ?? CGRect.zero
        presentedView()?.frame = frameOfPresentedViewInContainerView()
    }
}
