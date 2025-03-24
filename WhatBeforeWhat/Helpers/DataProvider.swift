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
        HistoricItem(id: UUID(), picture: "EiffelTower", date: 1889, flavourText: "The Eiffel Tower is a famous landmark symbolizing Paris and France. It was originally built for the 1889 World’s Fair.", circa: false),
        HistoricItem(id: UUID(), picture: "Colosseum", date: 80, flavourText: "Colosseum is one of the most famous and iconic structures of the Roman Empire and is considered one of the greatest works of Roman architecture.", circa: false),
        HistoricItem(id: UUID(), picture: "TajMahal", date: 1631, flavourText: "Taj Mahal is a world-famous mausoleum located in Agra, India. It is considered a symbol of love and devotion.", circa: false),
        HistoricItem(id: UUID(), picture: "SaintBasilCathedral", date: 1555, flavourText: "Saint Basil's Cathedral is situated on the Red Square in Moscow, this used-to-be church is known for its colorful onion-shaped domes and unique Russian Orthodox architecture.", circa:  false),
        HistoricItem(id: UUID(), picture: "BurjKhalifa", date: 2004, flavourText: "The Burj Khalifa is the tallest building in the world, located in Dubai, United Arab Emirates.", circa: false),
        HistoricItem(id: UUID(), picture: "CasaMila", date: 1906, flavourText: "Casa Milà is a famous modernist building in Barcelona, Spain, designed by the renowned architect Antoni Gaudí.", circa: false),
        HistoricItem(id: UUID(), picture: "TowerOfPisa", date: 1372, flavourText: "Leaning Tower of Pisa, is a famous bell tower located in Pisa, Italy. It is well-known for its unintentional tilt, caused by unstable foundation soil.", circa: false),
        HistoricItem(id: UUID(), picture: "SagradaFamilia", date: 1882, flavourText: "The Sagrada Família is a famous basilica in Barcelona, Spain. It is known for its intricate design and unfinished status.", circa: false),
        HistoricItem(id: UUID(), picture: "DancingHouse", date: 1996, flavourText: "The Dancing House is a modern architectural landmark in Prague, Czech Republic, known for its unusual design that resembles a dancing couple.", circa: false),
        HistoricItem(id: UUID(), picture: "WhiteHouse", date: 1800, flavourText: "The White House is the official residence and workplace of the President of the United States, located in Washington, D.C.", circa: false),
        HistoricItem(id: UUID(), picture: "MaskOfTutankhamun", date: -1323, flavourText: "The Mask of Tutankhamun is an ancient Egyptian funerary mask made of solid gold that belonged to Pharaoh Tutankhamun, one of Egypt’s most famous rulers.", circa: true),
        HistoricItem(id: UUID(), picture: "SydneyOperaHouse", date: 1973, flavourText: "The Sydney Opera House is a world-famous performing arts center located in Sydney, Australia. It is known for its sail-like design.", circa: false),
        HistoricItem(id: UUID(), picture: "RosettaStone", date: -196, flavourText: "The Rosetta Stone is an ancient Egyptian artifact that was crucial in deciphering Egyptian hieroglyphs. It contains the same text written in three different scripts.", circa: true),
        HistoricItem(id: UUID(), picture: "Stonehenge", date: -2500, flavourText: "Stonehenge is a prehistoric monument located in Wiltshire, England, known for its massive standing stones arranged in a circular formation.", circa: true),
        HistoricItem(id: UUID(), picture: "Moai", date: 1250, flavourText: "The Moai are massive stone statues found on Easter Island, a remote island in the Pacific Ocean.", circa: true),
        HistoricItem(id: UUID(), picture: "TerracottaArmy", date: -210, flavourText: "The Terracotta Army is a massive collection of life-sized clay soldiers buried near the tomb of China’s first emperor to guard him in the afterlife.", circa: true),
        HistoricItem(id: UUID(), picture: "OlmecColossalHeads", date: -900, flavourText: "The Olmec Colossal Heads are massive stone sculptures created by the Olmec civilization, one of the earliest known cultures in Mesoamerica.", circa: true),
        HistoricItem(id: UUID(), picture: "DanseusesBleues", date: 1897, flavourText: "“Danseuses Bleues” is a famous painting by Edgar Degas, a renowned French Impressionist artist.", circa: false),
        HistoricItem(id: UUID(), picture: "AmericanGothic", date: 1930, flavourText: "“American Gothic” is a famous painting by Grant Wood. It is one of the most recognizable works of American art, known for its depiction of rural life and traditional values.", circa: false),
        HistoricItem(id: UUID(), picture: "Nighthawks", date: 1942, flavourText: "“Nighthawks” is a famous painting by Edward Hopper. It is one of the most iconic artworks of American realism, known for its moody atmosphere.", circa: false),
        HistoricItem(id: UUID(), picture: "DimancheApresMidiIleGrandeJatte", date: 1884, flavourText: "“Un dimanche après-midi à l’Île de la Grande Jatte” is a famous pointillist painting by Georges Seurat.", circa: false),
        HistoricItem(id: UUID(), picture: "VoyageurContemplantUneMerDeNuages", date: 1818, flavourText: "“Voyageur contemplant une mer de nuages” is a famous Romantic painting by Caspar David Friedrich. It is one of the most iconic representations of Romanticism.", circa: false),
        HistoricItem(id: UUID(), picture: "NinthWave", date: 1850, flavourText: "“The Ninth Wave” is a famous maritime painting by Ivan Aivazovsky. It is considered one of the greatest seascapes in art history.", circa: false),
        HistoricItem(id: UUID(), picture: "LibertyLeadingThePeople", date: 1830, flavourText: "“Liberty Leading the People” is a famous historical painting by Eugène Delacroix. It is one of the most iconic representations of revolution", circa: false),
        HistoricItem(id: UUID(), picture: "NightWatch", date: 1830, flavourText: "“The Night Watch” is a famous Baroque painting by Rembrandt van Rijn. It is one of the most celebrated works of Dutch Golden Age art.", circa: false),
        HistoricItem(id: UUID(), picture: "ThePersistenceOfMemory", date: 1931, flavourText: "“The Persistence of Memory” is a famous Surrealist painting by Salvador Dalí. It is known for its dreamlike atmosphere.", circa: false),
        HistoricItem(id: UUID(), picture: "GreatWallOfChina", date: -220, flavourText: "The Great Wall of China is a massive ancient fortification built to protect China from invasions and control trade routes.", circa: true),
        HistoricItem(id: UUID(), picture: "BorgundStaveChurch", date: 1200, flavourText: "The Borgund Stave Church is a medieval wooden church located in Norway, known for its Viking-era architecture.", circa: true),
        HistoricItem(id: UUID(), picture: "HimejiCastle", date: 1333, flavourText: "Himeji Castle is one of Japan’s most famous and well-preserved castles, known for its elegant white appearance and advanced defensive design.", circa: false),
        HistoricItem(id: UUID(), picture: "NeuschwansteinCastle", date: 1869, flavourText: "Neuschwanstein Castle is a castle located in Bavaria, Germany, famous for its romantic design and breathtaking setting.", circa: false),
        HistoricItem(id: UUID(), picture: "TempleOfHeaven", date: 1406, flavourText: "The Temple of Heaven is a historic religious complex in Beijing, China, where emperors of the Ming and Qing Dynasties performed ceremonies to pray for good harvests.", circa: true),
        HistoricItem(id: UUID(), picture: "RadeauDeLaMeduse", date: 1818, flavourText: "“Le Radeau de la Méduse” is a famous French Romantic painting by Théodore Géricault. It is depicting the real-life tragedy of a shipwreck.", circa: false),
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
