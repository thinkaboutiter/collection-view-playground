//
//  ListViewController.swift
//  Expandable-collection
//
//  Created by boyankov on 2020-W16-13-April-Mon.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import UIKit

import UIKit

/// APIs for `DependecyContainer` to expose.
protocol ListViewControllerFactory {
    func makeListViewController() -> ListViewController
}

class ListViewController: UIViewController, ListViewModelConsumer {
    
    // MARK: - Properties
    private let viewModel: ListViewModel
    @IBOutlet private weak var itemsCollectionView: ItemsCollectionView! {
        didSet {
            let identifier: String = String(describing: ItemCollectionViewCell.self)
            self.itemsCollectionView.register(UINib(nibName: identifier, bundle: nil),
                                              forCellWithReuseIdentifier: identifier)
            self.itemsCollectionView.delegate = self
            self.itemsCollectionView.dataSource = self
        }
    }
    
    // MARK: - Initialization
    @available(*, unavailable, message: "Creating this view controller with `init(coder:)` is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Creating this view controller with `init(coder:)` is unsupported in favor of dependency injection initializer.")
    }
    
    @available(*, unavailable, message: "Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of dependency injection initializer.")
    }
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ListViewController.self), bundle: nil)
        self.viewModel.setViewModelConsumer(self)
        debugPrint("✅ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    deinit {
        debugPrint("☠️ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    // MARK: - ListViewModelConsumer protocol
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// MARK: - UICollectionViewDataSource protocol
extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return self.viewModel.items().count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let validCell: ItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemCollectionViewCell.self), for: indexPath) as? ItemCollectionViewCell else {
            let message: String = "Unable to dequeue valid \(String(describing: ItemCollectionViewCell.self))!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return UICollectionViewCell()
        }
        guard let title: String = self.viewModel.item(at: indexPath) else {
            let message: String = "Unable to find item for indexPath=\(indexPath)!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return validCell
        }
        validCell.configure(with: title)
        return validCell
    }
}

// MARK: - UICollectionViewDelegate protocol
extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol
extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return self.itemSize(for: collectionView)
    }
    
    fileprivate func itemSize(for collectionView: UICollectionView) -> CGSize {
        guard let valid_dimensionsProvider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return CGSize.zero
        }
        
        let item_width: CGFloat = (
            collectionView.bounds.width
                - valid_dimensionsProvider.paddingLeft
                - valid_dimensionsProvider.paddingRight
                - CGFloat(valid_dimensionsProvider.itemsPerRow - 1) * valid_dimensionsProvider.minimumInteritemSpacing
            ) / CGFloat(valid_dimensionsProvider.itemsPerRow)
        
        let item_height: CGFloat = item_width / valid_dimensionsProvider.itemWidthToHeightRatio
        
        return CGSize(width: item_width, height: item_height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        guard let valid_dimensionsProvider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return UIEdgeInsets.zero
        }
        return valid_dimensionsProvider.sectionEdgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        guard let valid_dimensionsProvider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return 0
        }
        return valid_dimensionsProvider.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        guard let valid_dimensionsProvider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return 0
        }
        return valid_dimensionsProvider.minimumLineSpacing
    }
}
