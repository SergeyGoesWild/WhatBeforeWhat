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

    private var roundCounter: Int = 0
    private var totalRounds: Int = 10
    private var didSetupContent = false
    private var isFirstRound: Bool = true
    private var wasLastRound: Bool = false
    
    private let borderWidth: CGFloat = 4
    private let cornerRadius: CGFloat = 25
    private let sidePadding: CGFloat = 10
    private let animDistanceOffset: CGFloat = 100
    private let animLenght: Double = 1.0
    
    private let dataProvider = DataProvider.shared
    private let scoreTracker = ScoreTracker.shared
    private let titleFactory = TitleFactory.shared
    
    private var topElementData: HistoricItem!
    private var bottomElementData: HistoricItem!
    private lazy var endGameAlert: CustomAlert = {
        let endGameAlert = CustomAlert(delegate: self)
        endGameAlert.translatesAutoresizingMaskIntoConstraints = false
        endGameAlert.isHidden = true
        return endGameAlert
    }()
    
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = AppColors.bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private lazy var buttonLabelContainer: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private lazy var counterElement: CounterView = {
        let counterElement = CounterView(frame: .zero, totalRounds: totalRounds)
        counterElement.translatesAutoresizingMaskIntoConstraints = false
        counterElement.clipsToBounds = true
        counterElement.layer.cornerRadius = 12
        return counterElement
    }()
    private lazy var topElement: ImageElement = {
        let topElement = ImageElement(frame: .zero, id: "top", delegate: self)
        topElement.translatesAutoresizingMaskIntoConstraints = false
        topElement.layer.cornerRadius = cornerRadius
        topElement.layer.borderWidth = borderWidth
        topElement.layer.borderColor = AppColors.borderColour.cgColor
        topElement.clipsToBounds = true
        topElement.isUserInteractionEnabled = true
        return topElement
    }()
    private lazy var bottomElement: ImageElement = {
        let bottomElement = ImageElement(frame: .zero, id: "bottom", delegate: self)
        bottomElement.translatesAutoresizingMaskIntoConstraints = false
        bottomElement.layer.cornerRadius = cornerRadius
        bottomElement.layer.borderWidth = borderWidth
        bottomElement.layer.borderColor = AppColors.borderColour.cgColor
        bottomElement.clipsToBounds = true
        bottomElement.isUserInteractionEnabled = true
        return bottomElement
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
    
    private var introLabelAnimConstraint: NSLayoutConstraint!
    private var nextButtonAnimConstraint: NSLayoutConstraint!
    private var topHeightConstraint: NSLayoutConstraint!
    private var bottomHeightConstraint: NSLayoutConstraint!
    private var containerPaddingConstraintTop: NSLayoutConstraint!
    private var containerPaddingConstraintBottom: NSLayoutConstraint!
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        containerPaddingConstraintTop = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        containerPaddingConstraintBottom = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        nextButtonAnimConstraint = nextButton.centerYAnchor.constraint(equalTo: buttonLabelContainer.centerYAnchor, constant: -animDistanceOffset)
        introLabelAnimConstraint = introLabel.centerYAnchor.constraint(equalTo: buttonLabelContainer.centerYAnchor, constant: 0)
        
        counterElement.updateConterLabel(newRound: roundCounter + 1)
        
        view.addSubview(bgView)
        view.addSubview(containerView)
        view.addSubview(endGameAlert)
        containerView.addSubview(buttonLabelContainer)
        containerView.addSubview(topElement)
        containerView.addSubview(bottomElement)
        containerView.addSubview(counterElement)
        buttonLabelContainer.addSubview(introLabel)
        buttonLabelContainer.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerPaddingConstraintTop,
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            containerPaddingConstraintBottom,
            
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
            
            counterElement.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            counterElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            counterElement.widthAnchor.constraint(equalToConstant: 75),
            counterElement.heightAnchor.constraint(equalToConstant: 30),
            
            topElement.topAnchor.constraint(equalTo: containerView.topAnchor),
            topElement.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.43),
            topElement.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topElement.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            bottomElement.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomElement.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.43),
            bottomElement.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bottomElement.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            endGameAlert.topAnchor.constraint(equalTo: view.topAnchor),
            endGameAlert.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endGameAlert.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            endGameAlert.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didSetupContent {
            containerPaddingConstraintTop.constant = view.safeAreaInsets.top < 24 ? 20 : 0
            containerPaddingConstraintBottom.constant = view.safeAreaInsets.bottom < 24 ? -20 : 0
            view.layoutIfNeeded()
            let smallScreen = view.frame.height < 812
            if smallScreen {
                introLabel.font = UIFont.systemFont(ofSize: 25, weight: .black)
            } else {
                introLabel.font = UIFont.systemFont(ofSize: 30, weight: .black)
            }
            fillElementsAndStartNewRound()
            didSetupContent = true
        }
    }
    
    // MARK: - Flow
    
    @objc private func nextButtonTapped() {
        blockingUI(withImagesBlocked: true, withButtonBlocked: true)
        if wasLastRound {
            
            let results = scoreTracker.getScore()
            let score = results.0
            let answers = results.1
            let titleObject = titleFactory.makeTitle(with: answers)
            endGameAlert.activateAlert(withScore: score, outOf: totalRounds, withTitleObject: titleObject)
            endGameAlert.isHidden = false
        } else {
            fillElementsAndStartNewRound()
            counterElement.updateConterLabel(newRound: roundCounter + 1)
            blockingUI(withImagesBlocked: false, withButtonBlocked: true)
        }
    }
    
    private func checkIfGameOver() {
        roundCounter += 1
        if roundCounter == totalRounds {
            wasLastRound = true
            nextButton.setTitle("Finish", for: .normal)
        }
    }
    
    private func resetGame() {
        roundCounter = 0
        counterElement.updateConterLabel(newRound: roundCounter + 1)
        wasLastRound = false
        isFirstRound = true
        buttonSwitchAnimation(goingDown: false, resetting: true)
        endGameAlert.isHidden = true
        fillElementsAndStartNewRound()
        blockingUI(withImagesBlocked: false, withButtonBlocked: true)
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
            self.buttonLabelContainer.layoutIfNeeded()
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

        scoreTracker.sendData(withID: id, topElementData: topElementData, bottomElementData: bottomElementData)
        checkIfGameOver()
    }
}

extension ViewController: EndGameAlertDelegate {
    func didTapOkButton() {
        resetGame()
    }
}
