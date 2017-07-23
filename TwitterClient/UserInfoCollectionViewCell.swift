//
//  FollowerInfoCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class UserInfoCollectionViewCell: TwitterBaseCellCollectionViewCell {
 
    var tweet: Tweet? {
        didSet {
            
            if let tweet = self.tweet,
                let tweeter = self.tweet?.tweeter {
                self.tweetTextView.text = tweet.text
                self.nameLabel.text = tweeter.name
                self.handleLabel.text = tweeter.handle
                
                if let urlString = tweeter.profilePicture,
                    let url = URL(string: urlString) {
                    profileImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "blank profile image"))
                } else {
                    profileImageView.image = #imageLiteral(resourceName: "blank profile image")
                }
                
            } else {
                return
            }
            
        }
    }
    
    let tweetTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Here goes the Tweets of the users.\nSome users may leave this field empty."
        textView.backgroundColor = .clear
        textView.backgroundColor = .cyan
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
        
    override func setupViews() {
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(handleLabel)
        addSubview(tweetTextView)
        addSubview(separatorLineView)
        
        backgroundColor = .orange
        
        profileImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, topConstant: 12, leadingConstant: 12, widthConstant: 54, heightConstant: 54)
        nameLabel.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, topConstant: 0, leadingConstant: 8)
        handleLabel.anchor(leading: nameLabel.trailingAnchor, leadingConstant: 8)
        handleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -8).isActive = true
        handleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        tweetTextView.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: self.trailingAnchor, topConstant: -6, leadingConstant: -4, trailingConstant: -8)
        tweetTextView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -4).isActive = true
        separatorLineView.anchor(leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, heightConstant: 0.5)
        
        
    }
    
}
