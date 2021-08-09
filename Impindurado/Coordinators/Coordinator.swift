//
//  Coordinator.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 09/08/21.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
