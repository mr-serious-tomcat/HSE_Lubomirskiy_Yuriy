def generate_legal_text(defendant_data, case_number, courts_data):
    court_code = case_number.split('-')[0]
    court_address = courts_data[court_code]['address']


    legal_template = f"""
    В {courts_data[court_code]['court_name']}
    Адрес: {court_address}

    Истец: Любомирский Юрий Александрович
    ИНН: 228227226225 ОГРН: 787858568585
    Адрес: г. Сочи, ул. Котиков, д. 65

    Ответчик: {defendant_data['short_name']}
    ИНН {defendant_data['inn']} ОГРН {defendant_data['ogrn']}
    Адрес: {defendant_data['address']}

    Номер дела: {case_number}
    """

    return legal_template


courts_data = {
    'А40': {'court_name': 'Арбитражный суд города Москвы', 'address': '115225, г. Москва, ул. Б. Тульская, 17'},

}

defendant = {
    'short_name': 'ООО “Кооператив Озеро”',
    'inn': '1231231231',
    'ogrn': '123124129312941',
    'address': '123534, г. Москва, ул. Красивых молдавских партизан, 69'
}

case_number = 'А40-123456/2023'

legal_text = generate_legal_text(defendant, case_number, courts_data)
print(legal_text)