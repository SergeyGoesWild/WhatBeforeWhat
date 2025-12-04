//
//  Extensions.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 04/12/2025.
//
import UIKit

enum ScreenCategory {
    case small
    case medium
    case large
}

extension UIScreen {
    var category: ScreenCategory {
        let height = UIScreen.main.bounds.height

        switch height {
        case ..<813:
            return .small
        case 813..<852:
            return .medium
        default:
            return .large
        }
    }
}
