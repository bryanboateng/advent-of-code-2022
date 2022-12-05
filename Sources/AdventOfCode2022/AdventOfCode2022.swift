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
		let algorithms = adventOfCode()[day-1]
		let results =
		"""
		Part 1: \(algorithms.0(input))
		Part 2: \(algorithms.1(input))
		"""
		print("Day \(day)\n\(results)")
	}
}

func adventOfCode() -> [(Algorithm, Algorithm)] {
	return [
		day01,
		day02,
		day03,
		day04,
		day05,
		day06,
		day07,
		day08,
		day09,
		day10,
		day11,
		day12,
		day13,
		day14,
		day15,
		day16,
		day17,
		day18,
		day19,
		day20,
		day21,
		day22,
		day23,
		day24
	]
}
