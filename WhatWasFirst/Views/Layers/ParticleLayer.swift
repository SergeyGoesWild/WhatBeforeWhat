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
        print("IN LAYOUT SUBVIEWS")
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: -50)
        emitter.emitterSize = CGSize(width: bounds.width, height: 1)
    }
    
    private func setupEmitter() {
        let cell = CAEmitterCell()
        emitter.emitterShape = .line
        cell.contents = UIImage(named: "star")?.cgImage
        cell.birthRate = 20
        cell.lifetime = 3
        cell.velocity = 250
        cell.yAcceleration = 200
        cell.velocityRange = 60
        cell.spin = 0.5
        cell.spinRange = 3
        cell.scale = 0.1
        cell.scaleRange = 0.07
        cell.emissionLongitude = .pi
        
        emitter.emitterCells = [cell]
        emitter.birthRate = 0
    }
    
    func startEmission() {
        self.layer.addSublayer(emitter)
        emitter.birthRate = 1
        emitter.beginTime = CACurrentMediaTime()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.stopEmission()
        }
    }
    
    private func stopEmission() {
        emitter.birthRate = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.emitter.removeFromSuperlayer()
        }
    }
}
