//
//  InventoryTests.swift
//  SubProblem1Tests
//
//  Created by Duong Tran Minh Hoang on 21/11/2024.
//

import Foundation
import XCTest
@testable import SubProblem1

final class InventoryTests: XCTestCase {
  var sut: Inventory!
  var products: [Product]!
  
  override func setUp() {
    super.setUp()
    // Test data with known order for each sort type:
    // By name (A-Z):     [AirPods, iPad, iPhone, MacBook]
    // By price (low-high): [AirPods($199), iPad($599), iPhone($999), MacBook($1299)]
    // By quantity (low-high): [MacBook(5), iPhone(10), iPad(15), AirPods(20)]
    products = [
      Product(name: "iPhone", price: 999.99, quantity: 10),   // name: 3rd, price: 3rd, qty: 2nd
      Product(name: "MacBook", price: 1299.99, quantity: 5),  // name: 4th, price: 4th, qty: 1st
      Product(name: "AirPods", price: 199.99, quantity: 20),  // name: 1st, price: 1st, qty: 4th
      Product(name: "iPad", price: 599.99, quantity: 15)      // name: 2nd, price: 2nd, qty: 3rd
    ]
    sut = Inventory(stock: products)
  }
  
  override func tearDown() {
    sut = nil
    products = nil
    super.tearDown()
  }
  
  // MARK: - Sort Tests
  
  func testPrintInventorySortByName() {
    print("\nExpected order by name ascending: AirPods, iPad, iPhone, MacBook")
    print("Testing sort by name ascending:")
    sut.printInventory(sortBy: .name, sortOrder: .ascending)
    
    print("\nExpected order by name descending: MacBook, iPhone, iPad, AirPods")
    print("Testing sort by name descending:")
    sut.printInventory(sortBy: .name, sortOrder: .descending)
  }
  
  func testPrintInventorySortByPrice() {
    print("\nExpected order by price ascending: AirPods($199), iPad($599), iPhone($999), MacBook($1299)")
    print("Testing sort by price ascending:")
    sut.printInventory(sortBy: .price, sortOrder: .ascending)
    
    print("\nExpected order by price descending: MacBook($1299), iPhone($999), iPad($599), AirPods($199)")
    print("Testing sort by price descending:")
    sut.printInventory(sortBy: .price, sortOrder: .descending)
  }
  
  func testPrintInventorySortByQuantity() {
    print("\nExpected order by quantity ascending: MacBook(5), iPhone(10), iPad(15), AirPods(20)")
    print("Testing sort by quantity ascending:")
    sut.printInventory(sortBy: .quantity, sortOrder: .ascending)
    
    print("\nExpected order by quantity descending: AirPods(20), iPad(15), iPhone(10), MacBook(5)")
    print("Testing sort by quantity descending:")
    sut.printInventory(sortBy: .quantity, sortOrder: .descending)
  }
  
  // MARK: - Attribute Filter Tests
  
  func testPrintInventoryWithSelectedAttributes() {
    // Expected output should maintain same sort order but only show selected attributes
    print("\nTesting name only (default sort):")
    sut.printInventory(attributes: [.name])
    
    print("\nTesting price only (default sort):")
    sut.printInventory(attributes: [.price])
    
    print("\nTesting quantity only (default sort):")
    sut.printInventory(attributes: [.quantity])
    
    print("\nTesting name and price (default sort):")
    sut.printInventory(attributes: [.name, .price])
    
    print("\nTesting name and quantity (default sort):")
    sut.printInventory(attributes: [.name, .quantity])
    
    print("\nTesting price and quantity (default sort):")
    sut.printInventory(attributes: [.price, .quantity])
  }
  
  // MARK: - Value Tests
  
  func testPrintInventoryTotal() {
    print("\nExpected total: $29,499.50")
    print("Testing inventory total value:")
    sut.printInventoryTotal()
  }
  
  func testPrintMostExpensive() {
    // Expected: MacBook ($1299.99)
    print("\nExpected most expensive: MacBook")
    print("Testing most expensive item:")
    sut.printMostExpensive()
  }
  
  // MARK: - Item Existence Tests
  
  func testPrintItemExists() {
    print("\nExpected: Item exists in inventory!")
    print("Testing existing item:")
    sut.printItemExists(productName: "iPhone")
    
    print("\nExpected: Item does not exist in inventory")
    print("Testing non-existing item:")
    sut.printItemExists(productName: "Android")
    
    print("\nExpected: Item exists in inventory! (case-insensitive)")
    print("Testing case-insensitive search:")
    sut.printItemExists(productName: "iphone")
  }
  
  // MARK: - Edge Cases
  
  func testEmptyInventory() {
    // Expected: Empty inventory list, $0 total, "No products in inventory" for most expensive
    print("\nExpected: Empty inventory with zero total")
    print("Testing empty inventory:")
    let emptyInventory = Inventory(stock: [])
    emptyInventory.printInventory()
    emptyInventory.printInventoryTotal()
    emptyInventory.printMostExpensive()
    emptyInventory.printItemExists(productName: "anything")
  }
}
