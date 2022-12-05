lines = File.read("assignments.txt").split("\n")

def completelyOverlap?(a, b)
    return (a[0] >= b[0] && a[1] <= b[1]) || (b[0] >= a[0] && b[1] <= a[1])
end

# each line represents a pair of elves
# and the "sections" those elves are assigned to

pairs = lines.map { |line| line.split(",").map { |s| s.split("-").map { |c| Integer(c) } } }


# pairs.each { | a, b | puts "#{a} #{b} - #{completelyOverlap?(a, b)}" }

completelyOverlappingPairs = pairs.filter { | a, b | completelyOverlap?(a, b) }

# how many completely overlap?
puts completelyOverlappingPairs.length