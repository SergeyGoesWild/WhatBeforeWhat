//
//  ParticleLayer.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 24/07/2025.
//
import UIKit

class ParticleLayer: UIView {
    
    private let emitter = CAEmitterLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupParticles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupParticles()
    }
    
    private func setupParticles() {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "star")?.cgImage
        cell.birthRate = 5          // per second (base rate)
        cell.lifetime = 10
        cell.velocity = 200
        cell.scale = 0.1
        cell.scaleRange = 0.1
        cell.spin = 0.5
        cell.emissionLongitude = .pi
        
        emitter.emitterCells = [cell]
        emitter.emitterShape = .line
        emitter.birthRate = 0
        layer.addSublayer(emitter)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emitter.frame = bounds
        emitter.emitterPosition = CGPoint(x: bounds.width / 2, y: -40)
        emitter.emitterSize = CGSize(width: bounds.width, height: 1)
    }
    
    func startEmitting() {
        emitter.birthRate = 1
    }
    
    func stopEmitting() {
        emitter.birthRate = 0
    }
}
