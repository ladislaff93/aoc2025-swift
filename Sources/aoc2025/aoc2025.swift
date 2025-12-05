// The Swift Programming Language
// https://docs.swift.org/swift-book
import day1
import day2
import day3
import day4
import day5
import day6
import helpers

@main
struct aoc2025 {
    static func main() {
        let args = CommandLine.arguments

        guard args.count >= 2 else {
            print("Usage: aoc2025 <day> [part] [--test]")
            print("Example: aoc2025 3 1 --test")
            return
        }

        let day = args[1]
        let part = args.count > 2 ? args[2] : "1"
        let useTest = args.contains("--test")

        let solvers: [String: [String: any Solver]] = [
            "1": ["1": Day1_1(), "2": Day1_2()],
            "2": ["1": Day2_1(), "2": Day2_2()],
            "3": ["1": Day3_1(), "2": Day3_2()],
            "4": ["1": Day4_1(), "2": Day4_2()],
            "5": ["1": Day5_1(), "2": Day5_2()],
            "6": ["1": Day6_1(), "2": Day6_2()],
        ]

        print("")
        print("              *               ")
        print("...EXECUTING A*VENT OF CODE...")
        print("...EXECUTING -*-ENT OF CODE...")
        print("...EXECUTING-*---NT OF CODE...")
        print("...EXECUTING------T OF CODE...")
        print("...EXECUTIN----*--- OF CODE...")
        print("...EXECUTI--*-------OF CODE...")
        print("...EXECUT-*---*--*---F CODE...")
        print("...EXECU-----------*-- CODE...")
        print("...EXEC--*---*---*-----CODE...")
        print("...EXE--*------------*--ODE...")
        print("...EX------*-------*-----DE...")
        print("...E--*--------*------*---E...")
        print("...-----*--------*---------...")
        print("...EXECUTING ADVENT OF CODE...")
        print("")

        if let solver = solvers[day]?[part] {
            solver.run(day: day, useTest: useTest)
        } else {
            print("Day \(day) part \(part) not implemented")
        }
    }
}
