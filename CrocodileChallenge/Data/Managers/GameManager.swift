//
//  GameManager.swift
//  CrocodileChallenge
//
//  Created by Владислав Резник on 20.04.2023.
//

import Foundation

class GameManager {
    
    static let shared = GameManager()
    
    private init() {}
    
    private var currentTeam = Team.getTeam()[0]
    private var nextTeam = Team.getTeam()[1]
    private var currentCategory = Category.getCategories()[0]
    private var numberOfRounds = 10
    
    func getCurrentTeam() -> Team {
        return currentTeam
    }
    
    func getNextTeam() -> Team {
        return nextTeam
    }
    
    func getCurrentCategory() -> Category {
        return currentCategory
    }
    
    func getRound() -> Int {
        return numberOfRounds
    }
    
    func setCategory(_ category: Category) {
        currentCategory = category
    }
    
    func nextMove() {
        numberOfRounds -= 1
        let temp = currentTeam
        currentTeam = nextTeam
        nextTeam = temp
    }
    
    func addScore() {
        currentTeam.addScore()
    }
    
    func getCurrentTeamScore() -> Int {
        return currentTeam.score
    }
    
    func getNextTeamScore() -> Int {
        return nextTeam.score
    }
    
    func reset() {
        numberOfRounds = 5
        currentTeam = Team.getTeam()[0]
        nextTeam = Team.getTeam()[1]
        currentCategory = Category.getCategories()[0]
        currentTeam.score = 0
        nextTeam.score = 0
    }
}
