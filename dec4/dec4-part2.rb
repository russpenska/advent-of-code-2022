lines = File.read("assignments.txt").split("\n")

def overlap?(a, b)
    return (a.min <= b.max && a.min >= b.min) || (b.min <= a.max && b.min >= a.min)
end

# each line represents a pair of elves
# and the "sections" those elves are assigned to
pairs = lines.map { |line| line.split(",").map { |s| s.split("-").map { |c| Integer(c) } } }


# pairs.each { | a, b | puts "#{a} #{b} - #{overlap?(a, b)}" }
overlappingPairs = pairs.filter { | a, b | overlap?(a, b) }

# how many completely overlap?
puts overlappingPairs.length