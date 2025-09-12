//
//  GameModel.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 18/08/2025.
//

enum ButtonText: String {
    case next = "Next"
    case finish = "Finish"
}

struct GameState {
    var currentRound: Int
    let totalRounds: Int
    var currentScore: Int
    var buttonText: ButtonText
}

enum ButtonOutcome {
    case gameEnded(title: String, answer: HistoricItem?)
    case newRound(item01: HistoricItem, item02: HistoricItem)
}

final class GameModel {
    
    private var gameState: GameState {
        didSet { onStateChange?(gameState) }
    }
    
    private let totalRounds: Int = 10
    private var rightAnswer: HistoricItem?
    private var rightAnswers: [HistoricItem] = []
    
    private let titleFactory: TitleFactory
    private let dataProvider: DataProvider
    
    var onStateChange: ((GameState) -> Void)?
    
    init(titleFactory: TitleFactory, dataProvider: DataProvider) {
        self.titleFactory = titleFactory
        self.dataProvider = dataProvider
        gameState = GameState(currentRound: 1, totalRounds: totalRounds, currentScore: 0, buttonText: .next)
    }
    
    func checkAction(guessedRight answer: Bool) {
        checkResult(guessedRight: answer)
        checkLastRound()
    }
    
    func nextStepAction() -> ButtonOutcome {
        if gameState.buttonText {
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
        return gameState
    }
    
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
            gameState.buttonText = .finish
        } else {
            gameState.buttonText = .next
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
        // The lastRound parameter is left on TRUE intentionally to keep the "Finish" button text, while the button plays the animation. It will switch to false on the next click on any image.
        gameState = GameState(currentRound: 1, totalRounds: totalRounds, currentScore: 0, buttonText: .finish)
        rightAnswers = []
    }
    
    private func generateHistoricItems() -> (HistoricItem, HistoricItem) {
        // TODO: remove the check in VC
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
