//
//  Algo.swift
//  SubProblem2
//
//  Created by Duong Tran Minh Hoang on 21/11/2024.
//

import Foundation

// This problem utilize the formula to calculate some of 1 to n + 1 (n is input array length)
// (n * (n + 1)) / 2
func findMissingElement(arr: [Int]) -> Int {
  let seqLength = arr.count + 1
  var sum = (seqLength * (seqLength + 1)) / 2
  
  for el in arr {
    sum -= el
  }
  
  return sum
}
