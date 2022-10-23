//
//  PallindromePartioning.swift
//  Algos
//
//  Created by Someshubhra Karmakar on 15/01/22.
//

import Foundation

/*
 Let say array is of five characters ... DP to solve it
 
 
   1        2       3       4       5
   11
            22
                    33
                            44
                                    55
 

 
 1        2       3       4       5
 11       12
          22      23
                  33      34
                          44      45
                                  55
 
 
 1        2       3       4       5
 11       12      13
          22      23      24
                  33      34      35
                          44      45
                                  55
 
 1        2       3       4       5
 11       12      13      14
          22      23      24      25
                  33      34      35
                          44      45
                                  55
 
 1        2       3       4       5
 11       12      13      14      15
          22      23      24      25
                  33      34      35
                          44      45
                                  55
 
 aabbcc
 a 1
 a 1
 b 1
 b 1
 c 1
 c 1
 
 aa 1
 ab 2
 bc 2
 cc 1
 
 aab 2   2
 abb 2   2
 bbc 2   2
 bcc 2   2
 
 
 aabb  2  3
 abbc  3  3
 bbcc  2  3
 
 
 aabbcc  3
 
 */




func pallindromePartionioning( characters: [Character]) -> Int {
    let nCharac = characters.count
    var matrix: [[Int]] =  Array(repeating: Array(repeating: 0, count: nCharac), count: nCharac)
    
    
    var offset = 0
    while offset < nCharac {
        var i = 0
        var k = i + offset
        while i < nCharac, (k < nCharac) {
            if offset == 0 { //text length 1
                matrix[i][i] = 1 // pallindrome
            }
            else if k - i == 1 { // text length 2
                if characters[i] == characters[k] {
                    matrix[i][k] = 1 // pallindrome
                }
            }
            // abba, if bb is pallindrome and 1st == last
            else if matrix[i + 1][k - 1] == 1, characters[i] == characters[k] {
                matrix[i][k] = 1 // pallindrome
            }

            // if not pallindrome then create the minimum divs
            if matrix[i][k] == 0  { // not pallindrome
                var j = i
                var minDivs = matrix[i][j] + matrix[j + 1][k]
                while j < k {
                    let div = matrix[i][j] + matrix[j + 1][k]
                    if div < minDivs {
                        minDivs = div
                    }
                    j = j + 1
                }
                matrix[i][k] = minDivs
            }
        
            i = i + 1
            k = i + offset
        }
        offset = offset + 1
        printMatrix(matrix: matrix, row: nCharac, col: nCharac)
    }

    return matrix[nCharac - 1][nCharac - 1]
}

func printMatrix(matrix: [[Int]], row: Int, col: Int) {
    print("*******************************")
    for r in 0...row - 1 {
        print(matrix[r])
    }
}
