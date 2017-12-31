//
//  Message.swift
//  BlogApp
//
//  Created by Subhamoy Paul on 12/30/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import Foundation
import Firebase

class Message {
    var heading :String
    var timestamps :Int64
    var content :String
    
    init (dictionary: [String:AnyObject]) {
        self.heading = dictionary["heading"] as! String
        self.content = dictionary["content"] as! String
        self.timestamps = dictionary["timestamps"] as! Int64
    }
}
