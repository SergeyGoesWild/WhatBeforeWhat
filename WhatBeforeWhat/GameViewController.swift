//
//  GameViewController.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 25/01/2025.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private let bgColour = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
    private var gameView: SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
    }
    
    func setupGameScene() {
        gameView = SKView(frame: view.bounds)
        view.addSubview(gameView)
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = bgColour
        gameView.ignoresSiblingOrder = true
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        gameView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
