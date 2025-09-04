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

protocol NextButtonDelegate: AnyObject {
    func didTapNextButton()
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
    private let buttonAnimLength: Double = 1.0
    
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
        return imageLayer
    }()
    private lazy var buttonLayer: ButtonLayer = {
        let buttonLayer = ButtonLayer(frame: .zero, delegate: self)
        buttonLayer.backgroundColor = .clear
        buttonLayer.translatesAutoresizingMaskIntoConstraints = false
        return buttonLayer
    }()
    private lazy var alertLayer: AlertLayer = {
        let endGameAlert = AlertLayer(delegate: self)
        endGameAlert.translatesAutoresizingMaskIntoConstraints = false
        endGameAlert.isHidden = true
        return endGameAlert
    }()
    private lazy var counterElement: CounterView = {
        let counterElement = CounterView(frame: .zero, totalRounds: currentState.totalRounds)
        counterElement.translatesAutoresizingMaskIntoConstraints = false
        counterElement.clipsToBounds = true
        counterElement.layer.cornerRadius = 12
        return counterElement
    }()
    
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
        model.onStateChange = { [weak self] state in
            self?.updateTextUI(state: state)
        }
        setupLayout()
    }
    
    private func setupLayout() {
        containerPaddingConstraintTop = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        containerPaddingConstraintBottom = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        view.addSubview(bgView)
        view.addSubview(containerView)
        view.addSubview(alertLayer)
        containerView.addSubview(buttonLayer)
        containerView.addSubview(imageLayer)
        containerView.addSubview(counterElement)
        
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
            
            buttonLayer.topAnchor.constraint(equalTo: containerView.topAnchor),
            buttonLayer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonLayer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonLayer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
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
            buttonLayer.setLabelFont(fontSize: smallScreen ? 25 : 30)
            
            // TODO: May change this?
            blockingUI(withImagesBlocked: false, withButtonBlocked: true)
            let historicItems = model.alertOkAction()
            updateElements(item01: historicItems.0, item02: historicItems.1)
            
            didSetupContent = true
        }
    }
    
    // MARK: - Flow
    
    private func imageTapped(guessedRight: Bool) {
        if isFirstRound {
            blockingUI(withImagesBlocked: true, withButtonBlocked: true)
            launchButtonAnimation(goingDown: true, resetting: false) { [weak self] in
                self?.blockingUI(withImagesBlocked: true, withButtonBlocked: false)
            }
            isFirstRound = false
        } else {
            blockingUI(withImagesBlocked: true, withButtonBlocked: false)
        }
        imageLayer.showOverlay(isShowing: true)
        model.checkAction(guessedRight: guessedRight)
    }
    
    private func nextButtonTapped() {
        blockingUI(withImagesBlocked: true, withButtonBlocked: true)
        switch model.nextStepAction() {
        case .gameEnded(let title, let answer):
            alertLayer.activateAlert(withScore: currentState.currentScore, outOf: currentState.totalRounds, withTitleObject: (title, answer))
            alertLayer.isHidden = false
        case .newRound(let item01, let item02):
            updateElements(item01: item01, item02: item02)
            blockingUI(withImagesBlocked: false, withButtonBlocked: true)
        }
    }
    
    private func updateTextUI(state: GameState) {
        buttonLayer.setButtonTitle(state.lastRound == true ? "Finish" : "Next")
        counterElement.updateConterLabel(newRound: state.currentRound)
    }
    
    private func resetGameUI() {
        blockingUI(withImagesBlocked: true, withButtonBlocked: true)
        launchButtonAnimation(goingDown: false, resetting: true) { [weak self] in
            self?.blockingUI(withImagesBlocked: false, withButtonBlocked: true)
        }
        let historicItems = model.alertOkAction()
        updateElements(item01: historicItems.0, item02: historicItems.1)
        isFirstRound = true
        alertLayer.isHidden = true
    }
    
    // MARK: - Service
    
    private func updateElements(item01: HistoricItem, item02: HistoricItem) {
        imageLayer.updateElements(item01: item01, item02: item02)
    }
    
    private func blockingUI(withImagesBlocked: Bool, withButtonBlocked: Bool) {
        imageLayer.blockImages(isBlocked: withImagesBlocked)
        buttonLayer.blockButton(isBlocked: withButtonBlocked)
    }
    
    private func launchButtonAnimation(goingDown: Bool, resetting: Bool, completion: (() -> Void)? = nil) {
        buttonLayer.prepareForAnimation(goingDown: goingDown)
        UIView.animate(withDuration: buttonAnimLength, animations: {
            self.buttonLayer.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
}

// MARK: - Extensions

extension ViewController: ImageElementDelegate {
    func didTapImageElement(with guessedRight: Bool) {
        imageTapped(guessedRight: guessedRight)
    }
}

extension ViewController: EndGameAlertDelegate {
    func didTapOkButton() {
        resetGameUI()
    }
}

extension ViewController: NextButtonDelegate {
    func didTapNextButton() {
        nextButtonTapped()
    }
}
