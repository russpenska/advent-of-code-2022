require 'set'
buffer = File.read("buffer.txt").split("")

# find the first occurence of 4 unique characters in a row
for i in (13..buffer.length) do
    # if all chars are unique our Set will have 14 items
    if Set.new(buffer.slice(i - 13, 14)).length == 14 then
        puts "First occurence of 14 unique characters is '#{buffer.slice(i - 13, 14).join("")}' at index #{i}. Characters processed: #{i+1}."
        break
    end

    i += 1
end