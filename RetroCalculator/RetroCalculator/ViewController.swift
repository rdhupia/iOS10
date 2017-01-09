//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ravideep Dhupia on 2017-01-07.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = "";
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add sound
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        // Need to convert the string obtained above to url
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLabel.text = "0"
        
    }

    @IBAction func numberPressed(sender: UIButton)  {   // Could use Any if we didnt know the object type expected
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onClearPressed(sender: UIButton) {
        processOperation(operation: .Empty)
        outputLabel.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            // User selected an operator, then selected another operator
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\( Double(leftValStr)! * Double(rightValStr)! )"
                } else if currentOperation == Operation.Divide {
                    result = "\( Double(leftValStr)! / Double(rightValStr)! )"
                } else if currentOperation == Operation.Subtract {
                    result = "\( Double(leftValStr)! - Double(rightValStr)! )"
                } else if currentOperation == Operation.Add {
                    result = "\( Double(leftValStr)! + Double(rightValStr)! )"
                }
                
                leftValStr = result
                outputLabel.text = result
            }

            currentOperation = operation
        } else {
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
        
    }

}

