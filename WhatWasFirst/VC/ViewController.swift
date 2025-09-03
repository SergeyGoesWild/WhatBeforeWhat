//
//  ViewController.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 14/05/2025.
//

import UIKit

protocol ImageElementDelegate: AnyObject {
    func didTapImageElement(with guessedRight: Bool)
}

protocol EndGameAlertDelegate: AnyObject {
    func didTapOkButton()
}

class ViewController: UIViewController {
    
    private var model: Model!
    private var currentState: GameState {
        get {
            model.shareState()
        }
    }
    
    private var didSetupContent = false
    private var isFirstRound: Bool = true
    private var wasLastRound: Bool = false
    
    private let sidePadding: CGFloat = 10
    private let animDistanceOffset: CGFloat = 100
    private let animLenght: Double = 1.0
    
    private lazy var alertLayer: AlertLayer = {
        let endGameAlert = AlertLayer(delegate: self)
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
    private lazy var imageLayer: ImageElementsLayer = {
        let imageLayer = ImageElementsLayer(frame: .zero, delegate: self)
        imageLayer.backgroundColor = .clear
        imageLayer.translatesAutoresizingMaskIntoConstraints = false
        imageLayer.isUserInteractionEnabled = true
        return imageLayer
    }()
    private lazy var buttonLabelContainer: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private lazy var counterElement: CounterView = {
        let counterElement = CounterView(frame: .zero, totalRounds: currentState.totalRounds)
        counterElement.translatesAutoresizingMaskIntoConstraints = false
        counterElement.clipsToBounds = true
        counterElement.layer.cornerRadius = 12
        return counterElement
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
        
        let titleFactory = TitleFactory()
        let dataProvider = DataProvider()
        self.model = Model(titleFactory: titleFactory, dataProvider: dataProvider)
        
        setupLayout()
    }
    
    private func setupLayout() {
        containerPaddingConstraintTop = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        containerPaddingConstraintBottom = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        nextButtonAnimConstraint = nextButton.centerYAnchor.constraint(equalTo: buttonLabelContainer.centerYAnchor, constant: -animDistanceOffset)
        introLabelAnimConstraint = introLabel.centerYAnchor.constraint(equalTo: buttonLabelContainer.centerYAnchor, constant: 0)
        
        view.addSubview(bgView)
        view.addSubview(containerView)
        view.addSubview(alertLayer)
        containerView.addSubview(buttonLabelContainer)
        containerView.addSubview(imageLayer)
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
            
            imageLayer.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageLayer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageLayer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageLayer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
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
            
            alertLayer.topAnchor.constraint(equalTo: view.topAnchor),
            alertLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alertLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alertLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            
            let items = model.generateHistoricItems()
            updateElements(item01: items.0, item02: items.1)
            updateTextUI()
            
            didSetupContent = true
        }
    }
    
    // MARK: - Flow
    
    @objc private func nextButtonTapped() {
        blockingUI(withImagesBlocked: true, withButtonBlocked: true)
        switch model.nextStepAction() {
        case .gameEnded(let title, let answer):
            alertLayer.activateAlert(withScore: currentState.currentScore, outOf: currentState.totalRounds, withTitleObject: (title, answer))
            alertLayer.isHidden = false
        case .newRound(let item01, let item02):
            updateTextUI()
            updateElements(item01: item01, item02: item02)
            blockingUI(withImagesBlocked: false, withButtonBlocked: true)
        }
    }
    
    private func updateTextUI() {
        nextButton.setTitle(currentState.lastRound == true ? "Finish" : "Next", for: .normal)
        counterElement.updateConterLabel(newRound: currentState.currentRound)
    }
    
    private func resetGameUI() {
        let historicItems = model.alertOkAction()
        updateElements(item01: historicItems.0, item02: historicItems.1)
        
        isFirstRound = true
        alertLayer.isHidden = true
        updateTextUI()
        buttonSwitchAnimation(goingDown: false, resetting: true)
        blockingUI(withImagesBlocked: false, withButtonBlocked: true)
    }
    
    // MARK: - Service
    
    private func updateElements(item01: HistoricItem, item02: HistoricItem) {
        imageLayer.updateElements(item01: item01, item02: item02)
    }
    
    private func blockingUI(withImagesBlocked: Bool, withButtonBlocked: Bool) {
        imageLayer.isUserInteractionEnabled = !withImagesBlocked
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
    func didTapImageElement(with guessedRight: Bool) {
        if isFirstRound {
            buttonSwitchAnimation(goingDown: true, resetting: false)
            isFirstRound = false
        } else {
            blockingUI(withImagesBlocked: true, withButtonBlocked: false)
        }
        imageLayer.showOverlay(isShowing: true)
        
        model.checkAction(guessedRight: guessedRight)
        if currentState.lastRound {
            updateTextUI()
        }
    }
}

extension ViewController: EndGameAlertDelegate {
    func didTapOkButton() {
        resetGameUI()
    }
}
