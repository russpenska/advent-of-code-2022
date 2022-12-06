require 'set'
buffer = File.read("buffer.txt").split("")

# find the first occurence of 4 unique characters in a row
i = 3

while i < buffer.length do
    # if all chars are unique our Set will have 4 items
    if Set.new(buffer.slice(i - 3, 4)).length == 4 then
        puts "First occurence of 4 unique characters is '#{buffer.slice(i - 3, 4).join("")}' at index #{i}. Characters processed: #{i+1}."
        break
    end

    i += 1
end