//
//  main.swift
//  Day5
//
//  Created by Johan McGwire on 12/5/18.
//  Copyright © 2018 Johan McGwire. All rights reserved.
//

import Foundation

// Giving a little primer incase anyone tries to run it
if CommandLine.arguments.count == 1 || (CommandLine.arguments)[1] == "-help" {
    print("""
    This is the Day 4 of the Advent of Code challenge binary

    For this binary to calculate the frequency change the command line parametes must be in the form described
    by the https://adventofcode.com/2018/day/4 link.

    Parmeters:

    -Help       : Prints this output
    -inputFile  : Takes in a string pointing to the input text file given by Advent of Code
    """)
}

// Parsing files since this seems to be helpful
func parseFile(filePath: String) -> String{
    
    // Reading in all the input
    let inputFileContents = try! String(contentsOfFile: filePath)
    
    return inputFileContents
}

// Initializing
var inputContents: String = ""
var noReductionFound = false
let capitalLetters = "ABCDEFGHIKLMNOPQRSTVXYZ"
var counter =  0

// Dealing with an input file and parsing it
if (CommandLine.arguments)[1] == "-inputFile" {
    inputContents = parseFile(filePath: (CommandLine.arguments)[2])
}

print("Input Length: \(inputContents.count)")

// Looping until no more reductions found
while !noReductionFound {
    
    // Initializing
    var i = 0
    
    noReductionFound = true
    
    // Checking for reductions
    while i <= (inputContents.count - 1) {
        
        var ReductionFound = false
        
        // Grabbing the characters to check next to
        let checkCharacter = String(inputContents[inputContents.index(inputContents.startIndex, offsetBy: i)])
        var checkCharacterCaseToggled = ""
        if capitalLetters.contains(checkCharacter){
            checkCharacterCaseToggled = checkCharacter.lowercased()
        } else {
            checkCharacterCaseToggled = checkCharacter.uppercased()
        }
        
        //Checking the character to the left
        if i > 1 && String(inputContents[inputContents.index(inputContents.startIndex, offsetBy: i - 1)]) == checkCharacterCaseToggled {
            ReductionFound = true
            noReductionFound = false
            print("reduction \t:     i=" + String(i) + "\t:    Left \t:" + String(inputContents.substring(with: inputContents.index(inputContents.startIndex, offsetBy: i - 1)..<inputContents.index(inputContents.startIndex, offsetBy: i + 1))) + "\t: \(counter)" )
            inputContents.removeSubrange(inputContents.index(inputContents.startIndex, offsetBy: i - 1)..<inputContents.index(inputContents.startIndex, offsetBy: i + 1))
            i -= 2
        }

        //Checking the character to the right
        if i <= (inputContents.count - 2) && !ReductionFound && String(inputContents[inputContents.index(inputContents.startIndex, offsetBy: i + 1)]) == checkCharacterCaseToggled {
            ReductionFound = true
            noReductionFound = false
            print("reduction \t:     i=" + String(i) + "\t:    Right \t:" + String(inputContents.substring(with: inputContents.index(inputContents.startIndex, offsetBy: i)..<inputContents.index(inputContents.startIndex, offsetBy: i + 2))) + "\t: \(counter)" )
            inputContents.removeSubrange(inputContents.index(inputContents.startIndex, offsetBy: i)..<inputContents.index(inputContents.startIndex, offsetBy: i + 2))
        }
        
        if !ReductionFound {
            i += 1
        } else {
            counter += 1
        }
    }
}

print(inputContents)
print("Output Length: \(inputContents.count)")


