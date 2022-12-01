let day01: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	return input
		.split(separator: "\n\n")
		.map {
			$0
				.split(separator: "\n")
				.map {
					Int($0)!
				}
				.reduce(0, +)
		}
		.max()!
}

private let part2: Algorithm = { input in
	return input
		.split(separator: "\n\n")
		.map {
			$0
				.split(separator: "\n")
				.map {
					Int($0)!
				}
				.reduce(0, +)
		}
		.max(count: 3)
		.reduce(0, +)
}
