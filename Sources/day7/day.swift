import Foundation
import helpers

public struct Day7_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        let lines =
            input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .map { Array($0) }

        var visitedSplitters = Set<String>()
        var stack: [(x: Int, y: Int)] = [(x: lines[0].firstIndex(of: "S")!, y: 0)]

        while !stack.isEmpty {
            var currIdx = stack.popLast()!

            while validIdx2d(currIdx, arr: lines) {
                let currChar = lines[currIdx.y][currIdx.x]

                print(
                    "Current x: \(currIdx.x), y: \(currIdx.y), character: \(lines[currIdx.y][currIdx.x])"
                )

                if currChar == "^" {
                    let splitterIdx = "\(currIdx.x),\(currIdx.y)"
                    if !visitedSplitters.contains(splitterIdx) {
                        visitedSplitters.insert(splitterIdx)

                        if validIdx2d(currIdx + .right, arr: lines) {
                            stack.append(currIdx + .right)
                        }
                        if validIdx2d(currIdx + .left, arr: lines) {
                            stack.append(currIdx + .left)
                        }
                    }
                    break
                }
                currIdx = (currIdx.x, currIdx.y + 1)
            }
        }
        print(visitedSplitters.count)
    }

}

public struct Day7_2: Solver {
    public init() {}
    public func solve(_ input: String) {
        let lines =
            input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .map { Array($0) }

        var cache = [String: Int]()
        let result = dfs((x: lines[0].firstIndex(of: "S")!, y: 0), lines: lines, cache: &cache)

        print(result)
    }

    func dfs(_ currIdx: (x: Int, y: Int), lines: [[Substring.Element]], cache: inout [String: Int])
        -> Int
    {
        guard validIdx2d(currIdx, arr: lines) else {
            return 1
        }

        let key = "\(currIdx.x),\(currIdx.y)"

        if let cached = cache[key] {
            return cached
        }

        let currChar = lines[currIdx.y][currIdx.x]
        let result: Int

        if currChar == "^" {
            let leftCount = dfs(currIdx + .downLeft, lines: lines, cache: &cache)
            let rightCount = dfs(currIdx + .downRight, lines: lines, cache: &cache)
            result = leftCount + rightCount
        } else {
            result = dfs(currIdx + .down, lines: lines, cache: &cache)
        }

        cache[key] = result
        return result
    }
}
