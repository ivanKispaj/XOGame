//
//  AFewStepsInvoker.swift
//  XO-game
//
//  Created by Ivan Konishchev on 21.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class AFewStepsInvoker {

    private var commands: [AFewStepCommand] = []
    
    func appendPlayerSteps(command: AFewStepCommand) {
        commands.append(command)
    }
    
    public func execute() {
        let commandsPool = commands//PlayerInvoker.shared.commands
        
        for i in 0..<commandsPool.count/2 {
            
            let delay = Double(i + 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                commandsPool[i].execute()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.7) {
                commandsPool[i + commandsPool.count/2].execute()
            }
        }
        commands = []
    }
    
}
