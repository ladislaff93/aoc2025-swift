import helpers

// (X, Y)
let directions = [
    (0, 1),  // UP
    (1, 1),  // UP RIGHT
    (1, 0),  // RIGHT
    (1, -1),  // DOWN RIGHT
    (0, -1),  // DOWN
    (-1, -1),  // DOWN LEFT
    (-1, 0),  // LEFT
    (-1, 1),  // UP LEFT
]

public struct Day4_1: Solver {
    public init() {}

    public func solve(_ input: String) {
        let grid: [[Character]] = input.split(separator: "\n").map { Array($0) }
        var result = 0

        for y in 0..<grid.count {
            print(grid[y])
            for x in 0..<grid[y].count {
                let char = grid[y][x]
                if char == "." {
                    continue
                }

                var rolls = 0

                for (dx, dy) in directions {
                    if y + dy < 0 || x + dx < 0 || y + dy > grid.count - 1
                        || x + dx > grid[y].count - 1 || rolls == 4
                    {
                        continue
                    }

                    let dChar = grid[y + dy][x + dx]
                    if dChar == "@" {
                        rolls += 1
                    }

                }
                if rolls < 4 {
                    result += 1
                }
            }
        }
        print(result)
    }
}

public struct Day4_2: Solver {
    public init() {}

    /// check if inside of the grid
    func isValid(_ grid: [[Character]], _ y: Int, _ x: Int) -> Bool {
        return y >= 0 && y < grid.count && x >= 0 && x < grid[y].count
    }

    func isRemovable(_ grid: [[Character]], _ y: Int, _ x: Int) -> Bool {
        guard grid[y][x] == "@" else { return false }

        var neighborCount = 0
        for (dx, dy) in directions {
            let nx = x + dx
            let ny = y + dy

            if isValid(grid, ny, nx) && grid[ny][nx] == "@" {
                neighborCount += 1
                if neighborCount >= 4 {
                    return false  // early exit
                }
            }
        }

        return true  // has < 4 neighbors
    }

    public func solve(_ input: String) {
        var grid: [[Character]] = input.split(separator: "\n").map { Array($0) }
        var result = 0

        var arrOfRolls: [(Int, Int)] = []

        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                if isRemovable(grid, y, x) {
                    arrOfRolls.append((x, y))
                }
            }
        }

        while !arrOfRolls.isEmpty {
            let roll = arrOfRolls.removeFirst()

            if grid[roll.1][roll.0] == "." { // already removed in previous steps
                continue
            }
            grid[roll.1][roll.0] = "." // remove from grid
            result += 1

            for (dx, dy) in directions {
                let nx = dx + roll.0
                let ny = dy + roll.1

                if isValid(grid, ny, nx) && grid[ny][nx] == "@" && isRemovable(grid, ny, nx) {
                    arrOfRolls.append((nx, ny))
                }
            }
        }

        print(result)
    }
}
