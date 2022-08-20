//
//  GameState.swift
//  XO-game
//
//  Created by Ivan Konishchev on 20.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    
    var isComleted: Bool { get }
    
    func begin()
    
    func addMark( at position: GameboardPosition)
}
