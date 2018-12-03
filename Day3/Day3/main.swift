//
//  main.swift
//  Day3
//
//  Created by Johan McGwire on 12/3/18.
//  Copyright © 2018 Johan McGwire. All rights reserved.
//

import Foundation

// Giving a little primer incase anyone tries to run it
if CommandLine.arguments.count == 1 || (CommandLine.arguments)[1] == "-help" {
    print("""
    This is the Day 3 of the Advent of Code challenge binary

    For this binary to calculate the frequency change the command line parametes must be in the form described
    by the https://adventofcode.com/2018/day/3 link.

    Parmeters:

    -Help       : Prints this output
    -inputFile  : Takes in a string pointing to the input text file given by Advent of Code
    """)
}

// Parsing files since this seems to be helpful
func parseFile(filePath: String) -> [[String:Int]]{
    
    // Initializing the String array for parsing later
    var frequencyStrArray: [String] = []
    var fabricSwatches: [[String:Int]] = [[:]]
    
    // Reading in all the input
    let inputFileContents = try! String(contentsOfFile: filePath)
    
    // Converting it to an iterable array
    let inputFileContentSubstrings = inputFileContents.split(separator: "\n")
    for substring in inputFileContentSubstrings {
        frequencyStrArray.append(String(substring))
    }
    
    // Going over all of the input fabric swatches
    for swatchStr in frequencyStrArray {
        
        // Splitting up the string into parseable chunks
        var swatchStrArray = swatchStr.split(separator: " ")
    
        // Pulling out and converting the sizes
        let sizeStr = swatchStrArray.removeLast()
        let x: Int = Int((sizeStr.split(separator: "x").first)!)!
        let y: Int = Int((sizeStr.split(separator: "x").last)!)!
        
        // Pulling out and converting the locations
        let offsetStr = swatchStrArray.removeLast()
        let leftOff: Int = Int((offsetStr.split(separator: ",").first)!)!
        let topOff: Int = Int((offsetStr.split(separator: ",").last)!.split(separator: ":").first!)!
        
        fabricSwatches.append(["x":x, "y":y, "leftOff":leftOff,  "topOff":topOff])
        //print(dump(["x":x, "y":y, "leftOff":leftOff,  "topOff":topOff]))
    }
    
    fabricSwatches.removeFirst()
    return fabricSwatches
}


let tmpArray: [Int] = [Int](repeating: 0, count: 1200)
var santaFabric: [[Int]] = [[Int]](repeating: tmpArray, count: 1200)
var fabricSwatches: [[String:Int]] = [[:]]

// Dealing with an input file and parsing it
if (CommandLine.arguments)[1] == "-inputFile" {
    fabricSwatches = parseFile(filePath: (CommandLine.arguments)[2])
}

for fabricSwatch in fabricSwatches {
    for y in (fabricSwatch["topOff"]!)..<(fabricSwatch["y"]! + fabricSwatch["topOff"]!) {
        for x in (fabricSwatch["leftOff"]!)..<(fabricSwatch["x"]! + fabricSwatch["leftOff"]!) {
            santaFabric[y][x] += 1
        }
    }
}


let countedCollisions = santaFabric.map({
    (value: [Int]) -> Int in
    var counted = 0
    for item in value{
        if item >= 2{counted += 1}
    }
    return counted
    }
)
print("Total fabric inch collision: " + String(countedCollisions.reduce(0, +)))
