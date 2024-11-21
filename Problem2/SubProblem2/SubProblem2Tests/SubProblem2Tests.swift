//
//  SubProblem2Tests.swift
//  SubProblem2Tests
//
//  Created by Duong Tran Minh Hoang on 21/11/2024.
//

import XCTest
@testable import SubProblem2

final class AlgoTests: XCTestCase {
  func testFindMissingElement_WithMissingMiddleElement() {
    // Given
    let input = [1, 2, 4, 5]
    
    // When
    let result = findMissingElement(arr: input)
    
    // Then
    XCTAssertEqual(result, 3, "Should find 3 as the missing element")
  }
  
  func testFindMissingElement_WithMissingFirstElement() {
    // Given
    let input = [2, 3, 4, 5]
    
    // When
    let result = findMissingElement(arr: input)
    
    // Then
    XCTAssertEqual(result, 1, "Should find 1 as the missing element")
  }
  
  func testFindMissingElement_WithMissingLastElement() {
    // Given
    let input = [1, 2, 3, 4]
    
    // When
    let result = findMissingElement(arr: input)
    
    // Then
    XCTAssertEqual(result, 5, "Should find 5 as the missing element")
  }
  
  func testFindMissingElement_WithSingleElement() {
    // Given
    let input = [1]
    
    // When
    let result = findMissingElement(arr: input)
    
    // Then
    XCTAssertEqual(result, 2, "Should find 2 as the missing element")
  }
  
  func testFindMissingElement_WithLargerSequence() {
    // Given
    let input = [1, 2, 3, 4, 5, 6, 7, 9, 10]
    
    // When
    let result = findMissingElement(arr: input)
    
    // Then
    XCTAssertEqual(result, 8, "Should find 8 as the missing element")
  }
}
