//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Ivan Konishchev on 20.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class PlayerInputState: GameState {
    
    private(set) var isComleted: Bool = false
    var player: Player
    private(set) weak var gameBoard: Gameboard?
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameBoardView: GameboardView?
    
    init(player: Player, gameBoard: Gameboard, gameViewController: GameViewController, gameBoardView: GameboardView) {
        self.player = player
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.gameViewController = gameViewController
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        gameViewController?.winnerLabel.isHidden = true

    }
    
    func addMark(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else {
            return
        }

        let mark: MarkView
        switch player {
        case .first:
            mark = XView()
        case .second:
            mark = OView()
        }
        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(mark, at: position)
        isComleted = true
    }
    
    
}
