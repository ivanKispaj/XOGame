//
//  MenuViewController.swift
//  XO-game
//
//  Created by Ivan Konishchev on 20.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//


import UIKit

enum GameDifficulty {
    case easy
    case middle
    case hard
    
}
enum GameOpponent {
    case player
    case computer
    
}

class MenuViewController: UIViewController {
    var difficulty: GameDifficulty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.difficulty = .easy
    }
    
    //MARK: - IBAction methods
    

    
    @IBAction func playerVsPlayer(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       guard let nextVC = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        
        switch difficulty {
        case .middle:
            GameboardSize.rows = 5
            GameboardSize.columns = 5
            
        case .hard:
            GameboardSize.rows = 5
            GameboardSize.columns = 5
        default:
            GameboardSize.rows = 3
            GameboardSize.columns = 3
            
        }
        nextVC.gameOpponent = .player
        nextVC.difficultyLevel = difficulty
        self.present(nextVC, animated: true)
    }
    
    @IBAction func playerVsComputer(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       guard let nextVC = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        switch difficulty {
        case .middle:
            GameboardSize.rows = 5
            GameboardSize.columns = 5
            
        case .hard:
            GameboardSize.rows = 5
            GameboardSize.columns = 5
        default:
            GameboardSize.rows = 3
            GameboardSize.columns = 3
            
        }
        
        self.present(nextVC, animated: true)
    }

    @IBAction func changed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            difficulty = .easy
        case 1:
            difficulty = .middle
        case 2:
            difficulty = .hard
        default:
            return
        }
    }
    
}
