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
    private var spriteNode: SKSpriteNode!
    
    init(containerSize: CGSize, imageName: String, cornerRadius: CGFloat = 20, name: String) {
        super.init()
        
        self.container = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.cropNode = SKCropNode()
        self.maskNode = SKShapeNode(rectOf: containerSize, cornerRadius: cornerRadius)
        self.spriteNode = createSpriteNode(withImage: imageName)
        self.name = name
        
        setupNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNodes() {
        
        container.name = "Container"
        spriteNode.name = "Sprite"
        cropNode.name = "CropNode"
        
        container.strokeColor = .clear
        container.lineWidth = 0
        
        spriteNode.position = .zero
        
        maskNode.fillColor = .white
        
        cropNode.maskNode = maskNode
        cropNode.addChild(spriteNode)
        
        addChild(container)
        addChild(cropNode)
        
        let touchArea = SKShapeNode(rectOf: container.frame.size)
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
            let multiplier = image.size.width / container.frame.height
            let height = image.size.height / multiplier
            let width = container.frame.height
            return CGSize(width: width, height: height)
        }
    }
    
    func updateImage(with imageName: String) {
        guard let newImage = UIImage(named: imageName) else { return }
        spriteNode.texture = SKTexture(image: newImage)
        spriteNode.size = getImageSize(image: newImage)
    }
}
