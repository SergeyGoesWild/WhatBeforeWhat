//
//  ImageBlocksLayer.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 02/09/2025.
//

import UIKit

final class ImageElementsLayer: UIView {
    
    weak var delegateToPass: ImageElementDelegate?
    
    private let borderWidth: CGFloat = 4
    private let cornerRadius: CGFloat = 25
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private lazy var topElement: ImageElementView = {
        let topElement = ImageElementView(frame: .zero, delegate: delegateToPass)
        topElement.translatesAutoresizingMaskIntoConstraints = false
        topElement.layer.cornerRadius = cornerRadius
        topElement.layer.borderWidth = borderWidth
        topElement.layer.borderColor = AppColors.borderColour.cgColor
        topElement.clipsToBounds = true
        topElement.isUserInteractionEnabled = true
        return topElement
    }()
    private lazy var bottomElement: ImageElementView = {
        let bottomElement = ImageElementView(frame: .zero, delegate: delegateToPass)
        bottomElement.translatesAutoresizingMaskIntoConstraints = false
        bottomElement.layer.cornerRadius = cornerRadius
        bottomElement.layer.borderWidth = borderWidth
        bottomElement.layer.borderColor = AppColors.borderColour.cgColor
        bottomElement.clipsToBounds = true
        bottomElement.isUserInteractionEnabled = true
        return bottomElement
    }()
    
    init(frame: CGRect, delegate: ImageElementDelegate?) {
        self.delegateToPass = delegate
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showOverlay(isShowing: Bool) {
        if isShowing {
            topElement.showingOverlay()
            bottomElement.showingOverlay()
            blockImages(isBlocked: true)
        } else {
            topElement.hidingOverlay()
            bottomElement.hidingOverlay()
            blockImages(isBlocked: false)
        }
    }
    
    func updateElements(item01: HistoricItem, item02: HistoricItem) {
        topElement.updateItem(with: item01, isRightAnswer: item01.date < item02.date)
        bottomElement.updateItem(with: item02, isRightAnswer: item02.date < item01.date)
    }
    
    private func blockImages(isBlocked: Bool) {
        self.isUserInteractionEnabled = !isBlocked
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(topElement)
        containerView.addSubview(bottomElement)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            topElement.topAnchor.constraint(equalTo: containerView.topAnchor),
            topElement.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.43),
            topElement.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topElement.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            bottomElement.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomElement.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.43),
            bottomElement.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bottomElement.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomElement.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
}
