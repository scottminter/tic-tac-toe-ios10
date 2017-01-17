//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Scott Minter on 1/16/17.
//  Copyright © 2017 Scott Minter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var upLeft: UIButton!
    @IBOutlet weak var upMid: UIButton!
    @IBOutlet weak var upRight: UIButton!
    @IBOutlet weak var mdLeft: UIButton!
    @IBOutlet weak var mdMid: UIButton!
    @IBOutlet weak var mdRight: UIButton!
    @IBOutlet weak var btmLeft: UIButton!
    @IBOutlet weak var btmMid: UIButton!
    @IBOutlet weak var btmRight: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!

    var buttonArr = [UIButton]()
    var imgToUse = UIImage()
    let ximg = UIImage(named: "x.png") as UIImage?
    let oimg = UIImage(named: "o.png") as UIImage?
    var imgArr = [UIImage]()
    var imgArrI = 0
    var imgName = ""
    var numOfMoves = 0
    var keepPlaying = true
    var moves: [String: [String]] = ["x":[], "o":[]]
    var buttonsPushed = [Int]()

    @IBAction func buttonMove(_ sender: UIButton) {
        let id = sender.tag

        if numOfMoves < 9 && keepPlaying == true && !buttonsPushed.contains(id) {
            var tempMove: String = ""
            
            buttonsPushed.append(id)
            sender.setImage(imgToUse, for: .normal)
        
            switch id {
            case 0:
                tempMove = "ul"
            case 1:
                tempMove = "um"
            case 2:
                tempMove = "ur"
            case 3:
                tempMove = "ml"
            case 4:
                tempMove = "mm"
            case 5:
                tempMove = "mr"
            case 6:
                tempMove = "bl"
            case 7:
                tempMove = "bm"
            case 8:
                tempMove = "br"
            default:
                // this should never be called
                print("Not a known button")
                tempMove = "not found"
            }
            
            moves[imgName]?.append(tempMove)
            checkForWinner()

            switchImage()
            numOfMoves += 1
        }
        
        if numOfMoves == 9 || keepPlaying == false {
            reset.isHidden = false
            
            if resultsLabel.text == "" {
                resultsLabel.text = "No Winner. Play again."
            }
        }
    }
    
    func checkForWinner() {
        print(moves)
        if (moves["x"]?.count)! >= 3 {
            let xWins: Bool = checkMovesForWinner(mvArr: moves["x"]!)
            if xWins == true {
                print("X Wins")
                resultsLabel.text = "X Wins!"
                keepPlaying = false
            }
        }
        
        if (moves["o"]?.count)! >= 3 {
            let yWins: Bool = checkMovesForWinner(mvArr: moves["o"]!)
            if yWins == true {
                print("O Wins")
                resultsLabel.text = "O Wins!"
                keepPlaying = false
            }
        }
    }
    
    func checkMovesForWinner(mvArr: [String])->Bool {
        var status: Bool = false
        
        // check top row
        if mvArr.contains("ul") && mvArr.contains("um") && mvArr.contains("ur") {
            print("top row win")
            status = true
        }
        
        // check middle row
        if mvArr.contains("ml") && mvArr.contains("mm") && mvArr.contains("mr") {
            print("middle row win")
            status = true
        }
        
        // check bottom row
        if mvArr.contains("bl") && mvArr.contains("bm") && mvArr.contains("br") {
            print("bottom row win")
            status = true
        }
        
        // check left col
        if mvArr.contains("bl") && mvArr.contains("ml") && mvArr.contains("ul") {
            print("left col win")
            status = true
        }
        
        // check middle col
        if mvArr.contains("bm") && mvArr.contains("mm") && mvArr.contains("um") {
            print("md col win")
            status = true
        }
        
        // check right col
        if mvArr.contains("br") && mvArr.contains("mr") && mvArr.contains("ur") {
            print("rt col win")
            status = true
        }
        
        // check diagonal upper left to lower right
        if mvArr.contains("ul") && mvArr.contains("mm") && mvArr.contains("br") {
            print("diag 1 win")
            status = true
        }
        
        // check diagonal lower lef to upper right
        if mvArr.contains("bl") && mvArr.contains("mm") && mvArr.contains("ur") {
            print("diag 2 win")
            status = true
        }

        return status
    }

    @IBAction func resetGame(_ sender: Any) {
        for btn in buttonArr {
            btn.setImage(nil, for: .normal)
        }
        
        numOfMoves = 0
        reset.isHidden = true
        switchImage()
        moves = ["x":[],"o":[]]
        keepPlaying = true
        resultsLabel.text = ""
        buttonsPushed.removeAll()
    }

    func switchImage() {
        imgArrI += 1
        if imgArrI >= imgArr.count {
            imgArrI = 0
        }
        
        imgToUse = imgArr[imgArrI]
        
        if imgName == "x" {
            imgName = "o"
        } else {
            imgName = "x"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttonArr.append(upLeft)
        buttonArr.append(upMid)
        buttonArr.append(upRight)
        buttonArr.append(mdLeft)
        buttonArr.append(mdMid)
        buttonArr.append(mdRight)
        buttonArr.append(btmLeft)
        buttonArr.append(btmMid)
        buttonArr.append(btmRight)
        
        for btn in buttonArr {
            btn.setTitle("", for: .normal)
        }
        
        imgArr.append(ximg!)
        imgArr.append(oimg!)
        
        imgToUse = ximg!
        imgName = "x"
        
        resultsLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

