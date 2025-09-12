//
//  ParticleLayer.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 24/07/2025.
//
import UIKit

final class ParticleLayer: UIView {
    private var emitter: CAEmitterLayer

    override init(frame: CGRect) {
        self.emitter = CAEmitterLayer()
        super.init(frame: frame)
        setupEmitter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: AppLayout.particleOffset)
        emitter.emitterSize = CGSize(width: bounds.width, height: 1)
    }
    
    private func setupEmitter() {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "star")?.cgImage
        cell.birthRate = 30
        cell.lifetime = Float(AppAnimations.particleTime)
        cell.velocity = 250
        cell.yAcceleration = 200
        cell.velocityRange = 60
        cell.spin = 0.5
        cell.spinRange = 3
        cell.scale = 0.1
        cell.scaleRange = 0.07
        cell.emissionLongitude = .pi
        
        emitter.emitterShape = .line
        emitter.emitterCells = [cell]
        emitter.birthRate = 0
    }
    
    func startEmission() {
        self.layer.addSublayer(emitter)
        emitter.birthRate = 1
        emitter.beginTime = CACurrentMediaTime()
        DispatchQueue.main.asyncAfter(deadline: .now() + AppAnimations.emittionDuration) {
            self.stopEmission()
        }
    }
    
    private func stopEmission() {
        emitter.birthRate = 0
    }
}
