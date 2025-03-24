//
//  GameScene.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 25/01/2025.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    let animationLength = 0.3
    let strokeWidth = 3
    let cornerRadius = 35
    let centralMargin = 45
    let buttonMargin = 60
    let sideMargin = 10
    let verticalMargin = 10
    let gameLimit: Int = 5
    let responseDelay: Double = 1.0
    let shadowOffset = 10
    let positiveMessage = "Yes!"
    let negativeMessage = "No!"
    let buttonColorActive = UIColor(red: 0.13, green: 0.58, blue: 0.33, alpha: 1.00)
    let buttonColorInactive = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    let shadowColorActive = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    let shadowColorInactive = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    
    var containerSize: CGSize!
    var isTouchBlocked = false
    var buttonActive = false
    let dataProvider = DataProvider.shared
    var guessRight = false
    var introOFF = false
    var isEnding = false
    var topObject: HistoricItem!
    var bottomObject: HistoricItem!
    var score: Int = 0
    var gameCounter: Int = 0
    
    var introLabel: SKLabelNode!
    var buttonNext: CustomButton!
    var buttonTouchArea: SKShapeNode!
    var topImageElement: ImageElement!
    var topTouchArea: SKShapeNode!
    var bottomImageElement: ImageElement!
    var bottomTouchArea: SKShapeNode!
    
    override func didMove(to view: SKView) {
        let items = dataProvider.provideItems()
        topObject = items.0
        bottomObject = items.1
        
        buttonNext = CustomButton(buttonText: "Next",
                               shadowOffset: 10,
                               animationLength: animationLength,
                               activeBodyColour: buttonColorActive,
                               inactiveBodyColour: buttonColorInactive,
                               activeShadowColour: shadowColorActive,
                               inactiveShadowColour: shadowColorInactive)
        buttonNext.position = CGPoint(x: view.frame.midX, y: view.frame.midY + 80)
        buttonNext.zPosition = 1
        addChild(buttonNext)
        
        introLabel = SKLabelNode(text: "What came first?")
        introLabel.fontSize = 25
        introLabel.fontName = "Helvetica-Bold"
        introLabel.fontColor = .black
        introLabel.horizontalAlignmentMode = .center
        introLabel.verticalAlignmentMode = .center
        introLabel.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        introLabel.name = "introLabel"
        introLabel.zPosition = 2
        addChild(introLabel)
        
        containerSize = CGSize(width: self.size.width - CGFloat(sideMargin * 2), height: self.size.height / 2 - CGFloat(centralMargin) - CGFloat(verticalMargin))
        
        topImageElement = ImageElement(containerSize: containerSize, cornerRadius: CGFloat(cornerRadius), name: "top", strokeWidth: strokeWidth, historicItem: topObject)
        topImageElement.position = CGPoint(x: Int(self.size.width) / 2, y: Int(self.frame.maxY - containerSize.height / 2) - verticalMargin)
        topImageElement.zPosition = 3
        addChild(topImageElement)
        
        bottomImageElement = ImageElement(containerSize: containerSize, cornerRadius: CGFloat(cornerRadius), name: "bottom", strokeWidth: strokeWidth, historicItem: bottomObject)
        bottomImageElement.position = CGPoint(x: Int(self.size.width) / 2, y: Int(self.frame.minY + containerSize.height / 2) + verticalMargin)
        bottomImageElement.zPosition = 4
        addChild(bottomImageElement)
        
        setupTouchAreas()
    }
    
    func setupTouchAreas() {
        topTouchArea = SKShapeNode(rectOf: containerSize)
        topTouchArea.strokeColor = .blue
        topTouchArea.lineWidth = 0
        topTouchArea.zPosition = 10
        topTouchArea.name = "top"
        bottomTouchArea = SKShapeNode(rectOf: containerSize)
        bottomTouchArea.strokeColor = .orange
        bottomTouchArea.lineWidth = 0
        bottomTouchArea.zPosition = 11
        bottomTouchArea.name = "bottom"
        buttonTouchArea = SKShapeNode(rectOf: CGSize(width: 300, height: 50 + shadowOffset))
        buttonTouchArea.strokeColor = .magenta
        buttonTouchArea.lineWidth = 0
        buttonTouchArea.zPosition = 12
        buttonTouchArea.name = "nextButton"
        
        topTouchArea.position = topImageElement.position
        bottomTouchArea.position = bottomImageElement.position
        buttonTouchArea.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        addChild(topTouchArea)
        addChild(bottomTouchArea)
        addChild(buttonTouchArea)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        print(node.name)
        if node.name == "top" && !isTouchBlocked {
            buttonActive = true
            isTouchBlocked = true
            buttonNext.changeButtonState(isActive: true)
            print("TOP clicked")
            if !introOFF { switchToButtonLayout() }
            topImageElement.updateState(showingInfo: true)
            bottomImageElement.updateState(showingInfo: true)
            guessRight = topObject.date < bottomObject.date
            if guessRight {
                responseAnimation(text: positiveMessage, location: location)
                print("RIGHT :)")
                score += 1
            } else {
                responseAnimation(text: negativeMessage, location: location)
                print(":(")
            }
            checkIfGameOver()
        } else if node.name == "bottom" && !isTouchBlocked {
            buttonActive = true
            isTouchBlocked = true
            buttonNext.changeButtonState(isActive: true)
            print("BOTTOM clicked")
            if !introOFF { switchToButtonLayout() }
            topImageElement.updateState(showingInfo: true)
            bottomImageElement.updateState(showingInfo: true)
            guessRight = bottomObject.date < topObject.date
            if guessRight {
                responseAnimation(text: positiveMessage, location: location)
                print("RIGHT :)")
                score += 1
            } else {
                responseAnimation(text: negativeMessage, location: location)
                print(":(")
            }
            checkIfGameOver()
        } else if node.name == "nextButton" && buttonActive == true {
            nextButtonPressed()
        }
    }
    
    private func nextButtonPressed(){
        buttonActive = false
        buttonNext.launchClick()
        
        if isEnding {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationLength) {
                self.showAlert(title: "Game Over", message: "Your score is: \(self.score)")
            }
        } else {
            isTouchBlocked = false
            buttonNext.changeButtonState(isActive: false)
            topImageElement.updateState(showingInfo: false)
            bottomImageElement.updateState(showingInfo: false)
            setNewImages()
        }
    }
    
    func checkIfGameOver() {
        gameCounter += 1
        if gameCounter == gameLimit {
            isEnding = true
            buttonNext.changeLabel(newText: "Finish")
        }
    }
    
    func switchToButtonLayout() {
        introOFF = true
        buttonActive = false
        let slideDownAction = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        slideDownAction.timingMode = .easeInEaseOut
        introLabel.run(slideDownAction)
        buttonNext.run(slideDownAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.buttonActive = true
        }
    }
    
    func restartGame() {
        score = 0
        gameCounter = 0
        introOFF = false
        buttonNext.changeLabel(newText: "Next")
        buttonActive = false
        isTouchBlocked = false
        isEnding = false
        buttonNext.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 80)
        introLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        topImageElement.updateState(showingInfo: false)
        bottomImageElement.updateState(showingInfo: false)
        setNewImages()
    }
    
    func setNewImages() {
        let items = dataProvider.provideItems()
        topObject = items.0
        bottomObject = items.1
        topImageElement.updateObjects(with: topObject)
        bottomImageElement.updateObjects(with: bottomObject)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.restartGame()
        }
        alert.addAction(okAction)
        
        if let viewController = self.view?.window?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func responseAnimation(text: String, location: CGPoint) {
        let responseLabel = SKLabelNode(text: text)
        responseLabel.fontName = "Helvetica-Bold"
        responseLabel.fontSize = 70
        responseLabel.fontColor = .white
        responseLabel.horizontalAlignmentMode = .center
        responseLabel.verticalAlignmentMode = .center
        responseLabel.position = CGPoint(x: location.x, y: location.y)
        responseLabel.zRotation = 10 * .pi / 180
        responseLabel.zPosition = 4
        addChild(responseLabel)
        
        let move = SKAction.moveBy(x: 0, y: 30, duration: responseDelay)
        let fadeOut = SKAction.fadeOut(withDuration: responseDelay)
        
        let moveAndFadeOut = SKAction.group([move, fadeOut])
        
        let sequence = SKAction.sequence([moveAndFadeOut, .removeFromParent()])
        
        responseLabel.run(sequence)
    }
}
