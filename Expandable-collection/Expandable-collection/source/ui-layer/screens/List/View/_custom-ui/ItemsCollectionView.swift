//
//  ItemsCollectionView.swift
//  Expandable-collection
//
//  Created by boyankov on 2020-W16-13-April-Mon.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import UIKit

protocol CollectionViewDimensionsProvider {
    var paddingLeft: CGFloat { get }
    var paddingRight: CGFloat { get }
    var minimumInteritemSpacing: CGFloat { get }
    var minimumLineSpacing: CGFloat { get }
    var itemsPerRow: UInt { get }
    var itemWidthToHeightRatio: CGFloat { get }
    var sectionEdgeInsets: UIEdgeInsets { get }
}

class ItemsCollectionView: UICollectionView {}

extension ItemsCollectionView: CollectionViewDimensionsProvider {
    
    var paddingLeft: CGFloat {
        return Dimensions.paddingLeft
    }
    
    var paddingRight: CGFloat {
        return Dimensions.paddingRight
    }
    
    var minimumInteritemSpacing: CGFloat {
        return Dimensions.minimumInteritemSpacing
    }
    
    var minimumLineSpacing: CGFloat {
        return Dimensions.minimumLineSpacing
    }
    
    var itemsPerRow: UInt {
        return Dimensions.itemsPerRow
    }
    
    var itemWidthToHeightRatio: CGFloat {
        return Dimensions.itemWidthToHeightRatio
    }
    
    var sectionEdgeInsets: UIEdgeInsets {
        return Dimensions.sectionEdgeInsets
    }
}

// MARK: - Dimensions
extension ItemsCollectionView {
    
    fileprivate enum Dimensions {
        static let paddingLeft: CGFloat = 8
        static let paddingRight: CGFloat = 8
        static let minimumInteritemSpacing: CGFloat = 8
        static let minimumLineSpacing: CGFloat = 8
        static let itemsPerRow: UInt = (UIDevice.current.userInterfaceIdiom == .phone) ? 2 : 4
        static let itemWidthToHeightRatio: CGFloat = 2/3
        static var sectionEdgeInsets: UIEdgeInsets {
            return UIEdgeInsets(top: self.minimumLineSpacing,
                                left: self.paddingLeft,
                                bottom: self.minimumLineSpacing,
                                right: self.paddingRight)
        }
    }
}
