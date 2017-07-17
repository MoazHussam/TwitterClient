//
//  FollowerCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.text = "FirstName LastName"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let handleLabel: UILabel = {
        var label = UILabel()
        label.text = "@username"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(colorLiteralRed: 130/256, green: 130/256, blue: 130/256, alpha: 1)
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Here goes the biography of the users./nSome users may leave this field empty."
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "blank profile image")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(handleLabel)
        addSubview(bioTextView)
        
        profileImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, topConstant: 12, leadingConstant: 12, widthConstant: 50, heightConstant: 50)
        nameLabel.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, trailing: self.trailingAnchor, leadingConstant: 8, trailingConstant: -8)
        handleLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor)
        bioTextView.anchor(top: handleLabel.bottomAnchor, leading: handleLabel.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, topConstant: -4, leadingConstant: -4)
        
    }

}
