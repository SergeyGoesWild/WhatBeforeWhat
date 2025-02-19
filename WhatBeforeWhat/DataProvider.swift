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
        HistoricItem(id: UUID(), picture: "Petra", date: 40),
        HistoricItem(id: UUID(), picture: "EiffelTower", date: 1889),
        HistoricItem(id: UUID(), picture: "Colosseum", date: 80),
        HistoricItem(id: UUID(), picture: "TajMahal", date: 1631),
        HistoricItem(id: UUID(), picture: "SaintBasilCathedral", date: 1555),
        HistoricItem(id: UUID(), picture: "BurjKhalifa", date: 2004),
        HistoricItem(id: UUID(), picture: "CasaMila", date: 1906),
        HistoricItem(id: UUID(), picture: "TowerOfPisa", date: 1372),
        HistoricItem(id: UUID(), picture: "SagradaFamilia", date: 1882),
        HistoricItem(id: UUID(), picture: "DancingHouse", date: 1996),
        HistoricItem(id: UUID(), picture: "WhiteHouse", date: 1800),
        HistoricItem(id: UUID(), picture: "MaskOfTutankhamun", date: -1323),
        HistoricItem(id: UUID(), picture: "SydneyOperaHouse", date: 1973),
        HistoricItem(id: UUID(), picture: "RosettaStone", date: -196),
        HistoricItem(id: UUID(), picture: "Stonehenge", date: -2500),
        HistoricItem(id: UUID(), picture: "Moai", date: 1250),
        HistoricItem(id: UUID(), picture: "TerracottaArmy", date: -210),
        HistoricItem(id: UUID(), picture: "OlmecColossalHeads", date: -900),
        HistoricItem(id: UUID(), picture: "DanseusesBleues", date: 1897),
        HistoricItem(id: UUID(), picture: "AmericanGothic", date: 1930),
        HistoricItem(id: UUID(), picture: "Nighthawks", date: 1942),
        HistoricItem(id: UUID(), picture: "DimancheApresMidiIleGrandeJatte", date: 1884),
        HistoricItem(id: UUID(), picture: "VoyageurContemplantUneMerDeNuages", date: 1818),
        HistoricItem(id: UUID(), picture: "NinthWave", date: 1850),
        HistoricItem(id: UUID(), picture: "LibertyLeadingThePeople", date: 1830),
        HistoricItem(id: UUID(), picture: "NightWatch", date: 1830),
        HistoricItem(id: UUID(), picture: "ThePersistenceOfMemory", date: 1931),
        HistoricItem(id: UUID(), picture: "GreatWallOfChina", date: -220),
        HistoricItem(id: UUID(), picture: "BorgundStaveChurch", date: 1200),
        HistoricItem(id: UUID(), picture: "HimejiCastle", date: 1333),
        HistoricItem(id: UUID(), picture: "NeuschwansteinCastle", date: 1869),
        HistoricItem(id: UUID(), picture: "TempleOfHeaven", date: 1406),
        HistoricItem(id: UUID(), picture: "RadeauDeLaMeduse", date: 1818),
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
