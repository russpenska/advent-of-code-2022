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

# every three lines represents a "group"
commonItems = (0..(lines.length - 1)).step(3).map do |i|
    # find the common element in each of the 
    # three rucksacks in this group
    (Set.new(lines[i].split("")) & Set.new(lines[i+1].split("")) & Set.new(lines[i+2].split(""))).first
end

# convert these to their respective priorities
priorities = commonItems.map { |i| getPriority i }

# sum them up!
puts priorities.sum