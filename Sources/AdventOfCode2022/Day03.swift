import Foundation

let day03: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	return input
		.split(separator: "\n")
		.map { rucksack in
			let splitIndex = rucksack.index(rucksack.startIndex, offsetBy: rucksack.count / 2)
			let firstPocket = Set(rucksack[rucksack.startIndex..<splitIndex])
			let secondPocket = Set(rucksack[splitIndex..<rucksack.endIndex])
			let matchingItem = firstPocket.intersection(secondPocket).first!
			if (CharacterSet.lowercaseLetters.contains(matchingItem.unicodeScalars.first!)) {
				return Int(matchingItem.asciiValue! - 97 + 1)
			} else {
				return Int(matchingItem.asciiValue! - 65 + 27)
			}
		}
		.reduce(0, +)
}

private let part2: Algorithm = { input in
	return input
		.split(separator: "\n")
		.chunks(ofCount: 3)
		.map { group in
			let matchingItem = group.dropFirst()
				.reduce(Set(group.first!)) { partialResult, ruckSack in
					partialResult.intersection(ruckSack)
				}
				.first!
			if (CharacterSet.lowercaseLetters.contains(matchingItem.unicodeScalars.first!)) {
				return Int(matchingItem.asciiValue! - 97 + 1)
			} else {
				return Int(matchingItem.asciiValue! - 65 + 27)
			}
		}
		.reduce(0, +)
}
