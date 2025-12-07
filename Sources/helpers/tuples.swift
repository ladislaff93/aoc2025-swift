import Foundation

// (X, Y)
public enum Direction: CaseIterable {
    case up, upRight, right, downRight, down, downLeft, left, upLeft

    var offset: (x: Int, y: Int) {
        switch self {
        case .up: return (0, -1)
        case .upRight: return (1, -1)
        case .right: return (1, 0)
        case .downRight: return (1, 1)
        case .down: return (0, 1)
        case .downLeft: return (-1, 1)
        case .left: return (-1, 0)
        case .upLeft: return (-1, -1)
        }
    }
}

public func + (lhs: (Int, Int), rhs: (Int, Int)) -> (Int, Int) {
    return (lhs.0 + rhs.0, lhs.1 + rhs.1)
}

public func + (lhs: (Int, Int), rhs: Direction) -> (Int, Int) {
    let offset = rhs.offset
    return (lhs.0 + offset.x, lhs.1 + offset.y)
}

public func validIdx2d(x: Int, y: Int, arr: [[Any]]) -> Bool {
    return 0 <= y && y < arr.count && 0 <= x && x < arr[0].count
}

public func validIdx2d(_ t: (x: Int, y: Int), arr: [[Any]]) -> Bool {
    return 0 <= t.y && t.y < arr.count && 0 <= t.x && t.x < arr[t.y].count
}

public func validIdx1d(_ x: Int, arr: [Any]) -> Bool {
    return 0 <= x && x < arr.count
}
