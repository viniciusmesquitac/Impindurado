//
//  GameCoordinator.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 11/08/21.
//

import UIKit

class GameCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private var rootViewController: (UIViewController & AlertDelegate)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = GameViewController(viewModel: GameViewModel(), coordinator: self)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        rootViewController = controller
        navigationController.present(controller, animated: true)
    }

    func showAlert(title: String, type: TypeAlert) {
        let controller = AlertViewController(title: title, type: type)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
         controller.delegate = rootViewController
        rootViewController?.present(controller, animated: true)
    }

    func result(_ gameResult: GameResult, score: Float) {
        let viewModel = GameResultViewModel(result: gameResult, score: score)
        let controller = GameResultViewController(viewModel: viewModel, coordinator: self)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            self.rootViewController?.present(controller, animated: true)
        }
    }
    
    func returnToMenu() {
        rootViewController = nil
        navigationController.dismiss(animated: false)
    }
}
