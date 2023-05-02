//
//  Team.swift
//  CrocodileChallenge
//
//  Created by Владислав Резник on 19.04.2023.
//

import Foundation

struct Team {
    let avatar: String
    let name: String
    var score: Int = 0
    
    static func getTeam() -> [Team] {
        return [
            Team(avatar: Resources.Images.cowboy, name: "Ковбои"),
            Team(avatar: Resources.Images.burger, name: "Стройняшки")
            ]
    }
    
    mutating func addScore() {
        self.score += 1
    }
}
