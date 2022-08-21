//
//  GameOverState.swift
//  XO-game
//
//  Created by Ivan Konishchev on 20.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class GameOverState: GameState {
    var isComleted: Bool = false
    var winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    func begin() {
        log(.gameFinished(winner: self.winner))
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = self.winner {
            self.gameViewController?.winnerLabel.text = winnerName(from: winner)
        } else {
            self.gameViewController?.winnerLabel.text = "Ничья"

        }
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {}
    
    private func winnerName(from winner: Player) -> String {
        return winner == .first ? "1St Player winn" : "2St Player winn"
    }
}
