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
    
    // MARK: - ListModelConsumer protocol
}

