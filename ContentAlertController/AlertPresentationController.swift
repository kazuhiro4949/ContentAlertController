//
//  AlertPresentationController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 7/10/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class AlertPresentationController: UIPresentationController {
    private var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .blackColor()
        view.alpha = 0.0
        return view
    }()
    
    var height = CGFloat(140)
    
    private var upperLimitHeight: CGFloat {
        return UIScreen.mainScreen().bounds.height - 24
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.insertSubview(overlayView, atIndex: 0)
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition(
            { [weak self] (context) in
                self?.overlayView.alpha = 0.3
            },
            completion: nil
        )
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition(
            { [weak self] (context) in
                self?.overlayView.alpha = 0.0
            },
            completion: nil
        )
    }
    
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        var size = container.preferredContentSize
        size.height = min(upperLimitHeight, size.height)
        return size
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        let containerViewFrame = containerView?.bounds ?? CGRect.zero
        var presentedViewFrame = containerViewFrame
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerViewFrame.size)
        presentedViewFrame.origin.x = (containerViewFrame.width - presentedViewFrame.size.width) / 2
        presentedViewFrame.origin.y = (containerViewFrame.height - presentedViewFrame.size.height) / 2
        return presentedViewFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        overlayView.frame = containerView?.frame ?? CGRect.zero
        presentedView()?.frame = frameOfPresentedViewInContainerView()
    }
    
    override func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer) {
        super.preferredContentSizeDidChangeForChildContentContainer(container)

    }
}
