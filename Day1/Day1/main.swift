//
//  main.swift
//  Day1
//
//  Created by Johan McGwire on 12/2/18.
//  Copyright © 2018 Johan McGwire. All rights reserved.
//

import Foundation


// Function to compartmentalize the Integer conversion
func parseInt(str: String) -> Int{
    
    // Getting the info of wheter there is a trailing comma or not
    let isTrailingCommand = str.hasSuffix(",")
    
    // Creating a temporary editing string since frequencyStr is immutable
    var frequencyStrEdit = str
    
    // Removing the first character
    frequencyStrEdit = String(frequencyStrEdit.dropFirst())
    
    // Removing the trailing comma
    if isTrailingCommand {
        frequencyStrEdit = String(frequencyStrEdit.dropLast())
    }
    
    // Converting the string to interger
    return Int(frequencyStrEdit) ?? 0
}


// Giving a little primer incase anyone tries to run it
if CommandLine.arguments.count == 1 || (CommandLine.arguments)[1] == "-help" {
    print("""
    This is the Day 1 of the Advent of Code challenge binary

    For this binary to calculate the frequency change the command line parametes must be in the form described
    by the https://adventofcode.com/2018/day/1 link.
    """)
}

// Initializing the counter to 0
var frequencyCorrection = 0

// Initializing the String array for parsing later
var frequencyStrArray: [String] = []

// Dealing with an input file
if (CommandLine.arguments)[1] == "-inputFile" {
    
    // Reading in all the input
    var inputFileContents = try String(contentsOfFile: (CommandLine.arguments)[2])
    
    // Standardizing the input to the CLI equivalent
    inputFileContents = inputFileContents.replacingOccurrences(of: "\n", with: ", ")
    
    // Converting it to an iterable array
    let inputFileContentSubstrings = inputFileContents.split(separator: " ")
    for substring in inputFileContentSubstrings {
        frequencyStrArray.append(String(substring))
    }
    
} else {

    // Removing the initial argument containing the binary location
    frequencyStrArray = Array((CommandLine.arguments)[1...])
}

// Iterating over all of the frequencies seperated by spaces
for frequencyStr in frequencyStrArray {
    
    // Getting the info on whether to add or subtract
    let isNegative = frequencyStr.hasPrefix("-")
    
    let frequencyNum = parseInt(str: frequencyStr)
    
    if isNegative {
        frequencyCorrection -= frequencyNum
    } else {
        frequencyCorrection += frequencyNum
    }
}

// Initializing the first frequency array and found variable
var firstFrequency: [Int] = [0]
var firstFrequencyFound = false

// Resetting the counter
var firstFrequencyFrequencyCorrection = 0

// Iniitalizng a looping mechanism
var frequencyCounter = 0

while !firstFrequencyFound {
    
    // Getting the entry to parse
    let frequencyStr = frequencyStrArray[frequencyCounter]
    
    // Getting the info on whether to add or subtract
    let isNegative = frequencyStr.hasPrefix("-")
    
    // Getting the parsed Integer
    let frequencyNum = parseInt(str: frequencyStr)
    
    // Tabulating
    if isNegative {
        firstFrequencyFrequencyCorrection -= frequencyNum
    } else {
        firstFrequencyFrequencyCorrection += frequencyNum
    }
    
    // Determining if a match has been found
    firstFrequencyFound = firstFrequency.contains(firstFrequencyFrequencyCorrection)
    
    // Appending the number
    firstFrequency.append(firstFrequencyFrequencyCorrection)
    
    // Getting the Counter
    frequencyCounter = (frequencyCounter + 1) % frequencyStrArray.count
    print(String(frequencyCounter) + "\t: \t" + String(firstFrequencyFrequencyCorrection) + "\t: \t" + String(firstFrequency.count) + "\t: \t" + String(firstFrequencyFound))
}

print("Total Frequency Correction: " + String(frequencyCorrection))
print("First Frequency Found: " + String(firstFrequency[firstFrequency.count - 1 ]))
