//
//  ListDependencyContainer.swift
//  Expandable-collection
//
//  Created by boyankov on 2020-W16-13-April-Mon.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation

class ListDependencyContainerImpl: ListViewControllerFactory {
    
    // MARK: - Initialization
    init() {
        debugPrint("✅ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    deinit {
        debugPrint("☠️ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    // MARK: - ListViewControllerFactory protocol
    func makeListViewController() -> ListViewController {
        let vm: ListViewModel = self.makeListViewModel()
        let vc: ListViewController = ListViewController(viewModel: vm)
        return vc
    }
    
    private func makeListViewModel() -> ListViewModel {
        let model: ListModel = ListModelImpl()
        let result: ListViewModel = ListViewModelImpl(model: model)
        return result
    }
}
