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
    private(set) var markPrototype: MarkView
    
//MARK: - init
    
    init(player: Player,gameViewCointroller: GameViewController,markViewPrototype: MarkView) {
        self.gameBoard = gameViewCointroller.gameBoard
        self.gameBoardView = gameViewCointroller.gameboardView
        self.markPrototype = markViewPrototype
        self.gameViewController = gameViewCointroller
        self.player = player
    }


//MARK: - PublicFunc
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

        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markPrototype.copy(), at: position)
        isComleted = true
    }
    
    
}
