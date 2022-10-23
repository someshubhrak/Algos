//
//  LongestIncreasingSeq.swift
//  Algos
//
//  Created by Someshubhra Karmakar on 30/12/21.
//

import Foundation

class CustomInt {
    var value: Int
    var prevValue: CustomInt?
    init( value: Int) {
        self.value = value
    }
}
/*
   lowestElementInSizeLevels contains the lowest element at each size level out of the various combinations possible.
 
   lowestElementInSizeLevels array, how does it work for the input
    0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15
 
    Lets say the array is at [0, 2, 10] now next element is 6.
    6 > 2, but 6 < 10. So anthing > 10 will be always > 6.
    So replace 10 with 6.
   [0, 2, 6]
 
    Following are its state for each element
 [0]
 [0, 8]
 [0, 4]
 [0, 4, 12]
 [0, 2, 12]
 [0, 2, 10]
 [0, 2, 6]
 [0, 2, 6, 14]
 [0, 1, 6, 14]
 [0, 1, 6, 9]
 [0, 1, 5, 9]
 [0, 1, 5, 9, 13]
 [0, 1, 3, 9, 13]
 [0, 1, 3, 9, 11]
 [0, 1, 3, 7, 11]
 [0, 1, 3, 7, 11, 15]
 */
func findLongestIncreasingSeq(inputElements: [Int]) -> [Int] {
    var elements: [CustomInt] = []
    var lowestElementInSizeLevels: [CustomInt] = []
    
    // initialise
    elements = inputElements.map{ CustomInt(value: $0)}

    elements.enumerated().forEach {
        let element = $0.element
        
        // check to see at what level to enter the new element
        var i = lowestElementInSizeLevels.count - 1
        if i < 0  {
            lowestElementInSizeLevels.append(element)
        }
        else {
            // sizeLevelForElement - complexity log n
            i = sizeLevelForElement(lowestElementInSizeLevels: lowestElementInSizeLevels, element: element)
            // print("element value \(element.value) index \(i)")
            
            // element to be appended at end of lowestElementInSizeLevels
            if i == lowestElementInSizeLevels.count {
                element.prevValue = lowestElementInSizeLevels.last
                lowestElementInSizeLevels.append(element)
            }
            // element to be replaced in lowestElementInSizeLevels
            else if element.value < lowestElementInSizeLevels[i].value {
                element.prevValue = lowestElementInSizeLevels[i - 1]
                lowestElementInSizeLevels[i] = element
            }
        }
        print(arr: lowestElementInSizeLevels)
    }

    // get the numbers in the reverse order.
    var lis: [Int] = []
    var element = lowestElementInSizeLevels.last
    while element != nil {
        lis.insert(element!.value, at: 0)
        element = element?.prevValue
    }

    return lis
}


func sizeLevelForElement(lowestElementInSizeLevels: [CustomInt],
                         element: CustomInt) -> Int {
    // lowestElementInSizeLevels is always sorted.
    // so do a binary search
    var lastIndex = lowestElementInSizeLevels.count - 1
    var firstIndex = 0
    var execute = true
    var mid = 0
   
    while execute {
        mid = firstIndex + (lastIndex - firstIndex) / 2
        execute = mid > firstIndex && mid < lastIndex
        if execute == false { continue }

        if element.value > lowestElementInSizeLevels[mid].value {
            firstIndex = mid
        }
        else {
            lastIndex = mid
        }
    }
    // if element is at last and is greater than last element then it should be placed beyond the last.
    if lastIndex == lowestElementInSizeLevels.count - 1 &&
        element.value > lowestElementInSizeLevels.last!.value {
        lastIndex = lastIndex + 1
    }
    return lastIndex
}

func print(arr: [CustomInt]) {
    let values = arr.map{ $0.value}
    print(values)
}
