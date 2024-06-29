def is_monotonic(arr):

  if len(arr) <= 1:
    return "true"

  increasing = arr[0] <= arr[1]

  for i in range(1, len(arr)):
    if increasing and arr[i] < arr[i - 1]:
      return "false"
    elif not increasing and arr[i] > arr[i - 1]:
      return "false"

  return "true"

print(is_monotonic([1, 2, 3, 4, 5]))


