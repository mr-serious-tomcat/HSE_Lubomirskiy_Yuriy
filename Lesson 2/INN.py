def validate_inn(inn):
    if not inn.isdigit():
        return False

    if len(inn) not in (10, 12):
        return False

    if len(inn) == 10:

        weights_10 = [2, 4, 10, 3, 5, 9, 4, 6, 8]
        control_sum_10 = sum(int(inn[i]) * weights_10[i] for i in range(9)) % 11 % 10
        if int(inn[9]) != control_sum_10:
            return False
    else:

        weights_12 = [7, 2, 4, 10, 3, 5, 9, 4, 6, 8]
        control_sum_11 = sum(int(inn[i]) * weights_12[i] for i in range(10)) % 11 % 10
        control_sum_12 = sum(int(inn[i]) * weights_12[i] for i in range(11)) % 11 % 10
        if int(inn[10]) != control_sum_11 or int(inn[11]) != control_sum_12:
            return False

    return True



user_inn = input("Введите ИНН для проверки: ")


if validate_inn(user_inn):
    print("Введенный ИНН является корректным.")
else:
    print("Введенный ИНН некорректен.")