let day12: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	let graph = graph(input: input)
	let (origin, destination) = originAndDestination(graph: graph)
	return graph.stepCount(between: origin, and: destination)
}

private let part2: Algorithm = { input in
	let graph = graph(input: input)
	let (_, destination) = originAndDestination(graph: graph)
	return graph.nodes
		.filter { node in
			node.elevation == "a" || node.elevation == "S"
		}
		.map { node in
			graph.stepCount(between: node, and: destination)
		}
		.filter { $0 > 0 }
		.min()!
}

private func graph(input: String) -> Graph {
	let rows = input
		.split(separator: "\n")

	let width = rows
		.first!
		.count
	let height = rows.count

	var nodes: [Graph.Node] = []
	var edges = Set<Graph.Edge>()
	for (rowIndex, row) in rows.enumerated() {
		for (columnIndex, elevation) in row.enumerated() {
			let node = Graph.Node(
				index: Graph.Node.Index(rowIndex, columnIndex),
				elevation: elevation
			)
			nodes.append(node)

			let upperRowIndex = rowIndex - 1
			if upperRowIndex >= 0 {
				let row = rows[upperRowIndex]
				let otherElevation = row[row.index(row.startIndex, offsetBy: columnIndex)]
				if elevationIsClimable(elevation, otherElevation) {
					edges.insert(Graph.Edge(node.index, Graph.Node.Index(upperRowIndex, columnIndex)))
				}
			}

			let lowerRowIndex = rowIndex + 1
			if lowerRowIndex < height {
				let row = rows[lowerRowIndex]
				let otherElevation = row[row.index(row.startIndex, offsetBy: columnIndex)]
				if elevationIsClimable(elevation, otherElevation) {
					edges.insert(Graph.Edge(node.index, Graph.Node.Index(lowerRowIndex, columnIndex)))
				}
			}

			let leftColumnIndex = columnIndex - 1
			if leftColumnIndex >= 0 {
				let otherElevation = row[row.index(row.startIndex, offsetBy: leftColumnIndex)]
				if elevationIsClimable(elevation, otherElevation) {
					edges.insert(Graph.Edge(node.index, Graph.Node.Index(rowIndex, leftColumnIndex)))
				}
			}

			let rightColumnIndex = columnIndex + 1
			if rightColumnIndex < width {
				let otherElevation = row[row.index(row.startIndex, offsetBy: rightColumnIndex)]
				if elevationIsClimable(elevation, otherElevation) {
					edges.insert(Graph.Edge(node.index, Graph.Node.Index(rowIndex, rightColumnIndex)))
				}
			}
		}
	}

	return Graph(nodes: nodes, edges: edges)
}

private func elevationIsClimable(_ elevationA: Character, _ elevationB: Character) -> Bool {
	return numericValue(forElevation: elevationA) >= numericValue(forElevation: elevationB) - 1
}

private func numericValue(forElevation elevation: Character) -> Int {
	switch elevation {
	case "S": return 0
	case "E": return 25
	default: return Int(elevation.asciiValue! - 97)
	}
}

private func originAndDestination(graph: Graph) -> (Graph.Node, Graph.Node) {
	let origin = graph.nodes
		.first { node in
			node.elevation == "S"
		}!

	let destination = graph.nodes
		.first { node in
			node.elevation == "E"
		}!

	return (origin, destination)
}

private struct Graph {
	let nodes: [Node]
	let edges: Set<Edge>

	func stepCount(between origin: Node, and destination: Node) -> Int {
		var frontier = [origin]
		var sources: [Node: Node?] = [origin: nil]
		mainLoop: while !frontier.isEmpty {
			let currentNode = frontier.removeFirst()
			for neighbor in neighbors(of: currentNode) {
				if !sources.keys.contains(neighbor) {
					frontier.append(neighbor)
					sources[neighbor] = currentNode
					if neighbor == destination {
						break mainLoop
					}
				}
			}
		}
		return path(backTrackingFrom: destination, sources: sources).count
	}

	func neighbors(of node: Node) -> [Node] {
		return edges
			.filter { edge in
				node.index == edge.indexA
			}
			.map { edge in
				nodes
					.first { node in
						node.index == edge.indexB
					}!
			}
	}

	func path(backTrackingFrom node: Node, sources: [Node: Node?]) -> [Node] {
		var path: [Node] = []
		var currentNode = node
		while let source = sources[currentNode] {
			guard let source else { break }
			path.append(source)
			currentNode = source
		}
		return path
	}
}

extension Graph {
	struct Node: Hashable {
		let index: Index
		let elevation: Character

		struct Index: Hashable {
			let row: Int
			let column: Int

			init(_ row: Int, _ column: Int) {
				self.row = row
				self.column = column
			}
		}
	}
}

extension Graph {
	struct Edge: Hashable {
		let indexA: Node.Index
		let indexB: Node.Index

		init(_ indexA: Node.Index, _ indexB: Node.Index) {
			self.indexA = indexA
			self.indexB = indexB
		}
	}
}
