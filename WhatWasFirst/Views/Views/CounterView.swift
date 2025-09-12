//
//  CounterView.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 16/06/2025.
//

import UIKit

final class CounterView: UIView {
    
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .black
        bgView.alpha = 0.15
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    private var counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.textColor = AppColors.labelColour
        counterLabel.textAlignment = .center
        counterLabel.font = .systemFont(ofSize: 15, weight: .bold)
        counterLabel.textColor = .white
        return counterLabel
    }()
    private lazy var backgroundEffectView: UIVisualEffectView = {
        let backgroundEffectView = UIVisualEffectView(effect: blurEffect)
        backgroundEffectView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundEffectView
    }()
    private lazy var blurEffect: UIBlurEffect = {
        let blurEffect = UIBlurEffect(style: .light)
        return blurEffect
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        
        addSubview(bgView)
        addSubview(backgroundEffectView)
        addSubview(counterLabel)
        
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backgroundEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundEffectView.topAnchor.constraint(equalTo: topAnchor),
            backgroundEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func updateCounterLabel(currentNumber: Int, totalNumber: Int) {
        counterLabel.text = "\(currentNumber) / \(totalNumber)"
    }
}
