//
//  MenuCoordinator.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 09/08/21.
//

import UIKit
import GameKit

class MenuCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private var rootNavigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.barStyle = .black
    }

    func start() {
        let controller = MenuViewController(viewModel: MenuViewModel(), coordinator: self)
        controller.navigationItem.setHidesBackButton(true, animated: false)
        rootNavigationController = UINavigationController(rootViewController: controller)
        rootNavigationController.modalTransitionStyle = .crossDissolve
        rootNavigationController.modalPresentationStyle = .overFullScreen
        rootNavigationController.navigationBar.backgroundColor = .clear
        rootNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        rootNavigationController.navigationBar.barTintColor = .clear
        rootNavigationController.navigationBar.shadowImage = UIImage()
        navigationController.present(rootNavigationController, animated: true)
    }

    func gameScene() {
        let coordinator = GameCoordinator(navigationController: rootNavigationController)
        coordinator.start()
    }
    
    func showLeaderboard() {
        let gamecenter = GKGameCenterViewController()
        if let controller = rootNavigationController.viewControllers.first as? MenuViewController {
            gamecenter.gameCenterDelegate = controller
        }
        rootNavigationController.present(gamecenter, animated: true)
    }
}
