import json
import csv

# 1. Получить список ИНН из файла traders.txt.
inn_list = []
with open('traders.txt', 'r') as f:
    for line in f:
        inn_list.append(line.strip())

# 2. Найти информацию об организациях из полученного списка ИНН в файле traders.json.
inn_info = {}
with open('traders.json', 'r') as f:
    traders_data = json.load(f)
    for trader in traders_data:
        if trader['inn'] in inn_list:
            inn_info[trader['inn']] = {'ogrn': trader['ogrn'], 'address': trader['address']}

# 3. Сохранить найденную информацию об ИНН, ОГРН и адресе организаций в файл traders.csv.
with open('traders.csv', 'w', newline='') as f:
    csv_writer = csv.writer(f)
    csv_writer.writerow(['inn', 'ogrn', 'address'])
    for inn, info in inn_info.items():
        csv_writer.writerow([inn, info['ogrn'], info['a ddress']])

print("Готово! Информация сохранена в файл traders.csv.")