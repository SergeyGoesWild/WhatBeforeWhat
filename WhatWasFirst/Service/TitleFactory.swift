//
//  TitleFactory.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 23/07/2025.
//

enum Titles: String, CaseIterable {
    case lord = "Lord of"
    case master = "Master of"
    case duke = "Duke of"
    case count = "Count of"
    case earl = "Earl of"
    case chief = "Chief of"
    case adept = "Adept of"
    case savant = "Savant of"
    case captain = "Captain of"
    case connoisseur = "Connoisseur of"
    case sage = "Sage of"
    case lorekeeper = "Lorekeeper of"
    case guru = "Guru of"
    case virtuoso = "Virtuoso of"
}

final class TitleFactory {
    
    init() {}
    
    func makeTitle(with answers: [HistoricItem]) -> (String, HistoricItem?) {
        let title = Titles.allCases.randomElement()!.rawValue
        if answers.isEmpty {
            return ("\(title) Nothingness", nil)
        } else {
            let randomIndex = Int.random(in: 0..<answers.count)
            let answer = answers[randomIndex]
            return ("\(title) \(answer.title.rawValue)", answer)
        }
    }
}
