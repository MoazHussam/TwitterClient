//
//  FollowerInfoHeaderCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class UserInfoViewControllerHeader: TwitterBaseCellCollectionViewCell {
    
    
    let coverPhoto: UIImageView = {
        let imageview = UIImageView()
        imageview.image = #imageLiteral(resourceName: "blank cover photo")
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .red
        return imageview
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Here goes the Biography of the users.\nSome users may leave this field empty."
        textView.backgroundColor = .clear
        textView.backgroundColor = .brown
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()

    
    
    override func setupViews() {
        
        addSubview(coverPhoto)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(handleLabel)
        addSubview(bioTextView)
        addSubview(separatorLineView)
        
        backgroundColor = .blue
        
        coverPhoto.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, heightConstant: 150)
        profileImageView.anchor(top: coverPhoto.bottomAnchor, leading: self.leadingAnchor, topConstant: -20, leadingConstant: 12, widthConstant: 60, heightConstant: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, leading: profileImageView.leadingAnchor, topConstant: 8)
        handleLabel.anchor(leading: nameLabel.trailingAnchor, leadingConstant: 8)
        handleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        handleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -8).isActive = true
        bioTextView.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, topConstant: -6, leadingConstant: -4, bottomConstant: -8, trailingConstant: -8)
        separatorLineView.anchor(leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, heightConstant: 0.5)
        
    }
}
