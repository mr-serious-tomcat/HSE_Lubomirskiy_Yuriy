def factorial(n):
    if n == 0:
        return 1
    else:
        return n * factorial(n-1)
number = int(input("Введите число: "))
if number < 0:
    print("Факториал числа не определен")
elif number == 0:
    print("Факториал 0 равен 1")
else:
    print("Факториал числа", number, "равен", factorial(number))