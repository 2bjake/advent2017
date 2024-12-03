import Algorithms

func noDuplicates<S: StringProtocol>(_ words: [S]) -> Bool {
  var set = Set<S>()
  for word in words {
    if set.contains(word) { return false }
    set.insert(word)
  }
  return true
}

func makeLists(sortLetters: Bool) -> [[String]] {
  input.split(separator: "\n").map {
    $0.split(separator: " ").map {
      if sortLetters { return String($0.sorted()) }
      return String($0)
    }
  }
}

func countValidPassphrases(disallowAnagrams: Bool = false) -> Int {
  makeLists(sortLetters: disallowAnagrams).filter(noDuplicates).count
}

public func partOne() {
  print(countValidPassphrases()) // 325
}

public func partTwo() {
  print(countValidPassphrases(disallowAnagrams: true)) // 119
}
