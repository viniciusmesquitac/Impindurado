//
//  GameCoordinator.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 11/08/21.
//

import UIKit

class GameCoordinator: Coordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = GameViewController(viewModel: GameViewModel())
        navigationController.pushViewController(controller, animated: false)
    }
}
