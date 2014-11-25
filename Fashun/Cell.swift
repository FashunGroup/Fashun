//
//  Cell.swift
//  Fashun
//
//  Created by Alex Macleod on 31/10/14.
//  Copyright (c) 2014 Alex Macleod. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    
    //    let textLabel: UILabel!
    let imageView: UIImageView!
    var photo: NSDictionary!
    
    //    init(photos: NSArray) {
    //        super.init()
    //        let photo = photos
    //    }
    //
    //    func setPhoto(#photo: NSDictionary) {
    //        self.photo = photo
    //        var url: NSURL = photo["images"]["standard_resolution"]["url"]
    //    }
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        //Add Gesture Recognizer
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        imageView.addGestureRecognizer(tap)
        
        
        contentView.addSubview(imageView)
        
        //        let textFrame = CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/3)
        //        textLabel = UILabel(frame: textFrame)
        //        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        //        textLabel.textAlignment = .Center
        //        contentView.addSubview(textLabel)
    }
    
    func handleTap(gesture: UITapGestureRecognizer) {
        println("gesture detect")
        
        let tapLocation = gesture.locationInView(self.superview)
        if self.layer.presentationLayer().frame.contains(tapLocation) {
            println("Bug tapped!")
            // add bug-squashing code here
        } else {
            println("Bug not tapped!")
        }
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    func downloadPhotoWithUrl(#url: NSURL) {
    //        
    //    }
    
}

