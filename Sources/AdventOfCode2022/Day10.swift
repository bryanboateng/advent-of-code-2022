let day10: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	return registerValues(for: input)[(20 - 1)...]
		.striding(by: 40)
		.enumerated()
		.map { index, value in
			((40 * index) + 20) * value
		}
		.reduce(0, +)
}

private let part2: Algorithm = { input in
	return registerValues(for: input)
		.enumerated()
		.map { globalIndex, value in
			let index = globalIndex % 40
			return ((index - 1)...(index + 1)).contains(value) ? "#" : "."
		}
		.reduce("") { partialResult, pixel in
			partialResult + pixel
		}
		.chunks(ofCount: 40)
		.reduce("") { partialResult, row in
			partialResult + "\n" + row
		}
}

private func registerValues(for input: String) -> [Int] {
	let instructions = input
		.split(separator: "\n")

	var values = [1]
	for instruction in instructions {
		if let summand = instruction.firstMatch(of: #/addx (?<summand>.+)/#)?.output.summand {
			values.append(contentsOf: [values.last!, values.last! + Int(summand)!])
		} else {
			values.append(values.last!)
		}
	}
	return values
}
