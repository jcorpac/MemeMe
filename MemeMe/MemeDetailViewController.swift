//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Jeff Corpac on 4/7/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    var memeIndex: Int!
    
    @IBOutlet weak var imgMemedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgMemedImage.image = meme.memedImage
    }
    
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.memes.removeAtIndex(memeIndex)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}