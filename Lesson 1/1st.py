a = input("Введите значение переменной a: ")
b = input("Введите значение переменной b: ")
c = input("Введите значение переменной c: ")

if a.isdigit() and b.isdigit() and c.isdigit():
    result = int(a) + int(b) + int(c)
    print(f"Сумма a, b и c равна: {result}")
else:
    print("Ошибка: Введите целые числа для переменных a, b и c.")