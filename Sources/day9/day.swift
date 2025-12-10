import Collections
import Foundation
import helpers

public struct Day9_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        let coords = input.split(separator: "\n")
            .map {
                var s = $0.split(separator: ",")
                return Point2d(x: Int(s.removeFirst())!, y: Int(s.removeFirst())!)
            }
        var maxArea = 0

        // Check all pairs of points
        for i in 0..<coords.count {
            for j in i + 1..<coords.count {
                let width = abs(coords[i].x - coords[j].x) + 1
                let height = abs(coords[i].y - coords[j].y) + 1
                let area = width * height
                maxArea = max(maxArea, area)
            }
        }

        print(maxArea)

    }
}

// read this shit for algo: https://en.wikipedia.org/wiki/Flood_fill
public struct Day9_2: Solver {
    public init() {}

    func createBorder(_ coordinates: [Point2d]) -> Set<Point2d> {
        var greenBorder: Set<Point2d> = []

        for i in 0..<coordinates.count {
            let currNode = coordinates[i]
            let nextNode = coordinates[(i + 1) % coordinates.count]

            if currNode.x == nextNode.x {  // they are in same row
                for y in min(currNode.y, nextNode.y)...max(currNode.y, nextNode.y) {
                    greenBorder.insert(Point2d(x: currNode.x, y: y))
                }

            } else {  // they are in the same col
                for x in min(currNode.x, nextNode.x)...max(currNode.x, nextNode.x) {
                    greenBorder.insert(Point2d(x: x, y: currNode.y))
                }

            }
        }
        return greenBorder
    }

    func pointIsInside(_ point: Point2d, border: Set<Point2d>) -> Bool {
        // raycasting count intersection
        var crossings = 0

        let maxX = border.map(\.x).max()!

        guard point.x + 1 <= maxX else {
            return false
        }

        for x in point.x + 1...maxX {
            if border.contains(Point2d(x: x, y: point.y)) {
                crossings += 1
            }
        }
        return crossings % 2 == 1
    }

    func floodFill(node: Point2d, border: Set<Point2d>, coords: [Point2d]) -> Set<Point2d> {
        var interior: Set<Point2d> = []
        var queue = Deque<Point2d>([node])
        var visited: Set<Point2d> = [node]

        while !queue.isEmpty {
            let currElement = queue.removeFirst()

            if border.contains(currElement) {
                continue
            }

            interior.insert(currElement)

            let neighbors = [
                Point2d(x: currElement.x + 1, y: currElement.y),
                Point2d(x: currElement.x - 1, y: currElement.y),
                Point2d(x: currElement.x, y: currElement.y - 1),
                Point2d(x: currElement.x, y: currElement.y + 1),
            ]

            for neighbour in neighbors {
                if !visited.contains(neighbour) && !border.contains(neighbour) {
                    visited.insert(neighbour)
                    queue.append(neighbour)
                }
            }
        }
        return interior
    }

    func rectangleContainsOnlyGreenOrRed(
        corner1: Point2d,
        corner2: Point2d,
        greenTiles: Set<Point2d>,
        redTiles: Set<Point2d>
    ) -> Bool {
        let minX = min(corner1.x, corner2.x)
        let maxX = max(corner1.x, corner2.x)
        let minY = min(corner1.y, corner2.y)
        let maxY = max(corner1.y, corner2.y)

        for x in minX...maxX {
            for y in minY...maxY {
                let point = Point2d(x: x, y: y)
                if !greenTiles.contains(point) && !redTiles.contains(point) {
                    return false
                }
            }
        }

        return true
    }

    func interiorPoint(_ border: Set<Point2d>, coords: [Point2d]) -> Point2d {
        let minX = coords.min { $0.x < $1.x }!.x
        let maxX = coords.max { $0.x < $1.x }!.x
        let minY = coords.min { $0.y < $1.y }!.y
        let maxY = coords.max { $0.y < $1.y }!.y

        // Start from actual center and spiral outward
        let centerX = (minX + maxX) / 2
        let centerY = (minY + maxY) / 2

        // Check center first
        let center = Point2d(x: centerX, y: centerY)

        if !border.contains(center) && pointIsInside(center, border: border) {
            return center
        }

        let offsets = [
            (0, 1), (1, 0), (0, -1), (-1, 0),
            (1, 1), (1, -1), (-1, 1), (-1, -1),
        ]

        for (dx, dy) in offsets {
            let point = Point2d(x: centerX + dx, y: centerY + dy)
            if !border.contains(point) && pointIsInside(point, border: border) {
                return point
            }
        }

        return Point2d(x: centerX + 1, y: centerY + 1)
    }

    // NOT MINE SOLUTION
    func pointOnSegment(point: Point2d, p1: Point2d, p2: Point2d) -> Bool {
        let minX = min(p1.x, p2.x)
        let maxX = max(p1.x, p2.x)
        let minY = min(p1.y, p2.y)
        let maxY = max(p1.y, p2.y)
        return point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
    }

