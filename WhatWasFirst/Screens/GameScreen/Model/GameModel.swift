//
//  GameModel.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 18/08/2025.
//

protocol GameModelProtocol: AnyObject {
    func checkAction(guessedRight answer: Bool)
    func nextStepAction()
    func alertOkAction()
}


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

final class GameModel: GameModelProtocol {
    
    private var gameState: GameState {
        didSet { onStateChange?(gameState) }
    }
    
    private let totalRounds: Int = 10
    private var rightAnswer: HistoricItem?
    private var rightAnswers: [HistoricItem] = []
    
    private let titleFactory: TitleFactory
    private let dataProvider: DataProvider
    
    var onStateChange: ((GameState) -> Void)?
    var onNewRound: ((HistoricItem, HistoricItem) -> Void)?
    var onEndGame: ((Int, Int, String, HistoricItem?) -> Void)?
    
    init(titleFactory: TitleFactory, dataProvider: DataProvider) {
        self.titleFactory = titleFactory
        self.dataProvider = dataProvider
        gameState = GameState(currentRound: 1, totalRounds: totalRounds, currentScore: 0, buttonText: .next)
    }
    
    func checkAction(guessedRight answer: Bool) {
        checkResult(guessedRight: answer)
        checkLastRound()
    }
    
    func nextStepAction() {
        if gameState.currentRound == totalRounds {
            let result = getAlertText()
            let alertTitle = result.0
            let chosenAnswer = result.1
            onEndGame?(gameState.currentScore, gameState.totalRounds, alertTitle, chosenAnswer)
        } else {
            gameState.currentRound += 1
            let items = generateHistoricItems()
            onNewRound?(items.0, items.1)
        }
    }
    
    func alertOkAction() {
        resetStats()
        let items = generateHistoricItems()
        onNewRound?(items.0, items.1)
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
