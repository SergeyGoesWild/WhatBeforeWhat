//
//  ImageElement.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 31/01/2025.
//

import UIKit

class ImageElement: UIView {
    private let currentItem: HistoricItem = HistoricItem(id: UUID(), picture: "ElCastillo", date: 1100, flavourText: "Temple of Kukulcan - a Mesoamerican step-pyramid in Mexico, built by the Maya civilization.", circa: true)
    private let image: UIImage = UIImage(named: "SewuTemple")!
    private var imageView: UIImageView!
    private var scrollView: UIScrollView!
    private var placeholderView: UIView!
    
    private var blackOverlay: UIView!
    private var flavorText: UILabel!
    private var dateText: UILabel!
    
//    private let flavourFontName: String = "Helvetica-LightOblique"
//    private let flavourFontSize: CGFloat = 20
//    private let flavourFontColour: UIColor = .white
//    private let dateFontName: String = "Helvetica-Bold"
//    private let dateFontSize: CGFloat = 24
//    private let dateFontColour: UIColor = .white
//    
//    private let horizontalMargin = 20
//    private let verticalMargin = 20
//    private let lineSpacing = 40
//    
//    private var container: SKShapeNode!
//    private var strokeNode: SKShapeNode!
//    private var overlay: SKShapeNode!
//    private var cropNode: SKCropNode!
//    private var maskNode: SKShapeNode!
//    private var spriteNode: SKSpriteNode!
//    private var cornerRadius: CGFloat!
//    private var strokeWidth: Int!
//    private var flavourText: SKNode!
//    private var dateText: SKLabelNode!
//    private var historicItem: HistoricItem!
//    private var textContainer: SKShapeNode!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        containerSize: CGSize, cornerRadius: CGFloat = 20, name: String, strokeWidth: Int, historicItem: HistoricItem
//        self.historicItem = historicItem
//        self.cornerRadius = cornerRadius
//        self.dateText = SKLabelNode(text: "Created: \(historicItem.circa ? "circa" : "") \(bcORad(date: historicItem.date))")
//        self.overlay = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
//        self.strokeNode = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
//        self.container = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
//        self.cropNode = SKCropNode()
//        self.maskNode = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
//        self.spriteNode = createSpriteNode(withImage: historicItem.picture)
//        self.textContainer = SKShapeNode()
//        self.flavourText = SKNode()
//        self.name = name
//        self.strokeWidth = strokeWidth
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func updateState(showingInfo: Bool) {
//        if showingInfo {
//            overlay.isHidden = false
//            flavourText.isHidden = false
//            dateText.isHidden = false
//            overlay.alpha = 0.0
//            let fadeToHalf = SKAction.fadeAlpha(to: 0.7, duration: 0.3)
//            overlay.run(fadeToHalf)
//        } else {
//            overlay.isHidden = true
//            flavourText.isHidden = true
//            dateText.isHidden = true
//        }
//    }
    
    private func formDateText(dateText: Int, circa: Bool) -> String {
        return "Created: \(circa ? "circa" : "") \(dateText) \(dateText > 0 ? "AD" : "BC")"
    }
    
    private func setupLayout() {
        placeholderView = UIView()
        placeholderView.backgroundColor = .systemGray6
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.delegate = self
        
        blackOverlay = UIView()
        blackOverlay.translatesAutoresizingMaskIntoConstraints = false
        blackOverlay.backgroundColor = .black
        blackOverlay.alpha = 0.75
        
        flavorText = UILabel()
        flavorText.translatesAutoresizingMaskIntoConstraints = false
        flavorText.textColor = .white
        flavorText.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        flavorText.numberOfLines = 0
        flavorText.text = currentItem.flavourText
        
        dateText = UILabel()
        dateText.translatesAutoresizingMaskIntoConstraints = false
        dateText.textColor = .white
        dateText.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dateText.numberOfLines = 0
        dateText.text = formDateText(dateText: currentItem.date, circa: currentItem.circa)
        
        let stackView = UIStackView(arrangedSubviews: [flavorText, dateText])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(placeholderView)
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        addSubview(blackOverlay)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            placeholderView.topAnchor.constraint(equalTo: self.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            blackOverlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackOverlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackOverlay.topAnchor.constraint(equalTo: self.topAnchor),
            blackOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
//        flavourText = createMultilineLabel(text: historicItem.flavourText, maxWidth: container.frame.width - CGFloat(horizontalMargin * 2), position: CGPoint(x: 0, y: 0))
//        flavourText.isHidden = true
//        flavourText.name = "flavourText"
//        
//        dateText.fontSize = dateFontSize
//        dateText.fontName = dateFontName
//        dateText.fontColor = dateFontColour
//        dateText.horizontalAlignmentMode = .left
//        dateText.isHidden = true
//        dateText.name = "dateText"
//        
//        flavourText.position = CGPoint(x: flavourText.frame.width / 2, y: flavourText.frame.height + CGFloat(lineSpacing))
//        dateText.position = CGPoint(x: 0, y: textContainer.frame.minY)
//        
//        let textContainerHeight = dateText.frame.height + flavourText.frame.height + CGFloat(lineSpacing)
//        
//        textContainer.strokeColor = .red
//        textContainer.lineWidth = 0
//        textContainer.path = CGPath(rect: CGRect(x: 0, y: 0, width: Int(container.frame.width - CGFloat(horizontalMargin * 2)), height: Int(textContainerHeight)), transform: nil)
//        textContainer.position = CGPoint(x: container.frame.minX + CGFloat(horizontalMargin), y: container.frame.midY-textContainer.frame.height / 2)
//        textContainer.addChild(flavourText)
//        textContainer.addChild(dateText)
//        textContainer.name = "textContainer"
//        
//        container.fillColor = .clear
//        maskNode.fillColor = .white
//        maskNode.strokeColor = .red
//        maskNode.lineWidth = 0
//        cropNode.maskNode = maskNode
//        
//        overlay.fillColor = .black
//        overlay.alpha = 0.7
//        overlay.isHidden = true
//        
//        strokeNode.fillColor = .clear
//        strokeNode.strokeColor = .black
//        strokeNode.lineWidth = CGFloat(strokeWidth)
//        
//        cropNode.addChild(spriteNode)
//        addChild(container)
//        addChild(cropNode)
//        addChild(overlay)
//        addChild(strokeNode)
//        addChild(textContainer)
//        
//        spriteNode.position = CGPoint(x: 0, y: 0)
//        spriteNode.size = getImageSize(image: UIImage(named: historicItem.picture) ?? UIImage())
//        spriteNode.name = "SPRITE NODE"
//        
//        cropNode.position = CGPoint(x: 0, y: 0)
//        cropNode.name = "CROP NODE"
//        maskNode.position = CGPoint(x: 0, y: 0)
//        maskNode.name = "MASK NODE"
    }
    
//    func createMultilineLabel(text: String, maxWidth: CGFloat, position: CGPoint) -> SKShapeNode {
//        
//        let containerNode = SKShapeNode()
//        containerNode.strokeColor = .blue
//        containerNode.lineWidth = 0
//        containerNode.fillColor = .clear
//        containerNode.position = position
//        
//        let words = text.components(separatedBy: " ")
//        var currentLine = ""
//        var lineNodes: [SKLabelNode] = []
//        
//        for word in words {
//            let testLine = currentLine.isEmpty ? word : "\(currentLine) \(word)"
//            let testLabel = SKLabelNode(text: testLine)
//            testLabel.fontSize = flavourFontSize
//            testLabel.fontName = flavourFontName
//            testLabel.fontColor = flavourFontColour
//            
//            if testLabel.frame.width > maxWidth {
//                let labelNode = SKLabelNode(text: currentLine)
//                labelNode.fontSize = flavourFontSize
//                labelNode.fontName = flavourFontName
//                labelNode.fontColor = flavourFontColour
//                lineNodes.append(labelNode)
//                currentLine = word
//            } else {
//                currentLine = testLine
//            }
//        }
//        
//        // Add last line
//        let lastLabel = SKLabelNode(text: currentLine)
//        lastLabel.fontSize = flavourFontSize
//        lastLabel.fontName = flavourFontName
//        lastLabel.fontColor = flavourFontColour
//        lineNodes.append(lastLabel)
//        
//        // Position lines properly (Top to Bottom)
//        let lineSpacing: CGFloat = 25
//        for (index, label) in lineNodes.enumerated() {
//            label.horizontalAlignmentMode = .left
//            label.position = CGPoint(x: -maxWidth / 2, y: -CGFloat(index) * lineSpacing)
//            containerNode.addChild(label)
//        }
//        
//        // Calculate total height dynamically
//        let totalHeight = CGFloat(lineNodes.count - 1) * lineSpacing
//        let padding: CGFloat = 0
//        
//        // Set the shape node's size
//        let rect = CGRect(x: -maxWidth / 2 - padding, y: -totalHeight - padding, width: maxWidth + padding * 2, height: totalHeight + padding * 2)
//        containerNode.path = CGPath(rect: rect, transform: nil)
//        
//        return containerNode
//    }
//    
//    func createSpriteNode(withImage imageName: String) -> SKSpriteNode {
//        guard let currentImage = UIImage(named: imageName) else { return SKSpriteNode() }
//        let texture = SKTexture(image: currentImage)
//        let size = getImageSize(image: currentImage)
//        let spriteNode = SKSpriteNode(texture: texture, size: size)
//        return spriteNode
//    }
//    
//    func getImageSize(image: UIImage) -> CGSize {
//        if image.size.width > image.size.height {
//            let multiplier = image.size.height / container.frame.height
//            let height = container.frame.height
//            let width = image.size.width / multiplier
//            return CGSize(width: width, height: height)
//        } else {
//            let multiplier = image.size.width / container.frame.width
//            let height = image.size.height / multiplier
//            let width = container.frame.width
//            return CGSize(width: width, height: height)
//        }
//    }
//    
//    func updateObjects(with newObject: HistoricItem) {
//        historicItem = newObject
//        
//        flavourText.removeFromParent()
//        flavourText = createMultilineLabel(text: historicItem.flavourText, maxWidth: container.frame.width - CGFloat(horizontalMargin * 2), position: CGPoint(x: 0, y: 0))
//        textContainer.addChild(flavourText)
//        flavourText.isHidden = true
//        
//        flavourText.position = CGPoint(x: flavourText.frame.width / 2, y: flavourText.frame.height + CGFloat(lineSpacing))
//        let textContainerHeight = dateText.frame.height + flavourText.frame.height + CGFloat(lineSpacing)
//        textContainer.path = CGPath(rect: CGRect(x: 0, y: 0, width: Int(container.frame.width - CGFloat(horizontalMargin * 2)), height: Int(textContainerHeight)), transform: nil)
//        textContainer.position = CGPoint(x: container.frame.minX + CGFloat(horizontalMargin), y: container.frame.midY-textContainer.frame.height / 2)
//        
//        dateText.text = "Created: \(historicItem.circa ? "circa" : "") \(bcORad(date: historicItem.date))"
//        guard let newImage = UIImage(named: historicItem.picture) else { return }
//        spriteNode.texture = SKTexture(image: newImage)
//        spriteNode.size = getImageSize(image: newImage)
//    }
//    
//    func bcORad(date: Int) -> String {
//        if date < 0 {
//            return "\(abs(date)) BC"
//        } else {
//            return "\(abs(date)) AD"
//        }
//    }
}

extension ImageElement: UIScrollViewDelegate {
    
}
