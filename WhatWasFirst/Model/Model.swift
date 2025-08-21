//
//  Model.swift
//  WhatWasFirst
//
//  Created by Sergey Telnov on 18/08/2025.
//

final class Model {
    func onClickImage() {
        checkResult()
    }
    
    func onClickButton() {
        if lastRound {
            endGame()
        } else {
            startNewRound()
        }
    }
    
    func onClickAlert() {
        restartGame()
    }
    
    
    
    
    private func startNewRound() {
        generateHistoricItems()
    }
    
    private func checkResult() {
        
    }
    
    private func endGame() -> String {
        return getAlertText()
    }
    
    private func restartGame() {
        resetStats()
        startNewRound()
    }
    
    private func resetStats() {
        
    }
    
    private func generateHistoricItems() {
        
    }
    
    private func getLevelCounter() -> String {
        return "1/10"
    }
    
    private func getButtonTitle() -> String {
        return "Tap me!"
    }
    
    private func getAlertText() -> String {
        return "Hello, World!"
    }
}
