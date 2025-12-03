import Foundation

public protocol Solver {
    func solve(_ input: String)
}

public extension Solver {
    func run(day: String, file: String = #filePath, useTest: Bool = false) {
        let projectRoot = URL(fileURLWithPath: file)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .path

        let fileName = useTest ? "test_input" : "input"
        let inputPath = "\(projectRoot)/day\(day)/\(fileName)"

        if let input = loadInput(inputPath) {
            solve(input)
        }
    }
}
