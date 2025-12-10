import Foundation

public func solveParallel<T, R>(_ items: [T], transform: @escaping (T) -> R) -> [R] {
    var results = [R?](repeating: nil, count: items.count)
    DispatchQueue.concurrentPerform(iterations: items.count) { i in
        results[i] = transform(items[i])
    }
    return results.compactMap(\.self)
}

