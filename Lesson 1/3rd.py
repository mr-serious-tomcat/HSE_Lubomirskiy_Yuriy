n = input("Введите число n: ")

if n.isdigit():
    nn = n + n
    nnn = n + n + n
    result = int(n) + int(nn) + int(nnn)
    print(f" n + nn + nnn равно: {result}")
else:
    print("Ошибка: Введите число  n.")