import random

file_name = "../knapsack-20.txt"
# Get all possible binary arrays of size n
def get_lists(n: int) -> list[list[int]]:
    if n == 0: return []
    if n == 1: return [[0], [1]]
    result = []
    for l in get_lists(n-1):
        result.append([0] + l)
        result.append([1] + l)
        
    return result

def load_data(file_name: str) -> "list[tuple[int, int]]":
  weights_and_values = []
  with open(file_name) as f:
    for line in f:
        parts = line.split() 
        if (len(parts) == 3):
            weight = int(parts[1])
            value = int(parts[2])
            weights_and_values.append((weight, value))
    
  return weights_and_values

def get_weight(file_name: str):
    with open(file_name) as f:
        lines = f.readlines() 
        return int(lines[-1].strip())

def check_random(): 
    data = load_data(file_name)
    all_combinations = get_lists(len(data)) 
    max_weight = get_weight(file_name)
    
    n = len(data)
    random_idx = random.randint(0, len(all_combinations) - 1)
    current_combination = all_combinations[random_idx]
    
    print(f"Checking combination index: {random_idx}")
    
    total_weight = 0
    total_value = 0
    
    for i in range(n):
        if current_combination[i] == 1:
            total_weight += data[i][0] # Weight
            total_value += data[i][1]  # Value
    
    if total_weight <= max_weight:
        return f"Found valid set! Weight: {total_weight}, Value: {total_value}"
    
    return "No valid set found in this attempt"
    
    
    

if __name__ == '__main__':
    print(get_lists(3))
    print(load_data(file_name))
    print(check_random())