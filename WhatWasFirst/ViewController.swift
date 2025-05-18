//
//  ViewController.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 14/05/2025.
//

import UIKit

protocol ImageElementDelegate: AnyObject {
    func didTapImageElement(with id: String)
}

protocol EndGameAlertDelegate: AnyObject {
    func didTapOkButton()
}

class ViewController: UIViewController {

    private let bgColour = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
    private let borderColour = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00)
    private let borderWidth: CGFloat = 4
    private let buttonMargin: CGFloat = 50
    private let cornerRadius: CGFloat = 25
    private let sidePadding: CGFloat = 10
    private let animDistanceOffset: CGFloat = 100
    private let animLenght: Double = 0.4
    
    private let dataProvider = DataProvider.shared
    private var topElementData: HistoricItem!
    private var bottomElementData: HistoricItem!
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
    
    private var score: Int = 0
    private var roundCounter: Int = 0
    private var totalRounds: Int = 3
    private var isFirstRound: Bool = true
    private var wasLastRound: Bool = false
    
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
        let firstTurnDataItems = dataProvider.provideItems()
        topElementData = firstTurnDataItems.0
        bottomElementData = firstTurnDataItems.1
        
        bgView = UIView()
        bgView.backgroundColor = bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        topElement = ImageElement(frame: .zero, id: "top", historicItem: topElementData, delegate: self)
        topElement.translatesAutoresizingMaskIntoConstraints = false
        topElement.layer.cornerRadius = cornerRadius
        topElement.layer.borderWidth = borderWidth
        topElement.layer.borderColor = borderColour
        topElement.clipsToBounds = true
        topHeightConstraint = topElement.heightAnchor.constraint(equalToConstant: 0)
        
        bottomElement = ImageElement(frame: .zero, id: "bottom", historicItem: bottomElementData, delegate: self)
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
        
        endGameAlert = CustomAlert(delegate: self)
        endGameAlert.translatesAutoresizingMaskIntoConstraints = false
        endGameAlert.isHidden = true
        
        view.addSubview(bgView)
        view.addSubview(containerView)
        view.addSubview(endGameAlert)
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
            
            endGameAlert.topAnchor.constraint(equalTo: view.topAnchor),
            endGameAlert.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endGameAlert.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            endGameAlert.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func startNewRound() {
        let historicItems = dataProvider.provideItems()
        topElementData = historicItems.0
        bottomElementData = historicItems.1
        
        topElement.updateItem(with: topElementData)
        bottomElement.updateItem(with: bottomElementData)
    }
    
    private func checkResult(given id: String) {
        if (id == "top" && topElementData.date < bottomElementData.date) || (id == "bottom" && bottomElementData.date < topElementData.date) {
            score += 1
        }
        roundCounter += 1
        print("score =   ", score)
        print("round =   ", roundCounter)
        
        if roundCounter == totalRounds {
            wasLastRound = true
        }
    }
    
    private func buttonSwitchAnimation(goingDown: Bool) {
        if goingDown {
            nextButtonAnimConstraint.constant += animDistanceOffset
            introLabelAnimConstraint.constant += animDistanceOffset
        } else {
            nextButtonAnimConstraint.constant -= animDistanceOffset
            introLabelAnimConstraint.constant -= animDistanceOffset
        }
        UIView.animate(withDuration: animLenght) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func resetGame() {
        score = 0
        roundCounter = 0
        wasLastRound = false
        isFirstRound = true
        endGameAlert.isHidden = true
        buttonSwitchAnimation(goingDown: false)
        startNewRound()
    }
    
    @objc private func nextButtonTapped() {
        print("------- ", wasLastRound)
        if wasLastRound {
            print("FINAL SCORE: \(score)")
            endGameAlert.setText(withScore: score, outOf: totalRounds)
            endGameAlert.isHidden = false
        } else {
            startNewRound()
        }
    }
}

extension ViewController: ImageElementDelegate {
    func didTapImageElement(with id: String) {
        if isFirstRound {
            buttonSwitchAnimation(goingDown: true)
            isFirstRound = false
        }
        checkResult(given: id)
    }
}

extension ViewController: EndGameAlertDelegate {
    func didTapOkButton() {
        resetGame()
    }
}
