//
//  AppDelegate.swift
//  Algos
//
//  Created by Someshubhra Karmakar on 30/12/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        let res = findLongestIncreasingSeq(inputElements: [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15])
//        print("Longest sequence \(res)")
        
      // testNumberOfOccurances()
       //  testPallindrome()
        //testMerge()
        testTotalWaterLogged()
        //LongestIncreasingSeqV2.test()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func testNumberOfOccurances() {
       _ = numberOfOccurances(main: ["r", "r", "a", "b", "b", "a", "b", "i", "r", "t"], sequence: ["r", "a", "b", "b", "i", "t"])
        
        _ = numberOfOccurances(main: ["a", "b", "a", "b", "b"], sequence: ["a", "b"])
        
        _ = numberOfOccurances(main: ["a", "a", "a", "a"], sequence: ["a", "a", "a"])
        
        _ = numberOfOccurances(main: ["r", "a", "r", "a", "r"], sequence: ["r", "a", "r"])
    }

    func testPallindrome() {
        // b  b  b  a.  b.  b.  a
       // _ = pallindromePartionioning(characters: "ababbbabbababa".map{$0})
       // _ = pallindromePartionioning(characters: "ababbbabbab".map{$0})
        _ = pallindromePartionioning(characters: "ababbbabbababa".map{$0})
       // _ = pallindromePartionioning(characters: "aabb".map{$0})
        
    }


}

