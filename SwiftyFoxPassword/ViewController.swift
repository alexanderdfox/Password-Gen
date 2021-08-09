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
        let pass = password(length: Int(lengthOfPassword!.intValue), specialChars: Specials.objectValue as! Bool ,vowelChars: Vowels.objectValue as! Bool, constChars: Constanants.objectValue as! Bool, numChars: Numbers.objectValue as! Bool, upperOnly: Uppercase.objectValue as! Bool, lowerOnly: Lowercase.objectValue as! Bool, extra: Other.objectValue as! Bool, Extras: OtherText.stringValue, emoji: Emoji.objectValue as! Bool)
        textCell.stringValue = pass
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
}
