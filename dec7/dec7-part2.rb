class Node

    def initialize (id, parent, children, size)
        @id = id
        @parent = parent
        @children = children
        @size = size
    end

    def totalSize()
        if (@children.length == 0) 
            return @size
        end

        return @children.sum { |c| c.totalSize() }
    end

    attr_accessor :id, :parent, :children, :size
end

def printTree(root, indent)
    puts ".#{"   " * indent} - #{root.id} (#{root.size == 0 ? "dir" : root.size})"

    root.children.each { |node| printTree(node, indent + 1) }
end

def findDirectoriesUnderSize(node, maxSize, foundAlready)
    if (node.children.length == 0)
        # this is a file, not a directory!
        return foundAlready
    end

    if (node.totalSize() <= maxSize)
        foundAlready.push(node)
    end

    node.children.each { |n| findDirectoriesUnderSize(n, maxSize, foundAlready) }

    return foundAlready
end

def findDirectoriesOverSize(node, minSize, foundAlready)
    if (node.children.length == 0)
        # this is a file, not a directory!
        return foundAlready
    end

    if (node.totalSize() >= minSize)
        foundAlready.push(node)
    end

    node.children.each { |n| findDirectoriesOverSize(n, minSize, foundAlready) }

    return foundAlready
end

def parseTree(lines) 
    rootNode = Node.new("/", nil, [], 0)
    currentNode = rootNode
    
    lines.each do |line|
        split = line.split(" ")
    
        if split[0] == "$"
            # command
            command = split[1]
            
            if (command == "cd")
                # assumption here that we've "seen" the directory before
    
                if split[2] == ".."
                    currentNode = currentNode.parent
                    next
                end
    
                if split[2] == "/"
                    currentNode = rootNode
                    next
                end

                currentNode = currentNode.children.filter { |n| n.id == split[2] }.first
            
            end
    
            if (command == "ls")
                # don't need to do anything
            end
    
            next
        end
    
        # not a command, so must be file details
        size = split[0] == "dir" ? 0 : Integer(split[0])
        child = Node.new(split[1], currentNode, [], size)
    
        currentNode.children.push(child)
    end

    return rootNode
end

lines = File.read("input.txt").split("\n")
rootNode = parseTree(lines)

puts "File structure:"
printTree(rootNode, 0)
puts " "

puts "Directories at most 100,000 in size:"
answers = findDirectoriesUnderSize(rootNode, 100000, [])
answers.each do |node|
    puts "#{node.id}: total size - #{node.totalSize()}"
end
puts " "

puts "Sum of their total sizes: #{answers.sum { |node| node.totalSize() }}"

totalSpace = 70000000
usedSpace = rootNode.totalSize()
unusedSpace = totalSpace - usedSpace
requiredSpace = 30000000
minToDelete = requiredSpace - unusedSpace

puts ""
puts "Filesystem size: #{totalSpace}"
puts "Used space: #{usedSpace}"
puts "Unused space: #{unusedSpace}"
puts "Required space: #{requiredSpace}"
puts "Need to free up: #{minToDelete}"

puts ""
puts "Directories over #{minToDelete} in size:"
puts ""

secondAnswers = findDirectoriesOverSize(rootNode, minToDelete, [])
secondAnswers.each do |node|
    puts "\t#{node.id}: total size - #{node.totalSize()}"
end
puts ""

smallestSize = secondAnswers.map { |node| node.totalSize() }.min
smallestOfThese = secondAnswers.filter { |node| node.totalSize() == smallestSize }.first

puts "Smallest of these: #{smallestOfThese.id} - #{smallestOfThese.totalSize()}"