//
//  ListViewModel.swift
//  Expandable-collection
//
//  Created by boyankov on 2020-W16-13-April-Mon.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation

/// APIs for `View` to expose to `ViewModel`
protocol ListViewModelConsumer: AnyObject {
}

/// APIs for `ViewModel` to expose to `View`
protocol ListViewModel: AnyObject {
    func setViewModelConsumer(_ newValue: ListViewModelConsumer)
    func items() -> [String]
    func item(at indexPath: IndexPath) -> String?
}

class ListViewModelImpl: ListViewModel, ListModelConsumer {
    
    // MARK: - Properties
    private let model: ListModel
    private weak var viewModelConsumer: ListViewModelConsumer!
    
    // MARK: - Initialization
    required init(model: ListModel) {
        self.model = model
        self.model.setModelConsumer(self)
        debugPrint("✅ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    deinit {
        debugPrint("☠️ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    // MARK: - ListViewModel protocol
    func setViewModelConsumer(_ newValue: ListViewModelConsumer) {
        self.viewModelConsumer = newValue
    }
    
    func items() -> [String] {
        return self.model.items()
    }
    
    func item(at indexPath: IndexPath) -> String? {
        let range: Range<Int> = 0..<self.items().count
        let index: Int = indexPath.item
        guard range ~= index else {
            let message: String = "index=\(index) out of range=\(range)!"
            debugPrint("❌ \(#file) » \(#function) » \(#line)", message, separator: "\n")
            return nil
        }
        let result: String = self.items()[index]
        return result
    }
    
    // MARK: - ListModelConsumer protocol
}

