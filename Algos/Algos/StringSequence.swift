//
//  StringSequence.swift
//  Algos
//
//  Created by Someshubhra Karmakar on 12/01/22.
//

import Foundation

let Invalid: Int = -1

/*
  rabbit in rabbbit
    let -1 is Invalid
                   [r,   a,  b,  b,  b,  i,  t]
    currentOccur = [-1, -1, -1, -1, -1, -1, -1]
    currentOccur = [ 1, -1, -1, -1, -1, -1, -1]    r
    currentOccur = [ -1, 1, -1, -1, -1, -1, -1]    a
    currentOccur = [ -1, -1, 1,  2,  3, -1, -1]    b // note third b is markrd as 3 to denote 3 possibilities that b in the string will provide , for the match "rab"
    currentOccur = [ -1, -1,-1,  1,  3, -1, -1]    b // for rabb b at index 4 becomes 1, and b at 5  becomes 3, because from prev step max possibility was already 2 at level 4, in this step we add 1 till index 4 , So possibilities is 2 + 1 = 3
    currentOccur = [ -1, -1,-1, -1,  -1, 3, -1]    i
    currentOccur = [ -1, -1,-1, -1,  -1, -1, 3]    t
 
    Occurences is 3
 
 
   To understand this lets identify same value elements by 0,1... prefix
    Ex main str = a a a a and string to find  "a a", find total number of occurances :
    lets denote main Str as a0 a1  a2  a3
 
   first iteration a
    a0                a1           a2                     a3
    a0               a0,a1        a0,a1,a2               a0,a1,a2,a3
    1                 2           3                       4
 
 
  second iteration aa
    a0                a1           a2                     a3
    invalid           a1a10        a2a0,a2a1,a1a0      a3a0,a3a1,a3a2,a2a0,a2a1,a1a0
      0              1            2 + 1 = 3               3 + 3 = 6
 
 Result = 6
                                   
 */

func numberOfOccurances(main: [Character], sequence: [Character]) -> Int {
    var occur: Int = 0
    var lastOccur: Int = 0

    var prevOccur: [Int] = []
    var currentOccur: [Int] = []
    print("**********************************")
    print(main)
    //initialise
    main.forEach{ _ in
        prevOccur.append(Invalid)
        currentOccur.append(Invalid)
    }

    sequence.forEach {
        let element = $0
        var i = 0
        occur = 0
        lastOccur = 0
        print(element)
        // first find start index
        var startFound = false
        while i < main.count {
            if prevOccur[i] != Invalid {
                lastOccur = prevOccur[i]
                currentOccur[i] = Invalid
                startFound = true
            }
            i = i + 1
            if startFound {
                break
            }
        }
        if startFound == false {
            i = 0
        }
        let firstIterate = startFound == false
        while i < main.count {
            if element == main[i] { // element match
                occur = occur + (firstIterate == true ? 1: lastOccur)
                currentOccur[i] = occur
            } else {
                currentOccur[i] = Invalid
            }
            
            if prevOccur[i] != Invalid {
                lastOccur = prevOccur[i]
            }
           
            i = i + 1
        }
        print(currentOccur)
        prevOccur = currentOccur
    }
    return occur
}
