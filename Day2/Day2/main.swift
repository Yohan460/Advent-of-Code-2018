//
//  main.swift
//  Day2
//
//  Created by Johan McGwire on 12/2/18.
//  Copyright © 2018 Johan McGwire. All rights reserved.
//

import Foundation

// Giving a little primer incase anyone tries to run it
if CommandLine.arguments.count == 1 || (CommandLine.arguments)[1] == "-help" {
    print("""
    This is the Day 1 of the Advent of Code challenge binary

    For this binary to calculate the frequency change the command line parametes must be in the form described
    by the https://adventofcode.com/2018/day/2 link.

    Parmeters:

    -Help       : Prints this output
    -inputFile  : Takes in a string pointing to the input text file given by Advent of Code
    """)
}

// Parsing files since this seems to be helpful
func parseFile(filePath: String) -> [String]{
    
    // Initializing the String array for parsing later
    var frequencyStrArray: [String] = []
    
    // Reading in all the input
    var inputFileContents = try! String(contentsOfFile: filePath)
    
    // Standardizing the input to the CLI equivalent
    inputFileContents = inputFileContents.replacingOccurrences(of: "\n", with: ", ")
    
    // Converting it to an iterable array
    let inputFileContentSubstrings = inputFileContents.split(separator: " ")
    for substring in inputFileContentSubstrings {
        frequencyStrArray.append(String(substring))
    }
    
    return frequencyStrArray
}

// Initializing
var idInputArray: [String] = []
var twoOccurences = 0
var threeOccurences = 0

// Dealing with an input file and parsing it
if (CommandLine.arguments)[1] == "-inputFile" {
    idInputArray = parseFile(filePath: (CommandLine.arguments)[2])
}

for id in idInputArray {
    
    // Initializing
    var twoFound: Bool = false, threeFound: Bool = false
    
    for letter in id {
        
        // Initializing
        var letterCounter = 0
        
        // looping through the id again to find the number of occurences
        for countLetter in id {
            if countLetter == letter{
                letterCounter += 1
            }
        }
        
        // Checking to see if this is a number we care about
        if letterCounter == 2 { twoFound = true}
        if letterCounter == 3 { threeFound = true}
    }
    
    if twoFound { twoOccurences += 1}
    if threeFound { threeOccurences += 1}
}

print("Twos: " + String(twoOccurences))
print("Threes: " + String(threeOccurences))
print("Checksum: " + String(threeOccurences * twoOccurences))



