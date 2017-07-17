//
//  FollowersFooterCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class FollowersFooterCollectionViewCell: UICollectionViewCell {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerLable: UILabel = {
        let label = UILabel()
        label.text = "Show me more".localized
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.Colors.twitterBlue
        return label
    }()
    
    private func setupViews() {
        
        addSubview(headerLable)
        headerLable.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, leadingConstant: 12)
    }
    
}
