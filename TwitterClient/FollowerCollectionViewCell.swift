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
        label.text = "Test Test Test"
        label.backgroundColor = .green
        return label
    }()
    
    let handleLabel: UILabel = {
        var label = UILabel()
        label.text = "@username"
        label.backgroundColor = .purple
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Test Test Test"
        textView.backgroundColor = .yellow
        return textView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
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
        handleLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor, topConstant: 8)
        bioTextView.anchor(top: handleLabel.bottomAnchor, leading: handleLabel.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        
    }

}
