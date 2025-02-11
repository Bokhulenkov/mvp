//
//  CustomPresentationController.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 07.02.2025.
//

import UIKit

final class CustomPresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return CGRect(x: 40, y: containerView.bounds.height / 3,
                      width: containerView.bounds.width - 80, height: 250)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        let dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            dimmingView.alpha = 1
        })
    }
}
