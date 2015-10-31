//
//  NewListViewController.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class NewListViewController: BaseModalViewController {
    
    //MARK: - UI
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    //MARK: - lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.dismissSelf()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissSelf()
    }
    
    //MARK: - private
    
    private func checkAddButton(text: NSString) {
        self.addButton.enabled = text.length > 0
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
