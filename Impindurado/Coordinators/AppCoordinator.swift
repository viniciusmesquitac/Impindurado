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
        self.navigationController.navigationBar.backgroundColor = .clear
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.barTintColor = .clear
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.barStyle = .black
    }

    func start() {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        launchScreen()
    }

    func coordinateToMenu() {
        let menu = MenuCoordinator(navigationController: navigationController)
        coordinate(to: menu)
    }

    private func launchScreen() {
        let launchScreen = LaunchScreenViewController(coordinator: self)
        navigationController.pushViewController(launchScreen, animated: false)
    }

}
