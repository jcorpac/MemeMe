//
//  TabBarViewController.swift
//  MemeMe
//
//  Created by Jeff Corpac on 4/8/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

// Central parent class for both of the "Saved Memes" view controllers
class TabBarViewController: UIViewController {

    var memes: [Meme]!
    
    override func viewDidLoad() {
        // Initialize the memes object when the view controller loads
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.memes = appDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        // Update the view controller when the view changes, even if it hasn't been unloaded from memory
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.memes = appDelegate.memes
        
        // If there are no memes, then move immediately to the meme editor view
        if self.memes.count == 0 {
            let newEditor = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
            
            self.navigationController?.pushViewController(newEditor, animated: true)
        }
    }
}