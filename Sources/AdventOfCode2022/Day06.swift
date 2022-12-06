let day06: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	let markerSize = 4
	return input
		.windows(ofCount: markerSize)
		.enumerated()
		.first { index, signal in
			Set(signal).count == markerSize
		}!
		.0
	+ markerSize
}

private let part2: Algorithm = { input in
	let markerSize = 14
	return input
		.windows(ofCount: markerSize)
		.enumerated()
		.first { index, signal in
			Set(signal).count == markerSize
		}!
		.0
	+ markerSize
}
