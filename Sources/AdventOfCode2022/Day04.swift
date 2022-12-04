import Foundation

let day04: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	return input
		.split(separator: "\n")
		.map { stringSectionAssignmentPair in
			let sectionAssignmentPair = stringSectionAssignmentPair
				.split(separator: ",")
				.map { stringSectionAssignment in
					let sectionBounds = stringSectionAssignment
						.split(separator: "-")
					return Int(sectionBounds.first!)!...Int(sectionBounds.last!)!
				}
			return sectionAssignmentPair.first!.contains(sectionAssignmentPair.last!) || sectionAssignmentPair.last!.contains(sectionAssignmentPair.first!)
		}
		.filter { $0 }
		.count
}

private let part2: Algorithm = { input in
	return input
		.split(separator: "\n")
		.map { stringSectionAssignmentPair in
			let sectionAssignmentPair = stringSectionAssignmentPair
				.split(separator: ",")
				.map { stringSectionAssignment in
					let sectionBounds = stringSectionAssignment
						.split(separator: "-")
					return Int(sectionBounds.first!)!...Int(sectionBounds.last!)!
				}
			return sectionAssignmentPair.first!.overlaps(sectionAssignmentPair.last!)
		}
		.filter { $0 }
		.count
}
