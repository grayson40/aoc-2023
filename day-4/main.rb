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
  total_points
end

def part_2()
  # Read the file and store the lines
  cards = File.readlines('input.txt').map(&:strip)

  # Array to hold the count of matching numbers for each card
  matches = []

  # Process each card to count matches
  cards.each do |card|
    my_numbers, winning_numbers = card.split(':')[1].split('|')
    winning_numbers_set = Set.new(winning_numbers.split(' '))
    match_count = my_numbers.split(' ').count { |num| winning_numbers_set.include?(num) }
    matches << match_count
  end

  # Array to hold the influence multiplier for each card
  multipliers = Array.new(cards.size, 1)

  # Process each card to calculate its influence on subsequent cards
  matches.each_with_index do |match_count, index|
    # Update multipliers for subsequent cards
    (1..match_count).each do |offset|
      next_index = index + offset
      break if next_index >= cards.size
      multipliers[next_index] += multipliers[index]
    end
  end

  # Calculate the total number of cards
  total_cards = multipliers.sum

  # Return total_cards
  total_cards
end

puts part_1()
puts part_2()
