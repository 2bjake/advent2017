import Algorithms
import AdventUtilities

func escapeCount(_ inst: [Int], adjustment: (Int) -> Int) -> Int {
  var inst = inst
  var idx = 0
  var stepCount = 0

  while idx + inst[idx] < inst.count {
    let temp = inst[idx]
    inst[idx] = adjustment(inst[idx])
    idx += temp
    stepCount += 1
  }
  return stepCount + 1
}

public func partOne() {
  let instructions = input.split(separator: "\n").compactMap(Int.init)
  print(escapeCount(instructions) { $0 + 1}) // 394829
}

public func partTwo() {
  let instructions = input.split(separator: "\n").compactMap(Int.init)
  print(escapeCount(instructions) { $0 < 3 ? $0 + 1 : $0 - 1 }) // 31150702
}
