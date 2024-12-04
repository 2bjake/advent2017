import Algorithms
import AdventUtilities
import RegexBuilder

let nameWeightRegex = Regex {
  Capture {
    OneOrMore {
      .word
    }
  }
  " ("
  Capture.int
  ")"
}

class Program {
  let name: String
  let weight: Int
  let supportedProgramNames: [String]
  var supportedPrograms: [Program] = []
  lazy var totalWeight: Int = {
    weight + supportedPrograms.map(\.totalWeight).reduce(0, +)
  }()

  init(source: Substring) {
    let parts = source.split(separator: " -> ")
    let match = parts[0].wholeMatch(of: nameWeightRegex)!
    name = String(match.1)
    weight = match.2
    if parts.count > 1 {
      supportedProgramNames = parts[1].split(separator: ", ").map(String.init)
    } else {
      supportedProgramNames = []
    }
  }

  enum BalancedResult {
    case balanced
    case newWeight(Int)
  }

  func checkBalance() -> BalancedResult {
    let weightToProgram: [Int: [Program]] = supportedPrograms.reduce(into: [:]) { result, value in
      result[value.totalWeight, default: []].append(value)
    }
    if weightToProgram.count == 1 { return .balanced }

    let unbalanced = weightToProgram.values.filter { $0.count == 1 }.only!.only!
    let result = unbalanced.checkBalance()
    if case .balanced = result {
      let balancedTotalWeight = weightToProgram.values.filter { $0.count != 1 }.only!.first!.totalWeight
      let diff = balancedTotalWeight - unbalanced.totalWeight
      return .newWeight(unbalanced.weight + diff)
    } else {
      return result
    }
  }
}

func makePrograms(_ src: String) -> (programs: [Program], rootName: String) {
  let programs = input.split(separator: "\n").map(Program.init)
  let supportedPrograms: Set<String> = programs.reduce(into: []) { result, value in
    result.formUnion(value.supportedProgramNames)
  }
  let allPrograms = Set(programs.map(\.name))
  return (programs, allPrograms.subtracting(supportedPrograms).only!)
}

public func partOne() {
  print(makePrograms(input).rootName) // hlqnsbe
}

func buildTree(programs: [Program], rootName: String) -> Program {
  let nameToProgram = programs.reduce(into: [:]) { result, value in
    result[value.name] = value
  }

  var programsToAttach = [nameToProgram[rootName]!]
  while !programsToAttach.isEmpty {
    let current = programsToAttach.popLast()!
    current.supportedPrograms = current.supportedProgramNames.map { nameToProgram[$0]! }
    programsToAttach.append(contentsOf: current.supportedPrograms)
  }
  return nameToProgram[rootName]!
}

public func partTwo() {
  let (programs, rootName) = makePrograms(input)
  let root = buildTree(programs: programs, rootName: rootName)
  print(root.checkBalance()) // 1993
}
