//
//  CustomAlert.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 14/05/2025.
//

import UIKit

final class CustomAlert: UIView {
    
    weak var delegate: EndGameAlertDelegate?
    
    private var alertBackgroundView: UIView = {
        let alertBackgroundView = UIView()
        alertBackgroundView.backgroundColor = AppColors.bgColour
        alertBackgroundView.layer.cornerRadius = 20
        alertBackgroundView.layer.borderWidth = 4
        alertBackgroundView.layer.borderColor = AppColors.borderColour.cgColor
        alertBackgroundView.clipsToBounds = true
        alertBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        return alertBackgroundView
    }()
    private var fadeBackgroundView: UIView = {
        let fadeBackgroundView = UIView()
        fadeBackgroundView.backgroundColor = .black
        fadeBackgroundView.alpha = 0.75
        fadeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        return fadeBackgroundView
    }()
    private var labelView: UILabel = {
        let labelView = UILabel()
        labelView.textColor = AppColors.labelColour
        labelView.textAlignment = .center
        labelView.numberOfLines = 0
        labelView.setContentHuggingPriority(.required, for: .vertical)
        labelView.setContentCompressionResistancePriority(.required, for: .vertical)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    private lazy var buttonView: UIButton = {
        let buttonView = UIButton(type: .system)
        buttonView.setTitle("OK", for: .normal)
        buttonView.setTitleColor(AppColors.bgColour, for: .normal)
        buttonView.backgroundColor = AppColors.buttonColour
        buttonView.layer.cornerRadius = 8
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonView.setContentHuggingPriority(.required, for: .vertical)
        buttonView.setContentCompressionResistancePriority(.required, for: .vertical)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        return buttonView
    }()
    
    // MARK: - Setup
    
    init(delegate: EndGameAlertDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [labelView, buttonView])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(fadeBackgroundView)
        addSubview(alertBackgroundView)
        alertBackgroundView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            fadeBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            fadeBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fadeBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fadeBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            alertBackgroundView.centerXAnchor.constraint(equalTo: fadeBackgroundView.centerXAnchor),
            alertBackgroundView.centerYAnchor.constraint(equalTo: fadeBackgroundView.centerYAnchor),
            
            stackView.topAnchor.constraint(equalTo: alertBackgroundView.topAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: alertBackgroundView.bottomAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: alertBackgroundView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: alertBackgroundView.trailingAnchor, constant: -30),
            
            alertBackgroundView.widthAnchor.constraint(lessThanOrEqualToConstant: 350),
            
            buttonView.widthAnchor.constraint(equalToConstant: 200),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Flow
    
    @objc func buttonTapped() {
        delegate?.didTapOkButton()
    }
    
    // MARK: - Service
    
    func setText(withScore score: Int, outOf total: Int) {
        labelView.text = "Your score: \n\(score) out of \(total)"
    }
}
