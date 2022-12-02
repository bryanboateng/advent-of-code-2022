import ArgumentParser
import Foundation

typealias Algorithm = (_ input: String) -> Any

@main
struct AdventOfCode2022: ParsableCommand {

	@Argument var day: Int

	func run() throws {
		let inputFileURL = Bundle.module.url(forResource: "day-\(day.formatted(.number.precision(.integerLength(2))))", withExtension: "txt")!
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
	return algorithms
}
