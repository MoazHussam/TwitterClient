//
//  Tweet.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import CoreData

class Tweet: NSManagedObject {

    convenience init(id: String, text: String, created: Date?, tweeter: TwitterUser? = nil) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
        self.id = id
        self.text = text
        self.tweeter = tweeter
        self.created = created as NSDate?
        
    }
    
    convenience init(fromJsonObject json: JSON) {
        
        let id = json[Constants.TwitterAPI.ParameterKeys.id].stringValue
        let text = json[Constants.TwitterAPI.ParameterKeys.text].stringValue
        let dateString = json[Constants.TwitterAPI.ParameterKeys.dateCreated].stringValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.TwitterAPI.dateFormat
        let date = dateFormatter.date(from: dateString)
        self.init(id: id, text: text, created: date, tweeter: nil)

    }

}
