import random

array1 = [random.randint(1, 1000000) for _ in range(100000)]

import random

array2 = [{"num_1": random.randint(1, 1000000), "num_2": random.randint(1, 1000000)} for _ in range(100000)]

def bubble_sort(arr):
    n = len(arr)
    for i in range(n - 1):
        for j in range(n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]

bubble_sort(array1)

array2.sort(key=lambda elem: (elem["num_1"], elem["num_2"]))
