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
        
        let result = calculateResult(num1: num1, num2: num2, selectedOperation: selectedOperation)

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
            
            result = "You Fool!  That's not a number!  Try again!"
            
        }
        
        if selectedOperation == 0 {
            
            result = "You need to select an operation! \nWhat's the matter with you?"
        }
        
        return result
        
    }

}

