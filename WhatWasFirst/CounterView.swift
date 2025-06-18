//
//  CounterView.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 16/06/2025.
//

import UIKit

final class CounterView: UIView {
    
    var totalRounds: Int!
    
    private var counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.textColor = AppColors.labelColour
        counterLabel.textAlignment = .center
        counterLabel.font = .systemFont(ofSize: 15, weight: .bold)
        counterLabel.textColor = .white
        return counterLabel
    }()
    
    init(frame: CGRect, totalRounds: Int) {
        super.init(frame: frame)
        self.totalRounds = totalRounds
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .black
        
        addSubview(counterLabel)
        
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func updateConterLabel(newRound number: Int) {
        counterLabel.text = "\(number) / \(totalRounds!)"
    }
}
