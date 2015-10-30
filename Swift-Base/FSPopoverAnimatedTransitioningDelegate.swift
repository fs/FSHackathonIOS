//
//  FSPopoverAnimatedTransitioningDelegate.swift
//
//  Created by Kruperfone on 17.08.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

//MARK: -
class FSPopoverAnimatedTransitioningDelegate : NSObject, UIViewControllerTransitioningDelegate {
    
    let destinationControllerSize:CGSize
    lazy var transitioning:BFPopoverAnimatedTransitioning = {
        return BFPopoverAnimatedTransitioning(destinationControllerSize: self.destinationControllerSize)
    }()
    
    init (destinationControllerSize:CGSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 40, UIScreen.mainScreen().bounds.height - 80)) {
        self.destinationControllerSize = destinationControllerSize
        super.init()
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.transitioning.presenting = true
        return self.transitioning
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.transitioning.presenting = false
        return self.transitioning
    }
}

class BFPopoverAnimatedTransitioning: NSObject {
    
    var presenting: Bool = true
    let duration: NSTimeInterval
    
    let destinationControllerSize:CGSize
    
    lazy var backgroundView:UIView = {
        let view = UIView(frame: UIScreen.mainScreen().bounds)

        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = view.bounds
        view.addSubview(visualEffectView)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(duration: NSTimeInterval = 0.5, destinationControllerSize:CGSize) {
        
        self.destinationControllerSize = destinationControllerSize
        self.duration = duration
    }
}

//MARK: -
extension BFPopoverAnimatedTransitioning : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        if let lTransitionContext = transitionContext where lTransitionContext.isAnimated() {
            return self.duration
        }
        
        return 0.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        
        let presentingViewController    = self.presenting ? toViewController    :   fromViewController
        var presentedViewController     = self.presenting ? fromViewController  :   toViewController
        
        if let lPresentedViewController = presentedViewController as? UINavigationController {
            presentedViewController = lPresentedViewController.topViewController
        }
        print(presentingViewController)
        print(presentedViewController)
        
        let presentingView  = presentingViewController.view
        
        let startingAlpha:CGFloat = 0
        
        presentingViewController.viewWillAppear(self.isAnimatable(transitionContext))
        presentedViewController.viewWillDisappear(self.isAnimatable(transitionContext))
        
        if self.presenting {
            
            self.backgroundView.alpha = startingAlpha
            
            containerView?.addSubview(self.backgroundView)
            containerView?.addConstraints([
                NSLayoutConstraint(item: self.backgroundView, attribute: .Leading, relatedBy: .Equal, toItem: containerView, attribute: .Leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.backgroundView, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.backgroundView, attribute: .Trailing, relatedBy: .Equal, toItem: containerView, attribute: .Trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.backgroundView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1, constant: 0)
                ])
            
            presentingViewController.viewWillAppear(self.isAnimatable(transitionContext))
            presentedViewController.viewWillDisappear(self.isAnimatable(transitionContext))
            
            self.prepareForPresenting(presentingViewController!)
            presentingView.center = self.backgroundView.center
            self.backgroundView.addSubview(presentingView)
            
            self.backgroundView.addConstraints([
                NSLayoutConstraint(item: presentingView, attribute: .CenterY, relatedBy: .Equal, toItem: self.backgroundView, attribute: .CenterY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: presentingView, attribute: .CenterX, relatedBy: .Equal, toItem: self.backgroundView, attribute: .CenterX, multiplier: 1, constant: 0)
            ])
        } else {
            presentedViewController.viewWillAppear(self.isAnimatable(transitionContext))
            presentingViewController.viewWillDisappear(self.isAnimatable(transitionContext))
        }
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {[weak self] () -> Void in
            
            if let sself = self {
                
                if sself.presenting {
                    sself.backgroundView.alpha = 1
                    presentingView.transform = CGAffineTransformIdentity
                } else {
                    sself.backgroundView.alpha = startingAlpha
                    presentingView.transform = CGAffineTransformMakeScale(0.1, 0.1)
                }
            }
            
            }) {[weak self] (finished: Bool) -> Void in
                
                if let sself = self {
                    
                    if sself.presenting {
                        presentingViewController.viewDidAppear(sself.isAnimatable(transitionContext))
                        presentedViewController.viewDidDisappear(sself.isAnimatable(transitionContext))
                    } else {
                        presentedViewController.viewDidAppear(sself.isAnimatable(transitionContext))
                        presentingViewController.viewDidDisappear(sself.isAnimatable(transitionContext))
                    }

                }
                
                transitionContext.completeTransition(finished)
        }
    }
    
    //MARK: - private
    private func prepareForPresenting (controller:UIViewController) {
        controller.view.size = self.destinationControllerSize
        controller.view.transform = CGAffineTransformMakeScale(0.1, 0.1)
        controller.view.layer.shadowColor = UIColor.blackColor().CGColor
        controller.view.layer.shadowOffset = CGSizeMake(0, 2)
        controller.view.layer.shadowOpacity = 0.3
        
        let cornerRadius:CGFloat = 15
        
        controller.view.layer.cornerRadius = cornerRadius
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addConstraints([
            NSLayoutConstraint(item: controller.view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.destinationControllerSize.width),
            NSLayoutConstraint(item: controller.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.destinationControllerSize.height)
            ])
        
    }
    
    private func isAnimatable(transitionContext: UIViewControllerContextTransitioning) -> Bool {
        return self.transitionDuration(transitionContext) > 0.0
    }
}
