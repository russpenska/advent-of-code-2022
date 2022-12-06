require 'set'
text = File.read("buffer.txt")

matches = Array.new
for a in (97..122) do
    for b in (97..122) do
        for c in (97..122) do
            for d in (97..122) do
                combination = a.chr + b.chr + c.chr + d.chr

                # check we have a unique set of characters
                if (Set.new([a, b, c, d]).length == 4) then 

                    # see if we can find it in the text
                    index = text.index(combination)
                    if (!index.nil?) then
                        # puts "Found #{combination} in text. Index: #{index}"
                        matches.push([index, combination])
                    end
                end
            end
        end
    end
end

puts matches.sort_by { |a| a[0] }.first + 4 # add 4 - we want to include the characters themselves