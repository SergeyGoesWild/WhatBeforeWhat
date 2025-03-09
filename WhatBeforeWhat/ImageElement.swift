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
    
    private let horizontalMargin = 20
    private let verticalMargin = 20
    private let lineSpacing = 40
    
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
        self.textContainer = SKShapeNode()
        self.flavourText = SKNode()
        self.name = name
        self.strokeWidth = strokeWidth
        
        setupNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        flavourText = createMultilineLabel(text: historicItem.flavourText, maxWidth: container.frame.width - CGFloat(horizontalMargin * 2), position: CGPoint(x: 0, y: 0))
        flavourText.isHidden = true
        flavourText.name = "flavourText"
        
        dateText.fontSize = dateFontSize
        dateText.fontName = dateFontName
        dateText.fontColor = dateFontColour
        dateText.horizontalAlignmentMode = .left
        dateText.isHidden = true
        dateText.name = "dateText"
        
        flavourText.position = CGPoint(x: flavourText.frame.width / 2, y: flavourText.frame.height + CGFloat(lineSpacing))
        dateText.position = CGPoint(x: 0, y: textContainer.frame.minY)
        
        let textContainerHeight = dateText.frame.height + flavourText.frame.height + CGFloat(lineSpacing)
        
        textContainer.strokeColor = .red
        textContainer.lineWidth = 0
        textContainer.path = CGPath(rect: CGRect(x: 0, y: 0, width: Int(container.frame.width - CGFloat(horizontalMargin * 2)), height: Int(textContainerHeight)), transform: nil)
        textContainer.position = CGPoint(x: container.frame.minX + CGFloat(horizontalMargin), y: container.frame.midY-textContainer.frame.height / 2)
        textContainer.addChild(flavourText)
        textContainer.addChild(dateText)
        textContainer.name = "textContainer"
        
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
    
    func createMultilineLabel(text: String, maxWidth: CGFloat, position: CGPoint) -> SKShapeNode {
        
        let containerNode = SKShapeNode()
        containerNode.strokeColor = .blue
        containerNode.lineWidth = 0
        containerNode.fillColor = .clear
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
            label.position = CGPoint(x: -maxWidth / 2, y: -CGFloat(index) * lineSpacing)
            containerNode.addChild(label)
        }
        
        // Calculate total height dynamically
        let totalHeight = CGFloat(lineNodes.count - 1) * lineSpacing
        let padding: CGFloat = 0
        
        // Set the shape node's size
        let rect = CGRect(x: -maxWidth / 2 - padding, y: -totalHeight - padding, width: maxWidth + padding * 2, height: totalHeight + padding * 2)
        containerNode.path = CGPath(rect: rect, transform: nil)
        
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
        
        flavourText.removeFromParent()
        flavourText = createMultilineLabel(text: historicItem.flavourText, maxWidth: container.frame.width - CGFloat(horizontalMargin * 2), position: CGPoint(x: 0, y: 0))
        textContainer.addChild(flavourText)
        flavourText.isHidden = true
        
        flavourText.position = CGPoint(x: flavourText.frame.width / 2, y: flavourText.frame.height + CGFloat(lineSpacing))
        let textContainerHeight = dateText.frame.height + flavourText.frame.height + CGFloat(lineSpacing)
        textContainer.path = CGPath(rect: CGRect(x: 0, y: 0, width: Int(container.frame.width - CGFloat(horizontalMargin * 2)), height: Int(textContainerHeight)), transform: nil)
        textContainer.position = CGPoint(x: container.frame.minX + CGFloat(horizontalMargin), y: container.frame.midY-textContainer.frame.height / 2)
        
        dateText.text = "Created: \(historicItem.circa ? "circa" : "") \(String(historicItem.date))"
        guard let newImage = UIImage(named: historicItem.picture) else { return }
        spriteNode.texture = SKTexture(image: newImage)
        spriteNode.size = getImageSize(image: newImage)
    }
}
