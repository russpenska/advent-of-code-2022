def parseDrawing(text)
    lines = text.split("\n")
    lastLine = lines.last
    
    # figure out which index holds which stack of crates
    stackIndices =  lastLine.split("").each_with_index.map { |x, i| [x, i] }.filter { |arr| arr[0] != " " }

    otherLines = lines.slice(0, lines.length - 1)

    # grab the "crate" (if any) at the index for each stack
    stacks = stackIndices.map do |c, i|
        otherLines.reverse.map { |line| line.split("")[i] }.filter { |c| c != " " }
    end

    # we ignore the ids and just trust the order
    return stacks
end

def parseMoves(line)
    words = line.split(" ")
    
    amountToMove = Integer(words[1])
    stackToMoveFrom = Integer(words[3])
    stackToMoveTo = Integer(words[5])

    return [ amountToMove, stackToMoveFrom, stackToMoveTo ]
end

def parseAllMoves(text)
    lines = text.split("\n")
    allMoves = lines.map { |line| parseMoves line }

    allMoves.each do |a, b, c| 
        puts "#{a} x #{b} to #{c}"
    end

    return allMoves
end

fileParts = File.read("crates.txt").split("\n\n")

stacks = parseDrawing fileParts[0]
moves = parseAllMoves fileParts[1]

puts "Initial Order:"

# rearrange the stacks with the given moves 
# except multiple crates moved at the same time
# retain their order
moves.each do | n, from, to |
    fromStack = stacks[from - 1] # hack!
    toStack = stacks[to - 1] # same hack again!

    fromStack.slice!(-n, n).each { |c| toStack.push c }
    puts "Moving #{n} from #{from} to #{to}"
end

puts "Final Order:"
stacks.each_with_index do | stack, i |
    puts "#{i + 1}: #{stack}" 
end


topCrates = stacks.map { |stack| stack.last }

puts "Top Crates: #{topCrates.join("")}" 