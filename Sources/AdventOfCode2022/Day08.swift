import Algorithms

let day08: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	let treeGrid = input
		.split(separator: "\n")
		.map { line in
			line
				.map { character in
					Int(String(character))!
				}
		}
	let gridSideLengthRange = 0..<treeGrid.count
	return product(gridSideLengthRange, gridSideLengthRange)
		.filter { (i, j) in
			let row = treeGrid[i]
			let column = gridSideLengthRange.map { treeGrid[$0][j] }
			return collection(row, hasVisibleTreeAtIndex: j) || collection(column, hasVisibleTreeAtIndex: i)
		}
		.count
}

private let part2: Algorithm = { input in
	let treeGrid = input
		.split(separator: "\n")
		.map { line in
			line
				.map { character in
					Int(String(character))!
				}
		}
	let gridSideLengthRange = 0..<treeGrid.count
	let result = product(gridSideLengthRange, gridSideLengthRange)
		.map { (i, j) in
			let element = treeGrid[i][j]
			let row = treeGrid[i]
			let column = gridSideLengthRange.map { treeGrid[$0][j] }
			return numberOfTreesVisibleFrom(tree: element, in: row[..<j].reversed())
			* numberOfTreesVisibleFrom(tree: element, in: row[(j + 1)...])
			* numberOfTreesVisibleFrom(tree: element, in: column[..<i].reversed())
			* numberOfTreesVisibleFrom(tree: element, in: column[(i + 1)...])
		}
		.max()!
	return result
}

private func collection(_ collection: [Int], hasVisibleTreeAtIndex index: Int) -> Bool {
	let element = collection[index]
	let predecessors = collection[..<index]
	let successors = collection[(index + 1)...]
	return predecessors.allSatisfy { element > $0 } || successors.allSatisfy { element > $0 }
}

private func numberOfTreesVisibleFrom(tree: Int, in collection: some Collection<Int>) -> Int {
	let firstBlockingTreeIndex = collection
		.enumerated()
		.first { $0.1 >= tree }?
		.0
	if let firstBlockingTreeIndex {
		return firstBlockingTreeIndex + 1
	} else {
		return collection.count
	}
}
