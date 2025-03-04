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
    let flavourText: String
    let circa: Bool
}

final class DataProvider {
    static let shared = DataProvider()
    private init() {}
    
    private var prevIndex1: Int?
    private var prevIndex2: Int?
    
    let data: [HistoricItem] = [
        HistoricItem(id: UUID(), picture: "HandsCave", date: -25000, flavourText: "Prehistoric hand paintings at the Cave of Hands in Argentina.", circa: true),
        HistoricItem(id: UUID(), picture: "BlackSquare", date: 1915, flavourText: "'Black square' painting by Kasimir Malevitch, considered one of the most radical artworks of its time.", circa: false),
        HistoricItem(id: UUID(), picture: "ElCastillo", date: 1100, flavourText: "Temple of Kukulcan - a Mesoamerican step-pyramid in Mexico, built by the Maya civilization.", circa: true),
        HistoricItem(id: UUID(), picture: "MonaLisa", date: 1506, flavourText: "'Mona Lisa' a painting by Leonardo da Vinci, an archetypal masterpiece of the Italian Renaissance.", circa: false),
        HistoricItem(id: UUID(), picture: "NotreDame", date: 1345, flavourText: "Notre-Dame is a famous Gothic cathedral in Paris, France.", circa: false),
        HistoricItem(id: UUID(), picture: "Parthenon", date: -432, flavourText: "The Parthenon is an ancient Greek temple located on the Acropolis of Athens.", circa: true),
        HistoricItem(id: UUID(), picture: "SacreCoeur", date: 1923, flavourText: "Sacré-Cœur is a renowned Roman Catholic church located at the summit of Montmartre, Paris.", circa: false),
        HistoricItem(id: UUID(), picture: "SantaMarieDelFiore", date: 1436, flavourText: "Santa Maria del Fiore is a famous church and a masterpiece of Italian Gothic and Renaissance architecture.", circa: false),
        HistoricItem(id: UUID(), picture: "StarryNight", date: 1889, flavourText: "'Starry Night' is one of the most famous paintings in the world, created by Vincent van Gogh in 1889", circa: false),
        HistoricItem(id: UUID(), picture: "GreatWaveOffKanagawa", date: 1831, flavourText: "'The Great Wave off Kanagawa' is a Japanese woodblock print by Katsushika Hokusai, one of the most recognizable works of Japanese art", circa: false),
        HistoricItem(id: UUID(), picture: "GirlPearlEarring", date: 1665, flavourText: "'Girl with a Pearl Earring' is a painting by Johannes Vermeer during the Dutch Golden Age.", circa: false),
        HistoricItem(id: UUID(), picture: "Scream", date: 1893, flavourText: "'The Scream' is one of the most famous paintings in art history, created by Edvard Munch in 1893.", circa: false),
        HistoricItem(id: UUID(), picture: "Petra", date: 40, flavourText: "Petra is an ancient city in Jordan. It is one of the New Seven Wonders of the World.", circa: true),
        HistoricItem(id: UUID(), picture: "EiffelTower", date: 1889, flavourText: "The Eiffel Tower is a famous landmark symbolizing Paris and France. It was originally built for the 1889 World’s Fair", circa: false),
        HistoricItem(id: UUID(), picture: "Colosseum", date: 80, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "TajMahal", date: 1631, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "SaintBasilCathedral", date: 1555, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "BurjKhalifa", date: 2004, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "CasaMila", date: 1906, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "TowerOfPisa", date: 1372, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "SagradaFamilia", date: 1882, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "DancingHouse", date: 1996, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "WhiteHouse", date: 1800, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "MaskOfTutankhamun", date: -1323, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "SydneyOperaHouse", date: 1973, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "RosettaStone", date: -196, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "Stonehenge", date: -2500, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "Moai", date: 1250, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "TerracottaArmy", date: -210, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "OlmecColossalHeads", date: -900, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "DanseusesBleues", date: 1897, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "AmericanGothic", date: 1930, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "Nighthawks", date: 1942, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "DimancheApresMidiIleGrandeJatte", date: 1884, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "VoyageurContemplantUneMerDeNuages", date: 1818, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "NinthWave", date: 1850, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "LibertyLeadingThePeople", date: 1830, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "NightWatch", date: 1830, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "ThePersistenceOfMemory", date: 1931, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "GreatWallOfChina", date: -220, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "BorgundStaveChurch", date: 1200, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "HimejiCastle", date: 1333, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "NeuschwansteinCastle", date: 1869, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "TempleOfHeaven", date: 1406, flavourText: "XXX"),
        HistoricItem(id: UUID(), picture: "RadeauDeLaMeduse", date: 1818, flavourText: "XXX"),
    ]
    
    func provideItems() -> (HistoricItem, HistoricItem) {
        guard let previous1 = prevIndex1, let previous2 = prevIndex2 else {
            let random1 = Int.random(in: 0..<data.count)
            var random2 = Int.random(in: 0..<data.count)
            while random2 == random1 {
                random2 = Int.random(in: 0..<data.count)
            }
            prevIndex1 = random1
            prevIndex2 = random2
            return (data[random1], data[random2])
        }
        var random1 = Int.random(in: 0..<data.count)
        while random1 == previous1 {
            random1 = Int.random(in: 0..<data.count)
        }
        var random2 = Int.random(in: 0..<data.count)
        while random2 == random1 || random2 == previous1 || random2 == previous2 {
            random2 = Int.random(in: 0..<data.count)
        }
        prevIndex1 = random1
        prevIndex2 = random2
        return (data[random1], data[random2])
    }
}
