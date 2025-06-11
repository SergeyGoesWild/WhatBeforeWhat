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
    let yOffset: CGFloat?
    
    init(id: UUID, picture: String, date: Int, flavourText: String, circa: Bool, yOffset: CGFloat? = nil) {
            self.id = id
            self.picture = picture
            self.date = date
            self.flavourText = flavourText
            self.circa = circa
            self.yOffset = yOffset
    }
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
        HistoricItem(id: UUID(), picture: "MonaLisa", date: 1506, flavourText: "'Mona Lisa' a painting by Leonardo da Vinci, an archetypal masterpiece of the Italian Renaissance.", circa: false, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "NotreDameDeParis", date: 1345, flavourText: "Notre-Dame is a famous Gothic cathedral in Paris, France.", circa: false),
        HistoricItem(id: UUID(), picture: "ParthenonAthens", date: -432, flavourText: "The Parthenon is an ancient Greek temple located on the Acropolis of Athens.", circa: true),
        HistoricItem(id: UUID(), picture: "SacreCoeur", date: 1923, flavourText: "Sacré-Cœur is a renowned Roman Catholic church located at the summit of Montmartre, Paris.", circa: false),
        HistoricItem(id: UUID(), picture: "SantaMariaDelFiore", date: 1436, flavourText: "Santa Maria del Fiore is a famous church and a masterpiece of Italian Gothic and Renaissance architecture.", circa: false),
        HistoricItem(id: UUID(), picture: "StarryNight", date: 1889, flavourText: "'Starry Night' is one of the most famous paintings in the world, created by Vincent van Gogh in 1889", circa: false),
        HistoricItem(id: UUID(), picture: "GreatWaveOffKanagawa", date: 1831, flavourText: "'The Great Wave off Kanagawa' is a Japanese woodblock print by Katsushika Hokusai, one of the most recognizable works of Japanese art", circa: false),
        HistoricItem(id: UUID(), picture: "GirlPearlEarring", date: 1665, flavourText: "'Girl with a Pearl Earring' is a painting by Johannes Vermeer during the Dutch Golden Age.", circa: false),
        HistoricItem(id: UUID(), picture: "TheScream", date: 1893, flavourText: "'The Scream' is one of the most famous paintings in art history, created by Edvard Munch in 1893.", circa: false),
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
        HistoricItem(id: UUID(), picture: "MaskOfTutankhamun", date: -1323, flavourText: "The Mask of Tutankhamun is an ancient Egyptian funerary mask made of solid gold that belonged to Pharaoh Tutankhamun, one of Egypt’s most famous rulers.", circa: true, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "SydneyOperaHouse", date: 1973, flavourText: "The Sydney Opera House is a world-famous performing arts center located in Sydney, Australia. It is known for its sail-like design.", circa: false),
        HistoricItem(id: UUID(), picture: "RosettaStone", date: -196, flavourText: "The Rosetta Stone is an ancient Egyptian artifact that was crucial in deciphering Egyptian hieroglyphs. It contains the same text written in three different scripts.", circa: true),
        HistoricItem(id: UUID(), picture: "Stonehenge", date: -2500, flavourText: "Stonehenge is a prehistoric monument located in Wiltshire, England, known for its massive standing stones arranged in a circular formation.", circa: true),
        HistoricItem(id: UUID(), picture: "Moai", date: 1250, flavourText: "The Moai are massive stone statues found on Easter Island, a remote island in the Pacific Ocean.", circa: true),
        HistoricItem(id: UUID(), picture: "TerracottaArmy", date: -210, flavourText: "The Terracotta Army is a massive collection of life-sized clay soldiers buried near the tomb of China’s first emperor to guard him in the afterlife.", circa: true),
        HistoricItem(id: UUID(), picture: "OlmecColossalHeads", date: -900, flavourText: "The Olmec Colossal Heads are massive stone sculptures created by the Olmec civilization, one of the earliest known cultures in Mesoamerica.", circa: true),
        HistoricItem(id: UUID(), picture: "DanseusesBleues", date: 1897, flavourText: "“Danseuses Bleues” is a famous painting by Edgar Degas, a renowned French Impressionist artist.", circa: false),
        HistoricItem(id: UUID(), picture: "AmericanGothic", date: 1930, flavourText: "“American Gothic” is a famous painting by Grant Wood. It is one of the most recognizable works of American art, known for its depiction of rural life and traditional values.", circa: false, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "Nighthawks", date: 1942, flavourText: "“Nighthawks” is a famous painting by Edward Hopper. It is one of the most iconic artworks of American realism, known for its moody atmosphere.", circa: false),
        HistoricItem(id: UUID(), picture: "DimancheApresMidiIleGrandeJatte", date: 1884, flavourText: "“Un dimanche après-midi à l’Île de la Grande Jatte” is a famous pointillist painting by Georges Seurat.", circa: false),
        HistoricItem(id: UUID(), picture: "VoyageurContemplantUneMerDeNuages", date: 1818, flavourText: "“Voyageur contemplant une mer de nuages” is a famous Romantic painting by Caspar David Friedrich. It is one of the most iconic representations of Romanticism.", circa: false),
        HistoricItem(id: UUID(), picture: "NinthWave", date: 1850, flavourText: "“The Ninth Wave” is a famous maritime painting by Ivan Aivazovsky. It is considered one of the greatest seascapes in art history.", circa: false),
        HistoricItem(id: UUID(), picture: "LibertyLeadingThePeople", date: 1830, flavourText: "“Liberty Leading the People” is a famous historical painting by Eugène Delacroix. It is one of the most iconic representations of revolution", circa: false, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "NightWatch", date: 1830, flavourText: "“The Night Watch” is a famous Baroque painting by Rembrandt van Rijn. It is one of the most celebrated works of Dutch Golden Age art.", circa: false),
        HistoricItem(id: UUID(), picture: "ThePersistenceOfMemory", date: 1931, flavourText: "“The Persistence of Memory” is a famous Surrealist painting by Salvador Dalí. It is known for its dreamlike atmosphere.", circa: false),
        HistoricItem(id: UUID(), picture: "GreatWallOfChina", date: -220, flavourText: "The Great Wall of China is a massive ancient fortification built to protect China from invasions and control trade routes.", circa: true),
        HistoricItem(id: UUID(), picture: "BorgundStaveChurch", date: 1200, flavourText: "The Borgund Stave Church is a medieval wooden church located in Norway, known for its Viking-era architecture.", circa: true, yOffset: -0.1),
        HistoricItem(id: UUID(), picture: "HimejiCastle", date: 1333, flavourText: "Himeji Castle is one of Japan’s most famous and well-preserved castles, known for its elegant white appearance and advanced defensive design.", circa: false),
        HistoricItem(id: UUID(), picture: "NeuschwansteinCastle", date: 1869, flavourText: "Neuschwanstein Castle is a castle located in Bavaria, Germany, famous for its romantic design and breathtaking setting.", circa: false),
        HistoricItem(id: UUID(), picture: "TempleOfHeaven", date: 1406, flavourText: "The Temple of Heaven is a historic religious complex in Beijing, China, where emperors of the Ming and Qing Dynasties performed ceremonies to pray for good harvests.", circa: true),
        HistoricItem(id: UUID(), picture: "RadeauDeLaMeduse", date: 1818, flavourText: "“Le Radeau de la Méduse” is a famous French Romantic painting by Théodore Géricault. It is depicting the real-life tragedy of a shipwreck.", circa: false),
        HistoricItem(id: UUID(), picture: "HuntersInTheSnow", date: 1565, flavourText: "“Hunters in the Snow” by Pieter Bruegel is a Renaissance masterpiece depicting a group of hunters returning home. The painting shows harsh winter and the quiet rhythm of rural life.", circa: false),
        HistoricItem(id: UUID(), picture: "Bogolyubovo", date: 1158, flavourText: "The Church of the Intercession on the Nerl is an example of early Russian Orthodox architecture. With its elegant white limestone structure, it is gracefully set at the confluence of rivers.", circa: true),
        HistoricItem(id: UUID(), picture: "Louvre", date: 1989, flavourText: "The Louvre Pyramid is a striking glass and steel structure at the heart of the Louvre courtyard in Paris that blends modern design with historic architecture.", circa: false),
        HistoricItem(id: UUID(), picture: "BigBen", date: 1854, flavourText: "Big Ben is the iconic clock tower of the Palace of Westminster in London, officially named the Elizabeth Tower. It is known for its massive bell and neo-Gothic design.", circa: false),
        HistoricItem(id: UUID(), picture: "BerlinWall", date: 1961, flavourText: "The Berlin Wall was a concrete barrier that divided East and West Berlin from 1961 to 1989, symbolizing the Cold War’s ideological divide.", circa: false),
        HistoricItem(id: UUID(), picture: "BreznevGraffiti", date: 1990, flavourText: "The famous mural known as “My God, Help Me to Survive This Deadly Love”, showing a passionate kiss between Soviet leader Leonid Brezhnev and East German leader Erich Honecker.", circa: false),
        HistoricItem(id: UUID(), picture: "MontSaintMichel", date: 1260, flavourText: "Mont Saint-Michel is a medieval abbey perched on a rocky island off the coast of Normandy. It has been a site of pilgrimage for centuries.", circa: false),
        HistoricItem(id: UUID(), picture: "TowerBridge", date: 1894, flavourText: "Tower Bridge is a historic drawbridge in London across the River Thames, known for its twin towers and striking Victorian Gothic design.", circa: false),
        HistoricItem(id: UUID(), picture: "Gherkin", date: 2004, flavourText: "The Gherkin, officially known as 30 St Mary Axe, is a distinctive glass skyscraper in London’s financial district.", circa: false),
        HistoricItem(id: UUID(), picture: "Cambridge", date: 1209, flavourText: "The University of Cambridge is one of the world’s oldest and most prestigious universities. It has been a global center of learning and research for over 800 years.", circa: false),
        HistoricItem(id: UUID(), picture: "SewuTemple", date: 760, flavourText: "Sewu Temple is an ancient Buddhist temple complex. Tt showcases the grandeur of early Javanese architecture and religious harmony.", circa: true),
        HistoricItem(id: UUID(), picture: "EmpireStateBuilding", date: 1931, flavourText: "The Empire State Building is a towering Art Deco skyscraper in New York City. It was once the tallest building in the world, surpassing the Eiffel Tower.", circa: false),
        HistoricItem(id: UUID(), picture: "ItsukushimaShrine", date: 1168, flavourText: "Itsukushima Shrine is a historic landmark located in Japan, famous for its iconic “floating” torii gate that appears to rise from the sea at high tide.", circa: false),
        HistoricItem(id: UUID(), picture: "StatueOfLiberty", date: 1876, flavourText: "The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor, gifted by France in 1886, symbolizing freedom and democracy.", circa: false),
        HistoricItem(id: UUID(), picture: "LaGrandPlace", date: 1695, flavourText: "La Grand-Place in Brussels is a stunning central square surrounded by ornate guildhalls, the Town Hall, and the King’s House. It showcases a rich blend of Gothic and Baroque architecture.", circa: false),
        HistoricItem(id: UUID(), picture: "CharlesBridge", date: 1402, flavourText: "The Charles Bridge is a historic stone bridge in Prague, spanning the Vltava River and connecting the Old Town with the Prague Castle.", circa: false),
        HistoricItem(id: UUID(), picture: "DiscoveriesMonument", date: 1958, flavourText: "The Monument to the Discoveries is a sculpture on the banks of the Tagus River in Lisbon’s Belém district. It honors Portugal’s Age of Discovery.", circa: false),
        HistoricItem(id: UUID(), picture: "TorreBelem", date: 1519, flavourText: "The Torre de Belém is a fortification near Lisbon, Portugal. It used to serve as a defensive structure and as a ceremonial gateway for explorers during the Age of Discoveries.", circa: false),
        HistoricItem(id: UUID(), picture: "MountRushmore", date: 1941, flavourText: "Mount Rushmore is a monumental granite sculpture in South Dakota, featuring the carved faces of four U.S. presidents: Washington, Jefferson, Roosevelt and Lincoln.", circa: false),
        HistoricItem(id: UUID(), picture: "WashingtonMonument", date: 1888, flavourText: "The Washington Monument is a white marble obelisk located in Washington, D.C., built to honor George Washington, the first U.S. president.", circa: false, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "SanctuaryBomJesusDoMonte", date: 1784, flavourText: "The Sanctuary of Bom Jesus do Monte, located in Braga, Portugal, is a landmark renowned for its monumental Baroque stairway and neoclassical basilica.", circa: false),
        HistoricItem(id: UUID(), picture: "PalacioDaPena", date: 1838, flavourText: "The Palácio Nacional da Pena is a palace in the Sintra Mountains, Portugal. The palace showcases an eclectic mix of architectural styles, reflecting the Romanticism of the era.", circa: false),
        HistoricItem(id: UUID(), picture: "HausmannHouses", date: 1853, flavourText: "Haussmann houses are elegant residential buildings that define much of Paris’s architectural identity. They feature uniform façades, wrought-iron balconies, and cream-colored stone.", circa: true),
        HistoricItem(id: UUID(), picture: "HallOfBulls", date: -16000, flavourText: "The Hall of Bulls in the Lascaux Cave, France, is a prehistoric cave famous for its striking Paleolithic cave paintings.", circa: false),
        HistoricItem(id: UUID(), picture: "VenusMilo", date: -115, flavourText: "The Venus de Milo is an ancient Greek marble statue believed to represent Aphrodite, the goddess of love and beauty.", circa: true, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "Moschophoros", date: -570, flavourText: "The Moschophoros, or “Calf Bearer”, is an ancient Greek statue, depicting a bearded man carrying a calf on his shoulders. It is a key example of early Archaic sculpture.", circa: true, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "MuiredachHighCross", date: 855, flavourText: "Muiredach’s High Cross, located in Ireland, is a sandstone monument known for its intricate carvings. It features detailed biblical scenes from the Old and New Testaments.", circa: true, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "MilesevaMonastery", date: 1234, flavourText: "Mileševa Monastery is a Serbian Orthodox monastery. Renowned for its exquisite frescoes, it houses the famous “White Angel”, considered a masterpiece of medieval European art.", circa: false),
        HistoricItem(id: UUID(), picture: "CodexAureus", date: 870, flavourText: "The Codex Aureus is a lavishly illuminated medieval manuscript. With its gold ink and decorations, it exemplifies the opulence and artistry of Carolingian scriptoria.", circa: false),
        HistoricItem(id: UUID(), picture: "IconChristAndAbbotMena", date: 550, flavourText: "An early Coptic icon showing Christ alongside Abbot Mena, symbolizing spiritual companionship and divine guidance.", circa: false),
        HistoricItem(id: UUID(), picture: "IvoryTabernacle", date: 1390, flavourText: "A delicately carved Gothic ivory tabernacle, used to house the Eucharist, reflecting medieval religious artistry.", circa: true),
        HistoricItem(id: UUID(), picture: "AztecSunStone", date: 1510, flavourText: "A monumental basalt sculpture symbolizing the Aztec cosmos and calendar, richly carved with mythological figures.", circa: true),
        HistoricItem(id: UUID(), picture: "LessayAbbey", date: 1080, flavourText: "A Romanesque Benedictine abbey in Normandy, known for its harmonious architecture and early use of rib vaults.", circa: false),
        HistoricItem(id: UUID(), picture: "MariaLaachAbbey", date: 1156, flavourText: "A Romanesque monastery by Lake Laach in Germany, blending spiritual function with striking architectural balance.", circa: true),
        HistoricItem(id: UUID(), picture: "CloistersApocalypse", date: 1330, flavourText: "An illuminated manuscript depicting vivid scenes from the Book of Revelation, held at The Cloisters in New York.", circa: true, yOffset: 0.28),
        HistoricItem(id: UUID(), picture: "AnnunciationVinci", date: 1474, flavourText: "A delicate early painting of the Annunciation attributed to Leonardo da Vinci, blending clarity with subtle emotion.", circa: true),
        HistoricItem(id: UUID(), picture: "MosaicFloorDogAlexandria", date: -175, flavourText: "A Hellenistic mosaic from Alexandria depicting a dog with remarkable realism, showcasing ancient Greek artistry.", circa: true),
        HistoricItem(id: UUID(), picture: "GreatTheaterOfEpidaurus", date: -320, flavourText: "A marvel of ancient Greek architecture, famed for its perfect acoustics and elegant semicircular design.", circa: true),
    ]
    
    func provideItems() -> (HistoricItem, HistoricItem) {
        guard let previous1 = prevIndex1, let previous2 = prevIndex2 else {
            let random1 = Int.random(in: 0..<data.count)
            var random2 = Int.random(in: 0..<data.count)
            while data[random2].date == data[random1].date {
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
        while data[random2].date == data[random1].date || random2 == previous1 || random2 == previous2 {
            random2 = Int.random(in: 0..<data.count)
        }
        prevIndex1 = random1
        prevIndex2 = random2
        return (data[random1], data[random2])
    }
}
