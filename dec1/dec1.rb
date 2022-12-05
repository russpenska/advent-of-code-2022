input = File.read("input.txt")
groups = input.split("\n\n")
sums = groups.map { |g| g.split("\n").map { |s|  Integer(s) }.sum() }

# bug here if one or more of these have the same sum

firstTotal = sums.max()
sums.delete(firstTotal)

secondTotal = sums.max()
sums.delete(secondTotal)

thirdTotal = sums.max()
sums.delete(thirdTotal)

puts firstTotal + secondTotal + thirdTotal