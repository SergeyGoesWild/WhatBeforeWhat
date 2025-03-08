//
//  ImageElement.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 31/01/2025.
//

import Foundation
import SpriteKit

class ImageElement: SKNode {
    
    private let flavourFontName: String = "Helvetica-LightOblique"
    private let flavourFontSize: CGFloat = 20
    private let flavourFontColour: UIColor = .white
    private let dateFontName: String = "Helvetica-Bold"
    private let dateFontSize: CGFloat = 24
    private let dateFontColour: UIColor = .white
    
    private var container: SKShapeNode!
    private var strokeNode: SKShapeNode!
    private var overlay: SKShapeNode!
    private var cropNode: SKCropNode!
    private var maskNode: SKShapeNode!
    private var touchArea: SKShapeNode!
    private var spriteNode: SKSpriteNode!
    private var cornerRadius: CGFloat!
    private var strokeWidth: Int!
    private var flavourText: SKNode!
    private var dateText: SKLabelNode!
    private var historicItem: HistoricItem!
    private var textContainer: SKShapeNode!
    
    init(containerSize: CGSize, cornerRadius: CGFloat = 20, name: String, strokeWidth: Int, historicItem: HistoricItem) {
        super.init()
        
        self.historicItem = historicItem
        self.cornerRadius = cornerRadius
        self.dateText = SKLabelNode(text: "Created: \(historicItem.circa ? "circa" : "") \(String(historicItem.date))")
        self.overlay = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.strokeNode = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.container = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.cropNode = SKCropNode()
        self.maskNode = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.spriteNode = createSpriteNode(withImage: historicItem.picture)
        self.textContainer = SKShapeNode(rectOf: CGSize(width: containerSize.width - 40, height: 100))
        self.flavourText = createMultilineLabel(text: historicItem.flavourText, maxWidth: textContainer.frame.width, position: CGPoint(x: 0, y: 0))
        self.name = name
        self.strokeWidth = strokeWidth
        
        setupNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func updateSize(newSize: CGSize) {
//        container.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
//                                cornerWidth: cornerRadius,
//                                cornerHeight: cornerRadius,
//                                transform: nil)
//        overlay.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
//                                cornerWidth: cornerRadius,
//                                cornerHeight: cornerRadius,
//                                transform: nil)
//        strokeNode.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
//                                cornerWidth: cornerRadius,
//                                cornerHeight: cornerRadius,
//                                transform: nil)
//        maskNode.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
//                              cornerWidth: cornerRadius,
//                              cornerHeight: cornerRadius,
//                              transform: nil)
//        touchArea.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
//                              cornerWidth: cornerRadius,
//                              cornerHeight: cornerRadius,
//                              transform: nil)
//        spriteNode.position = CGPoint(x: container.frame.width / 2, y: container.frame.height / 2)
//        spriteNode.size = getImageSize(image: UIImage(named: historicItem.picture) ?? UIImage())
//        
//        textContainer.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
//        let textContainerHeight = flavourText.frame.height + dateText.frame.height + 10
//        
//        flavourText.position = CGPoint(x: 0, y: textContainerHeight / 2 - flavourText.frame.height / 2)
//        dateText.position = CGPoint(x: 0, y: -textContainerHeight / 2 + dateText.frame.height / 2)
//    }
    
    func updateState(showingInfo: Bool) {
        if showingInfo {
            overlay.isHidden = false
            flavourText.isHidden = false
            dateText.isHidden = false
        } else {
            overlay.isHidden = true
            flavourText.isHidden = true
            dateText.isHidden = true
        }
    }
    
    private func setupNodes() {

        flavourText.isHidden = true
        
        dateText.fontSize = dateFontSize
        dateText.fontName = dateFontName
        dateText.fontColor = dateFontColour
        dateText.horizontalAlignmentMode = .left
        dateText.verticalAlignmentMode = .center
        dateText.isHidden = true
        
        flavourText.position = CGPoint(x: -textContainer.frame.width / 2, y: textContainer.frame.maxY)
        dateText.position = CGPoint(x: -textContainer.frame.width / 2, y: textContainer.frame.minY)
        
        textContainer.strokeColor = .red
        textContainer.lineWidth = 5
        textContainer.position = CGPoint(x: 0, y: 0)
        textContainer.addChild(flavourText)
        textContainer.addChild(dateText)
        
        container.fillColor = .clear
        maskNode.fillColor = .white
        cropNode.maskNode = maskNode
        
        overlay.fillColor = .black
        overlay.alpha = 0.7
        overlay.isHidden = true
        
        strokeNode.fillColor = .clear
        strokeNode.strokeColor = .black
        strokeNode.lineWidth = CGFloat(strokeWidth)
        
        cropNode.addChild(spriteNode)
        addChild(container)
        addChild(cropNode)
        addChild(overlay)
        addChild(strokeNode)
        addChild(textContainer)
        
        touchArea = SKShapeNode(rectOf: container.frame.size)
        touchArea.fillColor = .clear
        touchArea.strokeColor = .clear
        touchArea.name = self.name
        addChild(touchArea)
        
        spriteNode.position = CGPoint(x: 0, y: 0)
        spriteNode.size = getImageSize(image: UIImage(named: historicItem.picture) ?? UIImage())
        
        cropNode.position = CGPoint(x: 0, y: 0)
        maskNode.position = CGPoint(x: 0, y: 0)
    }
    
    func createMultilineLabel(text: String, maxWidth: CGFloat, position: CGPoint) -> SKNode {
        let containerNode = SKNode()
        containerNode.position = position
        
        let words = text.components(separatedBy: " ")
        var currentLine = ""
        var lineNodes: [SKLabelNode] = []
        
        for word in words {
            let testLine = currentLine.isEmpty ? word : "\(currentLine) \(word)"
            let testLabel = SKLabelNode(text: testLine)
            testLabel.fontSize = flavourFontSize
            testLabel.fontName = flavourFontName
            testLabel.fontColor = flavourFontColour
            
            if testLabel.frame.width > maxWidth {
                let labelNode = SKLabelNode(text: currentLine)
                labelNode.fontSize = flavourFontSize
                labelNode.fontName = flavourFontName
                labelNode.fontColor = flavourFontColour
                lineNodes.append(labelNode)
                currentLine = word
            } else {
                currentLine = testLine
            }
        }
        
        // Add last line
        let lastLabel = SKLabelNode(text: currentLine)
        lastLabel.fontSize = flavourFontSize
        lastLabel.fontName = flavourFontName
        lastLabel.fontColor = flavourFontColour
        lineNodes.append(lastLabel)

        // Position lines properly (Top to Bottom)
        let lineSpacing: CGFloat = 25
        for (index, label) in lineNodes.enumerated() {
            label.horizontalAlignmentMode = .left
            label.position = CGPoint(x: 0, y: -CGFloat(index) * lineSpacing)
            containerNode.addChild(label)
        }

        return containerNode
    }
    
    func createSpriteNode(withImage imageName: String) -> SKSpriteNode {
        guard let currentImage = UIImage(named: imageName) else { return SKSpriteNode() }
        let texture = SKTexture(image: currentImage)
        let size = getImageSize(image: currentImage)
        let spriteNode = SKSpriteNode(texture: texture, size: size)
        return spriteNode
    }
    
    func getImageSize(image: UIImage) -> CGSize {
        if image.size.width > image.size.height {
            let multiplier = image.size.height / container.frame.height
            let height = container.frame.height
            let width = image.size.width / multiplier
            return CGSize(width: width, height: height)
        } else {
            let multiplier = image.size.width / container.frame.width
            let height = image.size.height / multiplier
            let width = container.frame.width
            return CGSize(width: width, height: height)
        }
    }
    
    func updateObjects(with newObject: HistoricItem) {
        historicItem = newObject
        flavourText = createMultilineLabel(text: historicItem.flavourText, maxWidth: textContainer.frame.width, position: CGPoint(x: 0, y: 0))
        dateText.text = "Created: \(historicItem.circa ? "circa" : "") \(String(historicItem.date))"
        guard let newImage = UIImage(named: historicItem.picture) else { return }
        spriteNode.texture = SKTexture(image: newImage)
        spriteNode.size = getImageSize(image: newImage)
    }
}