    // NOT MINE SOLUTION
    func polygonContainsPoint(polygon: [Point2d], point: Point2d) -> Bool {
        for i in 0..<polygon.count {
            let p1 = polygon[i]
            let p2 = polygon[(i + 1) % polygon.count]
            if pointOnSegment(point: point, p1: p1, p2: p2) {
                return true
            }
        }

        var inside = false
        for i in 0..<polygon.count {
            let p1 = polygon[i]
            let p2 = polygon[(i + 1) % polygon.count]
            guard p1.x == p2.x else { continue }

            let minY = min(p1.y, p2.y)
            let maxY = max(p1.y, p2.y)
            if point.y > minY && point.y <= maxY && point.x < p1.x {
                inside = !inside
            }
        }
        return inside
    }

    // NOT MINE SOLUTION
    func segmentsCross(p1: Point2d, p2: Point2d, edge: (Point2d, Point2d)) -> Bool {
        let (p3, p4) = edge

        let seg1Horizontal = p1.y == p2.y
        let seg2Horizontal = p3.y == p4.y
        if seg1Horizontal == seg2Horizontal {
            return false
        }

        let (hP1, hP2, vP1, vP2) = seg1Horizontal ? (p1, p2, p3, p4) : (p3, p4, p1, p2)
        let hY = hP1.y
        let hXMin = min(hP1.x, hP2.x)
        let hXMax = max(hP1.x, hP2.x)
        let vX = vP1.x
        let vYMin = min(vP1.y, vP2.y)
        let vYMax = max(vP1.y, vP2.y)
        return hXMin < vX && vX < hXMax && vYMin < hY && hY < vYMax
    }

    // NOT MINE SOLUTION
    func polygonContainsRect(polygon: [Point2d], rect: (Point2d, Point2d)) -> Bool {
        let (p1, p2) = rect
        let rectXMin = min(p1.x, p2.x)
        let rectXMax = max(p1.x, p2.x)
        let rectYMin = min(p1.y, p2.y)
        let rectYMax = max(p1.y, p2.y)

        // Verify corners are inside the polygon
        let corners = [
            Point2d(x: rectXMin, y: rectYMin),
            Point2d(x: rectXMin, y: rectYMax),
            Point2d(x: rectXMax, y: rectYMin),
            Point2d(x: rectXMax, y: rectYMax),
        ]

        for corner in corners {
            if !polygonContainsPoint(polygon: polygon, point: corner) {
                return false
            }
        }

        // Verify there are no edge intersections
        let edges = [
            (Point2d(x: rectXMin, y: rectYMin), Point2d(x: rectXMax, y: rectYMin)),
            (Point2d(x: rectXMax, y: rectYMin), Point2d(x: rectXMax, y: rectYMax)),
            (Point2d(x: rectXMax, y: rectYMax), Point2d(x: rectXMin, y: rectYMax)),
            (Point2d(x: rectXMin, y: rectYMax), Point2d(x: rectXMin, y: rectYMin)),
        ]

        for i in 0..<polygon.count {
            let p1 = polygon[i]
            let p2 = polygon[(i + 1) % polygon.count]
            for edge in edges {
                if segmentsCross(p1: p1, p2: p2, edge: edge) {
                    return false
                }
            }
        }

        return true
    }

    public func solve(_ input: String) {
        let coords = input.split(separator: "\n")
            .map {
                var s = $0.split(separator: ",")
                return Point2d(x: Int(s.removeFirst())!, y: Int(s.removeFirst())!)
            }

        /*
            THIS WAS CRAZY IDEA TO FLOOD FILL THE ENTIRE INSIDE DIDN'T EVEN FINISHED
        */

        var maxArea = 0

        // let greenBorder = createBorder(coords)
        // let startPoint = interiorPoint(greenBorder, coords: coords)
        // let interior = floodFill(node: startPoint, border: greenBorder, coords: coords)
        // let allGreen = greenBorder.union(interior)
        // let allRed = Set(coords)
        //
        // for i in 0..<coords.count - 1 {
        //     for j in i + 1..<coords.count {
        //         let corner1 = coords[i]
        //         let corner2 = coords[j]
        //
        //         let width = abs(coords[i].x - coords[j].x) + 1
        //         let height = abs(coords[i].y - coords[j].y) + 1
        //
        //         if rectangleContainsOnlyGreenOrRed(
        //             corner1: corner1,
        //             corner2: corner2,
        //             greenTiles: allGreen,
        //             redTiles: allRed
        //         ) {
        //             let width = abs(corner1.x - corner2.x) + 1
        //             let height = abs(corner1.y - corner2.y) + 1
        //             let area = width * height
        //             maxArea = max(maxArea, area)
        //         }
        //     }
        // }

        // NOT MINE SOLUTION
        for p1Index in 0..<coords.count {
            let p1 = coords[p1Index]
            for p2 in coords[p1Index + 1..<coords.count] {
                if polygonContainsRect(polygon: coords, rect: (p1, p2)) {
                    maxArea = max(maxArea, Point2d.rectArea(p1: p1, p2: p2))
                }
            }
        }

        print(maxArea)
    }
}
