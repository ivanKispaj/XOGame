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
    
    var difficultyLevel: GameDifficulty!
    var gameOpponent: GameOpponent!
    private lazy var refery: Referee = Referee(gameboard: gameBoard)
    var gameBoard: Gameboard!
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    var isLastStep = false
    private(set) var aStepInvoker = AFewStepsInvoker()
 
    
    //MARK: - restart Button
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        log(.restartgame)
        self.dismiss(animated: true)
    }
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameBoard = Gameboard()
        goToFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isComleted {
                self.goToNextState()
            }
        }
    }
    //MARK: - private method
    private func goToFirstState() {
        let player: Player = .first
        switch gameOpponent {
        case .player:
            switch difficultyLevel{
                
            case .hard:
                currentState = AFewStepsState(player: player,
                                              gameViewController: self,
                                              isLastStep: false,
                                              markViewPrototype: player.playerMark,
                                              playerInvoker: self.aStepInvoker)
            default:
                isLastStep = true
                currentState = PlayerInputState(player: player,
                                                gameViewCointroller: self,
                                                markViewPrototype: player.playerMark)
            }
            
        case .computer:
            switch difficultyLevel{
            case .easy:
                print("computer easy")
            case .middle:
                print("computer middle")
            case .hard:
                print("computer hard")
            default:
                return
            }
            
        default:
            return
        }
    }
    
    private func goToNextState() {
        
        switch currentState {
            
        case is PlayerInputState:
            let playerInputState = currentState as! PlayerInputState
            let player = playerInputState.player.next
            currentState = PlayerInputState(player: player,
                                            gameViewCointroller: self,
                                            markViewPrototype: player.playerMark)
        case is AFewStepsState:
            
            let playerInputState = self.currentState as! AFewStepsState
            let player = playerInputState.player.next
            if !playerInputState.isLastStep {
                self.currentState = AFewStepsState(player: player,
                                                   gameViewController: self,
                                                   isLastStep: true,
                                                   markViewPrototype: player.playerMark,
                                                   playerInvoker: self.aStepInvoker)
            } else {
                self.currentState = AfewStepsGamePlay(player: player,
                                                      gameViewController: self,
                                                      markViewPrototype: player.playerMark,
                                                      playerInvoker: self.aStepInvoker,
                                                      referee: self.refery)
                self.currentState.begin()
                
            }
            
        default:
            break
        }
        
        if let winner = refery.determineWinner() {
            var playerWinner: Player? = nil
            if  winner.count == 1, let playerWinn = winner.first {
                playerWinner = playerWinn
            }
            if isLastStep {
                self.currentState = GameOverState(winner: playerWinner, gameViewController: self)
                return
            }
        }
        
        isLastStep = true
        
        let allPosition = gameBoard.getAllPosition()
        var players: [Player] = []
        allPosition.forEach({
            $0.forEach({
                if let player = $0 {
                    players.append(player)
                }
            })
            
        })
        if players.count == (GameboardSize.columns * GameboardSize.rows) {
            self.currentState = GameOverState(winner: nil, gameViewController: self)
        }
    }
    
    
    
}

