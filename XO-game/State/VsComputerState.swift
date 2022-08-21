//
//  VsComputerState.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class VsComputerState: GameState {
    var isComleted: Bool = false
    private(set) var player: Player
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
    
    func begin() {
        guard let gameboardView = gameBoardView else {
            return
        }

        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
            
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
            
            isComleted = true
            guard let position = getPosition() else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                gameboardView.onSelectPosition!(position)

            }
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
    
    private func getPosition() -> GameboardPosition? {
        guard let gameBoardView = gameBoardView else {
            return nil
        }

        let row = 0...(GameboardSize.rows - 1)
        let column = 0...(GameboardSize.columns - 1)
        
       
        while true {
            let  position = GameboardPosition(column: Int.random(in: column), row: Int.random(in: row))
            if gameBoardView.canPlaceMarkView(at: position) {
                return position
            }
        }
    }

}
