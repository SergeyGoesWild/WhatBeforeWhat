//
//  ButtonLayer.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 03/09/2025.
//

import UIKit

final class ButtonLayer: UIView {
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private lazy var introLabel: UILabel = {
        let introLabel = UILabel()
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.textColor = AppColors.labelColour
        introLabel.font = UIFont.systemFont(ofSize: 25, weight: .black)
        introLabel.numberOfLines = 0
        introLabel.text = "What was first?"
        return introLabel
    }()
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(AppColors.bgColour, for: .normal)
        nextButton.backgroundColor = AppColors.buttonColour
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
        return nextButton
    }()
    
    init(frame: CGRect, delegate: ImageElementDelegate?) {
        self.delegateToPass = delegate
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        nextButtonAnimConstraint = nextButton.centerYAnchor.constraint(equalTo: buttonLabelContainer.centerYAnchor, constant: -animDistanceOffset)
        introLabelAnimConstraint = introLabel.centerYAnchor.constraint(equalTo: buttonLabelContainer.centerYAnchor, constant: 0)
        
        addSubview(containerView)
        containerView.addSubview(introLabel)
        containerView.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            buttonLabelContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonLabelContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            buttonLabelContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonLabelContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            nextButtonAnimConstraint,
            nextButton.centerXAnchor.constraint(equalTo: buttonLabelContainer.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: buttonLabelContainer.widthAnchor, multiplier: 0.85),
            
            introLabelAnimConstraint,
            introLabel.centerXAnchor.constraint(equalTo: buttonLabelContainer.centerXAnchor),
        ])
    }
}
