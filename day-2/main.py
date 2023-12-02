MAX_COLORS = {'red': 12, 'green': 13, 'blue': 14}


def part_1():
    with open('input.txt', 'r') as f:
        total = 0
        for line in f.readlines():
            # Get the game ID's start and end index
            num_start_index = line.find(' ') + 1
            num_end_index = line.find(':', num_start_index)

            # Get the game ID
            game_id = int(line[num_start_index: num_end_index])

            # Get the number of red, green, and blue in each set, separated by ;
            sets = line[num_end_index + 1:].split(';')
            is_valid = True
            for set in sets:
                set = set.strip()
                if set == '':
                    continue

                # Get the number and color of each subset, separated by ,
                subsets = set.split(', ')
                for subset in subsets:
                    num = int(subset[0: subset.find(' ')])
                    color = subset[subset.find(' ') + 1:]
                    # Check if the number of the color is greater than the max
                    if num > MAX_COLORS[color]:
                        is_valid = False
                        break

                # Break out of line loop if the set is invalid
                if not is_valid:
                    break

            # Add the game ID to the total if it is valid
            total += game_id if is_valid else 0

        return total


print(part_1())
