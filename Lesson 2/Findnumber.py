def find_max_of_three_numbers():
    numbers = [int(input("Введите первое число: ")),
               int(input("Введите второе число: ")),
               int(input("Введите третье число: "))]

    max_number = max(numbers)

    print("Наибольшее число:", max_number)

find_max_of_three_numbers()