//
//  Constants.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 31/05/2025.
//

import UIKit

enum AppColors {
    static let bgColour = UIColor(named: "BackgroundColour")!
    static let borderColour = UIColor(named: "OutlineColour")!
    static let okColour = UIColor(named: "OutlineColour")!
    static let buttonColour = UIColor(named: "ButtonColour")!
    static let labelColour = UIColor(named: "LabelColour")!
}

enum AppLayout {
    static let counterSpacing: CGFloat = 10
    static let counterWidth: CGFloat = 75
    static let counterHeight: CGFloat = 30
    static let counterCorRad: CGFloat = 12
    
    static let sidePadding: CGFloat = 10
    
    static let additionalVertPadding: CGFloat = 10
    
    static let smallLabelFont: CGFloat = 25
    static let bigLabelFont: CGFloat = 30
    
    static let particleOffset: CGFloat = -80
    
    static let zoomMargin: CGFloat = 60
}

enum AppAnimations {
    static let buttonMove: Double = 1.0
    
    static let emittionDuration: Double = 1.0
    static let particleTime: Double = 3.0
}

enum AppThreshold {
    static let smallScreenLimit: CGFloat = 812
    static let safeAreaInset: CGFloat = 24
}

enum AppFonts {
    
}
