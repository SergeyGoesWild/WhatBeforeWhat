//
//  DataProvider.swift
//  WhatBeforeWhat
//
//  Created by Sergey Telnov on 26/01/2025.
//

import Foundation

enum TitlesSpecific: String {
    case ancientVase = "Ancient Vases"
    case prehistoric = "Prehistoric Art"
    case ancientArt = "Ancient Art"
    case ancientArchi = "Oldest Buildings"
    case artifact = "Ancient Artifacts"
    case temple = "Temples and Churches"
    case scroll = "Old Scrolls"
    case gothic = "Gothic Things"
    case baroque = "Baroque Things"
    case neoClassical = "Neoclassical Art"
    case avantgarde = "Avantgarde"
    case renaissance = "Renaissance"
    case impressionisme = "Impressionisme"
    case romantisme = "Romantisme"
    case point = "Pointillism"
    case medieval = "Medieval Stuff"
    case antiquity = "Cool Antiquity"
    case victorian = "Victorian Stuff"
    case paris = "Parisian Vibes"
    case french = "French Art"
    case dutch = "Dutch Art"
    case slavic = "Slavic Vibes"
    case asian = "Asian Style"
    case indian = "Indian Vibes"
    case american = "American Core"
    case modern = "Modernity"
}

struct HistoricItem {
    let id: UUID
    let picture: String
    let date: Int
    let name: String
    let flavourText: String
    let circa: Bool
    let title: TitlesSpecific
    let yOffset: CGFloat?
    
    init(id: UUID, picture: String, date: Int, name: String, flavourText: String, circa: Bool, title: TitlesSpecific, yOffset: CGFloat? = nil) {
            self.id = id
            self.picture = picture
            self.date = date
            self.name = name
            self.flavourText = flavourText
            self.circa = circa
            self.title = title
            self.yOffset = yOffset
    }
}

final class DataProvider {
    static let shared = DataProvider()
    private init() {}
    
    private var prevIndex1: Int?
    private var prevIndex2: Int?
    
