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
    
    let cornerRadius = 20
    let centralMargin = 25
    let gameLimit: Int = 5
    let responseDelay: Double = 1.0
    let positiveMessage = "Yes!"
    let negativeMessage = "No!"
    
    var containerSize: CGSize {
        return CGSize(width: self.size.width, height: self.size.height / 2 - CGFloat(centralMargin))
    }
    var isTouchBlocked = false
    let dataProvider = DataProvider.shared
    var guessRight = false
    var topObject: HistoricItem!
    var bottomObject: HistoricItem!
    var score: Int = 0
    var gameCounter: Int = 0
    
    var topImageElement: ImageElement!
    var bottomImageElement: ImageElement!
    var container1: SKShapeNode!
    var container2: SKShapeNode!
    var topSprite: SKSpriteNode?
    var bottomSprite: SKSpriteNode?
    var maskNode1: SKShapeNode?
    var maskNode2: SKShapeNode?
    var cropNode1: SKCropNode?
    var cropNode2: SKCropNode?
    
    override func didMove(to view: SKView) {
        let items = dataProvider.provideItems()
        topObject = items.0
        bottomObject = items.1
        
        let centralLabel = SKLabelNode(text: "What came first?")
        centralLabel.fontSize = 25
        centralLabel.fontColor = .white
        centralLabel.horizontalAlignmentMode = .center
        centralLabel.verticalAlignmentMode = .center
        centralLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(centralLabel)
        
        topImageElement = ImageElement(containerSize: containerSize, imageName: topObject.picture, cornerRadius: CGFloat(cornerRadius), name: "top")
        topImageElement.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - containerSize.height / 2)
        addChild(topImageElement)
        bottomImageElement = ImageElement(containerSize: containerSize, imageName: bottomObject.picture, cornerRadius: CGFloat(cornerRadius), name: "bottom")
        bottomImageElement.position = CGPoint(x: self.frame.midX, y: self.frame.minY + containerSize.height / 2)
        addChild(bottomImageElement)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        print(node.name)
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
    
    func didTapPicture() {
        gameCounter += 1
        if gameCounter == gameLimit {
            showAlert(title: "Game Over", message: "Your score is: \(score)")
        } else {
            setNewImages()
        }
    }
    
    //    func setupTopPic() {
    //        topSprite?.removeFromParent()
    //        maskNode1?.removeFromParent()
    //        cropNode1?.removeFromParent()
    //
    //        topSprite = createSpriteNode(withImage: topObject.picture)
    //
    //        guard let topSprite else { return }
    //        topSprite.position = CGPoint(x: 0, y: 0)
    //        topSprite.name = "top"
    //
    //        maskNode1 = SKShapeNode(rectOf: container1.frame.size, cornerRadius: 20)
    //        guard let maskNode1 else { return }
    //        maskNode1.fillColor = .white
    //
    //        cropNode1 = SKCropNode()
    //        guard let cropNode1 else { return }
    //        cropNode1.maskNode = maskNode1
    //        cropNode1.position = container1.position
    //        cropNode1.addChild(topSprite)
    //        addChild(cropNode1)
    //    }
    //
    //    func setupBottomPic() {
    //        bottomSprite?.removeFromParent()
    //        maskNode2?.removeFromParent()
    //        cropNode2?.removeFromParent()
    //
    //        bottomSprite = createSpriteNode(withImage: bottomObject.picture)
    //
    //        guard let bottomSprite else { return }
    //        bottomSprite.position = CGPoint(x: 0, y: 0)
    //        bottomSprite.name = "bottom"
    //
    //        maskNode2 = SKShapeNode(rectOf: container2.frame.size, cornerRadius: 20)
    //        guard let maskNode2 else { return }
    //        maskNode2.fillColor = .white
    //
    //        cropNode2 = SKCropNode()
    //        guard let cropNode2 else { return }
    //        cropNode2.maskNode = maskNode2
    //        cropNode2.position = container2.position
    //        cropNode2.addChild(bottomSprite)
    //        addChild(cropNode2)
    //    }
    
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
