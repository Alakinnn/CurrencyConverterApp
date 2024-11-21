//
//  Inventory.swift
//  SubProblem1
//
//  Created by Duong Tran Minh Hoang on 21/11/2024.
//

import Foundation

class Inventory {
  private var stock: [Product]
  
  init(stock: [Product]) {
    self.stock = stock
  }
  
  private func padString(_ str: String, length: Int) -> String {
    if str.count >= length {
      return str
    }
    return str + String(repeating: " ", count: length - str.count)
  }
  
  private func formatPrice(_ price: Double) -> String {
    return String(format: "$%.2f", price)
  }
  
  private func sortByName(_ products: [Product], order: SortOrder) -> [Product] {
    products.sorted {
      switch order {
      case .ascending:
        return $0.name.localizedStandardCompare($1.name) == .orderedAscending
      case .descending:
        return $0.name.localizedStandardCompare($1.name) == .orderedDescending
      }
    }
    
  }
  
  private func sortByPrice(_ products: [Product], order: SortOrder) -> [Product] {
    products.sorted {
      switch order {
      case .ascending:
        return $0.price < $1.price
      case .descending:
        return $0.price > $1.price
      }
    }
  }
  
  private func sortByQuantity(_ products: [Product], order: SortOrder) -> [Product] {
    products.sorted {
      switch order {
      case .ascending:
        return $0.quantity < $1.quantity
      case .descending:
        return $0.quantity > $1.quantity
      }
    }
  }
  
  func printInventory(sortBy: SortBy? = nil, sortOrder: SortOrder = .ascending, attributes: Set<Attribute> = [.name, .price, .quantity]) {
    var currentStock = stock
    
    if let sortBy = sortBy {
      currentStock = switch sortBy {
      case .name:
        sortByName(currentStock, order: sortOrder)
      case .price:
        sortByPrice(currentStock, order: sortOrder)
      case .quantity:
        sortByQuantity(currentStock, order: sortOrder)
      }
    }
    
    print("\nInventory List:")
    
    var headerLine = ""
    var separatorLine = ""
    
    if attributes.contains(.name) {
      headerLine += padString("Name", length: 20)
      separatorLine += String(repeating: "-", count: 20)
    }
    if attributes.contains(.price) {
      headerLine += padString("Price", length: 15)
      separatorLine += String(repeating: "-", count: 15)
    }
    if attributes.contains(.quantity) {
      headerLine += "Quantity"
      separatorLine += String(repeating: "-", count: 10)
    }
    
    print(headerLine)
    print(separatorLine)
    
    for product in currentStock {
      var line = ""
      
      if attributes.contains(.name) {
        line += padString(product.name, length: 20)
      }
      if attributes.contains(.price) {
        line += padString(formatPrice(product.price), length: 15)
      }
      if attributes.contains(.quantity) {
        line += String(product.quantity)
      }
      
      print(line)
    }
    
    print("\nTotal Items: \(currentStock.count)")
  }
  
  private func calculateTotal() -> Double {
    stock.reduce(0) { total, product in
      total + (product.price * Double(product.quantity))
    }
  }
  
  func printInventoryTotal() {
    let total = calculateTotal()
    print("Inventory Total Value:")
    print(String(repeating: "-", count: 25))
    print("Total: \(formatPrice(total))")
  }
  
  private func findMostExpensive() -> String {
    guard let mostExpensive = stock.max(by: { $0.price < $1.price }) else {
      return "No products in inventory"
    }
    return mostExpensive.name
  }
  
  func printMostExpensive() {
    let item = findMostExpensive()
    print("Most Expensive Item: \(item)")
  }
  
  private func checkExists(productName: String) -> Bool {
    stock.contains { $0.name.lowercased() == productName.lowercased() }
  }
  
  func printItemExists(productName: String) {
    let bool = checkExists(productName: productName)
    if bool {
      print("Item exists in inventory!")
    } else {
      print("Item does not exist in inventory")
    }
  }
}
