//
//  Registers.swift
//
//
//  Created by Jake Foster on 12/3/24.
//

struct Registers {
  var nameToValue: [String: Int] = [:]
  var maxValue = 0

  var curMax: Int? {
    nameToValue.values.max()
  }

  mutating func inc(_ name: String, by value: Int) {
    let newValue = nameToValue[name, default: 0] + value
    if newValue > maxValue { maxValue = newValue }
    nameToValue[name] = newValue

  }

  mutating func dec(_ name: String, by value: Int) {
    let newValue = nameToValue[name, default: 0] - value
    if newValue > maxValue { maxValue = newValue }
    nameToValue[name] = newValue
  }

  func value(_ name: String) -> Int {
    nameToValue[name, default: 0]
  }
}
