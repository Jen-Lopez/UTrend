//
//  Post.swift
//  UTrend
//
//  Created by Jennifer Lopez on 4/24/20.

// model for post uploaded to social page

import UIKit

class Post: NSObject {
    var postImg : String?
    var textCaption : String?
    var likes : NSNumber?
    var time : String?
    var username : String?
    var userPic : String?
    var isLiked = false
    var pid : String? // post id
    var uid :String? // user id
}
