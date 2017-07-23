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
    
    private convenience init(id: String, handle: String, name: String, bio: String? = nil, profilePicture: String? = nil, coverPhoto: String? = nil, tweets: [Tweet]? = nil, inContext context: NSManagedObjectContext = AppDelegate.viewContext) {
        
        let context = context
        self.init(context: context)
        self.handle = handle
        self.name = name
        self.bio = bio
        self.profilePicture = profilePicture
        self.coverPhoto = coverPhoto
        self.id = id
        self.profilePicture = profilePicture
        try? context.save()
        
    }
    
    class func initializeTwitterUser(id: String, handle: String, name: String, bio: String? = nil, profilePicture: String? = nil, coverPhoto: String? = nil, tweets: [Tweet]? = nil, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> TwitterUser {
        
        let tweeter: TwitterUser
        
        if let fetchedUser = fetchUser(forTweetID: id) {
            tweeter = fetchedUser
        } else {
            tweeter = TwitterUser(id: id, handle: handle, name: name, bio: bio, profilePicture: profilePicture, coverPhoto: coverPhoto, tweets: tweets, inContext: context)
        }
        
        return tweeter

    }
    
    class func initializeTwitterUser(fromJsonObject json: JSON, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> TwitterUser {
        
        let tweeter: TwitterUser
        let parsedTweeter = parseTwitterUser(fromJsonObject: json)
        
        if let fetchedUser = fetchUser(forTweetID: parsedTweeter.id) {
            tweeter = fetchedUser
        } else {
            tweeter = TwitterUser(id: parsedTweeter.id, handle: parsedTweeter.handle, name: parsedTweeter.name, bio: parsedTweeter.bio, profilePicture: parsedTweeter.profilePicture, coverPhoto: parsedTweeter.coverPhoto, inContext: context)
        }
        
        return tweeter
        
    }
 
    class func fetchUser(forTweetID id: String, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> TwitterUser? {
        
        var fetchedUser: TwitterUser?
        let request:NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let fetchedResults = try? context.fetch(request), fetchedResults.count > 0 {
            assert(fetchedResults.count == 1, "Database inconsistenty, two tweets found with id \(id)")
            fetchedUser = fetchedResults.first
        } else {
            fetchedUser = nil
        }
        
        return fetchedUser
        
    }
    
    class func fetchAllTwitterUsers(inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> [TwitterUser]? {
        
        let users: [TwitterUser]?
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        if let fetchedUsers =  try? context.fetch(request), fetchedUsers.count > 0 {
            users = fetchedUsers
        } else {
            users = nil
        }
        
        return users
        
    }
    
    class func fetchFollowers(forUser user: TwitterUser, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> [TwitterUser]? {
        
        guard let userID = user.id else { fatalError("Database inconsistancy, twitteruser id cannot be nil") }
        let followers: [TwitterUser]?
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
         request.predicate = NSPredicate(format: "following = %@", userID)
        
        if let fetchedFollowers = try? context.fetch(request), fetchedFollowers.count > 0 {
            followers = fetchedFollowers
        } else {
            followers = nil
        }
        
        return followers
        
    }
    
    private class func parseTwitterUser(fromJsonObject json: JSON) -> (id: String, handle: String, name: String, bio: String, profilePicture: String, coverPhoto: String) {
        
        let id = json[Constants.TwitterAPI.ParameterKeys.id].stringValue
        let bio = json[Constants.TwitterAPI.ParameterKeys.bio].stringValue
        let handle = json[Constants.TwitterAPI.ParameterKeys.screenName].stringValue
        let coverPhoto = json[Constants.TwitterAPI.ParameterKeys.coverPhoto].stringValue
        let profilePicture = json[Constants.TwitterAPI.ParameterKeys.profilePicture].stringValue
        let name = json[Constants.TwitterAPI.ParameterKeys.name].stringValue

        return (id: id, handle: handle, name: name, bio: bio, profilePicture: profilePicture, coverPhoto: coverPhoto)
        
    
    }
    
}
