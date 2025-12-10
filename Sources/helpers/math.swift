import Foundation

public struct Point2d: Hashable, Comparable, CustomStringConvertible {
    public var x: Int
    public var y: Int

    public var description: String {
        return "(x:\(x),y:\(y))"
    }

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public static func < (lhs: Point2d, rhs: Point2d) -> Bool {
        return lhs.x < rhs.x || (lhs.x == rhs.x && lhs.y < rhs.y)
    }

    public static func rectArea(p1: Point2d, p2: Point2d) -> Int {
        return (abs(p1.x - p2.x) + 1) * (abs(p1.y - p2.y) + 1)
    }
}

public struct Point3d: Hashable, CustomStringConvertible {
    public var x: Int
    public var y: Int
    public var z: Int

    public var description: String {
        return "(x:\(x),y:\(y),z:\(z))"
    }

    public init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
}

public func distance(a: Point3d, b: Point3d) -> Double {
    let dX: Double = pow(Double(a.x - b.x), 2)
    let dY: Double = pow(Double(a.y - b.y), 2)
    let dZ: Double = pow(Double(a.z - b.z), 2)
    return sqrt(Double(dX + dY + dZ))
}

public func distance(a: Point2d, b: Point2d) -> Double {
    let dX: Double = pow(Double(a.x - b.x), 2)
    let dY: Double = pow(Double(a.y - b.y), 2)
    return sqrt(Double(dX + dY))
}

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

public func + (lhs: Point2d, rhs: Direction) -> Point2d {
    let offset = rhs.offset
    return Point2d(x: lhs.x + offset.x, y: lhs.y + offset.y)
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
