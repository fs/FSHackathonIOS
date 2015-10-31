//
//  BaseModalViewController.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 31.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class BaseModalViewController: UIViewController {
    
    //MARK: - UI
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var yAxisConstraint: NSLayoutConstraint!
    
    //MARK: - popover
    let popoverDelegate = FSPopoverAnimatedTransitioningDelegate()
    
    func dismissSelf() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: - view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
    }
    
    //MARK: - Keyboard helper
    
    internal func registerForKeyboardNotifications () {
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: - notifications
    internal func keyboardWillShow (notif: NSNotification) {
        if let info = notif.userInfo {
            if let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue, duration = info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
                let keyboardFrame = value.CGRectValue()
                self.yAxisConstraint.constant = -(keyboardFrame.size.height * 0.5)
                UIView.animateWithDuration(duration.doubleValue, animations: {[weak self] () -> Void in
                    guard let sself = self else { return }
                    sself.backgroundView.layoutIfNeeded()
                })
            }
        }
    }
    
    internal func keyboardWillHide (notif: NSNotification) {
        self.yAxisConstraint.constant = 0.0
        if let info = notif.userInfo {
            if let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
                UIView.animateWithDuration(duration.doubleValue, animations: {[weak self] () -> Void in
                    guard let sself = self else { return }
                    sself.backgroundView.layoutIfNeeded()
                })
            }
        }
    }
}
