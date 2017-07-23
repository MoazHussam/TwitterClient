//
//  FollowerCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import AlamofireImage

class UserCollectionViewCell: TwitterBaseCellCollectionViewCell {
        
    var tweeter: TwitterUser? {
        didSet {
            nameLabel.text = tweeter?.name
            handleLabel.text = tweeter?.handle
            bioTextView.text = tweeter?.bio
            
            if let urlString = tweeter?.profilePicture,
                let url = URL(string: urlString) {
                profileImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "blank profile image"))
            } else {
                profileImageView.image = #imageLiteral(resourceName: "blank profile image")
            }

        }
    }
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Here goes the biography of the users.\nSome users may leave this field empty."
        textView.backgroundColor = .clear
        textView.backgroundColor = .orange
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        textView.textAlignment = .natural
        return textView
    }()
    
    override func setupViews() {
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(handleLabel)
        addSubview(bioTextView)
        addSubview(separatorLineView)
        
        backgroundColor = .brown
        
        profileImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, topConstant: 12, leadingConstant: 12, widthConstant: 54, heightConstant: 54)
        nameLabel.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, trailing: self.trailingAnchor, leadingConstant: 8, trailingConstant: -8)
        handleLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor)
        bioTextView.anchor(top: handleLabel.bottomAnchor, leading: handleLabel.leadingAnchor, trailing: self.trailingAnchor, topConstant: -6, leadingConstant: -4)
        bioTextView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        separatorLineView.anchor(leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, heightConstant: 0.5)
        
    }

}
