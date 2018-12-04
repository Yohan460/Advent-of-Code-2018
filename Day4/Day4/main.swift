//
//  main.swift
//  Day4
//
//  Created by Johan McGwire on 12/4/18.
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
func parseFile(filePath: String) -> [String]{
    
    // Initializing the String array for parsing later
    var inputContentsArray: [String] = []
    
    // Reading in all the input
    let inputFileContents = try! String(contentsOfFile: filePath)
    
    // Converting it to an iterable array
    let inputFileContentSubstrings = inputFileContents.split(separator: "\n")
    for substring in inputFileContentSubstrings {
        inputContentsArray.append(String(substring))
    }
    
    return inputContentsArray
}

// Initializing
var inputContentsArray: [String] = []
var guardInformationTotal: [Int:[String:AnyObject]] = [:]

// Dealing with an input file and parsing it
if (CommandLine.arguments)[1] == "-inputFile" {
    inputContentsArray = parseFile(filePath: (CommandLine.arguments)[2])
    inputContentsArray.sort()
}

// Iterating over the input after sorting it
var i = 0
while i < inputContentsArray.count - 1{
    
    // Getting the guard id and pulling the information if it's there
    let guardID = Int(((inputContentsArray[i].split(separator: "#"))[1].split(separator: " "))[0])
    var guardInformation = guardInformationTotal[guardID!] ?? ["totalTimeAsleep":0, "sleepRanges":[[]] ] as [String:AnyObject]
    
    i += 1
    // looping over the asleep information
    while i < inputContentsArray.count - 1 && inputContentsArray[i].contains("falls asleep"){
        
        let startTime = Int(inputContentsArray[i][inputContentsArray[i].index(inputContentsArray[i].startIndex, offsetBy: 15)..<inputContentsArray[i].index(inputContentsArray[i].startIndex, offsetBy: 17)])!
        i += 1
        let endTime = Int(inputContentsArray[i][inputContentsArray[i].index(inputContentsArray[i].startIndex, offsetBy: 15)..<inputContentsArray[i].index(inputContentsArray[i].startIndex, offsetBy: 17)])!
        
        var sleepRanges = guardInformation["sleepRanges"] as! [[Int]]
        sleepRanges.append(Array(startTime..<(endTime)))
        guardInformation["totalTimeAsleep"] = (guardInformation["totalTimeAsleep"] as! Int + (endTime - startTime)) as AnyObject
        guardInformation["sleepRanges"] = sleepRanges as AnyObject
        
        /*
        print(inputContentsArray[i-1])
        print(inputContentsArray[i])
        print("Guard ID: " + String(guardID!))
        print("Start Time: " + String(startTime))
        print("End Time: " + String(endTime))
        print(Array(startTime..<(endTime)))
        print("Asleep Time: " + String(endTime - startTime))
        print("Total Time Asleep: " + String(guardInformation["totalTimeAsleep"] as! Int) + "\n")
        */

        i += 1
    }
    guardInformationTotal[guardID!] = guardInformation
}

let sleepiestGuards = guardInformationTotal.sorted { (first: (key: Int, value: [String:AnyObject]), second: (key: Int, value: [String:AnyObject])) -> Bool in
    return (first.value["totalTimeAsleep"] as! Int) > (second.value["totalTimeAsleep"] as! Int)
}

print("Max time asleep: " + String(sleepiestGuards[0].value["totalTimeAsleep"] as! Int))
print("Guard ID: " + String(sleepiestGuards[0].key))

var mostCommonMinuteCount: [Int:Int] = [:]
for each in Array((guardInformationTotal[sleepiestGuards[0].key]!["sleepRanges"] as! [[Int]]).joined()) {
    let minute = mostCommonMinuteCount[each] ?? 0
    mostCommonMinuteCount[each] = minute + 1
}

var mostCommonMinute = mostCommonMinuteCount.sorted { (first: (key: Int, value: Int), second: (key: Int, value: Int)) -> Bool in
    return first.value > second.value
}
print("Most Common Minute: " + String(mostCommonMinute[0].key))
print("Most Common Minute occurences: " + String(mostCommonMinute[0].value))

print("\nSecond part\n")

let mostCommonMinuteBewteenAllGuards = guardInformationTotal.sorted { (first: (key: Int, value: [String:AnyObject]), second: (key: Int, value: [String:AnyObject])) -> Bool in

    var firstMostCommonMinuteCount: [Int:Int] = [:]
    for each in Array((first.value["sleepRanges"] as! [[Int]]).joined()) {
        let minute = firstMostCommonMinuteCount[each] ?? 0
        firstMostCommonMinuteCount[each] = minute + 1
    }
    var firstMostCommonMinute = firstMostCommonMinuteCount.sorted { (first: (key: Int, value: Int), second: (key: Int, value: Int)) -> Bool in
        return first.value > second.value
    }
    
    
    var secondMostCommonMinuteCount: [Int:Int] = [:]
    for each in Array((second.value["sleepRanges"] as! [[Int]]).joined()) {
        let minute = secondMostCommonMinuteCount[each] ?? 0
        secondMostCommonMinuteCount[each] = minute + 1
    }
    var secondMostCommonMinute = secondMostCommonMinuteCount.sorted { (first: (key: Int, value: Int), second: (key: Int, value: Int)) -> Bool in
        return first.value > second.value
    }
    
    if Array((first.value["sleepRanges"] as! [[Int]]).joined()) == [] {
        firstMostCommonMinute.append((key: -1, value: -1))
    }
    
    if Array((second.value["sleepRanges"] as! [[Int]]).joined()) == [] {
        secondMostCommonMinute.append((key: -1, value: -1))
    }
    
    return firstMostCommonMinute[0].value > secondMostCommonMinute[0].value
}


print("Guard ID: " + String(mostCommonMinuteBewteenAllGuards[0].key))

mostCommonMinuteCount = [:]
for each in Array((guardInformationTotal[mostCommonMinuteBewteenAllGuards[0].key]!["sleepRanges"] as! [[Int]]).joined()) {
    let minute = mostCommonMinuteCount[each] ?? 0
    mostCommonMinuteCount[each] = minute + 1
}

mostCommonMinute = mostCommonMinuteCount.sorted { (first: (key: Int, value: Int), second: (key: Int, value: Int)) -> Bool in
    return first.value > second.value
}
print("Most Common Minute: " + String(mostCommonMinute[0].key))
print("Most Common Minute occurences: " + String(mostCommonMinute[0].value))


