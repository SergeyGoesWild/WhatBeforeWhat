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
    func startNewRound()
}

enum ButtonText: String {
    case next
    case finish
    
    var localized: String {
        switch self {
        case .next: return UIStrings.string("UI.nextButton")
        case .finish: return UIStrings.string("UI.endButton")
        }
    }
}

struct GameState {
    var currentRound: Int
    let totalRounds: Int
    var currentScore: Int
    var buttonText: String
}

struct SharedItem {
    var item: HistoricItem
    var rightAnswer: Bool
}

final class GameModel: GameModelProtocol {
    
    private var gameState: GameState {
        didSet {
            onStateChange?(gameState)
        }
    }
    
    private let totalRounds: Int = 2
    private var rightAnswer: HistoricItem?
    private var rightAnswers: [HistoricItem] = []
    
    private let titleFactory: TitleFactory
    private let dataProvider: DataProvider
    
    var onStateChange: ((GameState) -> Void)?
    var onNewRound: ((SharedItem, SharedItem) -> Void)?
    var onEndGame: ((Int, Int, String, HistoricItem?) -> Void)?
    
    init(titleFactory: TitleFactory, dataProvider: DataProvider) {
        self.titleFactory = titleFactory
        self.dataProvider = dataProvider
        gameState = GameState(currentRound: 0, totalRounds: totalRounds, currentScore: 0, buttonText: ButtonText.next.localized)
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
            startNewRound()
        }
    }
    
    func alertOkAction() {
        resetStats()
        startNewRound()
    }
    
    func startNewRound() {
        gameState.currentRound += 1
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
            gameState.buttonText = ButtonText.finish.localized
        } else {
            gameState.buttonText = ButtonText.next.localized
        }
    }
    
    private func resetStats() {
        // The lastRound parameter is left on TRUE intentionally to keep the "Finish" button text, while the button plays the animation. It will switch to false on the next click on any image.
        gameState = GameState(currentRound: 0, totalRounds: totalRounds, currentScore: 0, buttonText: ButtonText.finish.localized)
        rightAnswers = []
    }
    
    private func generateHistoricItems() -> (SharedItem, SharedItem) {
        let items = dataProvider.provideItems()
        if items.0.date < items.1.date {
            rightAnswer = items.0
            return (SharedItem(item: items.0, rightAnswer: true), SharedItem(item: items.1, rightAnswer: false))
        } else {
            rightAnswer = items.1
            return (SharedItem(item: items.0, rightAnswer: false), SharedItem(item: items.1, rightAnswer: true))
        }
    }
    
    private func getAlertText() -> (String, HistoricItem?) {
        return titleFactory.makeTitle(with: rightAnswers)
    }
}
