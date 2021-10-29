=begin
- I created a file entries.txt just to visualize how the entries looks like.
- Each entry is 4 lines long
- Each line has 27 characters
- The first 3 lines of each entry contain a policy number written using pipes and underscores.
- The fourth line is blank
- Each policy number should have 9 digits [0-9]
=end

require './file_writer.rb'

# open the file
file = File.open("entries.txt")

# entries
@policy_numbers = [] # to strore the actual policy numbers

# numbers representation
@numbers_representation = {
  1 => "       ||",
  2 => " |___ |",
  3 => "___ ||",
  4 => "|  _  ||",
  5 => " | ___  |",
  6 => " ||___ |",
  7 => "_   ||",
  8 => " ||___ ||",
  9 => " | __  ||"
}


# To parse the pipes and underscore into actual numbers
# using numbers_representation hashmap
def parse_to_actual_numbers(lines)
  combined_lines = []
  policy_numbers = []
  # each line has the same length so we can use any of them
  length = lines[:first].length 

  length.times do |i|
    #puts "1st #{lines[:first][i]}, 2nd #{lines[:second][i]}, 3rd #{lines[:third][i]}"
    number_as_string = lines[:first][i] + lines[:second][i] + lines[:third][i]
    combined_lines.push(number_as_string)
  end
  combined_lines = combined_lines.join
  # 1 - loop through numbers_representation
  @numbers_representation.each do |number, string|
    # 2 - find if any of the numbers are in combined_lines
    if combined_lines.include? string then
      # 3 find the index of each number 
      indexs = find_indexes(combined_lines, string)
      for i in indexs do
        policy_numbers.push([i, number])
      end
    end
  end
  # 4 - sort numbers by index, eg 3 found in index 3 first but 9 
      # found in index 0 last then 9 must come before 3
  policy_numbers = policy_numbers.sort_by { |el| el[0] }
  temp_policy = []
  policy_numbers.map {|e| temp_policy.push(e[1])}
  @policy_numbers << (temp_policy.join)
end

def find_indexes(combined_lines, string) 
  j = -1
  indexs = []
  while j = combined_lines.index(string,j+1)
    indexs << j
  end
  return indexs
end

i = 0
lines = {
  first: [],
  second: [],
  third: []
}

file.each_line do |line|
    if line.length != 1 then # only empty lines == 1
      line.each_char do |c|
        if i == 0
          lines[:first].push(c)
        elsif i == 1 
          lines[:second].push(c) 
        elsif i == 2
          lines[:third].push(c)
        end
      end # each_char loop
    end # condition
    
    if line.length == 1 then
      parse_to_actual_numbers(lines)
      lines = {
        first: [],
        second: [],
        third: []
      }
      i = 0
    else

    i = i + 1
  end
end

puts @policy_numbers
#file = FileWriter.new(@policy_numbers)
#file.build_file
