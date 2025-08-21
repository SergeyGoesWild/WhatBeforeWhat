//
//  ScoreTracker.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 23/07/2025.
//

final class ScoreTracker {
    static let shared = ScoreTracker()
    private init() {}
    
    var score: Int = 0
    var correctAnswers: [HistoricItem] = []
    
    func sendData(withID id: String, topElementData: HistoricItem, bottomElementData: HistoricItem) {
        if (id == "top" && topElementData.date < bottomElementData.date) {
            correctAnswers.append(topElementData)
            score += 1
        } else if (id == "bottom" && bottomElementData.date < topElementData.date) {
            correctAnswers.append(bottomElementData)
            score += 1
        }
    }
    
    func getScore() -> (Int, [HistoricItem]) {
        let scoreToReturn = score
        let answersToReturn = correctAnswers
        resetScoreTracker()
        return (scoreToReturn, answersToReturn)
    }
    
    private func resetScoreTracker() {
        score = 0
        correctAnswers.removeAll()
    }
}
