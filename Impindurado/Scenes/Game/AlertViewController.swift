//
//  AlertViewController.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 14/08/21.
//

import UIKit

protocol AlertDelegate: AnyObject {
    func didTapConfirmButton(type: TypeAlert?)
    func didTapCancelButton(type: TypeAlert?)
}

enum TypeAlert {
    case tutorial
    case confirmLetter
}

class AlertViewController: UIViewController {
    
    lazy var blur: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.alpha = 0.6
        blurView.frame = self.view.bounds
        return blurView
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBrown
        view.layer.masksToBounds = false
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.lightBrown.cgColor
        view.layer.cornerRadius = 8
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = -1
        label.textAlignment = .center
        label.textColor = .white
        label.font = R.font.pacificoRegular(size: 16)
        return label
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()

    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private let verticalLine: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .lightBrown
        return view
    }()

    private let horizontalLine: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .lightBrown
        return view
    }()
    
    weak var delegate: AlertDelegate?
    
    var type: TypeAlert?

    init(title: String, type: TypeAlert) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
    }
    
    @objc func didTapConfirmButton() {
        delegate?.didTapConfirmButton(type: type)
    }
    
    @objc func didTapCancelButton() {
        delegate?.didTapCancelButton(type: type)
        dismiss(animated: true)
    }
}

extension AlertViewController: ViewCode  {

    func setupViewHierarchy() {
        view.addSubview(blur)
        view.addSubview(contentView)
        contentView.addSubview(horizontalLine)
        contentView.addSubview(verticalLine)
        contentView.addSubview(titleLabel)
        contentView.addSubview(confirmButton)
        contentView.addSubview(cancelButton)
    }

    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        horizontalLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }

        verticalLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(horizontalLine.snp.bottom).offset(-4)
            make.width.equalTo(4)
            make.bottom.equalToSuperview().inset(8)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalTo(verticalLine.snp.leading).inset(8)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(verticalLine.snp.trailing).inset(8)
        }
    }
}
