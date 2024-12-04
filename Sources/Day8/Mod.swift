//
//  Mod.swift
//  
//
//  Created by Jake Foster on 12/3/24.
//

import RegexBuilder
import AdventUtilities

struct Mod {
  enum Op: String, CaseIterable { case inc, dec }

  let registerName: String
  let op: Op
  let amount: Int

  init(_ source: any StringProtocol) {
    let match = String(source).wholeMatch(of: Self.regex)!
    registerName = String(match.1)
    op = match.2
    amount = match.3
  }

  func executeWith(_ registers: inout Registers) {
    switch op {
      case .inc: registers.inc(registerName, by: amount)//registers[registerName, default: 0] += amount
      case .dec: registers.dec(registerName, by: amount)//registers[registerName, default: 0] -= amount
    }
  }
}

extension Mod {
  static let regex = Regex {
    Capture {
      OneOrMore { .word }
    }
    " "
    Capture {
      ChoiceOf {
        "inc"
        "dec"
      }
    } transform: {
      Op(rawValue: String($0))!
    }
    " "
    Capture.int
  }
}

