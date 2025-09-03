//
//  ViewController.swift
//  SwiftyFoxPassword
//
//  Created by Alexander Fox on 7/15/19.
//  Copyright © 2019 Alexander Fox. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textCell: NSTextFieldCell!
    @IBOutlet weak var lengthOfPassword: NSSliderCell!
    @IBOutlet weak var OtherText: NSTextField!
    @IBOutlet weak var Other: NSButtonCell!
    @IBOutlet weak var Specials: NSButtonCell!
    @IBOutlet weak var Vowels: NSButtonCell!
    @IBOutlet weak var Constanants: NSButtonCell!
    @IBOutlet weak var Numbers: NSButtonCell!
    @IBOutlet weak var Uppercase: NSButtonCell!
    @IBOutlet weak var Lowercase: NSButtonCell!
    @IBOutlet weak var Emoji: NSButton!
    
    @IBAction func NewPassword(_ sender: Any) {
        update()
    }
    
    @IBAction func OtherText(_ sender: Any) {
        update()
    }
    
    @IBAction func lengthOfPassword(_ sender: Any) {
        update()
    }
    
    @IBAction func Other(_ sender: Any) {
        update()
    }
    
    @IBAction func Specials(_ sender: Any) {
        update()
    }
    
    @IBAction func Vowels(_ sender: Any) {
        update()
    }
    
    @IBAction func Constantants(_ sender: Any) {
        update()
    }
    
    @IBAction func Numbers(_ sender: Any) {
        update()
    }
    
    @IBAction func Uppercase(_ sender: Any) {
       update()
    }
    
    @IBAction func Lowercase(_ sender: Any) {
        update()
    }
    
    @IBAction func Emoji(_ sender: Any) {
        update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        // Do any additional setup after loading the view.
    }

    func update() {
        // Input validation and safe unwrapping
        guard let lengthValue = lengthOfPassword?.intValue,
              let specialsValue = Specials?.objectValue as? Bool,
              let vowelsValue = Vowels?.objectValue as? Bool,
              let consonantsValue = Constanants?.objectValue as? Bool,
              let numbersValue = Numbers?.objectValue as? Bool,
              let uppercaseValue = Uppercase?.objectValue as? Bool,
              let lowercaseValue = Lowercase?.objectValue as? Bool,
              let otherValue = Other?.objectValue as? Bool,
              let emojiValue = Emoji?.objectValue as? Bool else {
            // Set default values if any controls are nil
            textCell?.stringValue = "Error: Invalid configuration"
            return
        }
        
        // Validate length
        let length = Int(lengthValue)
        guard length >= 1 && length <= 1000 else {
            textCell?.stringValue = "Error: Invalid password length"
            return
        }
        
        // Validate that at least one character type is selected
        guard specialsValue || vowelsValue || consonantsValue || numbersValue || uppercaseValue || lowercaseValue || emojiValue || otherValue else {
            textCell?.stringValue = "Error: Please select at least one character type"
            return
        }
        
        // Safely get the extras text
        let extrasText = OtherText?.stringValue ?? ""
        
        let pass = password(length: length, 
                          specialChars: specialsValue,
                          vowelChars: vowelsValue, 
                          constChars: consonantsValue, 
                          numChars: numbersValue, 
                          upperOnly: uppercaseValue, 
                          lowerOnly: lowercaseValue, 
                          extra: otherValue, 
                          Extras: extrasText, 
                          emoji: emojiValue)
        
        // Validate the generated password
        guard !pass.isEmpty else {
            textCell?.stringValue = "Error: Failed to generate password"
            return
        }
        
        textCell?.stringValue = pass
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
}
