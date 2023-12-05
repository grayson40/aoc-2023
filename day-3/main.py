# Create a list of all keyboard symbols
symbols = ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "-", "=", "[", "]", "{", "}", "|", "\\", ";", ":", "'", "\"", ",", "<", ">", "/", "?"]

# Function to extract a number considering its original left-to-right orientation
def extract_full_number(grid, x, y):
    # Find the start of the number
    while y > 0 and grid[x][y - 1].isdigit():
        y -= 1
    # Extract the full number
    number = ''
    while y < len(grid[0]) and grid[x][y].isdigit():
        number += grid[x][y]
        y += 1
    return int(number) if number else None

# Read the engine schematic into a 2D array
with open("input.txt", "r") as file:
    grid = [list(line.strip()) for line in file]

# Set to keep track of counted numbers
counted_numbers = set()

# Iterate through each cell and sum adjacent numbers if the cell is a symbol
total_sum = 0
for x in range(len(grid)):
    for y in range(len(grid[0])):
        if grid[x][y] in symbols:
            # Check in all eight directions
            for dx, dy in [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < len(grid) and 0 <= ny < len(grid[0]) and grid[nx][ny].isdigit():
                    number = extract_full_number(grid, nx, ny)
                    if number is not None and number not in counted_numbers:
                        total_sum += number
                        counted_numbers.add(number)

print(counted_numbers)
print("The sum of all adjacent numbers is", total_sum)
