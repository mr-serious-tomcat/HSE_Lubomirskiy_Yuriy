participants = []

for i in range(3):
    participant = {}
    print(f"Внесите участника  {i + 1}:")
    participant["наименование"] = input("Введите наименование: ")
    participant["статус"] = input("Введите статус: ")
    participant["ИНН"] = input("Введите ИНН: ")

    participants.append(participant)

print("Список участников:")
for idx, participant in enumerate(participants, 1):
    print(f"Участник {idx}: {participant}")