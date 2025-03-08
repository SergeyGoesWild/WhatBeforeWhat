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
    
    let strokeWidth = 3
    let cornerRadius = 35
    let centralMargin = 45
    let buttonMargin = 60
    let sideMargin = 10
    let gameLimit: Int = 5
    let responseDelay: Double = 1.0
    let positiveMessage = "Yes!"
    let negativeMessage = "No!"
    
    var containerSize: CGSize!
    var isTouchBlocked = false
    var buttonActive = false
    let dataProvider = DataProvider.shared
    var guessRight = false
    var introOFF = false
    var topObject: HistoricItem!
    var bottomObject: HistoricItem!
    var score: Int = 0
    var gameCounter: Int = 0
    
    var introLabel: SKLabelNode!
    var buttonLabel: SKLabelNode!
    var nextButton: SKShapeNode!
    var topImageElement: ImageElement!
    var bottomImageElement: ImageElement!
    
    override func didMove(to view: SKView) {
        let items = dataProvider.provideItems()
        topObject = items.0
        bottomObject = items.1
        
        nextButton = SKShapeNode(rectOf: CGSize(width: Int(self.size.width) - buttonMargin * 2, height: 50), cornerRadius: 15)
        nextButton.fillColor = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
        nextButton.strokeColor = .black
        nextButton.lineWidth = 2
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(nextButton)
        
        introLabel = SKLabelNode(text: "What came first?")
        introLabel.fontSize = 25
        introLabel.fontName = "HelveticaNeue-Medium"
        introLabel.fontColor = .black
        introLabel.horizontalAlignmentMode = .center
        introLabel.verticalAlignmentMode = .center
        introLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(introLabel)
        
        buttonLabel = SKLabelNode(text: "Next ➡️")
        buttonLabel.fontSize = 25
        buttonLabel.fontName = "HelveticaNeue-Medium"
        buttonLabel.fontColor = .black
        buttonLabel.horizontalAlignmentMode = .center
        buttonLabel.verticalAlignmentMode = .center
        buttonLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(buttonLabel)
        
        containerSize = CGSize(width: self.size.width - CGFloat(sideMargin * 2), height: self.size.height / 2 - CGFloat(centralMargin))
        
        topImageElement = ImageElement(containerSize: containerSize, cornerRadius: CGFloat(cornerRadius), name: "top", strokeWidth: strokeWidth, historicItem: topObject)
        topImageElement.position = CGPoint(x: Int(self.size.width) / 2, y: Int(self.frame.maxY - containerSize.height / 2))
        addChild(topImageElement)
        
        bottomImageElement = ImageElement(containerSize: containerSize, cornerRadius: CGFloat(cornerRadius), name: "bottom", strokeWidth: strokeWidth, historicItem: bottomObject)
        bottomImageElement.position = CGPoint(x: Int(self.size.width) / 2, y: Int(self.frame.minY + containerSize.height / 2))
        addChild(bottomImageElement)
        
        introLabel.isHidden = false
        nextButton.isHidden = true
        buttonLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node.name == "top" && !isTouchBlocked {
            buttonActive = true
            isTouchBlocked = true
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
        isTouchBlocked = false
        topImageElement.updateState(showingInfo: false)
        bottomImageElement.updateState(showingInfo: false)
        setNewImages()
    }
    
    func checkIfGameOver() {
        gameCounter += 1
        if gameCounter == gameLimit {
            showAlert(title: "Game Over", message: "Your score is: \(score)")
        }
    }
    
    func switchToButtonLayout() {
        introOFF = true
        introLabel.isHidden = true
        nextButton.isHidden = false
        buttonLabel.isHidden = false
    }
    
    func restartGame() {
        score = 0
        gameCounter = 0
        introOFF = false
        introLabel.isHidden = false
        nextButton.isHidden = true
        buttonLabel.isHidden = true
        buttonActive = false
        isTouchBlocked = false
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
        addChild(responseLabel)
        
        let move = SKAction.moveBy(x: 0, y: 30, duration: responseDelay)
        let fadeOut = SKAction.fadeOut(withDuration: responseDelay)
        
        let moveAndFadeOut = SKAction.group([move, fadeOut])
        
        let sequence = SKAction.sequence([moveAndFadeOut, .removeFromParent()])
        
        responseLabel.run(sequence)
    }
}
