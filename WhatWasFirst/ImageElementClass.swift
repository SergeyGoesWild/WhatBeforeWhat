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
    private var imageView: UIImageView!
    private var backgroundImageView: UIImageView!
    private var backgroundEffectView: UIVisualEffectView!
    private var blurEffect: UIBlurEffect!
    private var scrollView: UIScrollView!
    private var placeholderView: UIView!
    private var blackOverlay: UIView!
    private var flavorText: UILabel!
    private var dateText: UILabel!
    private var dataStackView: UIStackView!
    
    private var imageViewHeightConstraint: NSLayoutConstraint!
    private var imageViewWidthConstraint: NSLayoutConstraint!
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
        placeholderView = UIView()
        placeholderView.backgroundColor = .systemGray6
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
        
        backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageWidthConstraint = backgroundImageView.widthAnchor.constraint(equalToConstant: 0)
        backgroundImageHeightConstraint = backgroundImageView.heightAnchor.constraint(equalToConstant: 0)
        
        blurEffect = UIBlurEffect(style: .regular)
        backgroundEffectView = UIVisualEffectView(effect: blurEffect)
        backgroundEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView = UIScrollView()
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
        
        blackOverlay = UIView()
        blackOverlay.translatesAutoresizingMaskIntoConstraints = false
        blackOverlay.backgroundColor = .black
        blackOverlay.alpha = 0.7
        blackOverlay.isHidden = true
        
        flavorText = UILabel()
        flavorText.translatesAutoresizingMaskIntoConstraints = false
        flavorText.textColor = .white
        flavorText.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        flavorText.numberOfLines = 0
        
        dateText = UILabel()
        dateText.translatesAutoresizingMaskIntoConstraints = false
        dateText.textColor = .white
        dateText.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dateText.numberOfLines = 0

        dataStackView = UIStackView(arrangedSubviews: [flavorText, dateText])
        dataStackView.axis = .vertical
        dataStackView.spacing = 10
        dataStackView.alignment = .fill
        dataStackView.distribution = .fill
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.isHidden = true
        
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
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
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
        
        // TODO: спросить почему это работает и спросить как это обойти
        DispatchQueue.main.async {
            self.flavorText.text = self.currentItem.flavourText
            self.dateText.text = self.formDateText(dateText: self.currentItem.date, circa: self.currentItem.circa)
            self.isRightAnswer = isRightAnswer
            self.resizeAndUpdateImage()
            self.hidingOverlay()
        }
    }
    
    @objc private func handleTap() {
        launchEmoji()
        delegate?.didTapImageElement(with: containerID)
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
        image = UIImage(named: currentItem.picture)
        let newImageSize = getImageSize(image: image)
        imageView.image = image
        backgroundImageView.image = image
        imageViewWidthConstraint.constant = newImageSize.width + zoomMargin
        imageViewHeightConstraint.constant = newImageSize.height + zoomMargin
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
            return CGSize(width: width, height: height)
        } else {
            let multiplier = image.size.width / self.bounds.width
            let height = image.size.height / multiplier
            let width = self.bounds.width
            return CGSize(width: width, height: height)
        }
    }
}

    // MARK: - Extensions

extension ImageElement: UIScrollViewDelegate {
    
}
