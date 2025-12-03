import Foundation

public func loadInput(_ path: String) -> String? {
    do {
        let fileContent = try String(contentsOfFile: path, encoding: .utf8)
        return fileContent
    } catch {
        print("Error reading the file: \(error)")
    }
    return nil
}
