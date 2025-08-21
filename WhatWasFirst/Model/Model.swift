//
//  Model.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 18/08/2025.
//

enum ButtonOutcome {
    case gameEnded(title: String, answer: HistoricItem?)
    case newRound(current: HistoricItem, next: HistoricItem)
}

final class Model {
    
    private let totalRounds: Int = 10
    private var currentRound: Int = 0
    private var currentScore: Int = 0
    private var rightAnswer: HistoricItem?
    private var rightAnswers: [HistoricItem] = []
    private var lastRound: Bool {
        currentRound == totalRounds
    }
    
    private let titleFactory: TitleFactory
    private let dataProvider: DataProvider
    
    init(titleFactory: TitleFactory, dataProvider: DataProvider) {
        self.titleFactory = titleFactory
        self.dataProvider = dataProvider
    }
    
    func imageAction(guessedRight answer: Bool) {
        checkResult(guessedRight: answer)
    }
    
    func confirmAction() -> ButtonOutcome {
        if lastRound {
            let result = getAlertText()
            let alertTitle = result.0
            let chosenAnswer = result.1
            return .gameEnded(title: alertTitle, answer: chosenAnswer)
        } else {
            let items = generateHistoricItems()
            return .newRound(current: items.0, next: items.1)
        }
    }
    
    func alertAction() -> (HistoricItem, HistoricItem) {
        return restartGame()
    }
    
//    --------------------------------------------------
    
    
    private func startNewRound() -> (HistoricItem, HistoricItem) {
        return generateHistoricItems()
    }
    
    private func checkResult(guessedRight answer: Bool) {
        if answer {
            currentScore += 1
            guard let rightAnswer = rightAnswer else { return }
            rightAnswers.append(rightAnswer)
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
        currentRound = 0
        currentScore = 0
        rightAnswers = []
    }
    
    private func generateHistoricItems() -> (HistoricItem, HistoricItem) {
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
    
//    private func getLevelCounter() -> String {
//        return "1/10"
//    }
//    
//    private func getButtonTitle() -> String {
//        return "Tap me!"
//    }
}
