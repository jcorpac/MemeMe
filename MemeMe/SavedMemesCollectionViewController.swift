//
//  SavedMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jeff Corpac on 4/7/15.
//  Copyright (c) 2015 Jeff Corpac. All rights reserved.
//

import UIKit

class SavedMemeCollectionViewController: TabBarViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as UICollectionViewCell
        let meme = memes[indexPath.item]

        cell.backgroundView = UIImageView(image: meme.memedImage)

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Grab the DetailVC from Storyboard
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController")  as MemeDetailViewController
        
        //Populate the view controller with data from the meme and its index
        detailVC.meme = self.memes[indexPath.row]
        detailVC.memeIndex = indexPath.row
        
        //Present the view controller using navigation
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}