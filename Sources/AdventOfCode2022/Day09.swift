let day09: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	return numberOfPositionsEndOfRopeVisitsAtLeastOnce(motions: input, ropeLength: 2)
}

private let part2: Algorithm = { input in
	return numberOfPositionsEndOfRopeVisitsAtLeastOnce(motions: input, ropeLength: 10)
}

private struct Position: Hashable {
	let x: Int
	let y: Int

	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}
}

private func numberOfPositionsEndOfRopeVisitsAtLeastOnce(motions: String, ropeLength: Int) -> Int {
	let motions = motions
		.split(separator: "\n")
		.map { line in
			let motion = line
				.split(separator: " ")
			return (motion.first!, Int(motion.last!)!)
		}

	var rope = Array(repeating: Position(0, 0), count: ropeLength)

	let tailPositions = motions
		.flatMap { direction, distance in
			var tailPositions: [Position] = []
			for _ in 0..<distance {
				rope = move(rope: rope, inDirection: direction)
				tailPositions.append(rope.last!)
			}
			return tailPositions
		}
	return Set(tailPositions + [Position(0,0)]).count
}

private func move(rope: [Position], inDirection direction: some StringProtocol) -> [Position] {
	let newHead = {
		let head = rope.first!
		switch direction {
		case "R":
			return Position(head.x + 1, head.y)
		case "L":
			return Position(head.x - 1, head.y)
		case "U":
			return Position(head.x, head.y + 1)
		case "D":
			return Position(head.x, head.y - 1)
		default: fatalError()
		}
	}()
	return [newHead] + pull(rope.dropFirst(), towards: newHead)
}

private func pull(_ tail: some Collection<Position>, towards position: Position) -> [Position] {
	guard let tailHead = tail.first else { return [] }
	let newTailHead = {
		let distance = max(abs(position.x - tailHead.x), abs(position.y - tailHead.y))
		if distance < 2 {
			return tailHead
		} else if position.x == tailHead.x {
			if tailHead.y < position.y {
				return Position(position.x, position.y - 1)
			} else {
				return Position(position.x, position.y + 1)
			}
		} else if position.y == tailHead.y {
			if tailHead.x < position.x {
				return Position(position.x - 1, position.y)
			} else {
				return Position(position.x + 1, position.y)
			}
		} else {
			let xOffset = position.x > tailHead.x ? 1 : -1
			let yOffset = position.y > tailHead.y ? 1 : -1
			return Position(tailHead.x + xOffset, tailHead.y + yOffset)
		}
	}()
	return [newTailHead] + pull(tail.dropFirst(), towards: newTailHead)
}
