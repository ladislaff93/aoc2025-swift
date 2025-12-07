import Foundation
import helpers

public struct Day6_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        var arr = input.split(separator: "\n").map {
            String($0).split(separator: " ").map { String($0) }
        }

        var result = 0

        let yMax = arr.count - 2
        let xMax = arr[0].count - 1

        for x in 0...xMax {
            let op = arr[arr.count - 1][x]
            for y in 0...yMax - 1 {
                if op == "*" {
                    arr[y + 1][x] = String(Int(arr[y][x])! * Int(arr[y + 1][x])!)
                } else if op == "+" {
                    arr[y + 1][x] = String(Int(arr[y][x])! + Int(arr[y + 1][x])!)
                } else if op == "-" {
                    arr[y + 1][x] = String(Int(arr[y][x])! - Int(arr[y + 1][x])!)
                } else if op == "/" {
                    arr[y + 1][x] = String(Int(arr[y][x])! / Int(arr[y + 1][x])!)
                }
            }
            result += Int(arr[yMax][x])!
        }
        print(result)
    }
}

public struct Day6_2: Solver {
    public init() {}
    public func solve(_ input: String) {
        let lines = input.split(separator: "\n").map { String($0) }
        let operators = lines.last!
        let numLines = lines.dropLast()

        guard let maxLen = numLines.map({ $0.count }).max() else { return }

        var grandTotal = 0
        var currentProblem: [Int] = []
        var currentOp: Character = "+"

        // Read right-to-left
        for x in stride(from: maxLen - 1, through: 0, by: -1) {
            // Build number from this column (top to bottom)
            var digitString = ""
            for line in numLines {
                if x < line.count {
                    let char = line[line.index(line.startIndex, offsetBy: x)]
                    if char != " " {
                        digitString.append(char)
                    }
                }
            }

            if digitString.isEmpty {
                // Empty column - separator between problems
                if !currentProblem.isEmpty {
                    let answer = calculateProblem(currentProblem, op: currentOp)
                    grandTotal += answer
                    currentProblem = []
                }
            } else {
                // This column forms a number
                if let num = Int(digitString) {
                    currentProblem.append(num)
                }

                // Get operator
                if x < operators.count {
                    let opChar = operators[operators.index(operators.startIndex, offsetBy: x)]
                    if opChar != " " {
                        currentOp = opChar
                    }
                }
            }
        }

        // Last problem
        if !currentProblem.isEmpty {
            let answer = calculateProblem(currentProblem, op: currentOp)
            grandTotal += answer
        }

        print(grandTotal)
    }

    func calculateProblem(_ numbers: [Int], op: Character) -> Int {
        guard !numbers.isEmpty else { return 0 }
        var result = numbers[0]
        for num in numbers.dropFirst() {
            switch op {
            case "*": result *= num
            case "+": result += num
            case "-": result -= num
            case "/": result /= num
            default: break
            }
        }
        return result
    }
}
