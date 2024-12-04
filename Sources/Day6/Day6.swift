import Algorithms
import AdventUtilities

func redistributeBlocksFrom(_ idx: Int, in list: inout [Int]) {
  var idx = idx
  var blockCount = list[idx]
  list[idx] = 0

  while blockCount > 0 {
    idx = (idx + 1) % list.count
    list[idx] += 1
    blockCount -= 1
  }
}

func mostBlocksIdxIn(_ list: [Int]) -> Int {
  var mostIdx = 0

  for i in list.indices {
    if list[i] > list[mostIdx] {
      mostIdx = i
    }
  }
  return mostIdx
}

public func findLoop() -> (cycleCount: Int, loopCount: Int){
  var list = input.split(separator: "  ").compactMap(Int.init)
  var configs = [[Int]: Int]()
  var cycleCount = 0
  while configs[list] == nil {
    configs[list] = cycleCount
    cycleCount += 1
    let mostIdx = mostBlocksIdxIn(list)
    redistributeBlocksFrom(mostIdx, in: &list)
  }
  return (cycleCount, cycleCount - configs[list]!)
}

public func partOne() {
  print(findLoop().cycleCount) // 14029
}

public func partTwo() {
  print(findLoop().loopCount) // 2765
}
