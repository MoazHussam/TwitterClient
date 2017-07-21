//
//  TwitterUser.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import CoreData

class TwitterUser: NSManagedObject {
    
    convenience init(handle: String, name: String, bio: String?, profilePicture: String?, tweets: [Tweet]? = nil) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
        self.handle = handle
        self.name = name
        self.bio = bio
        self.profilePicture = profilePicture
        
    }
    
}
