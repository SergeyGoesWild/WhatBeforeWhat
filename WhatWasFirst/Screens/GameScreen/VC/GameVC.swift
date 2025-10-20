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

class GameVC: UIViewController {
    
    private var model: GameModelProtocol
    
    private var didSetupContent = false
    private var isFirstRound: Bool = true
    
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
        let counterElement = CounterView()
        counterElement.translatesAutoresizingMaskIntoConstraints = false
        counterElement.clipsToBounds = true
        counterElement.layer.cornerRadius = AppLayout.counterCorRad
        return counterElement
    }()
    
    private var topHeightConstraint: NSLayoutConstraint!
    private var bottomHeightConstraint: NSLayoutConstraint!
    private var containerPaddingConstraintTop: NSLayoutConstraint!
    private var containerPaddingConstraintBottom: NSLayoutConstraint!
    
    // MARK: - Setup
    init(model: GameModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        model.onStateChange = { [weak self] state in
            self?.updateTextUI(state: state)
        }
        model.onNewRound = { [weak self] sharedItem01, sharedItem02 in
            self?.updateElements(item01: sharedItem01, item02: sharedItem02)
            self?.imageLayer.showOverlay(isShowing: false)
        }
        model.onEndGame = { [weak self] score, rounds, title, answer in
            self?.alertLayer.activateAlert(withScore: score, outOf: rounds, withTitleObject: (title, answer))
            self?.alertLayer.isHidden = false
            self?.launchStars()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        model.startNewRound()
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
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppLayout.sidePadding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppLayout.sidePadding),
            containerPaddingConstraintBottom,
            
            imageLayer.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageLayer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageLayer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageLayer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            buttonLayer.topAnchor.constraint(equalTo: containerView.topAnchor),
            buttonLayer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonLayer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonLayer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            counterElement.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AppLayout.counterSpacing),
            counterElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AppLayout.counterSpacing),
            counterElement.widthAnchor.constraint(equalToConstant: AppLayout.counterWidth),
            counterElement.heightAnchor.constraint(equalToConstant: AppLayout.counterHeight),
            
            alertLayer.topAnchor.constraint(equalTo: view.topAnchor),
            alertLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alertLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alertLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didSetupContent {
            didSetupContent = true
            setupResponsive()
        }
    }
    
    private func setupResponsive() {
        containerPaddingConstraintTop.constant = view.safeAreaInsets.top < AppThreshold.safeAreaInset ? AppLayout.additionalVertPadding : 0
        containerPaddingConstraintBottom.constant = view.safeAreaInsets.bottom < AppThreshold.safeAreaInset ? -AppLayout.additionalVertPadding : 0
        let smallScreen = view.frame.height < AppThreshold.smallScreenLimit
        buttonLayer.setLabelFont(fontSize: smallScreen ? AppLayout.smallLabelFont : AppLayout.bigLabelFont)
        view.layoutIfNeeded()
    }
    
    // MARK: - Flow
    private func imageTapped(guessedRight: Bool) {
        if isFirstRound {
            launchButtonAnimation(goingDown: true) { [weak self] in
                self?.buttonLayer.blockButton(isBlocked: false)
            }
            isFirstRound = false
        } else {
            buttonLayer.blockButton(isBlocked: false)
        }
        imageLayer.showOverlay(isShowing: true)
        model.checkAction(guessedRight: guessedRight)
    }
    
    private func nextButtonTapped() {
        model.nextStepAction()
    }
    
    private func updateTextUI(state: GameState) {
        buttonLayer.setButtonTitle(state.buttonText)
        counterElement.updateCounterLabel(currentNumber: state.currentRound, totalNumber: state.totalRounds)
    }
    
    private func resetGameUI() {
        launchButtonAnimation(goingDown: false)
        model.alertOkAction()
        imageLayer.showOverlay(isShowing: false)
        isFirstRound = true
        alertLayer.isHidden = true
    }
    
    // MARK: - Service
    private func updateElements(item01: SharedItem, item02: SharedItem) {
        imageLayer.updateElements(item01: item01, item02: item02)
    }
    
    private func launchButtonAnimation(goingDown: Bool, completion: (() -> Void)? = nil) {
        buttonLayer.prepareForAnimation(goingDown: goingDown)
        UIView.animate(withDuration: AppAnimations.buttonMove, animations: {
            self.buttonLayer.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
    
    private func launchStars() {
        let particLayer = ParticleLayer()
        particLayer.translatesAutoresizingMaskIntoConstraints = false
        particLayer.isUserInteractionEnabled = false
        view.addSubview(particLayer)
        NSLayoutConstraint.activate([
            particLayer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            particLayer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            particLayer.topAnchor.constraint(equalTo: containerView.topAnchor),
            particLayer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        particLayer.startEmission()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + AppAnimations.particleTime + AppAnimations.emittionDuration) {
            particLayer.removeFromSuperview()
        }
    }
}

    // MARK: - Extensions
extension GameVC: ImageElementDelegate {
    func didTapImageElement(with guessedRight: Bool) {
        imageTapped(guessedRight: guessedRight)
    }
}

extension GameVC: EndGameAlertDelegate {
    func didTapOkButton() {
        resetGameUI()
    }
}

extension GameVC: NextButtonDelegate {
    func didTapNextButton() {
        nextButtonTapped()
    }
}
