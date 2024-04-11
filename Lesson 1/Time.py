def convert_seconds(seconds):
    minutes = seconds / 60
    hours = minutes / 60
    days = hours / 24


    return {
        "minutes": minutes,
        "hours": hours,
        "days": days,
    }

seconds_input = input("Введите количество секунд: ")
if seconds_input.isdigit():
    seconds = int(seconds_input)
    result = convert_seconds(seconds)
    print(f"Минуты: {result['minutes']}")
    print(f"Часы: {result['hours']}")
    print(f"Дни: {result['days']}")
else:
    print("Ошибка: Введите число.")