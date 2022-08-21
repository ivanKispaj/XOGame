//
//  LogCommand.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class LogCommand {
    var logAction: LogAction
    var logMessage: String {
        switch logAction {
        case .playerInput(let player, let position):
            return ("\(player) placed mark at \(position)")
        case .gameFinished(let winner):
            if let winner = winner {
                return "Победитель\(winner)"
            } else {
                return "Ничья"
            }
           
        case .restartgame:
            return "Restart Game"
        }
    }
    
    init(logAction: LogAction) {
        self.logAction = logAction
    }
}
