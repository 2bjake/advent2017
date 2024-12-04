//
//  Instruction.swift
//
//
//  Created by Jake Foster on 12/3/24.
//

struct Instruction {
  let mod: Mod
  let conditional: Conditional

  init(_ source: any StringProtocol) {
    let parts = source.split(separator: " if ")
    mod = Mod(parts[0])
    conditional = Conditional(parts[1])
  }

  func runWith(_ registers: inout Registers) {
    if conditional.evaluateWith(registers) {
      mod.executeWith(&registers)
    }
  }
}
