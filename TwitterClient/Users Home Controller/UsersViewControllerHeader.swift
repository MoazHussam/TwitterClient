//
//  FollowersHeaderCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class UsersViewControllerHeader: BaseCollectionViewCell {
        
    let headerLable: UILabel = {
        let label = UILabel()
        label.text = "FOLLOWERS".localized
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let separatorLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(colorLiteralRed: 230/256, green: 230/256, blue: 230/256, alpha: 1)
        return lineView
    }()
    
    override func setupViews() {
        
        addSubview(headerLable)
        addSubview(separatorLineView)
        
        backgroundColor = Constants.Colors.twitterBlue
        
        headerLable.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, leadingConstant: 12)
        separatorLineView.anchor(leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, heightConstant: 0.5)
        
    }
}
