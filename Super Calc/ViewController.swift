//
//  ViewController.swift
//  Super Calc
//
//  Created by Josh Winebrener on 3/25/17.
//  Copyright © 2017 Josh Winebrener. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {

    //drop-down menu of operations
    @IBOutlet weak var opsPopup: NSPopUpButton!
    //input text fields
    @IBOutlet weak var num1TextField: NSTextField!
    @IBOutlet weak var num2TextField: NSTextField!
    //"Calculate!" button
    @IBOutlet weak var calculateButton: NSButton!
    //output text field
    @IBOutlet weak var resultTextField: NSTextField!
    //mode selection radio buttons
    @IBOutlet weak var sarcasticModeRadioButton: NSButton!
    @IBOutlet weak var literalModeRadiobutton: NSButton!
    
    fileprivate let possibleOperations = ["Select Operation",
                                          "Add",
                                          "Subtract",
                                          "Multiply",
                                          "Divide"]
    
    //show the window
    //This is necessary because we extended NSWindowDelegate to be able to quit on close
    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show the popup operations menu
        opsPopup.removeAllItems()
        opsPopup.addItems(withTitles: possibleOperations)
        opsPopup.selectItem(at: 0)
        
        //insert default, eraseable text in the text fields
        num1TextField.stringValue = "no. 1"
        num2TextField.stringValue = "no. 2"
        resultTextField.stringValue = "result"
        
    }

    //I don't know what this does, but it was here with the app template, so I won't mess with it
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    //This keeps the radio buttons grouped together
    @IBAction func radioButtonChanged(_ sender: AnyObject) {}
    
    //called if/when the "Calculate!" button is pressed
    @IBAction func calculatePressed(_ sender: Any) {
        
        //declare all the necessary constants
        let selectedOperation = opsPopup.indexOfSelectedItem
        let num1 = Double(num1TextField.stringValue)
        let num2 = Double(num2TextField.stringValue)
        var result: String = ""
        
        //determine if the sarcastic mode is selected, and plan accordingly
        if sarcasticModeRadioButton.state == NSOnState {
            result = calculateSarcasticResult(num1: num1, num2: num2,
                                                  selectedOperation: selectedOperation)
        } else {
            result = calculateResult(num1: num1, num2: num2,
                                         selectedOperation: selectedOperation)
        }
        
        resultTextField.stringValue = result
        
    }
    
    //quit the app when the window is closed
    func windowShouldClose(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    //this function is called if the "Literal" mode is selected
    func calculateResult(num1: Double?,
                         num2: Double?,
                         selectedOperation: Int) -> String {
        
        var result: String = ""
        
        if num1 != nil && num2 != nil {
            
            //the index for the addition option
            if selectedOperation == 1 {
                
                //add num1 + num2, then send the result as a string
                result = String(num1! + num2!)
                
            //the index for the subtraction option
            } else if selectedOperation == 2 {
                
                //subtract num1 - num2, then send the result as a string
                result = String(num1! - num2!)
                
            //the index for the multiplication option
            } else if selectedOperation == 3 {
                
                //multiply num1 * num2, then send the result as a string
                result = String(num1! * num2!)
                
            //the index for the division option
            } else if selectedOperation == 4 {
                
                //guess what?!?  DIVIDE!
                result = String(num1! / num2!)
                
            }
        
        //In case num1 or num2 are nil, which they can be if a string is passed in
        } else {
            
            result = "Please insert an actual number"
            
        }
        
        //In case no operation is selected
        if selectedOperation == 0 {
            
            result = "Please select an operation \nfrom the menu"
        }
        
        // after all this work, we have a result to return    *!!PARTY!!*
        return result
        
    }
    
    //this function is called if the "Sarcastic" mode is selected
    // It will return false math and comical retorts if chosen
    func calculateSarcasticResult(num1: Double?,
                                  num2: Double?,
                                  selectedOperation: Int) -> String {
        
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
                    
                } else if num1! < 10.0 && num2! >= 10.0{
                
                    result = "Your horoscope is not looking good, \nmy friend.  I will read your palm again \nfor a fee"
                    
                }else if num1! >= 10.0 && num2! < 10.0 {
                    
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

