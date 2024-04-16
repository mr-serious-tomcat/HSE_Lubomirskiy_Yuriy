import random

step = random.randint(3, 5)
arr = list(range(10, 250_000_000 + 1, step))

import random

random_numbers = [random.randint(1, 100) for _ in range(10)]

def linear_search(arr, target):
    for i, num in enumerate(arr):
        if num == target:
            return i
    return -1

def binary_search(arr, target):
    low = 0
    high = len(arr) - 1

    while low <= high:
        mid = (low + high) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            low = mid + 1
        else:
            high = mid - 1

    return -1

import time

# Линейный поиск
start_time = time.time()
for num in random_numbers:
    index = linear_search(arr, num)
    if index != -1:
        print(f"Число {num} найдено по индексу {index} (линейный поиск)")
    else:
        print(f"Число {num} не найдено (линейный поиск)")
end_time = time.time()
linear_search_time = end_time - start_time

# Бинарный поиск
start_time = time.time()
for num in random_numbers:
    index = binary_search(arr, num)
    if index != -1:
        print(f"Число {num} найдено по индексу {index} (бинарный поиск)")
    else:
        print(f"Число {num} не найдено (бинарный поиск)")
end_time = time.time()
binary_search_time = end_time - start_time

print(f"Время выполнения линейного поиска: {linear_search_time} сек.")
print(f"Время выполнения бинарного поиска: {binary_search_time} сек.")

