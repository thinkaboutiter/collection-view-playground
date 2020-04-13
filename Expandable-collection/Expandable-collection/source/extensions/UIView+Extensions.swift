//
//  UIView+Extensions.swift
//  Expandable-collection
//
//  Created by boyankov on 2020-W16-13-April-Mon.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import UIKit

extension UIView {
    
    func round(cornerRadius: CGFloat,
               borderWidth width: CGFloat = 0,
               borderColor color: UIColor = UIColor.clear)
    {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
