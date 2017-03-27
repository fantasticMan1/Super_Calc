//
//  ViewController.swift
//  Super Calc
//
//  Created by Josh Winebrener on 3/25/17.
//  Copyright © 2017 Josh Winebrener. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {

    @IBOutlet weak var opsPopup: NSPopUpButton!
    @IBOutlet weak var chooseOperation: NSMenuItem!
    @IBOutlet weak var addNumbers: NSMenuItem!
    @IBOutlet weak var subtractNumbers: NSMenuItem!
    @IBOutlet weak var num1TextField: NSTextField!
    @IBOutlet weak var num2TextField: NSTextField!
    @IBOutlet weak var calculateButton: NSButton!
    @IBOutlet weak var resultTextField: NSTextField!
    //mode selection radio buttons
    @IBOutlet weak var sarcasticModeRadioButton: NSButton!
    @IBOutlet weak var literalModeRadiobutton: NSButton!
    
    var result: String = ""
    var sarcasticMode = false
    
    fileprivate let possibleOperations = ["Select Operation", "Add", "Subtract", "Multiply", "Divide"]
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opsPopup.removeAllItems()
        opsPopup.addItems(withTitles: possibleOperations)
        opsPopup.selectItem(at: 0)
        
        num1TextField.stringValue = "no. 1"
        num2TextField.stringValue = "no. 2"
        resultTextField.stringValue = "result"
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func radioButtonChanged(_ sender: AnyObject) {
        
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        
        let selectedOperation = opsPopup.indexOfSelectedItem
        let num1 = Double(num1TextField.stringValue)
        let num2 = Double(num2TextField.stringValue)
        var result: String = ""
        
        if sarcasticModeRadioButton.state == NSOnState {
        
            result = calculateSarcasticResult(num1: num1, num2: num2,
                                                  selectedOperation: selectedOperation)
            
        } else {
        
            result = calculateResult(num1: num1, num2: num2,
                                         selectedOperation: selectedOperation)

        }
        resultTextField.stringValue = result
        
    }
    
    func windowShouldClose(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    func calculateResult(num1: Double?, num2: Double?, selectedOperation: Int) -> String {
        
        var result: String = ""
        
        if num1 != nil && num2 != nil {
            
            //the index for the addition option
            if selectedOperation == 1 {
                result = String(num1! + num2!)
                //the index for the subtraction option
            } else if selectedOperation == 2 {
                result = String(num1! - num2!)
                //the index for the multiplication option
            } else if selectedOperation == 3 {
                result = String(num1! * num2!)
                //the index for the division option
            } else if selectedOperation == 4 {
                result = String(num1! / num2!)
            }
            
        } else {
            
            result = "Please insert an actual number"
            
        }
        
        if selectedOperation == 0 {
            
            result = "Please select an operation \nfrom the menu"
        }
        
        return result
        
    }
    
    func calculateSarcasticResult(num1: Double?, num2: Double?, selectedOperation: Int) -> String {
        
        var result: String = ""
        
        if num1 != nil && num2 != nil {
            
            //the index for the addition option
            if selectedOperation == 1 {
                
                //concatenate the values instead of adding them (1 + 1 = 11)
                result = String(Int(num1!)) + String(Int(num2!))
                
            //the index for the subtraction option
            } else if selectedOperation == 2 {
                
                //return a random number
                result = String(arc4random())
                
            //the index for the multiplication option
            } else if selectedOperation == 3 {
            
                //return a different string of text depending on the value of num1 and num1
                if num1! < 10.0 && num2! < 10.0 {
                    
                    result = "I'm tired right now and don't feel like\n multiplying. That's too much energy."
                    
                } else if num1! >= 10.0 && num2! < 10.0 {
                    
                    result = "The answer is ... TACOS!"
                    
                } else if num1! >= 10.0 && num2! >= 10.0 {
                    
                    result = "An error occurred, and you \naren't smart enough to figure it out. \nCome back another day after the error \nis fixed."
                }
                
            //the index for the division option
            } else if selectedOperation == 4 {
            
                //Subtract instead of dividing
                result = String(num1! - num2!)
            
            }
            
        } else {
            
            result = "You Fool!  That's not a number!  Try again!"
            
        }
        
        if selectedOperation == 0 {
            
            result = "You need to select an operation! \nWhat's the matter with you?"
        }
        
        return result
        
    }

}

