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
    
    var cellWidthConstrant: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
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
//        textView.backgroundColor = .orange
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        textView.textAlignment = .natural
        return textView
    }()
    
    let containerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .cyan
        return view
    }()
    
    override func setupViews() {
        
        backgroundColor = .white
        
        self.constraints.forEach { $0.isActive = false }
        
        addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(handleLabel)
        containerView.addSubview(bioTextView)
        containerView.addSubview(separatorLineView)
        
//        backgroundColor = .brown
        
        cellWidthConstrant = containerView.anchorWithReturn(widthConstant: UIScreen.main.bounds.size.width).first
        containerView.fillSuperView()
        
        profileImageView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, topConstant: 12, leadingConstant: 12, widthConstant: 54, heightConstant: 54)
        nameLabel.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, trailing: containerView.trailingAnchor, leadingConstant: 8, trailingConstant: -8)
        handleLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor)
        bioTextView.anchor(top: handleLabel.bottomAnchor, leading: handleLabel.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, topConstant: -6, leadingConstant: -4)
        separatorLineView.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, heightConstant: 0.5)
        
    }
    
    func setWidthConstrant() {
        
        if cellWidthConstrant?.constant == 0 {
            cellWidthConstrant?.constant = UIScreen.main.bounds.size.width
        } else {
            // should update constraint here
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setWidthConstrant()
    }

}
