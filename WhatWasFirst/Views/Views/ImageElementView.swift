//
//  ImageElement.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 31/01/2025.
//

import UIKit

final class ImageElementView: UIView {
    
    weak var delegate: ImageElementDelegate?
    
    private var firstLaunch: Bool = true
    
    private var isRightAnswer: Bool!
    private var currentItem: HistoricItem!
    private var image: UIImage!
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    private lazy var backgroundEffectView: UIVisualEffectView = {
        let backgroundEffectView = UIVisualEffectView(effect: blurEffect)
        backgroundEffectView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundEffectView
    }()
    private lazy var blurEffect: UIBlurEffect = {
        let blurEffect = UIBlurEffect(style: .regular)
        return blurEffect
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        return scrollView
    }()
    private var placeholderView: UIView = {
        let placeholderView = UIView()
        placeholderView.backgroundColor = .systemGray6
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        return placeholderView
    }()
    private var blackOverlay: UIView = {
        let blackOverlay = UIView()
        blackOverlay.translatesAutoresizingMaskIntoConstraints = false
        blackOverlay.backgroundColor = .black
        blackOverlay.alpha = 0.8
        blackOverlay.isHidden = true
        return blackOverlay
    }()
    private lazy var flavorText: UILabel = {
        let flavorText = UILabel()
        flavorText.translatesAutoresizingMaskIntoConstraints = false
        flavorText.textColor = .white
        flavorText.numberOfLines = 0
        return flavorText
    }()
    private var dateText: UILabel = {
        let dateText = UILabel()
        dateText.translatesAutoresizingMaskIntoConstraints = false
        dateText.textColor = .white
        dateText.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dateText.numberOfLines = 0
        return dateText
    }()
    private lazy var dataStackView: UIStackView = {
        let dataStackView = UIStackView(arrangedSubviews: [flavorText, dateText])
        dataStackView.axis = .vertical
        dataStackView.spacing = 10
        dataStackView.alignment = .fill
        dataStackView.distribution = .fill
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.isHidden = true
        return dataStackView
    }()
    
    private var imageViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var imageViewWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var imageViewCenterXConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var imageViewCenterYConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private var backgroundImageHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var backgroundImageWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var backgroundImageCenterXConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var backgroundImageCenterYConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    // MARK: - Setup
    
    init(frame: CGRect, delegate: ImageElementDelegate?) {
        self.delegate = delegate
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstLaunch {
            firstLaunch = false
            let offset = self.bounds.height * (currentItem.yOffset ?? 0)
            imageViewCenterYConstraint.constant = offset
            backgroundImageCenterYConstraint.constant = offset
        }
    }
    
    private func setupLayout() {
        let screenSize = UIScreen.main.bounds
        let smallScreen = screenSize.width <= 375 && screenSize.height < 812
        
        flavorText.font = UIFont.systemFont(ofSize: smallScreen ? 19 : 22, weight: .thin)
        
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(placeholderView)
        addSubview(backgroundImageView)
        addSubview(backgroundEffectView)
        addSubview(overlay)
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        addSubview(blackOverlay)
        addSubview(dataStackView)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(gestureRecognizer)
        
        NSLayoutConstraint.activate([
            placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            placeholderView.topAnchor.constraint(equalTo: self.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backgroundEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            overlay.topAnchor.constraint(equalTo: self.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            blackOverlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackOverlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackOverlay.topAnchor.constraint(equalTo: self.topAnchor),
            blackOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dataStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            dataStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            dataStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    // MARK: - Flow
    
    func updateItem(with newItem: HistoricItem, isRightAnswer: Bool) {
        currentItem = newItem
        flavorText.text = self.currentItem.flavourText
        dateText.text = self.formDateText(dateText: self.currentItem.date, circa: self.currentItem.circa)
        self.isRightAnswer = isRightAnswer
        resizeAndUpdateImage()
    }
    
    @objc private func handleTap() {
        launchEmoji()
        delegate?.didTapImageElement(with: isRightAnswer)
    }
    
    // MARK: - Service
    
    func showingOverlay() {
        self.blackOverlay.isHidden = false
        self.dataStackView.isHidden = false
    }
    
    func hidingOverlay() {
        blackOverlay.isHidden = true
        dataStackView.isHidden = true
    }
    
    private func formDateText(dateText: Int, circa: Bool) -> String {
        let date = UIStrings.string("Result.date")
        let circaText = UIStrings.string("Result.circa")
        let adText = UIStrings.string("Result.ad")
        let bcText = UIStrings.string("Result.bc")
        
        return "\(date) \(circa ? circaText : "") \(abs(dateText)) \(dateText > 0 ? adText : bcText)"
    }
    
    private func resizeAndUpdateImage() {
        guard let path = Bundle.main.path(forResource: currentItem.picture, ofType: "jpg") else { return }
        image = UIImage(contentsOfFile: path)
        setupImageConstraints(image: image)
        imageView.image = image
        backgroundImageView.image = image

    }
    
    private func launchEmoji() {
        let emojiLabel = UILabel()
        emojiLabel.text = isRightAnswer ? "✅" : "❌"
        emojiLabel.font = .systemFont(ofSize: 200)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emojiLabel)
        emojiLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        let centerYConstraint = emojiLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        centerYConstraint.isActive = true
        self.layoutIfNeeded()
        centerYConstraint.constant = -270
        UIView.animate(withDuration: 1.0, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            emojiLabel.removeFromSuperview()
        })
    }
    
    private func setupImageConstraints(image: UIImage){
        NSLayoutConstraint.deactivate([
            backgroundImageWidthConstraint,
            backgroundImageHeightConstraint,
            backgroundImageCenterXConstraint,
            backgroundImageCenterYConstraint,
            
            imageViewWidthConstraint,
            imageViewHeightConstraint,
            imageViewCenterXConstraint,
            imageViewCenterYConstraint,
        ])
        
        if image.size.width > image.size.height {
            let ratio = image.size.width / image.size.height
            imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: ratio)
            imageViewHeightConstraint = imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            imageViewHeightConstraint.constant += AppLayout.zoomMargin
            imageViewWidthConstraint.constant += AppLayout.zoomMargin * ratio
            
            backgroundImageWidthConstraint = backgroundImageView.widthAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: ratio)
            backgroundImageHeightConstraint = backgroundImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        } else {
            let ratio = image.size.height / image.size.width
            imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            imageViewHeightConstraint = imageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: ratio)
            imageViewWidthConstraint.constant += AppLayout.zoomMargin
            imageViewHeightConstraint.constant += AppLayout.zoomMargin * ratio
            
            backgroundImageWidthConstraint = backgroundImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            backgroundImageHeightConstraint = backgroundImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: ratio)
        }
        
        let offset = self.bounds.height * (currentItem.yOffset ?? 0)
        imageViewCenterYConstraint = imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: offset)
        backgroundImageCenterYConstraint = backgroundImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: offset)
        
        imageViewCenterXConstraint = imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0)
        backgroundImageCenterXConstraint = backgroundImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            backgroundImageWidthConstraint,
            backgroundImageHeightConstraint,
            backgroundImageCenterXConstraint,
            backgroundImageCenterYConstraint,
            
            imageViewWidthConstraint,
            imageViewHeightConstraint,
            imageViewCenterXConstraint,
            imageViewCenterYConstraint,
        ])
    }
}
