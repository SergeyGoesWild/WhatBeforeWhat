//
//  ButtonLayer.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 03/09/2025.
//

import UIKit

final class ButtonLayer: UIView {
    
    weak var delegate: NextButtonDelegate?
    
    private let animDistanceOffset: CGFloat = 100
    
    private var introLabelAnimConstraint: NSLayoutConstraint!
    private var nextButtonAnimConstraint: NSLayoutConstraint!
    
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
        introLabel.text = UIStrings.string("UI.centralQuestion")
        return introLabel
    }()
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle(UIStrings.string("UI.nextButton"), for: .normal)
        nextButton.setTitleColor(AppColors.bgColour, for: .normal)
        nextButton.backgroundColor = AppColors.buttonColour
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        return nextButton
    }()
    
    init(frame: CGRect, delegate: NextButtonDelegate?) {
        self.delegate = delegate
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func nextButtonTapped() {
        blockButton(isBlocked: true)
        delegate?.didTapNextButton()
    }
    
    private func setupLayout() {
        nextButtonAnimConstraint = nextButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -animDistanceOffset)
        introLabelAnimConstraint = introLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0)
        
        addSubview(containerView)
        containerView.addSubview(introLabel)
        containerView.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nextButtonAnimConstraint,
            nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
            
            introLabelAnimConstraint,
            introLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    func prepareForAnimation(goingDown: Bool) {
        if goingDown {
            nextButtonAnimConstraint.constant += animDistanceOffset
            introLabelAnimConstraint.constant += animDistanceOffset
        } else {
            nextButtonAnimConstraint.constant -= animDistanceOffset
            introLabelAnimConstraint.constant -= animDistanceOffset
        }
    }
    
    func setButtonTitle(_ title: String) {
        nextButton.setTitle(title, for: .normal)
    }
    
    func blockButton(isBlocked: Bool) {
        nextButton.isEnabled = !isBlocked
        nextButton.alpha = isBlocked ? 0.5 : 1
    }
    
    func setLabelFont(fontSize: CGFloat) {
        introLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .black)
    }
}
