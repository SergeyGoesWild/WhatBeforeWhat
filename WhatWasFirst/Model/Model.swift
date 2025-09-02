//
//  Model.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 18/08/2025.
//

struct GameState {
    var currentRound: Int
    let totalRounds: Int
    var currentScore: Int
    var lastRound: Bool
}

enum ButtonOutcome {
    case gameEnded(title: String, answer: HistoricItem?)
    case newRound(item01: HistoricItem, item02: HistoricItem)
}

final class Model {
    
    private var gameState: GameState
    private let totalRounds: Int = 10
    
    private var rightAnswer: HistoricItem?
    private var rightAnswers: [HistoricItem] = []
    
    let titleFactory: TitleFactory
    let dataProvider: DataProvider
    
    init(titleFactory: TitleFactory, dataProvider: DataProvider) {
        self.titleFactory = titleFactory
        self.dataProvider = dataProvider
        gameState = GameState(currentRound: 1, totalRounds: totalRounds, currentScore: 0, lastRound: false)
    }
    
    func checkAction(guessedRight answer: Bool) {
        checkResult(guessedRight: answer)
        checkLastRound()
    }
    
    func nextStepAction() -> ButtonOutcome {
        if gameState.lastRound {
            let result = getAlertText()
            let alertTitle = result.0
            let chosenAnswer = result.1
            return .gameEnded(title: alertTitle, answer: chosenAnswer)
        } else {
            let items = generateHistoricItems()
            gameState.currentRound += 1
            return .newRound(item01: items.0, item02: items.1)
        }
    }
    
    func alertOkAction() -> (HistoricItem, HistoricItem) {
        return restartGame()
    }
    
    func shareState() -> GameState {
        print("GAME STATE: \(gameState)")
        return gameState
    }
    
//    --------------------------------------------------
    
    private func startNewRound() -> (HistoricItem, HistoricItem) {
        return generateHistoricItems()
    }
    
    private func checkResult(guessedRight answer: Bool) {
        if answer {
            gameState.currentScore += 1
            guard let rightAnswer = rightAnswer else { return }
            rightAnswers.append(rightAnswer)
        }
    }
    
    private func checkLastRound() {
        if gameState.currentRound == totalRounds {
            gameState.lastRound = true
        }
    }
    
    private func endGame() -> (String, HistoricItem?) {
        return getAlertText()
    }
    
    private func restartGame() -> (HistoricItem, HistoricItem){
        resetStats()
        return startNewRound()
    }
    
    private func resetStats() {
        gameState = GameState(currentRound: 1, totalRounds: totalRounds, currentScore: 0, lastRound: false)
        rightAnswers = []
    }
    
    func generateHistoricItems() -> (HistoricItem, HistoricItem) {
        let items = dataProvider.provideItems()
        if items.0.date < items.1.date {
            rightAnswer = items.0
        } else {
            rightAnswer = items.1
        }
        return items
    }
    
    private func getAlertText() -> (String, HistoricItem?) {
        return titleFactory.makeTitle(with: rightAnswers)
    }
}
