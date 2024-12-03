import Algorithms
import AdventUtilities

func addAdjacents(_ str: String) -> Int {
  let sum = str.first == str.last ? Int(str.first!)! : 0

  return str.adjacentPairs().map {
    $0.0 == $0.1 ? Int($0.0)! : 0
  }.reduce(sum, +)
}

public func partOne() {
  print(addAdjacents(input))
}

public func partTwo() {
  let digits = input.compactMap(Int.init)
  var sum = 0
  for i in digits.indices {
    let nextIdx = (i + digits.count / 2) % digits.count
    if digits[i] == digits[nextIdx] {
      sum += digits[i]
    }
  }
  print(sum)
}
