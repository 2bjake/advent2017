import Algorithms
import AdventUtilities

func parseLine(_ s: Substring) -> [Int] {
  s.split(separator: "  ").compactMap(Int.init)
}

public func partOne() {
  let result = input
    .split(separator: "\n")
    .map(parseLine)
    .map {
      let (min, max) = $0.minAndMax()!
      return max - min
    }.reduce(0, +)
  print(result) // 51139
}

func processValues(_ values: [Int]) -> Int {
  for perm in values.permutations(ofCount: 2) {
    let (q, r) = perm[0].quotientAndRemainder(dividingBy: perm[1])
    if r == 0 {
      return q
    }
  }
  fatalError()
}

public func partTwo() {
  let result = input
    .split(separator: "\n")
    .map(parseLine)
    .map(processValues)
    .reduce(0, +)
  print(result) // 272

}
