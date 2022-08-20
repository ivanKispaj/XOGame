//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private lazy var refery: Referee = Referee(gameboard: gameBoard)
    private let gameBoard: Gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       goToFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addMark(at: position)
            if self.currentState.isComleted {
                self.goToNextState()
            }
        }
    }
    
    private func goToFirstState() {
        currentState = PlayerInputState(player: .first, gameBoard: self.gameBoard, gameViewController: self, gameBoardView: self.gameboardView)
    }
    
    private func goToNextState() {
        if let winner = refery.determineWinner() {
            self.currentState = GameOverState(winner: winner, gameViewController: self)
            return 
        }
        if let playerInputState = self.currentState as? PlayerInputState {
            currentState = PlayerInputState(player: playerInputState.player.next,
                                                   gameBoard: self.gameBoard,
                                                   gameViewController: self,
                                                   gameBoardView: self.gameboardView)
        }
        let allPosition = gameBoard.getAllPosition()
        var pla: [Player] = []
        allPosition.forEach({
           $0.forEach({
               if let player = $0 {
                   pla.append(player)
               }
           })
            
        })
        if pla.count == (GameboardSize.columns * GameboardSize.rows) {
            self.currentState = GameOverState(winner: nil, gameViewController: self)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameBoard.clear()
        gameboardView.clear()
        self.goToFirstState()
        
    }

}

