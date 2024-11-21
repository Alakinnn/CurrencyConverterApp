//
//  Product.swift
//  SubProblem1
//
//  Created by Duong Tran Minh Hoang on 21/11/2024.
//

import Foundation

struct Product {
  let name: String
  let price: Double
  let quantity: Int
  
  init(name: String, price: Double, quantity: Int) {
    self.name = name
    self.price = price
    self.quantity = quantity
  }
}

enum SortOrder {
  case ascending
  case descending
}

enum SortBy {
  case name
  case price
  case quantity
}

enum Attribute {
  case name
  case price
  case quantity
}
