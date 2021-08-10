//
//  MenuCoordinator.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 09/08/21.
//

import UIKit

class MenuCoordinator: Coordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = MenuViewController(viewModel: MenuViewModel())
        navigationController.pushViewController(controller, animated: false)
    }
}
