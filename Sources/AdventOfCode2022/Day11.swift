let day11: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	let monkeys = getMonkeys(input: input)
	var counts = Array(repeating: 0, count: monkeys.count)
	for i in 0..<20 {
		counts = zip(counts, round(monkeys: monkeys, divide: true))
			.map(+)
	}
	return counts
		.max(count: 2)
		.reduce(1, *)
}

private let part2: Algorithm = { input in
	let monkeys = getMonkeys(input: input)
	var counts = Array(repeating: 0, count: monkeys.count)
	for i in 0..<10000 {
		counts = zip(counts, round(monkeys: monkeys, divide: false))
			.map(+)
	}
	return counts
		.max(count: 2)
		.reduce(1, *)
}

private func getMonkeys(input: String) -> [Monkey] {
	return [
		Monkey(
			items: [83, 88, 96, 79, 86, 88, 70],
			operation: { x in x * 5 },
			divisor: 11,
			tMonkeyIndex: 2,
			fMonkeyIndex: 3
		),
		Monkey(
			items: [59, 63, 98, 85, 68, 72],
			operation: { x in x * 11 },
			divisor: 5,
			tMonkeyIndex: 4,
			fMonkeyIndex: 0
		),
		Monkey(
			items: [90, 79, 97, 52, 90, 94, 71, 70],
			operation: { x in x + 2 },
			divisor: 19,
			tMonkeyIndex: 5,
			fMonkeyIndex: 6
		),
		Monkey(
			items: [97, 55, 62],
			operation: { x in x + 5 },
			divisor: 13,
			tMonkeyIndex: 2,
			fMonkeyIndex: 6
		),
		Monkey(
			items: [74, 54, 94, 76],
			operation: { x in x * x },
			divisor: 7,
			tMonkeyIndex: 0,
			fMonkeyIndex: 3
		),
		Monkey(
			items: [58],
			operation: { x in x + 4 },
			divisor: 17,
			tMonkeyIndex: 7,
			fMonkeyIndex: 1
		),
		Monkey(
			items: [66, 63],
			operation: { x in x + 6 },
			divisor: 2,
			tMonkeyIndex: 7,
			fMonkeyIndex: 5
		),
		Monkey(
			items: [56, 56, 90, 96, 68],
			operation: { x in x + 7 },
			divisor: 3,
			tMonkeyIndex: 4,
			fMonkeyIndex: 1
		)
	]
}

private func round(monkeys: [Monkey], divide: Bool) -> [Int] {
	var counts = Array(repeating: 0, count: monkeys.count)
	for (index, monkey) in monkeys.enumerated() {
		counts[index] = counts[index] + monkey.items.count
		let modulo = monkeys
			.map { monkey in
				monkey.divisor
			}
			.reduce(1, *)
		let (ts, fs) = monkey.inspectItems(divide: divide, modulo: modulo)
		monkeys[monkey.tMonkeyIndex].items.append(contentsOf: ts)
		monkeys[monkey.fMonkeyIndex].items.append(contentsOf: fs)
	}
	return counts
}

private class Monkey {
	var items: [Int]
	let operation: (Int) -> Int
	let divisor: Int
	let tMonkeyIndex: Int
	let fMonkeyIndex: Int

	init(items: [Int], operation: @escaping (Int) -> Int, divisor: Int, tMonkeyIndex: Int, fMonkeyIndex: Int) {
		self.items = items
		self.operation = operation
		self.divisor = divisor
		self.tMonkeyIndex = tMonkeyIndex
		self.fMonkeyIndex = fMonkeyIndex
	}

	func inspectItems(divide: Bool, modulo: Int) -> ([Int], [Int]) {
		let recalculatedItems = items
			.map { item in
				(operation(item) % modulo) / (divide ? 3 : 1)
			}

		var ts: [Int] = []
		var fs: [Int] = []
		for item in recalculatedItems {
			if item.isMultiple(of: self.divisor) {
				ts.append(item)
			} else {
				fs.append(item)
			}
		}
		items = []
		return (ts, fs)
	}
}
