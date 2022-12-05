require 'set'

def getPriority(character)
    # uppercase item types A through Z have priorities 27 through 52.
    if (character.ord < 97) then
        return 27 + (character.ord - 65)
    end

    # lowercase item types a through z have priorities 1 through 26.
    return character.ord - 96
end

# each line represents a rucksack
lines = File.read("rucksacks.txt").split("\n")

# each rucksack contains two compartments (half each)
# model this as a 2d array 
compartments = lines.map { |line| [line.slice(0, line.length / 2), line.slice(line.length / 2, line.length / 2) ] }

# each character is an item in that rucksack
# we're expecting one item to be _both_ the first and second compartments
duplicates = compartments.map { |a, b| (Set.new(a.split("")) & Set.new(b.split(""))).first }

# convert these items into their respective "priorities"
priorities = duplicates.map { |i| getPriority i }

# sum it all up!
puts priorities.sum