//
//  LocalizationHelper.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 19/10/2025.
//

import Foundation

enum UIStrings {
    static func string(_ key: String) -> String {
        NSLocalizedString(key,
                          tableName: "Localizable",
                          bundle: .main,
                          value: key,
                          comment: "")
    }
}
