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
    let sideMargin = 10
    let gameLimit: Int = 5
    let responseDelay: Double = 1.0
    let positiveMessage = "Yes!"
    let negativeMessage = "No!"
    
    var containerSize: CGSize!
    var isTouchBlocked = false
    let dataProvider = DataProvider.shared
    var guessRight = false
    var topObject: HistoricItem!
    var bottomObject: HistoricItem!
    var score: Int = 0
    var gameCounter: Int = 0
    
    var centralLabel: SKLabelNode!
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
        
        centralLabel = SKLabelNode(text: "What came first?")
        centralLabel.fontSize = 25
        centralLabel.fontName = "HelveticaNeue-Medium"
        centralLabel.fontColor = .black
        centralLabel.horizontalAlignmentMode = .center
        centralLabel.verticalAlignmentMode = .center
        
        containerSize = CGSize(width: self.size.width - CGFloat(sideMargin * 2), height: self.size.height / 2 - CGFloat(centralMargin))
        
        topImageElement = ImageElement(containerSize: containerSize, imageName: topObject.picture, cornerRadius: CGFloat(cornerRadius), name: "top", strokeWidth: strokeWidth)
        bottomImageElement = ImageElement(containerSize: containerSize, imageName: bottomObject.picture, cornerRadius: CGFloat(cornerRadius), name: "bottom", strokeWidth: strokeWidth)
        
        updatePosition()
        
        addChild(centralLabel)
        addChild(topImageElement)
        addChild(bottomImageElement)
        
        hasInitialized = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node.name == "top" {
            print("TOP clicked")
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
        containerSize = CGSize(width: self.size.width - CGFloat(sideMargin * 2), height: self.size.height / 2  - CGFloat(centralMargin))
        topImageElement.updateSize(newSize: containerSize)
        bottomImageElement.updateSize(newSize: containerSize)
        centralLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        topImageElement.position = CGPoint(x: 10, y: Int(self.frame.maxY - containerSize.height) - strokeWidth / 2)
        bottomImageElement.position = CGPoint(x: 10, y: Int(self.frame.minY) + strokeWidth / 2)
    }
    
    func didTapPicture() {
        gameCounter += 1
        if gameCounter == gameLimit {
            showAlert(title: "Game Over", message: "Your score is: \(score)")
        } else {
            setNewImages()
        }
    }
    
    func restartGame() {
        score = 0
        gameCounter = 0
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
