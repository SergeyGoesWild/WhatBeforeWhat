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
                          tableName: "UI-Localizable",
                          bundle: .main,
                          value: key,
                          comment: "")
    }
}


enum DBStrings {
    static func string(_ key: String) -> String {
        NSLocalizedString(key,
                          tableName: "DB-Localizable",
                          bundle: .main,
                          value: key,
                          comment: "")
    }
}
