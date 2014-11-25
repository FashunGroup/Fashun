//
//  Instagram.swift
//  Fashun
//
//  Created by Ken on 25/11/14.
//  Copyright (c) 2014 Alex Macleod. All rights reserved.
//

import Foundation

class Instagram: NSObject {
    var accessToken = "1570900151.c2711e8.75915e1949da40f395bf22e17101b43d"
    var userid="7522782"
    let baseUrl = "https://api.instagram.com"
    
    func getJsonData()->NSData? {
        var url = NSURL(string: "\(self.baseUrl)/v1/users/\(self.userid)/media/recent/?access_token=\(self.accessToken)")
        var jsond = NSData(contentsOfURL: url!)
        return jsond
    }
    
    func getImages() {
        
    }
}
