//
//  WaterLogging.swift
//  Algos
//
//  Created by Someshubhra Karmakar on 06/03/22.
//

import Foundation

struct ConcreteSegment {
    var totalheight: Int = 0
    var width: Int = 0
}
typealias Segment = ConcreteSegment

func testTotalWaterLogged() {
    // Needs few more testining , back track method
    //let segments: [Int] = [8,4,7]
    //let segments: [Int] = [7,4,8]
    //let segments: [Int] = [7,4,3,8]
    //let segments: [Int] = [7,4,3,9,5,8]
    let segments: [Int] = [3,4,7,6,7]
    print("testTotalWaterLogged \(totalWaterLogged(segments: segments))")
}

func totalWaterLogged(segments: [Int]) -> Int {
    var totalWaterLogged: Int = 0
    /// This always contain  10 , 8, 4, 3,...
    /// If 5 is added, 10 , 8, 4, 3, 5, downhill stack it is reduced to 10,8,5
    /// the curve created by 8,4,3,5 is reduced to 8, 5
    var downHillStack: [Segment] = []
    var index: Int = 0
    
    while index < segments.count {
        
        //  if it is a rise of the curve , like 4 -> 7
        if index > 0 , segments[index] > segments [index - 1] {
            // back track to get the water logged
            let currentHeight = segments[index]
            var sumCurveHeight: Int = 0
            var curveWidth: Int = 0
            var newElements: [Segment] = []
            var run = true
            while run {
                // if left segment greater than the current segment
                if downHillStack.last?.totalheight ?? 0 >= currentHeight {
                    run = false
                    let seg = Segment(totalheight: sumCurveHeight, width: curveWidth)
                    newElements.append(seg)
                    totalWaterLogged = totalWaterLogged + (( currentHeight * curveWidth) - sumCurveHeight)
                }
                // if left segment less than the current segment
                else {
                    let totalheight = downHillStack.last?.totalheight ?? 0
                    let width = downHillStack.last?.width ?? 0
                    // if this the last left element
                    if downHillStack.count == 1 {
                        run = false
                        totalWaterLogged = totalWaterLogged + ((totalheight * curveWidth) - sumCurveHeight)
                    }
                    // otherwise simply add to the curve calculation
                    else {
                        sumCurveHeight = sumCurveHeight + totalheight
                        curveWidth = curveWidth + width
                    }
                    downHillStack.removeLast()
                }
            }
            downHillStack.append(contentsOf: newElements)
        }

        // add this segment in the stack
        let seg = Segment(totalheight: segments[index], width: 1)
        downHillStack.append(seg)
        index = index + 1
    }
    return totalWaterLogged
}
