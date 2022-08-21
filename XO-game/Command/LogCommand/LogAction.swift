//
//  LogAction.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartgame
}

func log(_ action: LogAction) {
    let command = LogCommand(logAction: action)
    LoggerInvoler.shared.addCommand(command)
}
