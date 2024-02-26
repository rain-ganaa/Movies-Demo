//
//  ModalPresentationAnimator.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import UIKit

class ModalPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3 
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        toView.frame = finalFrame.offsetBy(dx: 0, dy: containerView.bounds.size.height)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.frame = finalFrame
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
