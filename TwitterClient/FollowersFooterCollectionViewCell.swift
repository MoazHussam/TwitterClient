//
//  FollowersFooterCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class FollowersFooterCollectionViewCell: BaseCollectionViewCell {
    
    let headerLable: UILabel = {
        let label = UILabel()
        label.text = "Show me more".localized
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.Colors.twitterBlue
        return label
    }()
    
    override func setupViews() {
        
        addSubview(headerLable)
        
        backgroundColor = .gray

        headerLable.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, leadingConstant: 12)
    }
    
}
