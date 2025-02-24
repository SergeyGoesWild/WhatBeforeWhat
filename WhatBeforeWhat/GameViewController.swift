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
    
    private let gameContainerView = UIView()
    private var gameView: SKView!
    private var gameSceneLoaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameContainer()
        setupGameView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !gameSceneLoaded {
            setupGameScene()
            gameSceneLoaded = true
        }
    }
    
    private func setupGameContainer() {
        gameContainerView.backgroundColor = .black
        gameContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameContainerView)
        
        NSLayoutConstraint.activate([
            gameContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            gameContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupGameView() {
        gameView = SKView()
        gameView.translatesAutoresizingMaskIntoConstraints = false
        gameContainerView.addSubview(gameView)
        
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupGameScene() {
        let scene = GameScene(size: gameContainerView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .black
        gameView.ignoresSiblingOrder = true
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        gameView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
