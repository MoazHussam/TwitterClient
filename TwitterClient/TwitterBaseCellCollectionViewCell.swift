//
//  TwitterBaseCellCollectionViewCell.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class TwitterBaseCellCollectionViewCell: BaseCollectionViewCell {
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.text = "FirstName LastName"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = .red
        return label
    }()
    
    let handleLabel: UILabel = {
        var label = UILabel()
        label.text = "@username"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(colorLiteralRed: 130/256, green: 130/256, blue: 130/256, alpha: 1)
        label.backgroundColor = .yellow
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "blank profile image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .purple
        return imageView
    }()
    
    let separatorLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(colorLiteralRed: 230/256, green: 230/256, blue: 230/256, alpha: 1)
        return lineView
    }()

}
