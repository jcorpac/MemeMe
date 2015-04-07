//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Jeff Corpac on 3/29/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField.text == textField.placeholder) {textField.text = "" }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
