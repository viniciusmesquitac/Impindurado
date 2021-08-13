//
//  AnimationController.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 12/08/21.
//

import UIKit

class AnimationController: NSObject {

    private let animationDuration: Double
    private let animationType: AnimationType

    enum AnimationType {
        case dismiss
        case present
    }

    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }

}

extension AnimationController: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TimeInterval(exactly: animationDuration) ?? 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let to = transitionContext.viewController(forKey: .to),
              let from = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        switch animationType {
        case .present:
            transitionContext.containerView.addSubview(to.view)
            present(with: transitionContext, view: to.view)
        case .dismiss:
            dismiss(with: transitionContext, view: from.view)
        }
        
        
    }

    func present(with transitionContext: UIViewControllerContextTransitioning, view: UIView) {
        view.clipsToBounds = true
        view.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: ({
            view.alpha = 1
        }), completion: { finish in
            transitionContext.completeTransition(finish)
        })
    }
    
    func dismiss(with transitionContext: UIViewControllerContextTransitioning, view: UIView) {
        view.clipsToBounds = true
        view.alpha = 1
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: ({
            view.alpha = 0
        }), completion: { finish in
            transitionContext.completeTransition(finish)
        })
    }

}
