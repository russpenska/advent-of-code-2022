# 1 for Rock, 2 for Paper, and 3 for Scissors
def scoreForShape(shape)
    case shape
    when :rock
        return 1
    when :paper
        return 2
    when :scissors
        return 3
    end

    # that's not a shape!
    return 0
end

# 0 if you lost, 3 if the round was a draw, and 6 if you won
def scoreForOutcome(opponentShape, myShape)
    # losing scenarios
    if (opponentShape == :rock && myShape == :scissors) || (opponentShape == :paper && myShape == :rock) || (opponentShape == :scissors && myShape == :paper) then
        return 0
    end

    # winning scenarios
    if (myShape == :rock && opponentShape == :scissors) || (myShape == :paper && opponentShape == :rock) || (myShape == :scissors && opponentShape == :paper) then
        return 6
    end

    # it's a draw!
    return 3
end

# only returns _my_ score
def scoreHand(opponentShape, myShape)
    return scoreForShape(myShape) + scoreForOutcome(opponentShape, myShape)
end

quickFix = {
    "A X" => "A C", # lose
    "A Y" => "A A", # draw
    "A Z" => "A B", # win

    "B X" => "B A", # lose
    "B Y" => "B B", # draw
    "B Z" => "B C", # win

    "C X" => "C B", # lose
    "C Y" => "C C", # draw
    "C Z" => "C A", # win
}

shapeLookup = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
}

str = File.read("strategy.txt")

# split into lines
# split those lines into (two) characters, 
# map those characters to our symbols

# X Y Z 
hands = str.split("\n").map{ |line| quickFix[line] }.map { |line| line.split(" ").map { |s| shapeLookup[s] } }

# calculate score
# hands.each { | opponentShape, myShape | puts "#{opponentShape} #{myShape} - score: #{scoreForShape(myShape)} + #{scoreForOutcome(opponentShape, myShape)} = #{scoreHand(opponentShape, myShape)}" }
puts hands.sum { | opponentShape, myShape | scoreHand(opponentShape, myShape) }