//
//  SavedMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jeff Corpac on 4/7/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

class SavedMemeCollectionViewController: UIViewController {
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
    }
}