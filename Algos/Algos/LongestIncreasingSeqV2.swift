//
//  LongestIncreasingSeqV2.swift
//  Algos
//
//  Created by Someshubhra Karmakar on 23/10/22.
//

import Foundation

/// A Better version

/**
 0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15

Steps
 
 0
 --------
 0
 0 8
 
 --------
 0
 0 4
 
 --------
 0
 0 4
 0 4 12
 
 --------
 0
 0 2
 0 4 12
 
 --------
 0
 0 2
 0 4 10
 
 --------
 0
 0 2
 0 2 6
 
 --------
 0
 0 2
 0 2 6
 0 2 6 14
 
 --------
 0
 0 1
 0 2 6
 0 2 6 14
 
 --------
 0
 0 1
 0 2 6
 0 2 6 9
 
 --------
 0
 0 1
 0 2 5
 0 2 6 9
 
 --------
 0
 0 1
 0 2 5
 0 2 6 9
 0 2 6 9 13
 
 --------
 0
 0 1
 0 1 3
 0 2 6 9
 0 2 6 9 13
 
 --------
 0
 0 1
 0 1 3
 0 2 6 9
 0 2 6 9 11
 
 --------
 0
 0 1
 0 1 3
 0 1 3 7
 0 2 6 9 11
 
 --------
 0
 0 1
 0 1 3
 0 1 3 7
 0 2 6 9 11
 0 2 6 9 11 15
 
 


 */


class LongestIncreasingSeqV2 {
    /**
     0
     0 1
     0 1 3
     0 1 3 7
     0 2 6 9 11
     0 2 6 9 11 15
     */
    var processMatrix: [[Int]] = [[]]

    func execute(input: [Int]) -> [Int] {
        for (_, value) in input.enumerated() {
            
            // find the right place in the process matrix where
            // the new value to be added.
            let row = index(value: value, startIndex: 0, endIndex: processMatrix.count - 1)
            if row == -1 { // this is the lowest put at the begining
                processMatrix[0] = [value]
            }
            else {
                var newRow = processMatrix[row]
                newRow.append(value)
                if row + 1 >= processMatrix.count {
                    processMatrix.append([])
                }
                processMatrix[row + 1] = newRow
            }
        }
        
        return processMatrix.last ?? []
    }

    /// Binary search
    func index(value: Int, startIndex: Int, endIndex: Int) -> Int {
        print("\(startIndex)  \(endIndex) *** \(value)")
        if startIndex == -1 || endIndex == -1 {
            return -1
        }

        let nElements = endIndex - startIndex + 1
        if nElements == 1 {
            guard let element = processMatrix[startIndex].last else {
                return -1
            }
            return value < element ? startIndex - 1: startIndex
        }
        else if nElements == 2 {
            guard let first = processMatrix[startIndex].last, let second = processMatrix[endIndex].last else {
                return -1
            }
            if value < first {
                return startIndex - 1
            }
            if value > first , value < second {
                return startIndex
            }
            else {
                return endIndex
            }
        }
        else { // if index more than 2
            let midIndex = (endIndex - startIndex) / 2
            guard let midElement = processMatrix[midIndex].last else {
                return -1
            }
            if value >= midElement {
                return index(value: value, startIndex: midIndex + 1, endIndex: endIndex)
            }
            else {
                return index(value: value, startIndex: startIndex, endIndex: midIndex - 1)
            }
        }
    }

    static func test() {
        let seq = LongestIncreasingSeqV2().execute(input: [ 0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15])
        print(seq)
    }
}

