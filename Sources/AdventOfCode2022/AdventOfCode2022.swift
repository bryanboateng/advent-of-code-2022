import ArgumentParser
import Foundation
import RegexBuilder

@main
struct AdventOfCode2022: ParsableCommand {

	@Argument var day: Int

	func run() throws {
		let inputFilePathPattern = Regex {
			"/day-\(day.formatted(.number.precision(.integerLength(2))))-"
			Capture {
				OneOrMore(.digit)
			}
			".txt"
		}
		let results = Bundle.module.paths(forResourcesOfType: "txt", inDirectory: nil)
			.compactMap { path in
				guard let match = path.firstMatch(of: inputFilePathPattern) else { return nil }
				return (String(match.1), path)
			}
			.map { (index: String, path: String) -> (String, String) in
				let input = try! String(contentsOf: URL(fileURLWithPath: String(path)))
				return (index, adventOfCode()[day]!(input))
			}
			.sorted {
				Int($0.0)! < Int($1.0)!
			}
			.map {
				let (index, result) = $0
				return "\(index): \(result)"
			}
			.joined(separator: "\n")
		print("Day \(day)\n\(results)")
	}
}

func adventOfCode() -> [Int: (String) -> String] {
	var algorithms: [Int: (String) -> String] = [:]
	algorithms[1] = { (input: String) -> String in
		return "Lorem Ipsum"
	}
	return algorithms
}
