//
//  AFewStepReceiver.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class AFewStepReceiver {
    private(set) var gameboard: Gameboard
    private(set) var gameboardView: GameboardView
    private(set) var player: Player
//MARK: - init
    init(player: Player, gameViewController: GameViewController) {
        self.gameboard = gameViewController.gameBoard
        self.gameboardView = gameViewController.gameboardView
        self.player = player
    }
    
    func placeXmark(to position: GameboardPosition) {
        if gameboardView.canPlaceMarkView(at: position) {
            gameboard.setPlayer(player, at: position)
            gameboardView.placeMarkView(player.playerMark, at: position)
        } else {
            gameboardView.removeMarkView(at: position)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.gameboard.setPlayer(self.player, at: position)

            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.gameboardView.placeMarkView(self.player.playerMark, at: position)
            }
            
        }
    }
    
    func placeOMark(to position: GameboardPosition) {
        if gameboardView.canPlaceMarkView(at: position) {
            gameboard.setPlayer(player, at: position)
            gameboardView.placeMarkView(player.playerMark, at: position)
        } else {
            gameboardView.removeMarkView(at: position)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.gameboard.setPlayer(self.player, at: position)

            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.gameboardView.placeMarkView(self.player.playerMark, at: position)
            }
            
        }
    }
}
