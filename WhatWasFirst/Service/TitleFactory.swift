//
//  TitleFactory.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 23/07/2025.
//

enum Titles: String, CaseIterable {
    case lord
    case master
    case duke
    case count
    case chief
    case savant
    case captain
    case guru
    
    var localized: String {
        switch self {
        case .lord: return UIStrings.string("Title.lord")
        case .master: return UIStrings.string("Title.master")
        case .duke: return UIStrings.string("Title.duke")
        case .count: return UIStrings.string("Title.count")
        case .chief: return UIStrings.string("Title.chief")
        case .savant: return UIStrings.string("Title.savant")
        case .captain: return UIStrings.string("Title.captain")
        case .guru: return UIStrings.string("Title.guru")
        }
    }
}

final class TitleFactory {
    
    init() {}
    
    func makeTitle(with answers: [HistoricItem]) -> (String, HistoricItem?) {
        let title = Titles.allCases.randomElement()!.localized
        if answers.isEmpty {
            return ("\(title) \(UIStrings.string("Title.nothing"))", nil)
        } else {
            let randomIndex = Int.random(in: 0..<answers.count)
            let answer = answers[randomIndex]
            return ("\(title) \(answer.title.rawValue)", answer)
        }
    }
}
