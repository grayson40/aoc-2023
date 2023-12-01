def part_1():
    floor = 0
    with open('input.txt', 'r') as f:
        for step in f.read():
            if step == '(':
                floor = floor + 1
            elif step == ')':
                floor = floor - 1
        return floor

def part_2():
    floor = 0
    with open('input.txt', 'r') as f:
        for index, step in enumerate(f.read()):
            if step == '(':
                floor = floor + 1
            elif step == ')':
                floor = floor - 1
            
            if floor < 0:
                return index + 1

print(part_1())
print(part_2())