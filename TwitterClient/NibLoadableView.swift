//
//  NibLoadableView.swift
//  AqarMap
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 AqarMap. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
}
