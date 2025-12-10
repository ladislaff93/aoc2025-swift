import Foundation
import helpers

/*
    Read this:
    https://en.wikipedia.org/wiki/Disjoint-set_data_structure
*/
class DisjointSet {
    var parent: [Point3d: Point3d] = [:]
    var size: [Point3d: Int] = [:]

    func makeSet(_ point: Point3d) {
        if parent[point] == nil {
            parent[point] = point
            size[point] = 1
        }
    }

    func find(_ point: Point3d) -> Point3d {
        if parent[point] != point {
            parent[point] = find(parent[point]!)
            return parent[point]!
        }
        return parent[point]!
    }

    func union(_ a: Point3d, _ b: Point3d) {
        // 1. First use find to determine the roots of the trees containing a,b
        let rootA = find(a)
        let rootB = find(b)

        // 2. roots of a and b point are same the are in the same tree
        guard rootA != rootB else {
            return
        }

        // 3. otherwise merge them by size
        if size[rootA]! < size[rootB]! {
            parent[rootA] = rootB
            size[rootB]! += size[rootA]!
        } else {
            parent[rootB] = rootA
            size[rootA]! += size[rootB]!
        }
    }

    func getTreeSize() -> [Int] {
        var roots: Set<Point3d> = []
        for k in parent.keys {
            roots.insert(find(k))
        }
        return roots.map { size[$0]! }
    }
}

func distance(a: Point3d, b: Point3d) -> Double {
    let dX: Double = pow(Double(a.x - b.x), 2)
    let dY: Double = pow(Double(a.y - b.y), 2)
    let dZ: Double = pow(Double(a.z - b.z), 2)
    return sqrt(Double(dX + dY + dZ))
}

public struct Day8_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        let points = input.split(separator: "\n")
            .map {
                var s = $0.split(separator: ",")
                return Point3d(
                    x: Int(s.removeFirst())!,
                    y: Int(s.removeFirst())!,
                    z: Int(s.removeFirst())!
                )
            }

        var edges: [(a: Point3d, b: Point3d, distance: Int)] = []

        for x in 0..<points.count {
            let pointX = points[x]
            for y in x + 1..<points.count {
                let pointY = points[y]
                let distance = Int(distance(a: pointX, b: pointY))
                edges.append((pointX, pointY, distance))
            }
        }

        edges.sort { $0.distance <= $1.distance }

        let ds = DisjointSet()

        for point in points {
            ds.makeSet(point)
        }

        var cycles = 0
        for (a, b, _) in edges {
            if cycles > 999 {
                break
            }
            ds.union(a, b)
            cycles += 1
        }

        let sizes = ds.getTreeSize().sorted { $0 > $1 }
        print(sizes)
        print(sizes[0] * sizes[1] * sizes[2])

    }
}

public struct Day8_2: Solver {
    public init() {}
    public func solve(_ input: String) {
        let points = input.split(separator: "\n")
            .map {
                var s = $0.split(separator: ",")
                return Point3d(
                    x: Int(s.removeFirst())!,
                    y: Int(s.removeFirst())!,
                    z: Int(s.removeFirst())!
                )
            }

        var edges: [(a: Point3d, b: Point3d, distance: Int)] = []

        for x in 0..<points.count {
            let pointX = points[x]
            for y in x + 1..<points.count {
                let pointY = points[y]
                let distance = Int(distance(a: pointX, b: pointY))
                edges.append((pointX, pointY, distance))
            }
        }

        edges.sort { $0.distance <= $1.distance }

        let ds = DisjointSet()

        for point in points {
            ds.makeSet(point)
        }

        var currentPoint: (Point3d, Point3d)? = nil
        for (a, b, _) in edges {
            ds.union(a, b)
            currentPoint = (a, b)
            let numOfCircuits = ds.getTreeSize().count
            if numOfCircuits == 1 {
                break
            }
        }

        print(currentPoint!)
        print(currentPoint!.0.x * currentPoint!.1.x)

    }
}
