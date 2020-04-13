//
//  ItemCollectionViewCell.swift
//  Expandable-collection
//
//  Created by boyankov on 2020-W16-13-April-Mon.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var itemContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUi()
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
    }
    
    func configure(with title: String) {
        self.titleLabel.text = title
    }
}

private extension ItemCollectionViewCell {
    
    func configureUi() {
        self.itemContainerView.backgroundColor = UIColor.yellow
    }
}
