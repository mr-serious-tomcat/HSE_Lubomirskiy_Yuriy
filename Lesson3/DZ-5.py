import json
import csv


inn_list = []
with open('traders.txt', 'r') as f:
    for line in f:
        inn_list.append(line.strip())


inn_info = {}
with open('traders.json', 'r') as f:
    traders_data = json.load(f)
    for trader in traders_data:
        if trader['inn'] in inn_list:
            inn_info[trader['inn']] = {'ogrn': trader['ogrn'], 'address': trader['address']}


with open('traders.csv', 'w', newline='') as f:
    csv_writer = csv.writer(f)
    csv_writer.writerow(['inn', 'ogrn', 'address'])
    for inn, info in inn_info.items():
        csv_writer.writerow([inn, info['ogrn'], info['a ddress']])

print("Информация сохранена в файл traders.csv.")