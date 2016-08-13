//
//  AlertAnimator.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 7/10/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class AlertAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    enum Style {
        case present
        case dismiss
    }
    
    let style: Style
    
    init(style: Style) {
        self.style = style
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        switch style {
        case .present:
            return 0.25
        case .dismiss:
            return 0.15
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch style {
        case .present:
            animatePresentTransition(transitionContext)
        case .dismiss:
            animateDismissTransition(transitionContext)
        }
    }
    
    func animateDismissTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let
            fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            _ = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            _ = transitionContext.containerView() else {
                transitionContext.completeTransition(false)
                return
        }
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            delay: 0,
            options: .CurveEaseIn,
            animations: {
                fromVC.view.alpha = 0.0
            },
            completion: { (finish) in
                transitionContext.completeTransition(finish)
            }
        )
    }
    
    func animatePresentTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let
            _ = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            containerView = transitionContext.containerView() else {
                transitionContext.completeTransition(false)
                return
        }
        
        toVC.view.alpha = 0.3
        toVC.view.transform = CGAffineTransformMakeScale(1.15, 1.15)
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        containerView.addSubview(toVC.view)
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .CurveEaseIn,
            animations: {
                toVC.view.alpha = 1.0
                toVC.view.transform = CGAffineTransformIdentity
            },
            completion: { (finish) in
                transitionContext.completeTransition(finish)
            }
        )
    }
    
    
}
