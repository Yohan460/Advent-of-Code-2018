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
    inputFileContents = inputFileContents.replacingOccurrences(of: "\n", with: " ")
    
    // Converting it to an iterable array
    let inputFileContentSubstrings = inputFileContents.split(separator: " ")
    for substring in inputFileContentSubstrings {
        frequencyStrArray.append(String(substring))
    }
    
    return frequencyStrArray
}

func differExactlyByOne(str1: String, str2: String) -> Int {
    
    // Initializing
    var atLeastOneDifference = false
    var indexFound = -1
    
    // Iterating over the string
    for i in 0..<(max(str1.count, str2.count) - 1) {
        
        // Checking to find differences
        if str1[str1.index(str1.startIndex, offsetBy: i)] != str2[str2.index(str2.startIndex, offsetBy: i)] {
            
            // Saving the difference location
            indexFound = i
            
            // if one difference has already been found reset the counter to -1
            if atLeastOneDifference {
                indexFound = -1
            }
            
            // Setting that a difference has been found
            atLeastOneDifference = true
        }
        
    }
    
    return indexFound
}

// Initializing
var idInputArray: [String] = []
var twoOccurences = 0
var threeOccurences = 0

// Dealing with an input file and parsing it
if (CommandLine.arguments)[1] == "-inputFile" {
    idInputArray = parseFile(filePath: (CommandLine.arguments)[2])
}

// iterating over every ID
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


// String to check
for id in idInputArray {
    // Strings to check against
    for checkid in idInputArray {
        
        let differIndex = differExactlyByOne(str1: id, str2: checkid)
        
        if differIndex != -1 {
            print("\nID 1: " + id)
            print("ID 2: " + checkid)
            print("Index: " + String(differIndex))
            exit(0)
        }
    }
}



