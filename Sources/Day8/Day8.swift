import Algorithms

func processInstructions() -> (maxValue: Int, curMax: Int) {
  var registers = Registers()

  let instructions = input.split(separator: "\n").map(Instruction.init)
  for instruction in instructions {
    instruction.runWith(&registers)
  }
  return (registers.maxValue, registers.curMax!)
}

public func partOne() {
  print(processInstructions().curMax) // 4877
}

public func partTwo() {
print(processInstructions().maxValue) // 5471
}
