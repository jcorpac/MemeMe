//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Jeff Corpac on 3/29/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Toolbar UI elements
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // Navigation bar UI elements
    @IBOutlet weak var shareButton: UIBarButtonItem!

    // Meme UI Elements
    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var txtTopText: UITextField!
    @IBOutlet weak var txtBottomText: UITextField!
    
    // Completed meme image
    var memedImage: UIImage!
    
    let textAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    let textDelegate = MemeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeTextField(txtTopText, initialText: "TOP")
        initializeTextField(txtBottomText, initialText: "BOTTOM")
    }

    // Helper function, initialize text fields for Meme before allowing editing
    func initializeTextField(textField: UITextField, initialText: String) {
        textField.defaultTextAttributes = textAttributes
        textField.placeholder = initialText
        textField.text = initialText
        textField.textAlignment = NSTextAlignment.Center
        textField.delegate = textDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.shareButton.enabled = self.imgImageView.image != nil
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imgImageView.image = image
            self.shareButton.enabled = self.imgImageView.image != nil
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        shareButton.enabled = self.imgImageView.image != nil
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue

        // Only move the view if the bottom text field is being edited.
        if txtBottomText.editing {
            return keyboardSize.CGRectValue().height
        } else {
            return 0
        }
    }
    
    func generateMemedImage() -> UIImage {
        // Hide the navbar and toolbar
        if self.navigationController != nil {
            self.navigationController?.navigationBar.hidden = true
        }
        toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show the navbar and toolbar
        if self.navigationController != nil {
            self.navigationController?.navigationBar.hidden = false
        }
        toolbar.hidden = false
        
        // Return the rendered image
        return memedImage
    }
    
    @IBAction func shareMemedImage(sender: UIButton) {
        self.memedImage = self.generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = saveMemeAfterSharing
    }
    
    func saveMemeAfterSharing(activity: String!, completed: Bool, items: [AnyObject]!, error: NSError!) {
        if completed {
            self.saveMeme()
            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func saveMeme() {
        // Create the meme object
        var meme = Meme(topString: txtTopText.text!, bottomString: txtBottomText.text!, originalImage: imgImageView.image!, memedImage: self.memedImage)
        
        // Add the meme object to the AppDelegate's array
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}

