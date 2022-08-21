//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class LoggerInvoler {
    static let shared = LoggerInvoler()
    private let logger = Logger()
    private let batchSize: Int = 10
    private var commands: [LogCommand] = []
    private init(){}
    
    public func addCommand(_ command: LogCommand) {
        self.commands.append(command)
        execiteCommandIfneeded()
    }
    
    private func execiteCommandIfneeded() {
        guard commands.count > batchSize else { return }
        commands.forEach({logger.writeMessageToLog($0.logMessage)})
        commands = []
    }
}

