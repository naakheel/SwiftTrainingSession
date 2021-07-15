//
//  ViewController.swift
//  D2TicTacToe
//
//  Created by Nabeel Ahamed on 7/13/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblGameOver: UILabel!
    @IBOutlet weak var gameView: UIView!
    
    var usedOnBoard = [UIButton]()
    var xMoves = [Int]()
    var oMoves = [Int]()
    var isXTurn = true
    
    let winningMoves = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,4,8], [0,3,6], [0,3,6], [0,4,8], [2,4,6] ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func checkForWin () {
        for winMove in winningMoves {
            let checkMoveSet = isXTurn ? Set(xMoves) : Set(oMoves)
            let winMoveSet = Set(winMove)

            if winMoveSet.isSubset(of: checkMoveSet) {
                lblGameOver.text = isXTurn ? "X wins!" : "O wins!"
                gameView.isUserInteractionEnabled = false
                
                // Mark winning move
                for btn in usedOnBoard {
                    if winMoveSet.contains(btn.tag) {
                        btn.backgroundColor = .green
                    }
                }
                
            }
        }
    }
    
    @IBAction func doNewGameBtn(_ sender: Any) {
        xMoves = [Int]()
        oMoves = [Int]()
        isXTurn = true
        lblGameOver.text = ""
        for btn in usedOnBoard {
            btn.setTitle("", for: .normal)
            btn.backgroundColor = .darkGray
            btn.isEnabled = true
        }
    }
    
    @IBAction func doTTTBtn(_ sender: UIButton) {
        let position = sender.tag
        
        if isXTurn {
            xMoves.append(position)
            sender.setTitle("X", for: .normal)
        } else {
            oMoves.append(position)
            sender.setTitle("O", for: .normal)
        }
        sender.isEnabled = false
        usedOnBoard.append(sender)
        checkForWin()
        
        isXTurn.toggle()
    }
}

