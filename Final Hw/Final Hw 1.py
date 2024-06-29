def fib(n):
  a, b = 0, 1
  for _ in range(n):
    yield a
    a, b = b, a + b


for number in fib(15):
  print(number)