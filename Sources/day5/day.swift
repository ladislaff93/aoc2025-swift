import helpers

func mergeRanges(_ ranges: [(Int, Int)]) -> [(Int, Int)] {
    var merged: [(Int, Int)] = []
    for range in ranges {
        if merged.isEmpty {
            merged.append(range)
        } else {
            let last = merged.removeLast()
            // check if the current lower is smaller than previous upper bound
            if range.0 <= last.1 + 1 {
                // last is always smaller than the current checked range
                merged.append((last.0, max(range.1, last.1)))
            } else {
                merged.append(last)
                merged.append(range)
            }
        }
    }
    return merged
}

public struct Day5_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        var splitted = input.split(separator: "\n\n").map { $0 }

        // sort ranges ascending
        let ranges: [(Int, Int)] = splitted.removeFirst()
            .split(separator: "\n")
            .compactMap { range -> (Int, Int)? in
                let parts = range.split(separator: "-")
                    .compactMap { Int(String($0)) }
                return (parts[0], parts[1])
            }
            .sorted { $0.0 <= $1.0 }

        let ingredients = splitted.removeFirst()
            .split(separator: "\n")
            .map { Int($0)! }

        let result = ingredients.filter { ingredient in
            mergeRanges(ranges).contains { $0.0 <= ingredient && ingredient <= $0.1 }
        }.count

        print(result)
    }
}

public struct Day5_2: Solver {
    public init() {}

    public func solve(_ input: String) {
        var splitted = input.split(separator: "\n\n").map { $0 }

        let ranges: [(Int, Int)] = splitted.removeFirst()
            .split(separator: "\n")
            .compactMap { range -> (Int, Int)? in
                let parts = range.split(separator: "-").compactMap { Int(String($0)) }
                return (parts[0], parts[1])
            }
            .sorted { $0.0 <= $1.0 }

        let result = mergeRanges(ranges).reduce(0, {$0 + ($1.0...$1.1).count})
        print(result)
    }
}
