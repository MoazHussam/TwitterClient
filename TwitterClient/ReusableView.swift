//
//  ReusableView.swift
//  AqarMap
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 AqarMap. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
