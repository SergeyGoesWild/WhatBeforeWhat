//
//  ImageElement.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 31/01/2025.
//

import Foundation
import SpriteKit

class ImageElement: SKNode {
    private var container: SKShapeNode!
    private var cropNode: SKCropNode!
    private var maskNode: SKShapeNode!
    private var touchArea: SKShapeNode!
    private var spriteNode: SKSpriteNode!
    private var cornerRadius: CGFloat!
    private var imageName: String!
    private var strokeWidth: Int!
    
    init(containerSize: CGSize, imageName: String, cornerRadius: CGFloat = 20, name: String, strokeWidth: Int) {
        super.init()
        
        self.imageName = imageName
        self.cornerRadius = cornerRadius
        self.container = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.cropNode = SKCropNode()
        self.maskNode = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.spriteNode = createSpriteNode(withImage: imageName)
        self.name = name
        self.strokeWidth = strokeWidth
        
        setupNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSize(newSize: CGSize) {
        container.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
                                cornerWidth: cornerRadius,
                                cornerHeight: cornerRadius,
                                transform: nil)
        maskNode.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
                              cornerWidth: cornerRadius,
                              cornerHeight: cornerRadius,
                              transform: nil)
        touchArea.path = CGPath(roundedRect: CGRect(origin: .zero, size: newSize),
                              cornerWidth: cornerRadius,
                              cornerHeight: cornerRadius,
                              transform: nil)
        spriteNode.position = CGPoint(x: container.frame.width / 2, y: container.frame.height / 2)
        spriteNode.size = getImageSize(image: UIImage(named: imageName) ?? UIImage())
    }
    
    private func setupNodes() {
        container.strokeColor = .black
        container.lineWidth = CGFloat(strokeWidth)
        maskNode.fillColor = .white
        cropNode.maskNode = maskNode
        
        cropNode.addChild(spriteNode)
        addChild(container)
        addChild(cropNode)
        
        touchArea = SKShapeNode(rectOf: container.frame.size)
        touchArea.fillColor = .clear
        touchArea.strokeColor = .clear
        touchArea.name = self.name
        addChild(touchArea)
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
    
    func updateImage(with imageName: String) {
        guard let newImage = UIImage(named: imageName) else { return }
        spriteNode.texture = SKTexture(image: newImage)
        spriteNode.size = getImageSize(image: newImage)
    }
}