    let data: [HistoricItem] = [
        HistoricItem(id: UUID(), picture: "HandsCave", date: -25000, name: "the Cave of Hands", flavourText: "Prehistoric hand paintings at the Cave of Hands in Argentina.", circa: true, title: .prehistoric),
        HistoricItem(id: UUID(), picture: "BlackSquare", date: 1915, name: "“Black Square“", flavourText: "'Black square' painting by Kasimir Malevitch, considered one of the most radical artworks of its time.", circa: false, title: .avantgarde),
        HistoricItem(id: UUID(), picture: "ElCastillo", date: 1100, name: "El Castillo", flavourText: "Temple of Kukulcan - a Mesoamerican step-pyramid in Mexico, built by the Maya civilization.", circa: true, title: .temple),
        HistoricItem(id: UUID(), picture: "MonaLisa", date: 1506, name: "“Mona Lisa”", flavourText: "'Mona Lisa' a painting by Leonardo da Vinci, an archetypal masterpiece of the Italian Renaissance.", circa: false, title: .renaissance, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "NotreDameDeParis", date: 1345, name: "Notre-Dame de Paris", flavourText: "Notre-Dame is a famous Gothic cathedral in Paris, France.", circa: false, title: .gothic),
        HistoricItem(id: UUID(), picture: "ParthenonAthens", date: -432, name: "the Parthenon", flavourText: "The Parthenon is an ancient Greek temple located on the Acropolis of Athens.", circa: true, title: .antiquity),
        HistoricItem(id: UUID(), picture: "SacreCoeur", date: 1923, name: "Sacré-Cœur", flavourText: "Sacré-Cœur is a renowned Roman Catholic church located at the summit of Montmartre, Paris.", circa: false, title: .paris),
        HistoricItem(id: UUID(), picture: "SantaMariaDelFiore", date: 1436, name: "Santa Maria del Fiore", flavourText: "Santa Maria del Fiore is a famous church and a masterpiece of Italian Gothic and Renaissance architecture.", circa: false, title: .renaissance),
        HistoricItem(id: UUID(), picture: "StarryNight", date: 1889, name: "“Starry Night“", flavourText: "'Starry Night' is one of the most famous paintings in the world, created by Vincent van Gogh in 1889", circa: false, title: .impressionisme),
        HistoricItem(id: UUID(), picture: "GreatWaveOffKanagawa", date: 1831, name: "“The Great Wave off Kanagawa“", flavourText: "“The Great Wave off Kanagawa“ is a Japanese woodblock print by Katsushika Hokusai, one of the most recognizable works of Japanese art", circa: false, title: .asian),
        HistoricItem(id: UUID(), picture: "GirlPearlEarring", date: 1665, name: "'Girl with a Pearl Earring'", flavourText: "'Girl with a Pearl Earring' is a painting by Johannes Vermeer during the Dutch Golden Age.", circa: false, title: .dutch),
        HistoricItem(id: UUID(), picture: "TheScream", date: 1893, name: "'The Scream'", flavourText: "'The Scream' is one of the most famous paintings in art history, created by Edvard Munch in 1893.", circa: false, title: .avantgarde),
        HistoricItem(id: UUID(), picture: "Petra", date: 40, name: "Petra", flavourText: "Petra is an ancient city in Jordan. It is one of the New Seven Wonders of the World.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "EiffelTower", date: 1889, name: "the Eiffel Tower", flavourText: "The Eiffel Tower is a famous landmark symbolizing Paris and France. It was originally built for the 1889 World’s Fair.", circa: false, title: .paris),
        HistoricItem(id: UUID(), picture: "Colosseum", date: 80, name: "Colosseum", flavourText: "Colosseum is one of the most famous and iconic structures of the Roman Empire and is considered one of the greatest works of Roman architecture.", circa: false, title: .antiquity),
        HistoricItem(id: UUID(), picture: "TajMahal", date: 1631, name: "Taj Mahal", flavourText: "Taj Mahal is a world-famous mausoleum located in Agra, India. It is considered a symbol of love and devotion.", circa: false, title: .indian),
        HistoricItem(id: UUID(), picture: "SaintBasilCathedral", date: 1555, name: "Saint Basil's Cathedral", flavourText: "Saint Basil's Cathedral is situated on the Red Square in Moscow, this used-to-be church is known for its colorful onion-shaped domes and unique Russian Orthodox architecture.", circa:  false, title: .slavic),
        HistoricItem(id: UUID(), picture: "BurjKhalifa", date: 2004, name: "the Burj Khalifa", flavourText: "The Burj Khalifa is the tallest building in the world, located in Dubai, United Arab Emirates.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "CasaMila", date: 1906, name: "Casa Milà", flavourText: "Casa Milà is a famous modernist building in Barcelona, Spain, designed by the renowned architect Antoni Gaudí.", circa: false, title: .avantgarde),
        HistoricItem(id: UUID(), picture: "TowerOfPisa", date: 1372, name: "the Tower of Pisa", flavourText: "Leaning Tower of Pisa, is a famous bell tower located in Pisa, Italy. It is well-known for its unintentional tilt, caused by unstable foundation soil.", circa: false, title: .renaissance),
        HistoricItem(id: UUID(), picture: "SagradaFamilia", date: 1882, name: "Sagrada Família", flavourText: "The Sagrada Família is a famous basilica in Barcelona, Spain. It is known for its intricate design and unfinished status.", circa: false, title: .avantgarde),
        HistoricItem(id: UUID(), picture: "DancingHouse", date: 1996, name: "the Dancing House", flavourText: "The Dancing House is a modern architectural landmark in Prague, Czech Republic, known for its unusual design that resembles a dancing couple.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "WhiteHouse", date: 1800, name: "the White House", flavourText: "The White House is the official residence and workplace of the President of the United States, located in Washington, D.C.", circa: false, title: .american),
        HistoricItem(id: UUID(), picture: "MaskOfTutankhamun", date: -1323, name: "the Mask of Tutankhamun", flavourText: "The Mask of Tutankhamun is an ancient Egyptian funerary mask made of solid gold that belonged to Pharaoh Tutankhamun, one of Egypt’s most famous rulers.", circa: true, title: .ancientVase, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "SydneyOperaHouse", date: 1973, name: "the Sydney Opera", flavourText: "The Sydney Opera House is a world-famous performing arts center located in Sydney, Australia. It is known for its sail-like design.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "RosettaStone", date: -196, name: "the Rosetta Stone", flavourText: "The Rosetta Stone is an ancient Egyptian artifact that was crucial in deciphering Egyptian hieroglyphs. It contains the same text written in three different scripts.", circa: true, title: .artifact),
        HistoricItem(id: UUID(), picture: "Stonehenge", date: -2500, name: "Stonehenge", flavourText: "Stonehenge is a prehistoric monument located in Wiltshire, England, known for its massive standing stones arranged in a circular formation.", circa: true, title: .ancientArchi),
        HistoricItem(id: UUID(), picture: "Moai", date: 1250, name: "the Moai", flavourText: "The Moai are massive stone statues found on Easter Island, a remote island in the Pacific Ocean.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "TerracottaArmy", date: -210, name: "the Terracotta Army", flavourText: "The Terracotta Army is a massive collection of life-sized clay soldiers buried near the tomb of China’s first emperor to guard him in the afterlife.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "OlmecColossalHeads", date: -900, name: "Olmec Colossal Heads", flavourText: "The Olmec Colossal Heads are massive stone sculptures created by the Olmec civilization, one of the earliest known cultures in Mesoamerica.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "DanseusesBleues", date: 1897, name: "“Danseuses Bleues”", flavourText: "“Danseuses Bleues” is a famous painting by Edgar Degas, a renowned French Impressionist artist.", circa: false, title: .impressionisme),
        HistoricItem(id: UUID(), picture: "AmericanGothic", date: 1930, name: "“American Gothic”", flavourText: "“American Gothic” is a famous painting by Grant Wood. It is one of the most recognizable works of American art, known for its depiction of rural life and traditional values.", circa: false, title: .american, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "Nighthawks", date: 1942, name: "“Nighthawks”", flavourText: "“Nighthawks” is a famous painting by Edward Hopper. It is one of the most iconic artworks of American realism, known for its moody atmosphere.", circa: false, title: .american),
        HistoricItem(id: UUID(), picture: "DimancheApresMidiIleGrandeJatte", date: 1884, name: "“L’Île de la Grande Jatte“", flavourText: "“Un dimanche après-midi à l’Île de la Grande Jatte” is a famous pointillist painting by Georges Seurat.", circa: false, title: .point),
        HistoricItem(id: UUID(), picture: "VoyageurContemplantUneMerDeNuages", date: 1818, name: "“Voyageur contemplant une mer de nuages”", flavourText: "“Voyageur contemplant une mer de nuages” is a famous Romantic painting by Caspar David Friedrich. It is one of the most iconic representations of Romanticism.", circa: false, title: .romantisme),
        HistoricItem(id: UUID(), picture: "NinthWave", date: 1850, name: "“The Ninth Wave”", flavourText: "“The Ninth Wave” is a famous maritime painting by Ivan Aivazovsky. It is considered one of the greatest seascapes in art history.", circa: false, title: .romantisme),
        HistoricItem(id: UUID(), picture: "LibertyLeadingThePeople", date: 1830, name: "“Liberty Leading the People”", flavourText: "“Liberty Leading the People” is a famous historical painting by Eugène Delacroix. It is one of the most iconic representations of revolution", circa: false, title: .romantisme, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "NightWatch", date: 1642, name: "“The Night Watch”", flavourText: "“The Night Watch” is a famous Baroque painting by Rembrandt van Rijn. It is one of the most celebrated works of Dutch Golden Age art.", circa: false, title: .dutch),
        HistoricItem(id: UUID(), picture: "ThePersistenceOfMemory", date: 1931, name: "“The Persistence of Memory”", flavourText: "“The Persistence of Memory” is a famous Surrealist painting by Salvador Dalí. It is known for its dreamlike atmosphere.", circa: false, title: .avantgarde),
        HistoricItem(id: UUID(), picture: "GreatWallOfChina", date: -220, name: "the Great Wall", flavourText: "The Great Wall of China is a massive ancient fortification built to protect China from invasions and control trade routes.", circa: true, title: .ancientArchi),
        HistoricItem(id: UUID(), picture: "BorgundStaveChurch", date: 1200, name: "the Borgund Church", flavourText: "The Borgund Stave Church is a medieval wooden church located in Norway, known for its Viking-era architecture.", circa: true, title: .medieval, yOffset: -0.1),
        HistoricItem(id: UUID(), picture: "HimejiCastle", date: 1333, name: "Himeji Castle", flavourText: "Himeji Castle is one of Japan’s most famous and well-preserved castles, known for its elegant white appearance and advanced defensive design.", circa: false, title: .asian),
        HistoricItem(id: UUID(), picture: "NeuschwansteinCastle", date: 1869, name: "Neuschwanstein Castle", flavourText: "Neuschwanstein Castle is a castle located in Bavaria, Germany, famous for its romantic design and breathtaking setting.", circa: false, title: .romantisme),
        HistoricItem(id: UUID(), picture: "TempleOfHeaven", date: 1406, name: "the Temple of Heaven", flavourText: "The Temple of Heaven is a historic religious complex in Beijing, China, where emperors of the Ming and Qing Dynasties performed ceremonies to pray for good harvests.", circa: true, title: .asian),
        HistoricItem(id: UUID(), picture: "RadeauDeLaMeduse", date: 1818, name: "“Le Radeau de la Méduse”", flavourText: "“Le Radeau de la Méduse” is a famous French Romantic painting by Théodore Géricault. It is depicting the real-life tragedy of a shipwreck.", circa: false, title: .french),
        HistoricItem(id: UUID(), picture: "HuntersInTheSnow", date: 1565, name: "“Hunters in the Snow”", flavourText: "“Hunters in the Snow” by Pieter Bruegel is a Renaissance masterpiece depicting a group of hunters returning home. The painting shows harsh winter and the quiet rhythm of rural life.", circa: false, title: .renaissance),
        HistoricItem(id: UUID(), picture: "Bogolyubovo", date: 1158, name: "the Church of the Intercession", flavourText: "The Church of the Intercession on the Nerl is an example of early Russian Orthodox architecture. With its elegant white limestone structure, it is gracefully set at the confluence of rivers.", circa: true, title: .slavic, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "Louvre", date: 1989, name: "the Louvre Pyramid", flavourText: "The Louvre Pyramid is a striking glass and steel structure at the heart of the Louvre courtyard in Paris that blends modern design with historic architecture.", circa: false, title: .paris),
        HistoricItem(id: UUID(), picture: "BigBen", date: 1854, name: "Big Ben", flavourText: "Big Ben is the iconic clock tower of the Palace of Westminster in London, officially named the Elizabeth Tower. It is known for its massive bell and neo-Gothic design.", circa: false, title: .victorian),
        HistoricItem(id: UUID(), picture: "BerlinWall", date: 1961, name: "the Berlin Wall", flavourText: "The Berlin Wall was a concrete barrier that divided East and West Berlin from 1961 to 1989, symbolizing the Cold War’s ideological divide.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "BreznevGraffiti", date: 1990, name: "“My God, Help Me...“ mural", flavourText: "The famous mural known as “My God, Help Me to Survive This Deadly Love”, showing a passionate kiss between Soviet leader Leonid Brezhnev and East German leader Erich Honecker.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "MontSaintMichel", date: 1260, name: "Mont Saint-Michel", flavourText: "Mont Saint-Michel is a medieval abbey perched on a rocky island off the coast of Normandy. It has been a site of pilgrimage for centuries.", circa: false, title: .french),
        HistoricItem(id: UUID(), picture: "TowerBridge", date: 1894, name: "Tower Bridge", flavourText: "Tower Bridge is a historic drawbridge in London across the River Thames, known for its twin towers and striking Victorian Gothic design.", circa: false, title: .victorian),
        HistoricItem(id: UUID(), picture: "Gherkin", date: 2004, name: "the Gherkin", flavourText: "The Gherkin, officially known as 30 St Mary Axe, is a distinctive glass skyscraper in London’s financial district.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "Cambridge", date: 1209, name: "the University of Cambridge", flavourText: "The University of Cambridge is one of the world’s oldest and most prestigious universities. It has been a global center of learning and research for over 800 years.", circa: false, title: .gothic),
        HistoricItem(id: UUID(), picture: "SewuTemple", date: 760, name: "Sewu Temple", flavourText: "Sewu Temple is an ancient Buddhist temple complex. Tt showcases the grandeur of early Javanese architecture and religious harmony.", circa: true, title: .asian),
        HistoricItem(id: UUID(), picture: "EmpireStateBuilding", date: 1931, name: "the Empire State Building", flavourText: "The Empire State Building is a towering Art Deco skyscraper in New York City. It was once the tallest building in the world, surpassing the Eiffel Tower.", circa: false, title: .american),
        HistoricItem(id: UUID(), picture: "ItsukushimaShrine", date: 1168, name: "Itsukushima Shrine", flavourText: "Itsukushima Shrine is a historic landmark located in Japan, famous for its iconic “floating” torii gate that appears to rise from the sea at high tide.", circa: false, title: .asian),
        HistoricItem(id: UUID(), picture: "StatueOfLiberty", date: 1876, name: "the Statue of Liberty", flavourText: "The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor, gifted by France in 1886, symbolizing freedom and democracy.", circa: false, title: .american),
        HistoricItem(id: UUID(), picture: "LaGrandPlace", date: 1695, name: "la Grand-Place", flavourText: "La Grand-Place in Brussels is a stunning central square surrounded by ornate guildhalls, the Town Hall, and the King’s House. It showcases a rich blend of Gothic and Baroque architecture.", circa: false, title: .baroque),
        HistoricItem(id: UUID(), picture: "CharlesBridge", date: 1402, name: "the Charles Bridge", flavourText: "The Charles Bridge is a historic stone bridge in Prague, spanning the Vltava River and connecting the Old Town with the Prague Castle.", circa: false, title: .gothic),
        HistoricItem(id: UUID(), picture: "DiscoveriesMonument", date: 1958, name: "the Discoveries monument", flavourText: "The Monument to the Discoveries is a sculpture on the banks of the Tagus River in Lisbon’s Belém district. It honors Portugal’s Age of Discovery.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "TorreBelem", date: 1519, name: "Torre de Belém", flavourText: "The Torre de Belém is a fortification near Lisbon, Portugal. It used to serve as a defensive structure and as a ceremonial gateway for explorers during the Age of Discoveries.", circa: false, title: .renaissance, yOffset: -0.1),
        HistoricItem(id: UUID(), picture: "MountRushmore", date: 1941, name: "Mount Rushmore", flavourText: "Mount Rushmore is a monumental granite sculpture in South Dakota, featuring the carved faces of four U.S. presidents: Washington, Jefferson, Roosevelt and Lincoln.", circa: false, title: .american),
        HistoricItem(id: UUID(), picture: "WashingtonMonument", date: 1884, name: "the Washington Monument", flavourText: "The Washington Monument is a white marble obelisk located in Washington, D.C., built to honor George Washington, the first U.S. president.", circa: false, title: .american, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "SanctuaryBomJesusDoMonte", date: 1784, name: "the Sanctuary of Bom Jesus do Monte", flavourText: "The Sanctuary of Bom Jesus do Monte, located in Braga, Portugal, is a landmark renowned for its monumental Baroque stairway and neoclassical basilica.", circa: false, title: .baroque, yOffset: 0.2),
        HistoricItem(id: UUID(), picture: "PalacioDaPena", date: 1838, name: "the Palácio da Pena", flavourText: "The Palácio Nacional da Pena is a palace in the Sintra Mountains, Portugal. The palace showcases an eclectic mix of architectural styles, reflecting the Romanticism of the era.", circa: false, title: .romantisme),
        HistoricItem(id: UUID(), picture: "HausmannHouses", date: 1853, name: "Haussmann houses", flavourText: "Haussmann houses are elegant residential buildings that define much of Paris’s architectural identity. They feature uniform façades, wrought-iron balconies, and cream-colored stone.", circa: true, title: .paris),
        HistoricItem(id: UUID(), picture: "HallOfBulls", date: -16000, name: "the Hall of Bulls", flavourText: "The Hall of Bulls in the Lascaux Cave, France, is a prehistoric cave famous for its striking Paleolithic cave paintings.", circa: false, title: .prehistoric),
        HistoricItem(id: UUID(), picture: "VenusMilo", date: -115, name: "the Venus de Milo", flavourText: "The Venus de Milo is an ancient Greek marble statue believed to represent Aphrodite, the goddess of love and beauty.", circa: true, title: .antiquity, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "Moschophoros", date: -570, name: "the Moschophoros", flavourText: "The Moschophoros, or “Calf Bearer”, is an ancient Greek statue, depicting a bearded man carrying a calf on his shoulders. It is a key example of early Archaic sculpture.", circa: true, title: .ancientArt, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "MuiredachHighCross", date: 855, name: "Muiredach’s Cross", flavourText: "Muiredach’s High Cross, located in Ireland, is a sandstone monument known for its intricate carvings. It features detailed biblical scenes from the Old and New Testaments.", circa: true, title: .medieval, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "MilesevaMonastery", date: 1234, name: "Mileševa Monastery", flavourText: "Mileševa Monastery is a Serbian Orthodox monastery. Renowned for its exquisite frescoes, it houses the famous “White Angel”, considered a masterpiece of medieval European art.", circa: false, title: .temple),
        HistoricItem(id: UUID(), picture: "CodexAureus", date: 870, name: "the Codex Aureus", flavourText: "The Codex Aureus is a lavishly illuminated medieval manuscript. With its gold ink and decorations, it exemplifies the opulence and artistry of Carolingian scriptoria.", circa: false, title: .scroll),
        HistoricItem(id: UUID(), picture: "IconChristAndAbbotMena", date: 550, name: "Christ and Abbot Mena icon", flavourText: "An early Coptic icon showing Christ alongside Abbot Mena, symbolizing spiritual companionship and divine guidance.", circa: false, title: .medieval, yOffset: 0.15),
        HistoricItem(id: UUID(), picture: "IvoryTabernacle", date: 1390, name: "the ivory tabernacle", flavourText: "A delicately carved Gothic ivory tabernacle, used to house the Eucharist, reflecting medieval religious artistry.", circa: true, title: .medieval),
        HistoricItem(id: UUID(), picture: "AztecSunStone", date: 1510, name: "the Aztec sun stone", flavourText: "The Aztec sun stone is a monumental basalt sculpture symbolizing the Aztec cosmos and calendar, richly carved with mythological figures.", circa: true, title: .artifact),
        HistoricItem(id: UUID(), picture: "LessayAbbey", date: 1080, name: "Lessay Abbey", flavourText: "A Romanesque Benedictine abbey in Normandy, known for its harmonious architecture and early use of rib vaults.", circa: false, title: .temple),
        HistoricItem(id: UUID(), picture: "MariaLaachAbbey", date: 1156, name: "Maria Laach Abbey", flavourText: "A Romanesque monastery by Lake Laach in Germany, blending spiritual function with striking architectural balance.", circa: true, title: .temple),
        HistoricItem(id: UUID(), picture: "CloistersApocalypse", date: 1330, name: "the Cloisters Apocalypse", flavourText: "An illuminated manuscript depicting vivid scenes from the Book of Revelation, held at The Cloisters in New York.", circa: true, title: .scroll, yOffset: 0.28),
        HistoricItem(id: UUID(), picture: "AnnunciationVinci", date: 1474, name: "the Annunciation painting", flavourText: "A delicate early painting of the Annunciation attributed to Leonardo da Vinci, blending clarity with subtle emotion.", circa: true, title: .renaissance),
        HistoricItem(id: UUID(), picture: "MosaicFloorDogAlexandria", date: -175, name: "the dog mosaic", flavourText: "A Hellenistic mosaic from Alexandria depicting a dog with remarkable realism, showcasing ancient Greek artistry.", circa: true, title: .antiquity),
        HistoricItem(id: UUID(), picture: "GreatTheaterOfEpidaurus", date: -320, name: "the Theater of Epidaurus", flavourText: "The Great Theater of Epidaurus is a marvel of ancient Greek architecture, famed for its perfect acoustics and elegant semicircular design.", circa: true, title: .antiquity),
        
        HistoricItem(id: UUID(), picture: "AgamemnonMask", date: -1550, name: "Agamemnon Mask", flavourText: "The Mask of Agamemnon is a gold funerary mask from Mycenae, symbolizing early Greek royal burials.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "FlatironBuilding", date: 1902, name: "еhe Flatiron Building", flavourText: "The Flatiron Building is a steel-framed skyscraper known for its triangular shape and iconic NYC status.", circa: false, title: .american, yOffset: 0.3),
        HistoricItem(id: UUID(), picture: "FrancoisCoignetHouse", date: 1855, name: "François Coignet House", flavourText: "The François Coignet House is the first building made with reinforced concrete, revolutionizing construction.", circa: false, title: .french),
        HistoricItem(id: UUID(), picture: "SuttonHooHelmet", date: 620, name: "the Sutton Hoo Helmet", flavourText: "The Sutton Hoo Helmet is a richly decorated Anglo-Saxon artifact that reveals warrior burial traditions.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "PaleoliticFlute", date: -43000, name: "the Paleolithic Flute", flavourText: "The Paleolithic Flute is one of the world’s oldest instruments, carved from bone to create early music.", circa: true, title: .prehistoric, yOffset: -0.30),
        HistoricItem(id: UUID(), picture: "Akshardham", date: 2005, name: "Akshardham", flavourText: "Akshardham is a modern Hindu temple in India, celebrated for its intricate carvings and spiritual ambiance.", circa: false, title: .modern),
        HistoricItem(id: UUID(), picture: "PiriReisMap", date: 1513, name: "Piri Reis Map", flavourText: "The Piri Reis Map is a mysterious early world map blending Ottoman geography with ancient cartographic lore.", circa: false, title: .scroll),
        HistoricItem(id: UUID(), picture: "AmbassadeursLautrec", date: 1892, name: "the Ambassadeurs poster", flavourText: "Toulouse-Lautrec’s poster for Ambassadeurs captures the vivid energy of Parisian nightlife and cabaret.", circa: false, title: .french, yOffset: 0.28),
        HistoricItem(id: UUID(), picture: "WalhallaLeoVonKlenze", date: 1842, name: "Walhalla", flavourText: "Leo von Klenze’s Walhalla is a neoclassical hall of fame, honoring Germanic heroes in grand architecture.", circa: false, title: .neoClassical),
        HistoricItem(id: UUID(), picture: "WedgwoodUrn", date: 1800, name: "Wedgwood urn", flavourText: "This Wedgwood urn reflects neoclassical elegance in ceramics, blending art, science, and industry.", circa: true, title: .neoClassical, yOffset: 0.33),
        HistoricItem(id: UUID(), picture: "MoscowStateUniversity", date: 1953, name: "Moscow State University", flavourText: "Moscow State University’s main tower is a Stalinist skyscraper blending Soviet ambition and neogothic flair.", circa: false, title: .slavic),
        HistoricItem(id: UUID(), picture: "CupidDrivingChariot", date: 1800, name: "Cupid painting", flavourText: "“Cupid Driving a Chariot Drawn by Griffins“ reflects neoclassical fascination with myth and movement.", circa: true, title: .neoClassical),
        HistoricItem(id: UUID(), picture: "MercuryPajou", date: 1780, name: "Mercury statue", flavourText: "Pajou’s Mercury is a dynamic neoclassical sculpture that captures the Roman god’s grace and swiftness.", circa: false, title: .neoClassical, yOffset: 0.61),
        HistoricItem(id: UUID(), picture: "ThreeGraces", date: 1817, name: "the Three Graces", flavourText: "The Three Graces is a sculpture celebrating beauty, charm, and creativity from classical mythology.", circa: false, title: .neoClassical, yOffset: 0.32),
        HistoricItem(id: UUID(), picture: "CorinthianHelmet", date: -500, name: "the Corinthian Helmet", flavourText: "The Corinthian Helmet, with its bold shape, reflects the martial pride of ancient Greek hoplites.", circa: true, title: .antiquity),
        HistoricItem(id: UUID(), picture: "NefertitiBust", date: -1345, name: "Nefertiti bust", flavourText: "The Bust of Nefertiti is a masterpiece of ancient Egyptian portraiture and timeless royal elegance.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "LindisfarneGospels", date: 715, name: "Lindisfarne Gospels", flavourText: "The Lindisfarne Gospels are a richly illuminated manuscript bridging Celtic art and Christian devotion.", circa: true, title: .scroll),
        HistoricItem(id: UUID(), picture: "CodexRunicus", date: 1300, name: "the Codex Runicus", flavourText: "The Codex Runicus is a medieval manuscript written in runes, preserving ancient Scandinavian law.", circa: true, title: .scroll),
        HistoricItem(id: UUID(), picture: "MycenaeanVase", date: -1100, name: "Mycenaean vase", flavourText: "This Mycenaean vase showcases early Greek pottery styles, linking utility with artistic expression.", circa: true, title: .ancientVase, yOffset: 0.05),
        HistoricItem(id: UUID(), picture: "WallsOfTroy", date: -2000, name: "the Walls of Troy", flavourText: "The Walls of Troy, steeped in myth, represent Bronze Age urban strength and epic war legends.", circa: true, title: .ancientArchi),
        HistoricItem(id: UUID(), picture: "ManesseCodex", date: 1305, name: "the Manesse Codex", flavourText: "The Manesse Codex is a vivid medieval manuscript celebrating courtly love and knightly poetry.", circa: true, title: .scroll),
        HistoricItem(id: UUID(), picture: "LewisChessmen", date: 1150, name: "the Lewis Chessmen", flavourText: "The Lewis Chessmen are medieval game pieces carved from walrus ivory, full of mystery and character.", circa: true, title: .medieval),
        HistoricItem(id: UUID(), picture: "LycurgusCup", date: 370, name: "the Lycurgus Cup", flavourText: "The Lycurgus Cup is a Roman glass marvel that changes color with light, showing ancient ”nanotech”.", circa: true, title: .antiquity, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "OsebergShip", date: 800, name: "Oseberg Ship", flavourText: "The Oseberg Ship is a beautifully preserved Viking burial vessel rich in intricate woodwork and lore.", circa: true, title: .medieval),
        HistoricItem(id: UUID(), picture: "RasTransformation", date: -350, name: "the Ra inlay", flavourText: "This ancient Egyptian inlay depicting the squatting god Ra is a decorative element often made of colored stone, glass, or faience.", circa: true, title: .ancientArt),
        HistoricItem(id: UUID(), picture: "VenusHohleFels", date: -40000, name: "Venus of Hohle Fels", flavourText: "The Venus of Hohle Fels is one of the oldest known figurines, symbolizing fertility and early art.", circa: true, title: .prehistoric, yOffset: 0.29),
        HistoricItem(id: UUID(), picture: "GavleGoat", date: 2011, name: "the Gävle Goat", flavourText: "The Gävle Goat is a Swedish holiday tradition often targeted by arson in a bizarre festive ritual.", circa: false, title: .modern, yOffset: 0.2)
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
