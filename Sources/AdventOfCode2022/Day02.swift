import Algorithms

let day02: (Algorithm, Algorithm) = (part1, part2)

private let part1: Algorithm = { input in
	return input
		.split(separator: "\n")
		.map {
			let plays = $0
				.split(separator: " ")
			let theirPlay = plays.first!
			let myPlay = plays.last!
			return {
				switch myPlay {
				case "X": return {
					let playScore = 1
					switch theirPlay {
					case "A":
						return playScore + 3
					case "B":
						return playScore + 0
					case "C":
						return playScore + 6
					default:
						fatalError()
					}
				}()
				case "Y": return {
					let playScore = 2
					switch theirPlay {
					case "A":
						return playScore + 6
					case "B":
						return playScore + 3
					case "C":
						return playScore + 0
					default:
						fatalError()
					}
				}()
				case "Z": return {
					let playScore = 3
					switch theirPlay {
					case "A":
						return playScore + 0
					case "B":
						return playScore + 6
					case "C":
						return playScore + 3
					default:
						fatalError()
					}
				}()
				default: fatalError()
				}
			}()
		}
		.reduce(0, +)
}

private let part2: Algorithm = { input in
	return input
		.split(separator: "\n")
		.map {
			let round = $0
				.split(separator: " ")
			let theirPlay = round.first!
			let outcome = round.last!
			return {
				switch outcome {
				case "X": return {
					let outcomeScore = 0
					switch theirPlay {
					case "A":
						return outcomeScore + 3
					case "B":
						return outcomeScore + 1
					case "C":
						return outcomeScore + 2
					default:
						fatalError()
					}
				}()
				case "Y": return {
					let outcomeScore = 3
					switch theirPlay {
					case "A":
						return outcomeScore + 1
					case "B":
						return outcomeScore + 2
					case "C":
						return outcomeScore + 3
					default:
						fatalError()
					}
				}()
				case "Z": return {
					let outcomeScore = 6
					switch theirPlay {
					case "A":
						return outcomeScore + 2
					case "B":
						return outcomeScore + 3
					case "C":
						return outcomeScore + 1
					default:
						fatalError()
					}
				}()
				default: fatalError()
				}
			}()
		}
		.reduce(0, +)
}
