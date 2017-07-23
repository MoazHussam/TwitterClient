//
//  FollowerInfoHeaderCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import AlamofireImage

class UserInfoViewControllerHeader: TwitterBaseCellCollectionViewCell {
    
    var user: TwitterUser? {
        didSet {
            self.nameLabel.text = user?.name
            self.handleLabel.text = user?.handle
            self.bioTextView.text = user?.bio
            
            if let profileUrlString = user?.profilePicture,
                let url = URL(string: profileUrlString) {
                profileImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "blank profile image"))
            } else {
                profileImageView.image = #imageLiteral(resourceName: "blank profile image")
            }
            
            if let coverUrlString = user?.coverPhoto,
                let url = URL(string: coverUrlString) {
                coverPhoto.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "blank cover photo"))
            } else {
                coverPhoto.image = #imageLiteral(resourceName: "blank cover photo")
            }
            
        }
    }
    
    let coverPhoto: UIImageView = {
        let imageview = UIImageView()
        imageview.image = #imageLiteral(resourceName: "blank cover photo")
        imageview.contentMode = .scaleAspectFill
//        imageview.backgroundColor = .red
        return imageview
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Here goes the Biography of the users.\nSome users may leave this field empty.".localized
        textView.backgroundColor = .clear
//        textView.backgroundColor = .brown
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .natural
        textView.isUserInteractionEnabled = false
        return textView
    }()

    
    
    override func setupViews() {
        
        addSubview(coverPhoto)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(handleLabel)
        addSubview(bioTextView)
        addSubview(separatorLineView)
        
        nameLabel.textColor = .white
        bioTextView.textColor = .white
        handleLabel.textColor = .white
        
//        backgroundColor = .blue
        
        coverPhoto.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, heightConstant: 100)
        profileImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, topConstant: 20, leadingConstant: 12, widthConstant: 64, heightConstant: 64)
        nameLabel.anchor(top: profileImageView.bottomAnchor, leading: profileImageView.leadingAnchor, topConstant: 8)
        handleLabel.anchor(leading: nameLabel.trailingAnchor, leadingConstant: 8)
        handleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        handleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -8).isActive = true
        bioTextView.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: self.trailingAnchor, topConstant: -6, leadingConstant: -4, trailingConstant: -8)
        bioTextView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8).isActive = true
        separatorLineView.anchor(leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, heightConstant: 0.5)
        
    }
}
