//
//  ViewController.swift
//  Silly Song
//
//  Created by James Whitney on 11/2/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        guard let getName = nameField.text, !getName.isEmpty else {
            return
        }
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: getName)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


func shortNameFromName(name: String) -> String{
    let lowercaseName = name.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    if let vowelRange = lowercaseName.rangeOfCharacter(from: vowelSet) {
        return lowercaseName.substring(from: vowelRange.lowerBound) // use of substring method found in iOSND forum
    }
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

let bananaFanaTemplate = ["<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
                          "Banana Fana Fo F<SHORT_NAME>",
                          "Me My Mo M<SHORT_NAME>",
                          "<FULL_NAME>"].joined(separator: "\n")
