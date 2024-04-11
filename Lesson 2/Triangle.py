def calculate_area_of_right_triangle(cathetus1, cathetus2):
    area = 0.5 * cathetus1 * cathetus2
    return area

cathetus1 = float(input("Введите длину катета: "))
cathetus2 = float(input("Введите длину катета: "))

if cathetus1 <= 0 or cathetus2 <= 0:
    print("Введите положительные числа.")

else:
    triangle_area = calculate_area_of_right_triangle(cathetus1, cathetus2)
    print("Площадь прямоугольного треугольника", cathetus1, "и", cathetus2, "равна", triangle_area)