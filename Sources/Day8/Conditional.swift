//
//  Conditional.swift
//
//
//  Created by Jake Foster on 12/3/24.
//

import RegexBuilder
import AdventUtilities

struct Conditional {
  enum Comparison: String, CaseIterable {
    case lt = "<"
    case gt = ">"
    case lte = "<="
    case gte = ">="
    case equal = "=="
    case notEqual = "!="
  }

  let registerName: String
  let comparison: Comparison
  let value: Int

  init(_ source: any StringProtocol) {
    let match = String(source).wholeMatch(of: Self.regex)!
    registerName = String(match.1)
    comparison = match.2
    value = match.3
  }

  func evaluateWith(_ registers: Registers) -> Bool {
    comparison.evaluate(registers.value(registerName), value)
  }
}

// b inc 5 if a > 1

extension Conditional {
  static let regex = Regex {
    Capture {
      OneOrMore { .word }
    }
    " "
    Capture {
      ChoiceOf {
        "<"
        ">"
        "<="
        ">="
        "=="
        "!="
      }
    } transform: { Comparison(rawValue: String($0))! }
    " "
    Capture.int
  }
}

extension Conditional.Comparison {
  func evaluate(_ x: Int, _ y: Int) -> Bool {
    switch self {
      case .lt: x < y
      case .gt: x > y
      case .lte: x <= y
      case .gte: x >= y
      case .equal: x == y
      case .notEqual: x != y
    }
  }
}
