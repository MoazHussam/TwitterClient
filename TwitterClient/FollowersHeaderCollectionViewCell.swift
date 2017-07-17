//
//  FollowersHeaderCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class FollowersHeaderCollectionViewCell: BaseCollectionViewCell {
        
    let headerLable: UILabel = {
        let label = UILabel()
        label.text = "WHO YOU ARE FOLLOWING".localized
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let sepratorLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(colorLiteralRed: 230/256, green: 230/256, blue: 230/256, alpha: 1)
        return lineView
    }()
    
    override func setupViews() {
        
        addSubview(headerLable)
        addSubview(sepratorLineView)
        
        headerLable.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, leadingConstant: 12)
        sepratorLineView.anchor(leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, heightConstant: 0.5)
        
    }
}
