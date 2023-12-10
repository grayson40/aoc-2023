DELTA = {
  'N' => [-1, 0],
  'S' => [1, 0],
  'E' => [0, 1],
  'W' => [0, -1],
}

OFFSET = [
  [-1, 0],
  [1, 0],
  [0, 1],
  [0, -1],
]

DIRECTIONS = {
  '|' => ['N', 'S'],
  '-' => ['E', 'W'],
  'L' => ['N', 'E'],
  'J' => ['N', 'W'],
  '7' => ['S', 'W'],
  'F' => ['S', 'E'],
}

def find_start(grid)
  grid.each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      if col == 'S'
        return [row_index, col_index]
      end
    end
  end
end

def find_longest_path(grid, start_pos, visited = {}, current_longest_path = 0)
  start_key = start_pos.join(',')
  return current_longest_path if visited[start_key]

  visited[start_key] = true
  current_longest_path += 1

  # Look at all adjacent squares
  OFFSET.each do |offset|
    # Store offset position and character
    offset_pos = [start_pos[0] + offset[0], start_pos[1] + offset[1]]
    # Check if offset_pos is within the bounds of the grid
    next if offset_pos[0] < 0 || offset_pos[0] >= grid.length || offset_pos[1] < 0 || offset_pos[1] >= grid[0].length
    character = grid[offset_pos[0]][offset_pos[1]]
    # If it's a direction, go that way using the DELTA
    if DIRECTIONS.has_key?(character)
      DIRECTIONS[character].each do |direction|
        # Calculate new position
        new_pos = [offset_pos[0] + DELTA[direction][0], offset_pos[1] + DELTA[direction][1]]
        # If the new position is a direction, move to it and increase the path length
        new_key = new_pos.join(',')
        if DIRECTIONS.has_key?(grid[new_pos[0]][new_pos[1]]) && !visited[new_key] && grid[new_pos[0]][new_pos[1]] != '.'
          # Recursive call to find_longest_path with new position and incremented path length
          path_length = find_longest_path(grid, new_pos, visited, current_longest_path)
          # Update current_longest_path if the returned path length is longer
          current_longest_path = [current_longest_path, path_length].max
        end
      end
    end
  end
  current_longest_path
end

# Read input file
input_lines = File.readlines('input.txt').map(&:strip)

# Put grid in 2d array
grid = input_lines.map { |line| line.split('') }

start_pos = find_start(grid)

longest_path = find_longest_path(grid, start_pos)

puts "Longest path: #{longest_path}"
