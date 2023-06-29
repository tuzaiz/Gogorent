//
//  CardTransitionAnimator.swift
//  Gogorent
//
//  Created by ClydeHsieh on 2023/6/29.
//

import UIKit

protocol CardTransitionAnimatorPresenting {
    func transitionView() -> UIView?
    func transitionViewRect() -> CGRect?
}

class CardTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration: TimeInterval = 0.5

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    // 执行自定义转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = toVC.view else {
            return
        }

        let containerView = transitionContext.containerView

        if toVC.isBeingPresented {
            let fromView = (fromVC as? CardTransitionAnimatorPresenting)?.transitionView()
            let frame = (fromVC as? CardTransitionAnimatorPresenting)?.transitionViewRect() ?? .zero
            fromView?.frame = frame
            if let fromView {
                containerView.addSubview(fromView)
            }
            
            let scale = containerView.frame.width / frame.width
            
            containerView.addSubview(toView)
            
            toView.alpha = 0.0
            UIView.animate(withDuration: duration, animations: {
                toView.alpha = 1.0
                fromView?.alpha = 0.0
                fromView?.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else if fromVC.isBeingDismissed {
            let fromView = (fromVC as? CardTransitionAnimatorPresenting)?.transitionView()
            
            UIView.animate(withDuration: duration, animations: {
                fromView?.alpha = 0.0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}

