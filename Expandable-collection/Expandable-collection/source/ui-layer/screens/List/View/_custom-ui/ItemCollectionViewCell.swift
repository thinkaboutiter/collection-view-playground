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
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUi()
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.round(cornerRadius: Constants.cornerRadius,
                   borderWidth: 2,
                   borderColor: UIColor.black)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    // MARK: - Configurations
    func configure(with title: String) {
        self.titleLabel.text = title
    }
}

private extension ItemCollectionViewCell {
    
    func configureUi() {
        self.itemContainerView.backgroundColor = UIColor.orange
        self.titleLabel.textColor = UIColor.white
    }
}

// MARK: - Constants
private extension ItemCollectionViewCell {
    enum Constants {
        static let cornerRadius: CGFloat = 8
    }
}
