def part_1():
    with open('input.txt', 'r') as f:
        total = 0
        for line in f.readlines():
            nums = []
            for ch in line:
                if ch.isnumeric():
                    nums.append(str(ch))
            comb_num = int(nums[0] + nums[-1])
            total += comb_num
        return total


def part_2():
    nums_dict = {
        'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5,
        'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    }
    with open('input.txt', 'r') as f:
        total = 0
        for line in f.readlines():
            first_digit = None
            last_digit = None

            # Find the first digit or spelled-out digit
            for word, num in nums_dict.items():
                if word in line:
                    first_digit_index = line.find(word)
                    if first_digit is None or first_digit_index < first_digit[1]:
                        first_digit = (str(num), first_digit_index)

            for char in line:
                if char.isdigit():
                    if first_digit is None or line.find(char) < first_digit[1]:
                        first_digit = (char, line.find(char))

            # Find the last digit or spelled-out digit
            for word, num in reversed(nums_dict.items()):
                if word in line:
                    last_digit_index = line.rfind(word)
                    if last_digit is None or last_digit_index > last_digit[1]:
                        last_digit = (str(num), last_digit_index)

            for char in reversed(line):
                if char.isdigit():
                    if last_digit is None or line.rfind(char) > last_digit[1]:
                        last_digit = (char, line.rfind(char))

            # Combine first and last digits to form a number
            if first_digit and last_digit:
                comb_num = int(first_digit[0] + last_digit[0])
                total += comb_num

        return total


print(part_1())
print(part_2())
