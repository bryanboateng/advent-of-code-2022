import ArgumentParser
import Foundation

typealias Algorithm = (String) -> Any

@main
struct AdventOfCode2022: ParsableCommand {

	@Argument var day: Int

	func run() throws {
		guard let inputFileURL = Bundle.module
			.url(
				forResource: "day-\(day.formatted(.number.precision(.integerLength(2))))",
				withExtension: "txt"
			)
		else {
			fatalError("No input file found.")
		}
		let input = try! String(contentsOf: inputFileURL)
		let algorithms = adventOfCode()[day]!
		let results =
		"""
		Part 1: \(algorithms.0(input))
		Part 2: \(algorithms.1(input))
		"""
		print("Day \(day)\n\(results)")
	}
}

func adventOfCode() -> [Int: (Algorithm, Algorithm)] {
	var algorithms: [Int: (Algorithm, Algorithm)] = [:]
	algorithms[1] = day01
	algorithms[2] = day02
	algorithms[3] = day03
	algorithms[4] = day04
	algorithms[5] = day05
	return algorithms
}
