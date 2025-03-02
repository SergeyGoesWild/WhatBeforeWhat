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
    
    var hasInitialized = false
    let strokeWidth = 6
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
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        guard size != oldSize else { return }
        guard hasInitialized else { return }
        updatePosition()
        print("size")
    }
    
    override func didMove(to view: SKView) {
        print("move")
        let items = dataProvider.provideItems()
        topObject = items.0
        bottomObject = items.1
        
        ///
        nextButton = SKShapeNode(rectOf: CGSize(width: Int(self.size.width) - buttonMargin * 2, height: 50), cornerRadius: 15)
        nextButton.fillColor = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
        nextButton.strokeColor = .black
        nextButton.lineWidth = 3
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        introLabel = SKLabelNode(text: "What came first?")
        introLabel.fontSize = 25
        introLabel.fontName = "HelveticaNeue-Medium"
        introLabel.fontColor = .black
        introLabel.horizontalAlignmentMode = .center
        introLabel.verticalAlignmentMode = .center
        introLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        buttonLabel = SKLabelNode(text: "Next >>>")
        buttonLabel.fontSize = 25
        buttonLabel.fontName = "HelveticaNeue-Medium"
        buttonLabel.fontColor = .black
        buttonLabel.horizontalAlignmentMode = .center
        buttonLabel.verticalAlignmentMode = .center
        buttonLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        containerSize = CGSize(width: self.size.width - CGFloat(sideMargin * 2), height: self.size.height / 2 - CGFloat(centralMargin))
        
        topImageElement = ImageElement(containerSize: containerSize, imageName: topObject.picture, cornerRadius: CGFloat(cornerRadius), name: "top", strokeWidth: strokeWidth)
        bottomImageElement = ImageElement(containerSize: containerSize, imageName: bottomObject.picture, cornerRadius: CGFloat(cornerRadius), name: "bottom", strokeWidth: strokeWidth)
        
        topImageElement.updateSize(newSize: containerSize)
        bottomImageElement.updateSize(newSize: containerSize)
        topImageElement.position = CGPoint(x: 10, y: Int(self.frame.maxY - containerSize.height) - strokeWidth / 2)
        bottomImageElement.position = CGPoint(x: 10, y: Int(self.frame.minY) + strokeWidth / 2)

        addChild(topImageElement)
        addChild(bottomImageElement)
        addChild(nextButton)
        addChild(introLabel)
        addChild(buttonLabel)
        
        introLabel.isHidden = false
        nextButton.isHidden = true
        buttonLabel.isHidden = true
        ///
        updatePosition()
        hasInitialized = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node.name == "top" {
            print("TOP clicked")
            if !introOFF { switchToButtonLayout() }
            guessRight = topObject.date < bottomObject.date
            if guessRight {
                responseAnimation(text: positiveMessage, location: location)
                print("RIGHT :)")
                score += 1
            } else {
                responseAnimation(text: negativeMessage, location: location)
                print(":(")
            }
            if !isTouchBlocked {
                isTouchBlocked = true
                DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
                    self.didTapPicture()
                    self.isTouchBlocked = false
                }
            }
        } else if node.name == "bottom" {
            print("BOTTOM clicked")
            if !introOFF { switchToButtonLayout() }
            guessRight = bottomObject.date < topObject.date
            if guessRight {
                responseAnimation(text: positiveMessage, location: location)
                print("RIGHT :)")
                score += 1
            } else {
                responseAnimation(text: negativeMessage, location: location)
                print(":(")
            }
            if !isTouchBlocked {
                isTouchBlocked = true
                DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
                    self.didTapPicture()
                    self.isTouchBlocked = false
                }
            }
        }
    }
    
    private func updatePosition() {
        nextButton = SKShapeNode(rectOf: CGSize(width: Int(self.size.width) - buttonMargin * 2, height: 50), cornerRadius: 15)
        nextButton.fillColor = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
        nextButton.strokeColor = .black
        nextButton.lineWidth = 3
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        introLabel = SKLabelNode(text: "What came first?")
        introLabel.fontSize = 25
        introLabel.fontName = "HelveticaNeue-Medium"
        introLabel.fontColor = .black
        introLabel.horizontalAlignmentMode = .center
        introLabel.verticalAlignmentMode = .center
        introLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        buttonLabel = SKLabelNode(text: "Next >>>")
        buttonLabel.fontSize = 25
        buttonLabel.fontName = "HelveticaNeue-Medium"
        buttonLabel.fontColor = .black
        buttonLabel.horizontalAlignmentMode = .center
        buttonLabel.verticalAlignmentMode = .center
        buttonLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        containerSize = CGSize(width: self.size.width - CGFloat(sideMargin * 2), height: self.size.height / 2 - CGFloat(centralMargin))
        
        topImageElement = ImageElement(containerSize: containerSize, imageName: topObject.picture, cornerRadius: CGFloat(cornerRadius), name: "top", strokeWidth: strokeWidth)
        bottomImageElement = ImageElement(containerSize: containerSize, imageName: bottomObject.picture, cornerRadius: CGFloat(cornerRadius), name: "bottom", strokeWidth: strokeWidth)
        
        topImageElement.updateSize(newSize: containerSize)
        bottomImageElement.updateSize(newSize: containerSize)
        topImageElement.position = CGPoint(x: 10, y: Int(self.frame.maxY - containerSize.height) - strokeWidth / 2)
        bottomImageElement.position = CGPoint(x: 10, y: Int(self.frame.minY) + strokeWidth / 2)
        
        introLabel.isHidden = false
        nextButton.isHidden = true
        buttonLabel.isHidden = true
    }
    
    func didTapPicture() {
        gameCounter += 1
        if gameCounter == gameLimit {
            showAlert(title: "Game Over", message: "Your score is: \(score)")
        } else {
            setNewImages()
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
        setNewImages()
    }
    
    func setNewImages() {
        let items = dataProvider.provideItems()
        topObject = items.0
        bottomObject = items.1
        topImageElement.updateImage(with: topObject.picture)
        bottomImageElement.updateImage(with: bottomObject.picture)
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
