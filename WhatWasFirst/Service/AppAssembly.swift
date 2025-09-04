//
//  AppAssembly.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 04/09/2025.
//

import UIKit

final class AppAssembly {
    private let titleFactory: TitleFactory
    private let dataProvider: DataProvider
    private let gameModel: GameModel
    
    init() {
        self.titleFactory = TitleFactory()
        self.dataProvider = DataProvider()
        self.gameModel = GameModel(titleFactory: self.titleFactory, dataProvider: self.dataProvider)
    }
    
    func wireComponents() -> UIViewController {
        let gameVC = GameVC(model: gameModel)
        return gameVC
    }
}
