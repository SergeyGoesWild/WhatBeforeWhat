//
//  FalseLaunchScreen.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 02/12/2025.
//
import UIKit

final class FalseLaunchScreen: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Telnov"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 56, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = AppColors.bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showMainScreen()
        }
    }
    
    private func showMainScreen() {
        let gameAssembly = GameAssembly()
        guard let window = view.window else { return }
        UIView.transition(with: window,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {
            window.rootViewController = gameAssembly.wireComponents()
        })
    }
    
    private func setupLayout() {
        view.addSubview(bgView)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            bgView.heightAnchor.constraint(equalTo: view.heightAnchor),
            bgView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
