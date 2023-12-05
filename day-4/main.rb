require 'set'

def part_1()
  total_points = 0

  # Open the file and read it line by line
  File.open('input.txt', 'r') do |file|
    file.each_line do |line|
      # Split the line by ':' and take the second part
      line = line.split(':')[1]

      # Split the line by '|' into my_numbers and winning_numbers
      my_numbers, winning_numbers = line.split('|')

      # Convert winning_numbers to a Set for faster lookup
      winning_numbers_set = Set.new(winning_numbers.split(' '))

      points = 0
      first_found = true

      # Iterate over my numbers
      my_numbers.split(' ').each do |my_number|
        # If my_number is in winning_numbers_set
        if winning_numbers_set.include?(my_number)
          # If it's the first found number, increment points by 1
          if first_found
            points += 1
            first_found = false
          else
            # If it's not the first found number, double the points
            points *= 2
          end
        end
      end

      # Add points to total_points
      total_points += points
    end
  end

  # Return total_points
  return total_points
end

puts part_1()
