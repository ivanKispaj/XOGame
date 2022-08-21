//
//  AfewStepsGamePlay.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class AfewStepsGamePlay: GameState {
    
    private(set) var isComleted: Bool = false
    var player: Player
    private(set) var markPrototype: MarkView
    private(set) weak var gameBoard: Gameboard?
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameBoardView: GameboardView?
    private(set) weak var playerInvoker: AFewStepsInvoker?
    private(set) weak var referee: Referee!
    init(player: Player,
         gameViewController: GameViewController,
         markViewPrototype: MarkView,
         playerInvoker: AFewStepsInvoker,
         referee: Referee) {
        self.player = player
        self.gameBoard = gameViewController.gameBoard
        self.gameBoardView = gameViewController.gameboardView
        self.gameViewController = gameViewController
        self.markPrototype = markViewPrototype
        self.playerInvoker = playerInvoker
        self.referee = referee
    }
    
    func begin() {
        guard let gameBoard = gameBoard,
              let gameboardView = gameBoardView,
              let referee = self.referee,
              let gameviewController = self.gameViewController else {
            return
        }
        gameviewController.isLastStep = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            gameBoard.clear()
            gameboardView.clear()
        }
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        }
        gameViewController?.winnerLabel.isHidden = true
        
        DispatchQueue.main.async {
            self.playerInvoker?.execute()
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                var state: GameOverState
                if let winner = referee.determineWinner() {
                    if  winner.count == 1, let playerWinn = winner.first {
                        state = GameOverState(winner: playerWinn, gameViewController: gameviewController)
                    } else {
                        state = GameOverState(winner: nil, gameViewController: gameviewController)
                    }
                    state.begin()
                }

            }
        }
    }
    
    func addMark(at position: GameboardPosition) { }
    
}
