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
            self.itemsCollectionView.isPagingEnabled = true
            let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = self.itemsCollectionView.bounds.size
            flowLayout.sectionInset = UIEdgeInsets.zero
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            self.itemsCollectionView.collectionViewLayout = flowLayout
        }
    }
    
    var selectedIndexPath: IndexPath? = nil
    
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
        if #available(iOS 11.0, *) {
            self.itemsCollectionView.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
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

/*
// MARK: - UICollectionViewDelegateFlowLayout protocol
extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return collectionView.bounds.size
//        return self.itemSize(for: collectionView, at: indexPath)
    }
    
    private func itemSize(for collectionView: UICollectionView, at indexPath: IndexPath) -> CGSize {
        guard let provider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return CGSize.zero
        }
        let result: CGSize = self.itemSize(for: provider,
                                           totalWidth: collectionView.bounds.width)
        return result
    }
    
    private func itemSize(for provider: CollectionViewDimensionsProvider,
                          totalWidth: CGFloat) -> CGSize
    {
        let item_width: CGFloat = (
            totalWidth
                - provider.paddingLeft
                - provider.paddingRight
                - CGFloat(provider.itemsPerRow - 1) * provider.minimumInteritemSpacing
            ) / CGFloat(provider.itemsPerRow)
        
        let item_height: CGFloat = item_width / provider.itemWidthToHeightRatio
        return CGSize(width: item_width, height: item_height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.zero
//        guard let valid_dimensionsProvider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
//            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
//            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
//            return UIEdgeInsets.zero
//        }
//        return valid_dimensionsProvider.sectionEdgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
//        guard let valid_dimensionsProvider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
//            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
//            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
//            return 0
//        }
//        return valid_dimensionsProvider.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
//        guard let valid_dimensionsProvider: CollectionViewDimensionsProvider = collectionView as? CollectionViewDimensionsProvider else {
//            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
//            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
//            return 0
//        }
//        return valid_dimensionsProvider.minimumLineSpacing
    }
}
*/
