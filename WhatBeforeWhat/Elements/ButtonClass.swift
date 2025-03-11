//
//  ButtonClass.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 10/03/2025.
//

import Foundation
import SpriteKit

class CustomButton: SKNode {
    var shadowOffset: Int!
    var animationLength: Double!
    var activeBodyColour: UIColor!
    var inactiveBodyColour: UIColor!
    var activeShadowColour: UIColor!
    var inactiveShadowColour: UIColor!
    
    var containerNode: SKShapeNode!
    var buttonBody: SKShapeNode!
    var buttonShadow: SKShapeNode!
    var buttonLabel: SKLabelNode!
    var buttonTouchArea: SKShapeNode!
    
    init(buttonText: String,
         shadowOffset: Int,
         animationLength: Double,
         activeBodyColour: UIColor,
         inactiveBodyColour: UIColor,
         activeShadowColour: UIColor,
         inactiveShadowColour: UIColor) {
        super.init()
        
        self.shadowOffset = shadowOffset
        self.animationLength = animationLength
        self.activeBodyColour = activeBodyColour
        self.inactiveBodyColour = inactiveBodyColour
        self.activeShadowColour = activeShadowColour
        self.inactiveShadowColour = inactiveShadowColour
        
        self.containerNode = SKShapeNode(rectOf: CGSize(width: 300, height: 50 + shadowOffset))
        self.containerNode.fillColor = .clear
        self.containerNode.strokeColor = .red
        self.containerNode.lineWidth = 5
        self.buttonTouchArea = SKShapeNode(rectOf: CGSize(width: 300, height: 50 + shadowOffset))
        self.buttonTouchArea.fillColor = .clear
        self.buttonTouchArea.strokeColor = .clear
        self.buttonTouchArea.name = "nextButton"
        self.buttonBody = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 300, height: 50), cornerRadius: 15)
        self.buttonBody.fillColor = activeBodyColour
        self.buttonBody.strokeColor = activeShadowColour
        self.buttonBody.lineWidth = 2
        self.buttonShadow = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 300, height: 50), cornerRadius: 15)
        self.buttonShadow.fillColor = activeShadowColour
        self.buttonShadow.strokeColor = activeShadowColour
        self.buttonShadow.lineWidth = 2
        self.buttonLabel = SKLabelNode(text: buttonText)
        self.buttonLabel.verticalAlignmentMode = .center
        self.buttonLabel.horizontalAlignmentMode = .center
        self.buttonLabel.fontSize = 25
        self.buttonLabel.fontName = "Helvetica-Bold"
        self.buttonLabel.fontColor = .white
        
        addChild(containerNode)
        containerNode.addChild(buttonShadow)
        containerNode.addChild(buttonBody)
        buttonBody.addChild(buttonLabel)
        addChild(buttonTouchArea)
        
        self.containerNode.position = CGPoint(x: 0, y: 0)
        self.buttonTouchArea.position = CGPoint(x: 0, y: 0)
        let adjustX = -self.buttonBody.frame.width / 2 + 2
        let adjustY = -self.buttonBody.frame.height / 2 + 2
        let firstPart = (Int(self.buttonBody.frame.height) + shadowOffset) / 2
        let secondPart = self.buttonBody.frame.height / 2
        let diff = firstPart - Int(secondPart)
        self.buttonBody.position = CGPoint(x: adjustX, y: adjustY + CGFloat(diff))
        self.buttonShadow.position = CGPoint(x: adjustX, y: adjustY + CGFloat(diff) - CGFloat(shadowOffset))
        self.buttonLabel.position = CGPoint(x: Int(buttonBody.frame.width) / 2, y: Int(buttonBody.frame.height) / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func launchClick() {
        let moveDown = SKAction.moveBy(x: 0, y: -CGFloat(shadowOffset), duration: 0.1)
        let moveUp = SKAction.moveBy(x: 0, y: CGFloat(shadowOffset), duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.1)
        let sequence = SKAction.sequence([moveDown, wait, moveUp])
        moveDown.timingMode = .easeInEaseOut
        moveUp.timingMode = .easeInEaseOut
        buttonBody.run(sequence)
    }
    
    func changeButtonState(isActive: Bool) {
        if isActive {
            buttonBody.fillColor = activeBodyColour
            buttonBody.strokeColor = activeShadowColour
            buttonShadow.fillColor = activeShadowColour
            buttonShadow.strokeColor = activeShadowColour
            buttonLabel.alpha = 1.0
        } else {
            buttonBody.fillColor = inactiveBodyColour
            buttonBody.strokeColor = inactiveShadowColour
            buttonShadow.fillColor = inactiveShadowColour
            buttonShadow.strokeColor = inactiveShadowColour
            buttonLabel.alpha = 0.5
        }
    }
    
    func changeLabel(newText: String) {
        buttonLabel.text = newText
    }
}
