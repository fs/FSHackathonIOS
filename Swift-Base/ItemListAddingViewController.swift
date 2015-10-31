//
//  ItemListAddingViewController.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 31.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ItemListAddingViewController: BaseModalViewController {
    
    private var units = Unit.all
    private var selectedUnit: Unit? = nil
    
    var itemsListViewController: ItemsListViewController!
    var list: List!
    var item: Item!

    //MARK: - UI
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //MARK: - lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkAddButton(self.numberTextField.text! as NSString, unitText: self.unitTextField.text! as NSString)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - actions
    @IBAction func add(sender: AnyObject) {
        
        MagicalRecord.saveWithBlockAndWait {[weak self] (context) -> Void in
            
            guard let sself = self else { return }
            
            let listedItem = ListedItem.MR_createEntityInContext(context)
            listedItem.count = NSNumber.init(integer: (sself.numberTextField.text! as NSString).integerValue)
            listedItem.unit = Unit.Kilogramm.numberValue
            listedItem.item = sself.item.MR_inContext(context)
            listedItem.list = sself.list.MR_inContext(context)
        }
        
        self.itemsListViewController.listViewController.collectionView?.reloadData()
        
        self.dismissSelf()
        self.itemsListViewController.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissSelf()
    }
    
    //MARK: - private
    
    private func checkAddButton(numberText: NSString, unitText: NSString) {
        self.addButton.enabled = numberText.length > 0 && unitText.length > 0
    }
}

//
extension ItemListAddingViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if self.unitTextField == textField {
            
            self.view.endEditing(true)
            
            let modalPickerView = GVModalPickerView.init()
            modalPickerView.pickerView?.delegate = self
            modalPickerView.pickerView?.dataSource = self
            modalPickerView.showWithType(GVModalViewShowType.Default, completion: nil)
            modalPickerView.completionHandler = {[weak self]() -> Void in
                
                guard let sself = self else { return }
                
                sself.selectedUnit = sself.units[modalPickerView.pickerView!.selectedRowInComponent(0)]
                sself.unitTextField.text = sself.selectedUnit?.short
                
                sself.checkAddButton(sself.numberTextField.text! as NSString, unitText: sself.unitTextField.text! as NSString)
                
                modalPickerView.dismissWithType(GVModalViewDismissType.Default, completion: nil)
            }
            modalPickerView.cancelHandler = {() -> Void in
                modalPickerView.dismissWithType(GVModalViewDismissType.Default, completion: nil)
            }
            
            return false
        }
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var txtAfterUpdate = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)
        self.checkAddButton(txtAfterUpdate, unitText: self.unitTextField.text! as NSString)
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

//
extension ItemListAddingViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.units.count
    }
}

//
extension ItemListAddingViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.units[row].short
    }
}
