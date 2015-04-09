//
//  TabBarController.swift
//  MemeMe
//
//  Created by Jeff Corpac on 4/8/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    var memes: [Meme]!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.memes = appDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.memes = appDelegate.memes
        
        if self.memes.count == 0 {
            let newEditor = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditor")! as ViewController
            
            self.navigationController?.pushViewController(newEditor, animated: true)
        }
    }
}