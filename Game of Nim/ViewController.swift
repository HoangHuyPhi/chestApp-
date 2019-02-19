//
//  ViewController.swift
//  Game of Nim
//
//  Created by Phi Hoang Huy on 8/26/18.
//  Copyright © 2018 Phi Hoang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: --Variables
    @IBOutlet weak var labelGameover: UILabel!
    var isGameOver : Bool?
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var Heap1: UIButton!
    @IBOutlet weak var Heap2: UIButton!
    @IBOutlet weak var Heap3: UIButton!
    @IBOutlet weak var Heap5B: UIButton!
    @IBOutlet weak var Heap3B: UIButton!
    @IBOutlet weak var Heap2B: UIButton!
    @IBOutlet weak var Heap1B: UIButton!
    @IBOutlet weak var Heap5C: UIButton!
    @IBOutlet weak var Heap4C: UIButton!
    @IBOutlet weak var Heap3C: UIButton!
    @IBOutlet weak var Heap2C: UIButton!
    @IBOutlet weak var Heap1C: UIButton!
    var heapArrayA = [UIButton]()
    var heapArrayB = [UIButton]()
    var heapArrayC = [UIButton]()
    var heapArray = [[UIButton]]()
    // MARK: --Pressed Function
    @IBAction func pressedHeap2(_ sender: UIButton) {
        removeHeap(Tag: sender.tag, column: "A")
        if CheckGameOver() == false {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.checkNimSum(numberOfA: self.countNumberOfHeap(Array: self.heapArrayA), numberOfB:self.countNumberOfHeap(Array: self.heapArrayB), numberOfC: self.countNumberOfHeap(Array: self.heapArrayC))
        }
        )
        }
    }
    @IBAction func pressedHeapB(_ sender: UIButton) {
        removeHeap(Tag: sender.tag, column: "B")
        if CheckGameOver() == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.checkNimSum(numberOfA: self.countNumberOfHeap(Array: self.heapArrayA), numberOfB:self.countNumberOfHeap(Array: self.heapArrayB), numberOfC: self.countNumberOfHeap(Array: self.heapArrayC))
            }
            )
    }
    }
    @IBAction func pressedHeapC(_ sender: UIButton) {
        removeHeap(Tag: sender.tag, column: "C")
        if CheckGameOver() == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.checkNimSum(numberOfA: self.countNumberOfHeap(Array: self.heapArrayA), numberOfB:self.countNumberOfHeap(Array: self.heapArrayB), numberOfC: self.countNumberOfHeap(Array: self.heapArrayC))
            }
            )
        }
    }
    override func viewDidLoad() {
        heapArrayA = [Heap1, Heap2, Heap3]
        heapArrayB = [Heap1B, Heap2B, Heap3B, Heap5B]
        heapArrayC = [Heap1C, Heap2C, Heap3C, Heap4C, Heap5C]
        heapArray = [heapArrayA, heapArrayB, heapArrayC]
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func removeHeap(Tag: Int, column: String) {
        var heapArray = [UIButton]()
        if column == "A" {
            heapArray = heapArrayA
        }
        else if column == "B" {
            heapArray = heapArrayB
        }
        else if column == "C" {
            heapArray = heapArrayC
        }
        for index in 0 ... Tag {
            heapArray[index].isHidden = true
        }
    }
    // Mark: -Check Game Over
    func CheckGameOver() -> Bool {
        let numberOfHeapsA = countNumberOfHeap(Array: heapArrayA)
        let numberOfHeapsB = countNumberOfHeap(Array: heapArrayB)
        let numberOfHeapsC = countNumberOfHeap(Array: heapArrayC)
        if numberOfHeapsA + numberOfHeapsB + numberOfHeapsC == 0
        {
           labelGameover.isHidden = false
            return true
        }
        else {
            return false
        }
    }
    //  MARK: --CheckSUM
    func randomPick() {
        // Pick  an Column ( Array) of Heaps randomly
        var maxNumber: Int = 0
        var column : String = ""
        var numberRandom : Int = 0
        // Check whether or not the picked Column has heap
        repeat {
        numberRandom =  Int(arc4random_uniform(UInt32(heapArray.count)))
            print(numberRandom)
        } while countNumberOfHeap(Array: heapArray[numberRandom]) == 0
        let randomArraySelected = heapArray[numberRandom]
        if randomArraySelected == heapArrayA {
            column = "A"
            maxNumber = 3
        }
        else if randomArraySelected == heapArrayB {
            column = "B"
            maxNumber = 4
        }
        else if randomArraySelected == heapArrayC {
             column = "C"
            maxNumber = 5
        }
// End.
// Remove a random number of heaps of picked Column
        let numberOfHeaps = countNumberOfHeap(Array: randomArraySelected)
        var randomNumberOfheaps: Int = 0
        if numberOfHeaps < 3
        {
         randomNumberOfheaps = generateRandomNumber(min: 1 , max: numberOfHeaps)
        } else {
         randomNumberOfheaps = generateRandomNumber(min: 1 , max: 3)
        }
        removeHeap(Tag: maxNumber - numberOfHeaps + randomNumberOfheaps - 1, column: column)
        CheckGameOver()
    }
// END
//MARK: -CHECK NIM SUM
    func checkNimSum(numberOfA: Int, numberOfB: Int, numberOfC: Int) {
        var column: String = ""
        var exclusiveOr = numberOfA ^ numberOfB ^ numberOfC
        var i = 1
        if exclusiveOr != 0
        {
            repeat {
                print("error")
                if numberOfA != 0 && numberOfA - i >= 0 {
                exclusiveOr = (numberOfA - i) ^ numberOfB ^ numberOfC
                    column = "A"
                }
                if exclusiveOr != 0 && numberOfB - i >= 0 {
                         exclusiveOr = numberOfA ^ (numberOfB - i) ^ numberOfC
                    column = "B"
                }
                if exclusiveOr != 0 && numberOfC - i >= 0 {
                            exclusiveOr = numberOfA ^ numberOfB ^ (numberOfC - i)
                    column = "C"
                }
                i = i + 1
            } while exclusiveOr != 0
            i = i - 1
            if column == "A" {
                removeHeap(Tag: heapArrayA.count - numberOfA + (i - 1)  , column: "A")
            }
            if column == "B" {
                       removeHeap(Tag: heapArrayB.count - numberOfB + (i - 1)   , column: "B")
            }
            if column == "C" {
                      removeHeap(Tag: heapArrayC.count - numberOfC + (i - 1)  , column: "C")
            }
        }
        else if exclusiveOr == 0 {
            randomPick()
        }
    }
//Mark: -Count Number of Heaps
    func countNumberOfHeap(Array: [UIButton]) -> Int {
        var numberOfRemoveHeap : Int = 0
        for index in 0 ... Array.count - 1
        {
         if Array[index].isHidden == false
       {
        numberOfRemoveHeap = numberOfRemoveHeap + 1
       }
        }
        return numberOfRemoveHeap
    }
    //MARK: -Generate Random Number
    func generateRandomNumber(min: Int, max: Int) -> Int {
        let randomNum = Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
        return randomNum
    }
    //MARK: -Choose to play first or not
    @IBAction func PlayerChoice(_ sender: UIButton) {
        if sender.tag == 1 {
            yesButton.isHidden = true
            noButton.isHidden = true
            questionLabel.isHidden = true
            Unhidden()
        } else {
            yesButton.isHidden = true
            noButton.isHidden = true
            questionLabel.isHidden = true
            Unhidden()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.checkNimSum(numberOfA: self.countNumberOfHeap(Array: self.heapArrayA), numberOfB:self.countNumberOfHeap(Array: self.heapArrayB), numberOfC: self.countNumberOfHeap(Array: self.heapArrayC))
            }
            )
        }
    }
    // MARK: -Unhidden all heaps
    func Unhidden() {
        for i in 0 ... 2 {
            heapArrayA[i].isHidden = false
        }
        for i in 0 ... 3 {
           heapArrayB[i].isHidden = false
        }
        for i in 0 ... 4 {
            heapArrayC[i].isHidden = false
        }
    }
}

