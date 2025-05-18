//
//  CustomAlert.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 14/05/2025.
//

import UIKit

final class CustomAlert: UIView {
    
    weak var delegate: EndGameAlertDelegate?
    
    private var alertBackgroundView: UIView!
    private var fadeBackgroundView: UIView!
    private var labelView: UILabel!
    private var buttonView: UIButton!
    
    init(delegate: EndGameAlertDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(withScore score: Int, outOf total: Int) {
        labelView.text = "Your score is \(score) out of \(total)"
    }
    
    private func setupViews() {
        fadeBackgroundView = UIView()
        fadeBackgroundView.backgroundColor = .black
        fadeBackgroundView.alpha = 0.7
        fadeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        alertBackgroundView = UIView()
        alertBackgroundView.backgroundColor = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
        alertBackgroundView.layer.cornerRadius = 20
        alertBackgroundView.layer.borderWidth = 4
        alertBackgroundView.layer.borderColor = UIColor.black.cgColor
        alertBackgroundView.clipsToBounds = true
        alertBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        labelView = UILabel()
        labelView.textColor = .label
        labelView.textAlignment = .center
        labelView.numberOfLines = 0
        labelView.setContentHuggingPriority(.required, for: .vertical)
        labelView.setContentCompressionResistancePriority(.required, for: .vertical)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonView = UIButton(type: .system)
        buttonView.setTitle("OK", for: .normal)
        buttonView.setTitleColor(.systemBlue, for: .normal)
        buttonView.backgroundColor = .white
        buttonView.layer.cornerRadius = 8
//        buttonView.layer.borderWidth = 2
//        buttonView.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00)
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonView.setContentHuggingPriority(.required, for: .vertical)
        buttonView.setContentCompressionResistancePriority(.required, for: .vertical)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [labelView, buttonView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setContentHuggingPriority(.required, for: .vertical)
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(fadeBackgroundView)
        addSubview(alertBackgroundView)
        alertBackgroundView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            fadeBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            fadeBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fadeBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fadeBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            alertBackgroundView.centerXAnchor.constraint(equalTo: fadeBackgroundView.centerXAnchor),
            alertBackgroundView.centerYAnchor.constraint(equalTo: fadeBackgroundView.centerYAnchor),
            alertBackgroundView.widthAnchor.constraint(equalTo: fadeBackgroundView.widthAnchor, multiplier: 0.7),
            alertBackgroundView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            alertBackgroundView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: alertBackgroundView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: alertBackgroundView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: alertBackgroundView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: alertBackgroundView.trailingAnchor, constant: -16),
            
        ])
    }
    
    @objc func buttonTapped() {
        delegate?.didTapOkButton()
    }
}

//Нужен ли здесь синглтон такого типа?
//class AlertService {
//    static let shared = AlertService()
//    
//    private var alertView: CustomAlertView?
//
//    func showAlert(in parent: UIView, message: String) {
//        if alertView == nil {
//            alertView = CustomAlertView()
//            parent.addSubview(alertView!)
//            // setup constraints here
//        }
//        
//        alertView?.setMessage(message)
//        alertView?.show()
//    }
//
//    func dismissAlert() {
//        alertView?.hide()
//    }
//}
