import helpers

public struct Range {
    var left: Int
    var right: Int
}

public struct Day2_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        let ranges = input.split(separator: ",").compactMap { line -> Range? in
            guard !line.isEmpty else { return nil }
            let ranges = line.split(separator: "-")
            return Range(
                left: Int(ranges[0].trimmingCharacters(in: .whitespacesAndNewlines))!,
                right: Int(ranges[1].trimmingCharacters(in: .whitespacesAndNewlines))!,
            )
        }
        var result = 0
        for range in ranges {
            for i in range.left ... range.right {
                print(i)
                if isInvalid(i) {
                    result += i
                }
            }
        }
        print(result)
    }

    func isInvalid(_ num: Int) -> Bool {
        let s = String(num)
        guard s.count % 2 == 0 else { return false } // Skip odd-length like 111

        let chars = Array(s)
        let mid = chars.count / 2
        return chars[0 ..< mid] == chars[mid ..< chars.count]
    }
}

public struct Day2_2: Solver {
    public init() {}

    public func solve(_ input: String) {
        let ranges = input.split(separator: ",").compactMap { line -> Range? in
            guard !line.isEmpty else { return nil }
            let ranges = line.split(separator: "-")
            return Range(
                left: Int(ranges[0].trimmingCharacters(in: .whitespacesAndNewlines))!,
                right: Int(ranges[1].trimmingCharacters(in: .whitespacesAndNewlines))!,
            )
        }
        var result = 0
        for range in ranges {
            for i in range.left ... range.right {
                if isInvalid(i) {
                    result += i
                }
            }
        }
        print(result)
    }

    func isInvalid(_ num: Int) -> Bool {
        let s = String(num)
        let len = s.count

        // Try all possible pattern lengths (divisors of total length)
        for patternLen in 1 ..< len {
            // Pattern length must divide evenly into total length
            guard len % patternLen == 0 else { continue }

            // Check if repeating the pattern gives us the full string
            let pattern = s.prefix(patternLen)
            let repeated = String(repeating: String(pattern), count: len / patternLen)

            if repeated == s {
                return true
            }
        }

        return false
    }
}

/*
 66 invalid
 101 valid
 111 invalid
 1010 invalid

 invalid IDs by looking for any ID which is made only of some sequence of digits repeated twice. So, 55 (5 twice), 6464 (64 twice), and 123123 (123 twice) would all be invalid IDs.

 an ID is invalid if it is made only of some sequence of digits repeated at least twice. So, 12341234 (1234 two times), 123123123 (123 three times), 1212121212 (12 five times), and 1111111 (1 seven times) are all invalid IDs.
 */
