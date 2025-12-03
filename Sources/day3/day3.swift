import Foundation
import helpers

public struct Day3_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        let banks: [[UInt8]] = input.split(separator: "\n")
            .map { $0.compactMap { UInt8(String($0)) } }
        let results = solveParallel(banks) { findMaxNum($0) }
        print(results.reduce(0) { $0 + Int($1) })
    }

    func findMaxNum(_ bank: [UInt8]) -> UInt8 {
        var maxN = UInt8.min
        var maxSuffix = bank.last!

        for i in stride(from: bank.count - 2, through: 0, by: -1) {
            let n = bank[i] * 10 + maxSuffix
            maxN = max(maxN, n)
            maxSuffix = max(maxSuffix, bank[i])
        }

        return maxN
    }
}

public struct Day3_2: Solver {
    public init() {}

    public func solve(_ input: String) {
        let banks: [[UInt8]] = input.split(separator: "\n")
            .map { $0.compactMap { UInt8(String($0)) } }
        let results = solveParallel(banks) { findMaxNum($0) }
        print(results.reduce(0, +))
    }

    func findMaxNum(_ bank: [UInt8]) -> UInt {
        var bank = bank
        let toRemove = bank.count - 12

        for _ in 0 ..< toRemove {
            let idx = smallestNumIdx(bank)
            bank.remove(at: idx)
        }
        return UInt(bank.map(String.init).joined())!
    }

    func smallestNumIdx(_ bank: [UInt8]) -> Int {
        for i in 0 ..< bank.count - 1 {
            if bank[i] < bank[i + 1] {
                return i
            }
        }
        return bank.count - 1
    }
}

/*
 can't change order of the batteries
 needs to turn on 12 batteries (12 numbers)
 biggest number from the bank
 */
