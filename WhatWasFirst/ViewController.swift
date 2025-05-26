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
    private let buttonColour = UIColor.white
    private let borderWidth: CGFloat = 4
    private let buttonMargin: CGFloat = 50
    private let cornerRadius: CGFloat = 25
    private let sidePadding: CGFloat = 10
    private let animDistanceOffset: CGFloat = 100
    private let animLenght: Double = 1.0
    
    private let dataProvider = DataProvider.shared
    private var topElementData: HistoricItem!
    private var bottomElementData: HistoricItem!
    private var bgView: UIView!
    private var containerView: UIView!
    private var topElement: ImageElement!
    private var bottomElement: ImageElement!
    private var introLabel: UILabel!
    private var nextButton: UIButton!
    private var endGameAlert: CustomAlert!
    
    private var introLabelAnimConstraint: NSLayoutConstraint!
    private var nextButtonAnimConstraint: NSLayoutConstraint!
    private var topHeightConstraint: NSLayoutConstraint!
    private var bottomHeightConstraint: NSLayoutConstraint!
    private var containerPaddingConstraintTop: NSLayoutConstraint!
    private var containerPaddingConstraintBottom: NSLayoutConstraint!
    
    private var score: Int = 0
    private var roundCounter: Int = 0
    private var totalRounds: Int = 3
    private var isFirstRound: Bool = true
    private var wasLastRound: Bool = false
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        bgView = UIView()
        bgView.backgroundColor = bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerPaddingConstraintTop = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        containerPaddingConstraintBottom = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        topElement = ImageElement(frame: .zero, id: "top", delegate: self)
        topElement.translatesAutoresizingMaskIntoConstraints = false
        topElement.layer.cornerRadius = cornerRadius
        topElement.layer.borderWidth = borderWidth
        topElement.layer.borderColor = borderColour
        topElement.clipsToBounds = true
        topElement.isUserInteractionEnabled = true
        topHeightConstraint = topElement.heightAnchor.constraint(equalToConstant: 0)
        
        bottomElement = ImageElement(frame: .zero, id: "bottom", delegate: self)
        bottomElement.translatesAutoresizingMaskIntoConstraints = false
        bottomElement.layer.cornerRadius = cornerRadius
        bottomElement.layer.borderWidth = borderWidth
        bottomElement.layer.borderColor = borderColour
        bottomElement.clipsToBounds = true
        bottomElement.isUserInteractionEnabled = true
        bottomHeightConstraint = bottomElement.heightAnchor.constraint(equalToConstant: 0)
        
        nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(bgColour, for: .normal)
        nextButton.backgroundColor = buttonColour
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
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
            
            containerPaddingConstraintTop,
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            containerPaddingConstraintBottom,
            
            nextButtonAnimConstraint,
            nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
            
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
        
        fillElementsAndStartNewRound()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerPaddingConstraintTop.constant = view.safeAreaInsets.top < 24 ? 20 : 0
        containerPaddingConstraintBottom.constant = view.safeAreaInsets.bottom < 24 ? -20 : 0
        
        let sideSize = containerView.bounds.height / 2 - buttonMargin
        topHeightConstraint.constant = sideSize
        bottomHeightConstraint.constant = sideSize
    }
    
    // MARK: - Flow
    
    @objc private func nextButtonTapped() {
        blockingUI(withImagesBlocked: true, withButtonBlocked: true)
        if wasLastRound {
            endGameAlert.setText(withScore: score, outOf: totalRounds)
            endGameAlert.isHidden = false
        } else {
            fillElementsAndStartNewRound()
        }
        
        // TODO: Вопрос здесь по повду async
        blockingUI(withImagesBlocked: false, withButtonBlocked: true)
    }
    
    private func checkResult(given id: String) {
        if (id == "top" && topElementData.date < bottomElementData.date) || (id == "bottom" && bottomElementData.date < topElementData.date) {
            score += 1
        }
        roundCounter += 1
        
        if roundCounter == totalRounds {
            wasLastRound = true
            nextButton.setTitle("Finish", for: .normal)
        }
    }
    
    private func resetGame() {
        score = 0
        roundCounter = 0
        wasLastRound = false
        isFirstRound = true
        endGameAlert.isHidden = true
        buttonSwitchAnimation(goingDown: false, resetting: true)
        fillElementsAndStartNewRound()
    }
    
    // MARK: - Service
    
    private func fillElementsAndStartNewRound() {
        let historicItems = dataProvider.provideItems()
        topElementData = historicItems.0
        bottomElementData = historicItems.1

        topElement.updateItem(with: topElementData, isRightAnswer: topElementData.date < bottomElementData.date)
        bottomElement.updateItem(with: bottomElementData, isRightAnswer: bottomElementData.date < topElementData.date)
    }
    
    private func blockingUI(withImagesBlocked: Bool, withButtonBlocked: Bool) {
        topElement.isUserInteractionEnabled = !withImagesBlocked
        bottomElement.isUserInteractionEnabled = !withImagesBlocked
        nextButton.isEnabled = !withButtonBlocked
        nextButton.alpha = withButtonBlocked ? 0.5 : 1
    }
    
    private func buttonSwitchAnimation(goingDown: Bool, resetting: Bool) {
        blockingUI(withImagesBlocked: true, withButtonBlocked: true)
        if goingDown {
            nextButtonAnimConstraint.constant += animDistanceOffset
            introLabelAnimConstraint.constant += animDistanceOffset
        } else {
            nextButtonAnimConstraint.constant -= animDistanceOffset
            introLabelAnimConstraint.constant -= animDistanceOffset
        }
        UIView.animate(withDuration: animLenght, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.blockingUI(withImagesBlocked: goingDown ? true : false, withButtonBlocked: goingDown ? false : true)
            if resetting {
                self.nextButton.setTitle("Next", for: .normal)
            }
        } )
    }
}

// MARK: - Extensions

extension ViewController: ImageElementDelegate {
    func didTapImageElement(with id: String) {
        if isFirstRound {
            buttonSwitchAnimation(goingDown: true, resetting: false)
            isFirstRound = false
        } else {
            blockingUI(withImagesBlocked: true, withButtonBlocked: false)
        }
        topElement.showingOverlay()
        bottomElement.showingOverlay()

        checkResult(given: id)
    }
}

extension ViewController: EndGameAlertDelegate {
    func didTapOkButton() {
        resetGame()
    }
}
