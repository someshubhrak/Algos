//
//  MergingList.swift
//  Samples
//
//  Created by Someshubhra Karmakar on 18/02/22.
//

import Foundation

class Node {
    var value: Int = 0
    var next: Node!

    init(value: Int) {
        self.value = value
    }
}

func testMerge() {
    var listA: Node!
    var listB: Node!
    
    push(list: &listA, value: 1)
    push(list: &listA, value: 2)
    push(list: &listA, value: 5)
    push(list: &listA, value: 6)
    
    
    push(list: &listB, value: 3)
    push(list: &listB, value: 4)
    push(list: &listB, value: 7)
    
    var mergedList: Node! = mergeListV3(listA: listA, listB: listB)
    while mergedList != nil {
        print(mergedList.value)
        mergedList = mergedList.next
    }
}


func push( list: inout Node!, value: Int) {
    var ptr: Node! = list
    if list == nil {
        list = Node(value: value)
        return
    }
    while ptr.next != nil {
        ptr = ptr.next
    }
    ptr.next = Node(value: value)
}

// in place, no extra space
func mergeListV3(listA: Node, listB: Node) -> Node! {
    var lowValue: Node! = listA.value < listB.value ? listA : listB
    var highValue: Node! = listA.value > listB.value ? listA : listB
    let mergedListStart: Node! = lowValue
    
    while lowValue != nil, highValue != nil {
        while lowValue.next != nil, highValue != nil,
              lowValue.next.value < highValue.value {
            lowValue = lowValue.next
        }
        let temp = lowValue.next
        lowValue.next = highValue
        highValue = temp
    }
    return mergedListStart
    
}

func mergeListV2(listA: Node, listB: Node) -> Node! {
    var mergedList: Node! = nil
    var mergedListStart: Node! = nil
    
    var nodeA: Node! = listA
    var nodeB: Node! = listB
    
    while nodeA != nil || nodeB != nil {
//        print("nodeA \(nodeA.value)")
//        print("nodeB \(nodeB.value)")
        var nodeToAdd: Node!
        if nodeA == nil {
            nodeToAdd = nodeB
            nodeB = nodeB.next
        }
        else if nodeB == nil {
            nodeToAdd = nodeA
            nodeA = nodeA.next
        }
        else if nodeA.value > nodeB.value {
            nodeToAdd = nodeB
            nodeB = nodeB.next
        }
        else {
            nodeToAdd = nodeA
            nodeA = nodeA.next
        }
        var newNode = Node(value: nodeToAdd.value)
        if mergedList == nil {
            mergedListStart = newNode
            mergedList = mergedListStart
        } else {
            mergedList.next = newNode
            mergedList = mergedList.next
        }
       
    }
    return mergedListStart
    
}

func mergeList(listA: Node, listB: Node) -> Node! {
    var mergedList: Node! = nil
    var mergedListStart: Node! = nil
    var lowValue: Node! = listA.value < listB.value ? listA : listB
    var highValue: Node! = listA.value > listB.value ? listA : listB
    
    while lowValue != nil, highValue != nil {
        while lowValue != nil,
                highValue != nil,
                lowValue.value < highValue.value {

            let newNode = Node(value: lowValue.value)
            if mergedList == nil {
                mergedListStart = newNode
                mergedList = mergedListStart
            } else {
                mergedList.next = newNode
                mergedList = mergedList.next
            }
            lowValue = lowValue.next
        }

        // swap pointers
        let temp = lowValue
        lowValue = highValue
        highValue = temp
        
    }
    var leftToMerge: Node! = lowValue != nil ? lowValue : highValue
    while leftToMerge != nil {
        let newNode = Node(value: leftToMerge.value)
        if mergedList == nil {
            mergedListStart = newNode
            mergedList = mergedListStart
        } else {
            mergedList.next = newNode
            mergedList = mergedList.next
        }
        leftToMerge = leftToMerge.next
    }
    return mergedListStart
}
