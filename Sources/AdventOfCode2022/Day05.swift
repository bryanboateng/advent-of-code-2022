import Foundation

let day05: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	let stacksAndInstructions = input.split(separator: "\n\n")
	var stacks = createStacks(stacksAndInstructions.first!)
	let instructions = createInstructions(stacksAndInstructions.last!)
	for instruction in instructions {
		stacks = instruction(stacks, false)
	}
	return stacks
		.reduce("") { partialResult, stack in
			return partialResult + String(stack.first!)
		}
}

private let part2: Algorithm = { input in
	let stacksAndInstructions = input.split(separator: "\n\n")
	var stacks = createStacks(stacksAndInstructions.first!)
	let instructions = createInstructions(stacksAndInstructions.last!)
	for instruction in instructions {
		stacks = instruction(stacks, true)
	}
	return stacks
		.reduce("") { partialResult, stack in
			return partialResult + String(stack.first!)
		}
}

private func createStacks(_ encodedStacks: some StringProtocol) -> [[Character]] {
	let stackCount = 9
	var stacks = [[Character]](repeating: [], count: stackCount)
	for layer in encodedStacks.split(separator: "\n").dropLast() {
		for stackIndex in 0..<stackCount {
			let crate = layer[layer.index(layer.startIndex, offsetBy: (4 * stackIndex) + 1)]
			if crate != " " {
				stacks[stackIndex].append(crate)
			}
		}
	}
	return stacks
}

private func createInstructions(_ instructions: some StringProtocol) -> [([[Character]], Bool) -> [[Character]]] {
	let pattern = #/move (?<count>\d+) from (?<source>\d) to (?<destination>\d)/#
	return instructions
		.split(separator: "\n")
		.map { line in
			let match = String(line).firstMatch(of: pattern)!
			return { stacks, movesMultipleCratesAtOnce in
				var copy = stacks

				let sourceStackIndex = Int(match.output.source)!-1
				let source = copy[sourceStackIndex]
				copy[sourceStackIndex] = Array<Character>(source.dropFirst(Int(match.output.count)!))

				let destinationStackIndex = Int(match.output.destination)!-1
				let destination = copy[destinationStackIndex]
				if movesMultipleCratesAtOnce {
					copy[destinationStackIndex] = source[..<Int(match.output.count)!] + destination
				} else {
					copy[destinationStackIndex] = source[..<Int(match.output.count)!].reversed() + destination
				}

				return copy
			}
		}
}
