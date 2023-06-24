//
//  BaseObservableObject.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Combine
import UIKit

class BaseObservableObject:ObservableObject {
    lazy var cancellables = Set<AnyCancellable>()
    lazy var tasks = [Task<Void,Never>]()

    
    func addTasks(_ t:[Task<Void,Never>]) {
        tasks.append(contentsOf: t)
    }
    
    deinit {
        tasks.forEach({$0.cancel()})
        cancellables.removeAll()

    }
}
