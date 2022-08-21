//
//  AFewStepsState.swift
//  XO-game
//
//  Created by Ivan Konishchev on 20.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class AFewStepsState: GameState {
    
    
    private(set) var isComleted: Bool = false
    var player: Player
    private(set) weak var gameBoard: Gameboard?
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameBoardView: GameboardView?
    private(set) var markPlayerForPosition: [GameboardPosition: MarkView] = [:]
    var currentMarkCount = 0
    private(set) var markPrototype: MarkView
    private(set) var isLastStep: Bool = false
    private(set) var playerInvoker: AFewStepsInvoker?
    //MARK: - init
    init(player: Player,
         gameViewController: GameViewController,
         isLastStep: Bool,
         markViewPrototype: MarkView,
         playerInvoker: AFewStepsInvoker) {
        self.player = player
        self.gameBoard = gameViewController.gameBoard
        self.gameBoardView = gameViewController.gameboardView
        self.gameViewController = gameViewController
        self.isLastStep = isLastStep
        self.markPrototype = markViewPrototype
        self.playerInvoker = playerInvoker
    }
    
    //MARK: - public method
    func begin() {
        guard let gameBoard = gameBoard, let gameboardView = gameBoardView else {
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            gameBoard.clear()
            gameboardView.clear()
        }
            switch self.player {
        case .first:
            
                self.gameViewController?.firstPlayerTurnLabel.isHidden = false
                self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
                self.gameViewController?.firstPlayerTurnLabel.isHidden = true
                self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
            self.gameViewController?.winnerLabel.isHidden = true
        
    }
    
    func addMark(at position: GameboardPosition) {
        
        guard let gameboard = self.gameBoard, let gameboardView = self.gameBoardView else { return }
        
        if currentMarkCount != GameboardSize.columns {
     
            if canPlaceMarkview(at: position,for: player.playerMark) {
                markPlayerForPosition[position] = player.playerMark
            } else {
                return
                
            }
            
            log(.playerInput(player: self.player, position: position))
            playerInvoker?.appendPlayerSteps(command: AFewStepCommand(player: player,
                                                                      gameBoardPosition: position,
                                                                      gameBoardView: gameboardView,
                                                                      gameBoard: gameboard))
         
            gameboard.setPlayer(self.player, at: position)
            gameboardView.placeMarkView(player.playerMark, at: position)
        }
        currentMarkCount += 1
        if currentMarkCount == GameboardSize.columns {
                self.isComleted = true
                self.currentMarkCount = 0
            
        }
        
    }
    // MARK: - private method
    private func canPlaceMarkview(at position: GameboardPosition, for mark: MarkView) -> Bool {
        
        if let markLast = markPlayerForPosition[position] {
            if markLast is XView && mark is XView || markLast is OView && mark is OView {
                return false
            }
            
        }
        return true
    }
    
}
