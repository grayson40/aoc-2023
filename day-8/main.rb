START_POS = "AAA"
END_POS = "ZZZ"
LEFT = "L"
RIGHT = "R"

# Part 1
def part_1()
  # Read file contents
  file_contents = File.readlines('input.txt').map(&:strip)

  # Get directions
  initial_directions = file_contents[0]

  # Get maps
  maps = file_contents[2..-1]

  # Convert maps to a dictionary
  directions_dict = {}
  maps.each do |map|
    # Get destination and directions
    destination, directions = map.split('=')

    # Remove brackets
    directions = directions[2..-2].split(', ')

    # Add to directions dictionary
    directions_dict[destination.strip] = directions
  end

  # Initialize variables
  nums_steps = 0
  current_pos = START_POS
  found = false

  # Iterate over directions, counting steps
  while !found
    initial_directions.each_char do |direction|
      next_pos = ""
      nums_steps += 1

      # Break if we've reached finish
      if (directions_dict[current_pos][0] == END_POS && direction == LEFT) ||
         (directions_dict[current_pos][1] == END_POS && direction == RIGHT)
        found = true
        break
      end

      # Get next position
      if direction == LEFT
        next_pos = directions_dict[current_pos][0]
      elsif direction == RIGHT
        next_pos = directions_dict[current_pos][1]
      end

      # Increment nums_steps
      current_pos = next_pos
    end
  end
  nums_steps
end

puts part_1()
