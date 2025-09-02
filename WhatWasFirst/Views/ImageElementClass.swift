//
//  ImageElement.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 31/01/2025.
//

import UIKit

class ImageElement: UIView {
    
    weak var delegate: ImageElementDelegate?
    private let containerID: String!
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
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.delegate = self
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
        blackOverlay.alpha = 0.7
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
    
    private var imageViewHeightConstraint: NSLayoutConstraint!
    private var imageViewWidthConstraint: NSLayoutConstraint!
    private var imageViewOffsetConstraint: NSLayoutConstraint!
    private var backgroundImageHeightConstraint: NSLayoutConstraint!
    private var backgroundImageWidthConstraint: NSLayoutConstraint!
    private let zoomMargin: CGFloat = 60
    
    // MARK: - Setup
    
    init(frame: CGRect, id: String, delegate: ImageElementDelegate?) {
        self.containerID = id
        self.delegate = delegate
        
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let screenSize = UIScreen.main.bounds
        let smallScreen = screenSize.width <= 375 && screenSize.height < 812
        
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
        imageViewOffsetConstraint = imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0)
        
        backgroundImageWidthConstraint = backgroundImageView.widthAnchor.constraint(equalToConstant: 0)
        backgroundImageHeightConstraint = backgroundImageView.heightAnchor.constraint(equalToConstant: 0)
        
        flavorText.font = UIFont.systemFont(ofSize: smallScreen ? 19 : 22, weight: .thin)
        
        addSubview(placeholderView)
        addSubview(backgroundImageView)
        addSubview(backgroundEffectView)
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
            
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imageViewWidthConstraint,
            imageViewHeightConstraint,
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageViewOffsetConstraint,
            
            backgroundImageWidthConstraint,
            backgroundImageHeightConstraint,
            backgroundImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            backgroundEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
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
        hidingOverlay()
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
        return "Created: \(circa ? "circa" : "") \(abs(dateText)) \(dateText > 0 ? "AD" : "BC")"
    }
    
    private func resizeAndUpdateImage() {
        guard let path = Bundle.main.path(forResource: currentItem.picture, ofType: "jpg") else { return }
        image = UIImage(contentsOfFile: path)
        let newImageSize = getImageSize(image: image)
        imageView.image = image
        backgroundImageView.image = image
        imageViewWidthConstraint.constant = newImageSize.width + zoomMargin
        imageViewHeightConstraint.constant = newImageSize.height + zoomMargin
        if let offset = currentItem.yOffset {
            imageViewOffsetConstraint.constant = self.bounds.height * offset
        } else {
            imageViewOffsetConstraint.constant = 0
        }
        backgroundImageWidthConstraint.constant = newImageSize.width
        backgroundImageHeightConstraint.constant = newImageSize.height
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
    
    func getImageSize(image: UIImage) -> CGSize {
        if image.size.width > image.size.height {
            let multiplier = image.size.height / self.bounds.height
            let height = self.bounds.height
            let width = image.size.width / multiplier
            let additionalMargin = self.bounds.width - width
            if additionalMargin > 0 {
                return CGSize(width: width + additionalMargin, height: height + additionalMargin)
            } else {
                return CGSize(width: width, height: height)
            }
        } else {
            let multiplier = image.size.width / self.bounds.width
            let height = image.size.height / multiplier
            let width = self.bounds.width
            let additionalMargin = self.bounds.height - height
            if additionalMargin > 0 {
                return CGSize(width: width + additionalMargin, height: height + additionalMargin)
            } else {
                return CGSize(width: width, height: height)
            }
        }
    }
}

    // MARK: - Extensions

extension ImageElement: UIScrollViewDelegate {
    
}
