//
//  File.swift
//  BlogApp
//
//  Created by Subhamoy Paul on 12/30/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import Foundation
class User {
    
    var email :String
    var uid :Int
    var username :String
    
    init (dictionary: [String : AnyObject]) {
        
        self.email = (dictionary["email"] as? String)!
        self.uid = (dictionary["uid"] as? Int)!
        self.username = (dictionary["username"] as? String)!
    }
}
