import helpers

var testStartValue: Int = 50

struct Instruction {
    enum Direction {
        case left
        case right

        static func from(_ character: Character) -> Direction? {
            switch character {
            case "L":
                .left
            case "R":
                .right
            default:
                nil
            }
        }
    }

    var directions: Direction
    var steps: Int
}

public struct Day1_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        let lines = input.split(separator: "\n").compactMap { line -> Instruction? in
            guard let dir = Instruction.Direction.from(line[line.startIndex]) else {
                return nil
            }
            guard let steps = Int(line.dropFirst()) else {
                return nil
            }
            return Instruction(directions: dir, steps: steps)
        }

        var result = 0

        for line in lines {
            print("\(testStartValue)")
            switch line.directions {
            case .left:
                testStartValue = (testStartValue - line.steps) % 100
                if testStartValue == 0 {
                    result += 1
                }
            case .right:
                testStartValue = (testStartValue + line.steps) % 100
                if testStartValue == 0 {
                    result += 1
                }
            }
        }

        print("\(result)")
    }
}

public struct Day1_2: Solver {
    public init() {}

    public func solve(_ input: String) {
        let lines = input.split(separator: "\n").compactMap { line -> Instruction? in
            guard let dir = Instruction.Direction.from(line[line.startIndex]) else {
                return nil
            }
            guard let steps = Int(line.dropFirst()) else {
                return nil
            }
            return Instruction(directions: dir, steps: steps)
        }

        var result = 0

        for line in lines {
            for _ in 0 ..< line.steps {
                switch line.directions {
                case .left:
                    testStartValue = (testStartValue - 1) % 100
                    if testStartValue < 0 {
                        testStartValue = testStartValue + 100
                    }
                case .right:
                    testStartValue = (testStartValue + 1) % 100
                }

                if testStartValue == 0 {
                    result += 1
                }
            }
        }

        print("\(result)")
    }
}
