//
//  TwitterUser.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class TwitterUser: NSManagedObject {
    
    convenience init(id: String, handle: String, name: String, bio: String? = nil, profilePicture: String? = nil, coverPhoto: String? = nil, tweets: [Tweet]? = nil, inContext context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext ) {
        
        let context = context
        self.init(context: context)
        self.handle = handle
        self.name = name
        self.bio = bio
        self.profilePicture = profilePicture
        self.coverPhoto = coverPhoto
        self.id = id
        self.profilePicture = profilePicture
        
    }
    
    convenience init(fromJsonObject json: JSON) {
        
        let id = json[Constants.TwitterAPI.ParameterKeys.id].stringValue
        let bio = json[Constants.TwitterAPI.ParameterKeys.bio].stringValue
        let handle = json[Constants.TwitterAPI.ParameterKeys.screenName].stringValue
        let coverPhoto = json[Constants.TwitterAPI.ParameterKeys.coverPhoto].stringValue
        let profilePicture = json[Constants.TwitterAPI.ParameterKeys.profilePicture].stringValue
        let name = json[Constants.TwitterAPI.ParameterKeys.name].stringValue
        self.init(id: id, handle: handle, name: name, bio: bio, profilePicture: profilePicture, coverPhoto: coverPhoto)
        
    }
    
}
