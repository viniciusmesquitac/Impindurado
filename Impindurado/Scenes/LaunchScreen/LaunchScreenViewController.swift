//
//  LaunchScreenViewController.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 22/08/21.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    private let logoImageSize = CGSize(width: 200, height: 200)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = R.image.logo()
        return imageView
    }()
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = R.image.menu_background()
        return imageView
    }()
    
    weak var coordinator: AppCoordinator?

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        setupViewHierarchy()
        setupConstraints()
        
        performAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.imageView.layer.removeAllAnimations()
            self.coordinator?.coordinateToMenu()
        }
    }

    func performAnimation() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, delay: .zero, options: [.repeat, .autoreverse]) {
            self.imageView.snp.remakeConstraints { make in
                make.size.equalTo(self.logoImageSize)
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func setupViewHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        imageView.snp.makeConstraints { make in
            make.size.equalTo(logoImageSize)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.62)
        }
        
        
    }
    
}
