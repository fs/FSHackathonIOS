//
//  NewListViewController.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class NewListViewController: UIViewController {
    
    //MARK: - UI
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var yAxisConstraint: NSLayoutConstraint!
    
    //MARK: - popover
    let popoverDelegate = FSPopoverAnimatedTransitioningDelegate()

    //MARK: - lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
        self.checkAddButton(self.textField.text! as NSString)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - actions
    @IBAction func add(sender: AnyObject) {
        MagicalRecord.saveWithBlockAndWait {[weak self] (context) -> Void in
            
            guard let sself = self else { return }
            
            let newList = List.MR_createEntityInContext(context)
            newList.title = sself.textField.text
        }
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - private
    
    private func checkAddButton(text: NSString) {
        self.addButton.enabled = text.length > 0
    }

    //MARK: - Keyboard helper
    
    private func registerForKeyboardNotifications () {
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

extension NewListViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var txtAfterUpdate = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)
        self.checkAddButton(txtAfterUpdate)
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
