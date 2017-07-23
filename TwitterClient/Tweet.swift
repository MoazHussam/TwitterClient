//
//  Tweet.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class Tweet: NSManagedObject {

    private convenience init(id: String, text: String, created: Date?, tweeter: TwitterUser? = nil, inContext context: NSManagedObjectContext = AppDelegate.viewContext) {
        
        self.init(context: context)
        self.id = id
        self.text = text
        self.tweeter = tweeter
        self.created = created as NSDate?
        try? context.save()
        
    }
    
    class func initializeTweet(id: String, text: String, created: Date?, tweeter: TwitterUser? = nil, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> Tweet {
        
        var tweet: Tweet
        
            if let fetchedTweet = fetchTweet(forTweetID: id) {
                tweet = fetchedTweet
            } else {
                tweet = Tweet(id: id, text: text, created: created, tweeter: tweeter, inContext: context)
            }
        
        return tweet
        
    }
    
    class func initializeTweet(fromJsonObject json :JSON, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> Tweet {
        
        var tweet: Tweet
        let parsedTweet = parseTweet(fromJsonObject: json)
        
        if let fetchedTweet = fetchTweet(forTweetID: parsedTweet.id) {
            tweet = fetchedTweet
        } else {
            tweet = Tweet(id: parsedTweet.id, text: parsedTweet.text, created: parsedTweet.created, tweeter: parsedTweet.tweeter, inContext: context)
        }
        
        return tweet

    }
    
    class func fetchAllTweets(inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> [Tweet]? {
        
        let tweets: [Tweet]?
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        if let fetchedTweets =  try? context.fetch(request), fetchedTweets.count > 0 {
            tweets = fetchedTweets
        } else {
            tweets = nil
        }
        
        return tweets
        
    }
    
    class func fetchTweets(forUser user: TwitterUser, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> [Tweet]? {
        
        guard let userID = user.id else { fatalError("Database inconsistancy, twitteruser id cannot be nil") }
        let tweets: [Tweet]?
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "tweeter.id = %@", userID)
        request.sortDescriptors = [NSSortDescriptor(key: "created", ascending: false)]
        
        if let fetchedTweets = try? context.fetch(request), fetchedTweets.count > 0 {
            tweets = fetchedTweets
        } else {
            tweets = nil
        }
        
        return tweets
        
    }
    
    class func fetchTweet(forTweetID id: String, inContext context: NSManagedObjectContext = AppDelegate.viewContext) -> Tweet? {
    
        var fetchedTweet: Tweet?
        let request:NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let fetchedResults = try? context.fetch(request), fetchedResults.count > 0 {
            assert(fetchedResults.count == 1, "Database inconsistenty, two tweets found with id \(id)")
            fetchedTweet = fetchedResults.first
        } else {
            fetchedTweet = nil
        }
        
        return fetchedTweet
        
    }
    
    class private func parseTweet(fromJsonObject json: JSON) -> (id: String, text: String, created: Date?, tweeter: TwitterUser) {
        
        let id = json[Constants.TwitterAPI.ParameterKeys.id].stringValue
        let text = json[Constants.TwitterAPI.ParameterKeys.text].stringValue
        let dateString = json[Constants.TwitterAPI.ParameterKeys.dateCreated].stringValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.TwitterAPI.dateFormat
        let date = dateFormatter.date(from: dateString)
        let tweeterJson = json[Constants.TwitterAPI.ParameterKeys.users]
        let tweeter = TwitterUser.initializeTwitterUser(fromJsonObject: tweeterJson)
        
        return (id: id, text: text, created: date, tweeter: tweeter)
        
    }

}
