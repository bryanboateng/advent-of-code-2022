let day07: (Algorithm, Algorithm) = (part1, part2)

private class Directory {
	let name: String
	let parent: Directory?
	var subDirectories: [Directory]
	var files: [File]

	init(name: String, parent: Directory?) {
		self.name = name
		self.parent = parent
		self.subDirectories = []
		self.files = []
	}
}

private class File {
	let name: String
	let size: Int

	init(name: String, size: Int) {
		self.name = name
		self.size = size
	}
}

private let part1: Algorithm = { input in
	let root = root(ofFileSystemDescripedIn: input)
	return directorySizes(ofFileSystemStartingAt: root)
		.filter { $0 <= 100_000 }
		.reduce(0, +)
}

private let part2: Algorithm = { input in
	let capacity = 70_000_000
	let requiredDiscSpace = 30_000_000
	let root = root(ofFileSystemDescripedIn: input)
	let directorySizes = directorySizes(ofFileSystemStartingAt: root)
	let availableDiscSpace = capacity - directorySizes.first!
	let neededDiscSpace = requiredDiscSpace - availableDiscSpace
	return directorySizes
		.filter { $0 >= neededDiscSpace }
		.min()!
}

private func root(ofFileSystemDescripedIn input: String) -> Directory {
	let root = Directory(name: "root", parent: nil)
	var currentDirectory = root
	for line in input.split(separator: "\n") {
		if let path = line.firstMatch(of: #/\$ cd (?<path>.+)/#)?.output.path {
			switch path {
			case "/": currentDirectory = root
			case "..": currentDirectory = currentDirectory.parent!
			default: currentDirectory = currentDirectory.subDirectories.first { directory in
				directory.name == path
			}!
			}
		} else if let name = line.firstMatch(of: #/dir (?<name>\w+)/#)?.output.name {
			if !currentDirectory.subDirectories.contains(where: { directory in
				directory.name == name
			}) {
				currentDirectory.subDirectories.append(Directory(name: String(name), parent: currentDirectory))
			}
		} else if let output = line.firstMatch(of: #/(?<size>\d+) (?<name>.+)/#)?.output {
			if !currentDirectory.files.contains(where: { file in
				file.name == output.name
			}) {
				currentDirectory.files.append(File(name: String(output.name), size: Int(output.size)!))
			}
		}
	}
	return root
}

private func directorySizes(ofFileSystemStartingAt directory: Directory) -> [Int] {
	let childDirectorySizes = directory
		.subDirectories
		.flatMap { subDirectory in
			return directorySizes(ofFileSystemStartingAt: subDirectory)
		}
	return [size(of: directory)] + childDirectorySizes
}

private func size(of directory: Directory) -> Int {
	let filesSize = directory
		.files
		.map (\.size)
		.reduce(0, +)

	let subDirectoriesSize = directory
		.subDirectories
		.map(size)
		.reduce(0, +)

	return filesSize + subDirectoriesSize
}
