//
//  Animation.swift
//  DayTree
//
//  Created by Yoshi on 2017/09/18.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit

class Animation : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewCotnroller = transitionContext.viewController(forKey: .from)
        let toViewCotnroller = transitionContext.viewController(forKey: .to)
        
        let containerView = transitionContext.containerView
        
        let fromView = fromViewCotnroller?.view
        let toView = toViewCotnroller?.view
        
        fromView?.frame = transitionContext.initialFrame(for: fromViewCotnroller!)
        toView?.frame = transitionContext.finalFrame(for: toViewCotnroller!)
        
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        
        containerView.addSubview(toView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: { () -> Void in
            fromView?.alpha = 0.0
            toView?.alpha = 1.0
        }, completion: { (BOOL) -> Void in
            let wasCanceled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCanceled)
        })
        
    }
    
    
}
