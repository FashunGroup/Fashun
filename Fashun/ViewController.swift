//
//  ViewController.swift
//  Fashun
//
//  Created by Alex Macleod on 20/10/14.
//  Copyright (c) 2014 Alex Macleod. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

var collectionView: UICollectionView?

var instanceOfCustomObject: CustomObject = CustomObject()
var accessToken: NSString! = "1570900151.c2711e8.75915e1949da40f395bf22e17101b43d"
//var userDefaults: NSUserDefaults!
let colorWheel = ColorWheel()
var photoCount: Int! = 0
let photos = NSMutableArray()
    
override func viewDidLoad() {
    
    super.viewDidLoad()

//    userDefaults = NSUserDefaults.standardUserDefaults()
//    self.accessToken = userDefaults!.objectForKey("accessToken") as NSString
//    println(self.accessToken)

//          .someProperty = "Hello World"
//        var accessToken : NSString? = NSString(instanceOfCustomObject.accessToken)
//        println(accessToken)
//    println("viewDidLoad")
//    instanceOfCustomObject.simpleAuth()
//        instanceOfCustomObject.authorize()

// Do any additional setup after loading the view, typically from a nib.
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    layout.itemSize = CGSize(width: 124, height: 124)
    layout.minimumInteritemSpacing = 1.0
    layout.minimumLineSpacing = 1.0
    collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    collectionView!.dataSource = self
    collectionView!.delegate = self
    collectionView!.registerClass(Cell.self, forCellWithReuseIdentifier: "Cell")
    collectionView!.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(collectionView!)
    
    getData()
//    imageCount()
    
}
    
    func getData() -> Void {
//
        let tuulavintageUrl = NSURL(string:"https://api.instagram.com/v1/users/7522782/media/recent/?access_token=\(self.accessToken)")
        let wendyslookbookUrl = NSURL(string:"https://api.instagram.com/v1/users/14454619/media/recent/?access_token=\(self.accessToken)")
//        
//        let sharedSession = NSURLSession.sharedSession()
//        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(baseUrl!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
    
//            var urlContents = NSString.stringWithContentsOfURL(location, encoding: NSUTF8StringEncoding, error: nil)
//            println(urlContents)
            
            let tuulavintageData = NSData(contentsOfURL: tuulavintageUrl!)
            let wendyslookbookData = NSData(contentsOfURL: wendyslookbookUrl!)
        
            if (tuulavintageData != nil) & (wendyslookbookData != nil) {

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                    
                    let tuulavintageDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(tuulavintageData!, options: nil, error: nil) as NSDictionary
                    let wendyslookbookDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(wendyslookbookData!, options: nil, error: nil) as NSDictionary
                    println(tuulavintageDictionary)
                    var tuulavintageImageResponse = tuulavintageDictionary.valueForKeyPath("data.images.standard_resolution.url") as NSArray
                    var tuulavintageTimeResponse = tuulavintageDictionary.valueForKeyPath("data.created_time") as NSArray
                    var tuulavintageLikeResponse = tuulavintageDictionary.valueForKeyPath("data.likes.count") as NSArray
//                    println(tuulavintageLikeResponse)
                    var wendyslookbookImageResponse = wendyslookbookDictionary.valueForKeyPath("data.images.standard_resolution.url") as NSArray
                    var wendyslookbookTimeResponse = wendyslookbookDictionary.valueForKeyPath("data.created_time") as NSArray
//                    println(wendyslookbookTimeResponse)
                    
                    for imageUrls in tuulavintageImageResponse {
                        
                        var imageUrlsAsStrings: NSString = imageUrls as NSString
                        var imageAsNsurls = NSURL(string: imageUrlsAsStrings)
                        
                        var err: NSError?
                        var imageData :NSData = NSData(contentsOfURL: imageAsNsurls!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
                        self.photos.addObject(UIImage(data:imageData)!)
//                        println(self.photos)
                        
                    }
                    
                    for imageUrls in wendyslookbookImageResponse {
                        
                        var imageUrlsAsStrings: NSString = imageUrls as NSString
                        var imageAsNsurls = NSURL(string: imageUrlsAsStrings)
                        
                        var err: NSError?
                        var imageData :NSData = NSData(contentsOfURL: imageAsNsurls!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
                        self.photos.addObject(UIImage(data:imageData)!)
//                        println(self.photos)
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.photoCount = tuulavintageImageResponse.count + wendyslookbookImageResponse.count as Int

                        self.collectionView?.reloadData()

                    })
                })
                
            } else {
                
                let networkIssueController = UIAlertController(title: "Error", message: "Something went wrong get a better phone you pleb!", preferredStyle: .ActionSheet)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButton)
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                networkIssueController.addAction(cancelButton)
                
                self.presentViewController(networkIssueController, animated: true, completion: nil)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //Stop refresh animation

                })
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCount
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as Cell
    //                println(photos)
    //            cell.textLabel.text = "Text"
        cell.imageView.image = photos.objectAtIndex(indexPath.row) as? UIImage
    //    cell.photo = self.photos[indexPath.row] as? NSDictionary
//        cell.imageView.backgroundColor = colorWheel.randomColor()

        return cell
    }
}

