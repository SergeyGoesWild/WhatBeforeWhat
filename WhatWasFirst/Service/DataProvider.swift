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
    
    init() {}
    
    private var prevIndex1: Int?
    private var prevIndex2: Int?
    
    let data: [HistoricItem] = [
        HistoricItem(id: UUID(), picture: "HandsCave", date: -25000, name: DBStrings.string("HandsCave.name"), flavourText: DBStrings.string("HandsCave.text"), circa: true, title: .prehistoric, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "BlackSquare", date: 1915, name: DBStrings.string("BlackSquare.name"), flavourText: DBStrings.string("BlackSquare.text"), circa: false, title: .avantgarde, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "ElCastillo", date: 1100, name: DBStrings.string("ElCastillo.name"), flavourText: DBStrings.string("ElCastillo.text"), circa: true, title: .temple, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "MonaLisa", date: 1506, name: DBStrings.string("MonaLisa.name"), flavourText: DBStrings.string("MonaLisa.text"), circa: false, title: .renaissance, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "NotreDameDeParis", date: 1345, name: DBStrings.string("NotreDameDeParis.name"), flavourText: DBStrings.string("NotreDameDeParis.text"), circa: false, title: .gothic, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "ParthenonAthens", date: -432, name: DBStrings.string("ParthenonAthens.name"), flavourText: DBStrings.string("ParthenonAthens.text"), circa: true, title: .antiquity, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "SacreCoeur", date: 1923, name: DBStrings.string("SacreCoeur.name"), flavourText: DBStrings.string("SacreCoeur.text"), circa: false, title: .paris, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "SantaMariaDelFiore", date: 1436, name: DBStrings.string("SantaMariaDelFiore.name"), flavourText: DBStrings.string("SantaMariaDelFiore.text"), circa: false, title: .renaissance, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "StarryNight", date: 1889, name: DBStrings.string("StarryNight.name"), flavourText: DBStrings.string("StarryNight.text"), circa: false, title: .impressionisme, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "GreatWaveOffKanagawa", date: 1831, name: DBStrings.string("GreatWaveOffKanagawa.name"), flavourText: DBStrings.string("GreatWaveOffKanagawa.text"), circa: false, title: .asian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "GirlPearlEarring", date: 1665, name: DBStrings.string("GirlPearlEarring.name"), flavourText: DBStrings.string("GirlPearlEarring.text"), circa: false, title: .dutch, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "TheScream", date: 1893, name: DBStrings.string("TheScream.name"), flavourText: DBStrings.string("TheScream.text"), circa: false, title: .avantgarde, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "Petra", date: 40, name: DBStrings.string("Petra.name"), flavourText: DBStrings.string("Petra.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "EiffelTower", date: 1889, name: DBStrings.string("EiffelTower.name"), flavourText: DBStrings.string("EiffelTower.text"), circa: false, title: .paris, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "Colosseum", date: 80, name: DBStrings.string("Colosseum.name"), flavourText: DBStrings.string("Colosseum.text"), circa: false, title: .antiquity, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "TajMahal", date: 1631, name: DBStrings.string("TajMahal.name"), flavourText: DBStrings.string("TajMahal.text"), circa: false, title: .indian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "SaintBasilCathedral", date: 1555, name: DBStrings.string("SaintBasilCathedral.name"), flavourText: DBStrings.string("SaintBasilCathedral.text"), circa: false, title: .slavic, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "BurjKhalifa", date: 2004, name: DBStrings.string("BurjKhalifa.name"), flavourText: DBStrings.string("BurjKhalifa.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "CasaMila", date: 1906, name: DBStrings.string("CasaMila.name"), flavourText: DBStrings.string("CasaMila.text"), circa: false, title: .avantgarde, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "TowerOfPisa", date: 1372, name: DBStrings.string("TowerOfPisa.name"), flavourText: DBStrings.string("TowerOfPisa.text"), circa: false, title: .renaissance, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "SagradaFamilia", date: 1882, name: DBStrings.string("SagradaFamilia.name"), flavourText: DBStrings.string("SagradaFamilia.text"), circa: false, title: .avantgarde, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "DancingHouse", date: 1996, name: DBStrings.string("DancingHouse.name"), flavourText: DBStrings.string("DancingHouse.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "WhiteHouse", date: 1800, name: DBStrings.string("WhiteHouse.name"), flavourText: DBStrings.string("WhiteHouse.text"), circa: false, title: .american, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "MaskOfTutankhamun", date: -1323, name: DBStrings.string("MaskOfTutankhamun.name"), flavourText: DBStrings.string("MaskOfTutankhamun.text"), circa: true, title: .ancientVase, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "SydneyOperaHouse", date: 1973, name: DBStrings.string("SydneyOperaHouse.name"), flavourText: DBStrings.string("SydneyOperaHouse.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "RosettaStone", date: -196, name: DBStrings.string("RosettaStone.name"), flavourText: DBStrings.string("RosettaStone.text"), circa: true, title: .artifact, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "Stonehenge", date: -2500, name: DBStrings.string("Stonehenge.name"), flavourText: DBStrings.string("Stonehenge.text"), circa: true, title: .ancientArchi, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "Moai", date: 1250, name: DBStrings.string("Moai.name"), flavourText: DBStrings.string("Moai.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "TerracottaArmy", date: -210, name: DBStrings.string("TerracottaArmy.name"), flavourText: DBStrings.string("TerracottaArmy.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "OlmecColossalHeads", date: -900, name: DBStrings.string("OlmecColossalHeads.name"), flavourText: DBStrings.string("OlmecColossalHeads.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "DanseusesBleues", date: 1897, name: DBStrings.string("DanseusesBleues.name"), flavourText: DBStrings.string("DanseusesBleues.text"), circa: false, title: .impressionisme, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "AmericanGothic", date: 1930, name: DBStrings.string("AmericanGothic.name"), flavourText: DBStrings.string("AmericanGothic.text"), circa: false, title: .american, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "Nighthawks", date: 1942, name: DBStrings.string("Nighthawks.name"), flavourText: DBStrings.string("Nighthawks.text"), circa: false, title: .american, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "DimancheApresMidiIleGrandeJatte", date: 1884, name: DBStrings.string("DimancheApresMidiIleGrandeJatte.name"), flavourText: DBStrings.string("DimancheApresMidiIleGrandeJatte.text"), circa: false, title: .point, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "VoyageurContemplantUneMerDeNuages", date: 1818, name: DBStrings.string("VoyageurContemplantUneMerDeNuages.name"), flavourText: DBStrings.string("VoyageurContemplantUneMerDeNuages.text"), circa: false, title: .romantisme, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "NinthWave", date: 1850, name: DBStrings.string("NinthWave.name"), flavourText: DBStrings.string("NinthWave.text"), circa: false, title: .romantisme, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "LibertyLeadingThePeople", date: 1830, name: DBStrings.string("LibertyLeadingThePeople.name"), flavourText: DBStrings.string("LibertyLeadingThePeople.text"), circa: false, title: .romantisme, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "NightWatch", date: 1642, name: DBStrings.string("NightWatch.name"), flavourText: DBStrings.string("NightWatch.text"), circa: false, title: .dutch, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "ThePersistenceOfMemory", date: 1931, name: DBStrings.string("ThePersistenceOfMemory.name"), flavourText: DBStrings.string("ThePersistenceOfMemory.text"), circa: false, title: .avantgarde, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "GreatWallOfChina", date: -220, name: DBStrings.string("GreatWallOfChina.name"), flavourText: DBStrings.string("GreatWallOfChina.text"), circa: true, title: .ancientArchi, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "BorgundStaveChurch", date: 1200, name: DBStrings.string("BorgundStaveChurch.name"), flavourText: DBStrings.string("BorgundStaveChurch.text"), circa: true, title: .medieval, yOffset: -0.1),
        HistoricItem(id: UUID(), picture: "HimejiCastle", date: 1333, name: DBStrings.string("HimejiCastle.name"), flavourText: DBStrings.string("HimejiCastle.text"), circa: false, title: .asian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "NeuschwansteinCastle", date: 1869, name: DBStrings.string("NeuschwansteinCastle.name"), flavourText: DBStrings.string("NeuschwansteinCastle.text"), circa: false, title: .romantisme, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "TempleOfHeaven", date: 1406, name: DBStrings.string("TempleOfHeaven.name"), flavourText: DBStrings.string("TempleOfHeaven.text"), circa: true, title: .asian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "RadeauDeLaMeduse", date: 1818, name: DBStrings.string("RadeauDeLaMeduse.name"), flavourText: DBStrings.string("RadeauDeLaMeduse.text"), circa: false, title: .french, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "HuntersInTheSnow", date: 1565, name: DBStrings.string("HuntersInTheSnow.name"), flavourText: DBStrings.string("HuntersInTheSnow.text"), circa: false, title: .renaissance, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "Bogolyubovo", date: 1158, name: DBStrings.string("Bogolyubovo.name"), flavourText: DBStrings.string("Bogolyubovo.text"), circa: true, title: .slavic, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "Louvre", date: 1989, name: DBStrings.string("Louvre.name"), flavourText: DBStrings.string("Louvre.text"), circa: false, title: .paris, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "BigBen", date: 1854, name: DBStrings.string("BigBen.name"), flavourText: DBStrings.string("BigBen.text"), circa: false, title: .victorian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "BerlinWall", date: 1961, name: DBStrings.string("BerlinWall.name"), flavourText: DBStrings.string("BerlinWall.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "BreznevGraffiti", date: 1990, name: DBStrings.string("BreznevGraffiti.name"), flavourText: DBStrings.string("BreznevGraffiti.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "MontSaintMichel", date: 1260, name: DBStrings.string("MontSaintMichel.name"), flavourText: DBStrings.string("MontSaintMichel.text"), circa: false, title: .french, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "TowerBridge", date: 1894, name: DBStrings.string("TowerBridge.name"), flavourText: DBStrings.string("TowerBridge.text"), circa: false, title: .victorian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "Gherkin", date: 2004, name: DBStrings.string("Gherkin.name"), flavourText: DBStrings.string("Gherkin.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "Cambridge", date: 1209, name: DBStrings.string("Cambridge.name"), flavourText: DBStrings.string("Cambridge.text"), circa: false, title: .gothic, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "SewuTemple", date: 760, name: DBStrings.string("SewuTemple.name"), flavourText: DBStrings.string("SewuTemple.text"), circa: true, title: .asian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "EmpireStateBuilding", date: 1931, name: DBStrings.string("EmpireStateBuilding.name"), flavourText: DBStrings.string("EmpireStateBuilding.text"), circa: false, title: .american, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "ItsukushimaShrine", date: 1168, name: DBStrings.string("ItsukushimaShrine.name"), flavourText: DBStrings.string("ItsukushimaShrine.text"), circa: false, title: .asian, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "StatueOfLiberty", date: 1876, name: DBStrings.string("StatueOfLiberty.name"), flavourText: DBStrings.string("StatueOfLiberty.text"), circa: false, title: .american, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "LaGrandPlace", date: 1695, name: DBStrings.string("LaGrandPlace.name"), flavourText: DBStrings.string("LaGrandPlace.text"), circa: false, title: .baroque, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "CharlesBridge", date: 1402, name: DBStrings.string("CharlesBridge.name"), flavourText: DBStrings.string("CharlesBridge.text"), circa: false, title: .gothic, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "DiscoveriesMonument", date: 1958, name: DBStrings.string("DiscoveriesMonument.name"), flavourText: DBStrings.string("DiscoveriesMonument.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "TorreBelem", date: 1519, name: DBStrings.string("TorreBelem.name"), flavourText: DBStrings.string("TorreBelem.text"), circa: false, title: .renaissance, yOffset: -0.1),
        HistoricItem(id: UUID(), picture: "MountRushmore", date: 1941, name: DBStrings.string("MountRushmore.name"), flavourText: DBStrings.string("MountRushmore.text"), circa: false, title: .american, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "WashingtonMonument", date: 1884, name: DBStrings.string("WashingtonMonument.name"), flavourText: DBStrings.string("WashingtonMonument.text"), circa: false, title: .american, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "SanctuaryBomJesusDoMonte", date: 1784, name: DBStrings.string("SanctuaryBomJesusDoMonte.name"), flavourText: DBStrings.string("SanctuaryBomJesusDoMonte.text"), circa: false, title: .baroque, yOffset: 0.2),
        HistoricItem(id: UUID(), picture: "PalacioDaPena", date: 1838, name: DBStrings.string("PalacioDaPena.name"), flavourText: DBStrings.string("PalacioDaPena.text"), circa: false, title: .romantisme, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "HausmannHouses", date: 1853, name: DBStrings.string("HausmannHouses.name"), flavourText: DBStrings.string("HausmannHouses.text"), circa: true, title: .paris, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "HallOfBulls", date: -16000, name: DBStrings.string("HallOfBulls.name"), flavourText: DBStrings.string("HallOfBulls.text"), circa: false, title: .prehistoric, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "VenusMilo", date: -115, name: DBStrings.string("VenusMilo.name"), flavourText: DBStrings.string("VenusMilo.text"), circa: true, title: .antiquity, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "Moschophoros", date: -570, name: DBStrings.string("Moschophoros.name"), flavourText: DBStrings.string("Moschophoros.text"), circa: true, title: .ancientArt, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "MuiredachHighCross", date: 855, name: DBStrings.string("MuiredachHighCross.name"), flavourText: DBStrings.string("MuiredachHighCross.text"), circa: true, title: .medieval, yOffset: 0.1),
        HistoricItem(id: UUID(), picture: "MilesevaMonastery", date: 1234, name: DBStrings.string("MilesevaMonastery.name"), flavourText: DBStrings.string("MilesevaMonastery.text"), circa: false, title: .temple, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "CodexAureus", date: 870, name: DBStrings.string("CodexAureus.name"), flavourText: DBStrings.string("CodexAureus.text"), circa: false, title: .scroll, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "IconChristAndAbbotMena", date: 550, name: DBStrings.string("IconChristAndAbbotMena.name"), flavourText: DBStrings.string("IconChristAndAbbotMena.text"), circa: false, title: .medieval, yOffset: 0.15),
        HistoricItem(id: UUID(), picture: "IvoryTabernacle", date: 1390, name: DBStrings.string("IvoryTabernacle.name"), flavourText: DBStrings.string("IvoryTabernacle.text"), circa: true, title: .medieval, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "AztecSunStone", date: 1510, name: DBStrings.string("AztecSunStone.name"), flavourText: DBStrings.string("AztecSunStone.text"), circa: true, title: .artifact, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "LessayAbbey", date: 1080, name: DBStrings.string("LessayAbbey.name"), flavourText: DBStrings.string("LessayAbbey.text"), circa: false, title: .temple, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "MariaLaachAbbey", date: 1156, name: DBStrings.string("MariaLaachAbbey.name"), flavourText: DBStrings.string("MariaLaachAbbey.text"), circa: true, title: .temple, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "CloistersApocalypse", date: 1330, name: DBStrings.string("CloistersApocalypse.name"), flavourText: DBStrings.string("CloistersApocalypse.text"), circa: true, title: .scroll, yOffset: 0.28),
        HistoricItem(id: UUID(), picture: "AnnunciationVinci", date: 1474, name: DBStrings.string("AnnunciationVinci.name"), flavourText: DBStrings.string("AnnunciationVinci.text"), circa: true, title: .renaissance, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "MosaicFloorDogAlexandria", date: -175, name: DBStrings.string("MosaicFloorDogAlexandria.name"), flavourText: DBStrings.string("MosaicFloorDogAlexandria.text"), circa: true, title: .antiquity, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "GreatTheaterOfEpidaurus", date: -320, name: DBStrings.string("GreatTheaterOfEpidaurus.name"), flavourText: DBStrings.string("GreatTheaterOfEpidaurus.text"), circa: true, title: .antiquity, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "AgamemnonMask", date: -1550, name: DBStrings.string("AgamemnonMask.name"), flavourText: DBStrings.string("AgamemnonMask.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "FlatironBuilding", date: 1902, name: DBStrings.string("FlatironBuilding.name"), flavourText: DBStrings.string("FlatironBuilding.text"), circa: false, title: .american, yOffset: 0.3),
        HistoricItem(id: UUID(), picture: "FrancoisCoignetHouse", date: 1855, name: DBStrings.string("FrancoisCoignetHouse.name"), flavourText: DBStrings.string("FrancoisCoignetHouse.text"), circa: false, title: .french, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "SuttonHooHelmet", date: 620, name: DBStrings.string("SuttonHooHelmet.name"), flavourText: DBStrings.string("SuttonHooHelmet.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "PaleoliticFlute", date: -43000, name: DBStrings.string("PaleoliticFlute.name"), flavourText: DBStrings.string("PaleoliticFlute.text"), circa: true, title: .prehistoric, yOffset: -0.3),
        HistoricItem(id: UUID(), picture: "Akshardham", date: 2005, name: DBStrings.string("Akshardham.name"), flavourText: DBStrings.string("Akshardham.text"), circa: false, title: .modern, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "PiriReisMap", date: 1513, name: DBStrings.string("PiriReisMap.name"), flavourText: DBStrings.string("PiriReisMap.text"), circa: false, title: .scroll, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "AmbassadeursLautrec", date: 1892, name: DBStrings.string("AmbassadeursLautrec.name"), flavourText: DBStrings.string("AmbassadeursLautrec.text"), circa: false, title: .french, yOffset: 0.28),
        HistoricItem(id: UUID(), picture: "WalhallaLeoVonKlenze", date: 1842, name: DBStrings.string("WalhallaLeoVonKlenze.name"), flavourText: DBStrings.string("WalhallaLeoVonKlenze.text"), circa: false, title: .neoClassical, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "WedgwoodUrn", date: 1800, name: DBStrings.string("WedgwoodUrn.name"), flavourText: DBStrings.string("WedgwoodUrn.text"), circa: true, title: .neoClassical, yOffset: 0.33),
        HistoricItem(id: UUID(), picture: "MoscowStateUniversity", date: 1953, name: DBStrings.string("MoscowStateUniversity.name"), flavourText: DBStrings.string("MoscowStateUniversity.text"), circa: false, title: .slavic, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "CupidDrivingChariot", date: 1800, name: DBStrings.string("CupidDrivingChariot.name"), flavourText: DBStrings.string("CupidDrivingChariot.text"), circa: true, title: .neoClassical, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "MercuryPajou", date: 1780, name: DBStrings.string("MercuryPajou.name"), flavourText: DBStrings.string("MercuryPajou.text"), circa: false, title: .neoClassical, yOffset: 0.61),
        HistoricItem(id: UUID(), picture: "ThreeGraces", date: 1817, name: DBStrings.string("ThreeGraces.name"), flavourText: DBStrings.string("ThreeGraces.text"), circa: false, title: .neoClassical, yOffset: 0.32),
        HistoricItem(id: UUID(), picture: "CorinthianHelmet", date: -500, name: DBStrings.string("CorinthianHelmet.name"), flavourText: DBStrings.string("CorinthianHelmet.text"), circa: true, title: .antiquity, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "NefertitiBust", date: -1345, name: DBStrings.string("NefertitiBust.name"), flavourText: DBStrings.string("NefertitiBust.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "LindisfarneGospels", date: 715, name: DBStrings.string("LindisfarneGospels.name"), flavourText: DBStrings.string("LindisfarneGospels.text"), circa: true, title: .scroll, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "CodexRunicus", date: 1300, name: DBStrings.string("CodexRunicus.name"), flavourText: DBStrings.string("CodexRunicus.text"), circa: true, title: .scroll, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "MycenaeanVase", date: -1100, name: DBStrings.string("MycenaeanVase.name"), flavourText: DBStrings.string("MycenaeanVase.text"), circa: true, title: .ancientVase, yOffset: 0.05),
        HistoricItem(id: UUID(), picture: "WallsOfTroy", date: -2000, name: DBStrings.string("WallsOfTroy.name"), flavourText: DBStrings.string("WallsOfTroy.text"), circa: true, title: .ancientArchi, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "ManesseCodex", date: 1305, name: DBStrings.string("ManesseCodex.name"), flavourText: DBStrings.string("ManesseCodex.text"), circa: true, title: .scroll, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "LewisChessmen", date: 1150, name: DBStrings.string("LewisChessmen.name"), flavourText: DBStrings.string("LewisChessmen.text"), circa: true, title: .medieval, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "LycurgusCup", date: 370, name: DBStrings.string("LycurgusCup.name"), flavourText: DBStrings.string("LycurgusCup.text"), circa: true, title: .antiquity, yOffset: 0.25),
        HistoricItem(id: UUID(), picture: "OsebergShip", date: 800, name: DBStrings.string("OsebergShip.name"), flavourText: DBStrings.string("OsebergShip.text"), circa: true, title: .medieval, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "RasTransformation", date: -350, name: DBStrings.string("RasTransformation.name"), flavourText: DBStrings.string("RasTransformation.text"), circa: true, title: .ancientArt, yOffset: 0.0),
        HistoricItem(id: UUID(), picture: "VenusHohleFels", date: -40000, name: DBStrings.string("VenusHohleFels.name"), flavourText: DBStrings.string("VenusHohleFels.text"), circa: true, title: .prehistoric, yOffset: 0.29),
        HistoricItem(id: UUID(), picture: "GavleGoat", date: 2011, name: DBStrings.string("GavleGoat.name"), flavourText: DBStrings.string("GavleGoat.text"), circa: false, title: .modern, yOffset: 0.2),
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
