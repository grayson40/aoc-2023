def part_1()
  input_lines = File.readlines('input.txt').map(&:strip)

  final_numbers = []
  input_lines.each_with_index do |line, line_index|
    # Append initial line to sequence history
    sequence_history = []
    sequence_numbers = line.split(' ').map(&:to_i)
    sequence_history << sequence_numbers

    # Append new sequence from the difference at each step until sequence is all zero
    until sequence_numbers.all?(&:zero?)
      sequence_numbers = sequence_numbers.each_cons(2).map { |a, b| b - a }
      sequence_history << sequence_numbers
    end

    # Reverse sequence history and iterate through each sequence
    reversed_history = sequence_history.reverse.dup
    reversed_history.each_with_index do |current_sequence, current_sequence_index|
      next if current_sequence_index.zero?

      # If all numbers in current sequence are the same, append the last number
      # Else, append the sum of the last number in the previous sequence and the last number in the current sequence
      if current_sequence.all?(current_sequence[-1])
        reversed_history[current_sequence_index] << current_sequence[-1]
      else
        number_to_append = reversed_history[current_sequence_index - 1][-1] + current_sequence[-1]
        reversed_history[current_sequence_index] << number_to_append
      end
    end

    # Append the last number in the last sequence to the final numbers array
    final_numbers << reversed_history[-1][-1]
  end

  # Return the sum of all final numbers
  final_numbers.sum
end

def part_2()
  input_lines = File.readlines('input.txt').map(&:strip)

  final_numbers = []
  input_lines.each_with_index do |line, line_index|
    # Append initial line to sequence history
    sequence_history = []
    sequence_numbers = line.split(' ').map(&:to_i)
    sequence_history << sequence_numbers

    # Append new sequence from the difference at each step until sequence is all zero
    until sequence_numbers.all?(&:zero?)
      sequence_numbers = sequence_numbers.each_cons(2).map { |a, b| b - a }
      sequence_history << sequence_numbers
    end

    # Reverse sequence history and iterate through each sequence
    reversed_history = sequence_history.reverse.dup
    reversed_history.each_with_index do |current_sequence, current_sequence_index|
      # If all numbers in current sequence are the same, append the last number
      # Else, append the sum of the last number in the previous sequence and the last number in the current sequence
      if current_sequence.all?(current_sequence[0])
        reversed_history[current_sequence_index].unshift(current_sequence[0])
      else
        number_to_append = current_sequence[0] - reversed_history[current_sequence_index - 1][0]
        reversed_history[current_sequence_index].unshift(number_to_append)
      end
    end

    # Append the last number in the last sequence to the final numbers array
    final_numbers << reversed_history[-1][0]
  end

  # Return the sum of all final numbers
  final_numbers.sum
end

puts part_1()
puts part_2()
