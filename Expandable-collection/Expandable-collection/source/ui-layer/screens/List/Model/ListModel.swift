//
//  ListModel.swift
//  Expandable-collection
//
//  Created by boyankov on 2020-W16-13-April-Mon.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation

/// APIs for `ViewModel` to expose to `Model`
protocol ListModelConsumer: AnyObject {
    init(model: ListModel)
}

/// APIs for `Model` to expose to `ViewModel`
protocol ListModel: AnyObject {
    func setModelConsumer(_ newValue: ListModelConsumer)
    func items() -> [String]
}

class ListModelImpl: ListModel {
    
    // MARK: - Properties
    private weak var modelConsumer: ListModelConsumer!
    
    // MARK: - Initialization
    init() {
        debugPrint("✅ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    deinit {
        debugPrint("☠️ \(#file) » \(#function) » \(#line)", separator: "\n")
    }
    
    // MARK: - ListModel protocol
    func setModelConsumer(_ newValue: ListModelConsumer) {
        self.modelConsumer = newValue
    }
    
    func items() -> [String] {
        return words
    }
}

private let words: [String] = "est lorem ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus et netus et malesuada fames ac".components(separatedBy: " ")
