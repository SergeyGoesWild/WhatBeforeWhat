//
//  ViewController.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 14/05/2025.
//

import UIKit

class ViewController: UIViewController {

    private let bgColour = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
    private let borderColour = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00)
    private let borderWidth: CGFloat = 4
    private let buttonMargin: CGFloat = 50
    private let cornerRadius: CGFloat = 25
    private let sidePadding: CGFloat = 10
    private let animDistanceOffset: CGFloat = 100
    
    private var bgView: UIView!
    private var containerView: UIView!
    private var topElement: ImageElement!
    private var bottomElement: ImageElement!
    private var introLabel: UILabel!
    private var nextButton: UIButton!
    private var introLabelAnimConstraint: NSLayoutConstraint!
    private var nextButtonAnimConstraint: NSLayoutConstraint!
    private var topHeightConstraint: NSLayoutConstraint!
    private var bottomHeightConstraint: NSLayoutConstraint!
    private var endGameAlert: CustomAlert!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let sideSize = containerView.bounds.height / 2 - buttonMargin
        topHeightConstraint.constant = sideSize
        bottomHeightConstraint.constant = sideSize
    }
    
    private func setupLayout() {
        bgView = UIView()
        bgView.backgroundColor = bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        topElement = ImageElement(frame: .zero)
        topElement.translatesAutoresizingMaskIntoConstraints = false
        topElement.layer.cornerRadius = cornerRadius
        topElement.layer.borderWidth = borderWidth
        topElement.layer.borderColor = borderColour
        topElement.clipsToBounds = true
        topHeightConstraint = topElement.heightAnchor.constraint(equalToConstant: 0)
        
        bottomElement = ImageElement(frame: .zero)
        bottomElement.translatesAutoresizingMaskIntoConstraints = false
        bottomElement.layer.cornerRadius = cornerRadius
        bottomElement.layer.borderWidth = borderWidth
        bottomElement.layer.borderColor = borderColour
        bottomElement.clipsToBounds = true
        bottomHeightConstraint = bottomElement.heightAnchor.constraint(equalToConstant: 0)
        
        nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.backgroundColor = .white
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButtonAnimConstraint = nextButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -animDistanceOffset)
        
        introLabel = UILabel()
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.textColor = .black
        introLabel.font = UIFont.systemFont(ofSize: 25, weight: .black)
        introLabel.numberOfLines = 0
        introLabel.text = "What was first?"
        introLabelAnimConstraint = introLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0)
        
        endGameAlert = CustomAlert(alertText: "Your result is 8/10")
        endGameAlert.translatesAutoresizingMaskIntoConstraints = false
        
//        let testButton = UIButton(type: .system)
//        testButton.setTitle("Next", for: .normal)
//        testButton.setTitleColor(.systemBlue, for: .normal)
//        testButton.backgroundColor = .white
//        testButton.layer.cornerRadius = 12
//        testButton.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
//        testButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bgView)
        view.addSubview(containerView)
//        view.addSubview(endGameAlert)
//        view.addSubview(testButton)
        containerView.addSubview(introLabel)
        containerView.addSubview(nextButton)
        containerView.addSubview(topElement)
        containerView.addSubview(bottomElement)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            nextButtonAnimConstraint,
            nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.75),
            
//            testButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            testButton.heightAnchor.constraint(equalToConstant: 50),
//            testButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.75),
            
            introLabelAnimConstraint,
            introLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            topElement.topAnchor.constraint(equalTo: containerView.topAnchor),
            topHeightConstraint,
            topElement.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topElement.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            bottomElement.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomHeightConstraint,
            bottomElement.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bottomElement.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
//            endGameAlert.topAnchor.constraint(equalTo: view.topAnchor),
//            endGameAlert.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            endGameAlert.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            endGameAlert.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func buttonSwitchAnimation() {
        nextButtonAnimConstraint.constant += animDistanceOffset
        introLabelAnimConstraint.constant += animDistanceOffset
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func nextButtonTapped() {
        print("Next button tapped!")
    }
    
    @objc private func testButtonTapped() {
        buttonSwitchAnimation()
    }
}
