//
//  AFewStepCommand.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Command {
    func execute()
}

class AFewStepCommand: Command {
    
    let player: Player
    let gameBoardPosition: GameboardPosition
    let gameBoardView: GameboardView
    let gameBoard: Gameboard
    
    init(player: Player, gameBoardPosition: GameboardPosition, gameBoardView: GameboardView, gameBoard: Gameboard) {
        self.player = player
        self.gameBoardPosition = gameBoardPosition
        self.gameBoardView = gameBoardView
        self.gameBoard = gameBoard
    }
    
    func execute() {
        
        if gameBoardView.canPlaceMarkView(at: gameBoardPosition) {
            gameBoard.setPlayer(player, at: gameBoardPosition)
            gameBoardView.placeMarkView(player.playerMark, at: gameBoardPosition)
        } else {
            gameBoardView.removeMarkView(at: gameBoardPosition)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.gameBoard.setPlayer(self.player, at: self.gameBoardPosition)

            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.gameBoardView.placeMarkView(self.player.playerMark, at: self.gameBoardPosition)
            }
            
        }
    }
    
}

