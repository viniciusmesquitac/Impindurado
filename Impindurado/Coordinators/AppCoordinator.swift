//
//  AppCoordinator.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 09/08/21.
//

import UIKit

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        coordinateToMenu()
    }

    private func coordinateToMenu() {
        let menu = MenuCoordinator(navigationController: navigationController)
        coordinate(to: menu)
    }

}
