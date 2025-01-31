//
//  DataProvider.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 26/01/2025.
//

import Foundation

struct HistoricItem {
    let id: UUID
    let picture: String
    let date: Int
}

final class DataProvider {
    static let shared = DataProvider()
    private init() {}
    
    let data: [HistoricItem] = [
        HistoricItem(id: UUID(), picture: "HandsCave", date: -25000),
        HistoricItem(id: UUID(), picture: "BlackSquare", date: 1915),
        HistoricItem(id: UUID(), picture: "ElCastillo", date: 1100),
        HistoricItem(id: UUID(), picture: "MonaLisa", date: 1506),
        HistoricItem(id: UUID(), picture: "NotreDame", date: 1345),
        HistoricItem(id: UUID(), picture: "Parthenon", date: -432),
        HistoricItem(id: UUID(), picture: "SacreCoeur", date: 1923),
        HistoricItem(id: UUID(), picture: "SantaMarieDelFiore", date: 1436),
        HistoricItem(id: UUID(), picture: "StarryNight", date: 1889),
        HistoricItem(id: UUID(), picture: "GreatWaveOffKanagawa", date: 1831),
        HistoricItem(id: UUID(), picture: "GirlPearlEarring", date: 1665),
        HistoricItem(id: UUID(), picture: "Scream", date: 1893),
    ]
    
    func provideItems() -> (HistoricItem, HistoricItem) {
        let random1 = Int.random(in: 0..<data.count)
        var random2 = Int.random(in: 0..<data.count)
        while random2 == random1 {
            random2 = Int.random(in: 0..<data.count)
        }
        return (data[random1], data[random2])
    }
}
