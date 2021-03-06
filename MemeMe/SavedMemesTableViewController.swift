//
//  SavedMemesTableViewController.swift
//  MemeMe
//
//  Created by Jeff Corpac on 4/7/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

class SavedMemesTableViewController: TabBarViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableRow = tableView.dequeueReusableCellWithIdentifier("MemeTableRow", forIndexPath: indexPath) as! UITableViewCell
        
        let meme = memes[indexPath.row]
        
        tableRow.imageView?.image = meme.memedImage
        tableRow.textLabel?.text = meme.topString
        tableRow.detailTextLabel?.text = meme.bottomString
        
        return tableRow
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Grab the DetailVC from Storyboard
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        //Populate the view controller with the selected meme and its index
        detailVC.meme = memes[indexPath.row]
        detailVC.memeIndex = indexPath.row
        
        //Present the view controller using navigation
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}