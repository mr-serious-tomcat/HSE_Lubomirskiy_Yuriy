import requests
from bs4 import BeautifulSoup
import json

class ParserCBRF:
    def __init__(self):
        self.data = {}

    def start(self):
        page = self._get_page_content("https://cbr.ru/hd_base/KeyRate/")
        if page:
            self._parse_key_rate(page)

    def _get_page_content(self, url):
        try:
            response = requests.get(url)
            if response.status_code == 200:
                return response.content
            else:
                print("Failed to retrieve page content")
                return None
        except requests.RequestException as e:
            print(f"Error during request: {e}")
            return None

    def _parse_key_rate(self, page_content):
        soup = BeautifulSoup(page_content, "html.parser")
        table = soup.find("table", class_="data")

        if table:
            rows = table.find_all("tr")
            for row in rows[1:]:  # Skipping the header row
                columns = row.find_all("td")
                date = columns[0].get_text()
                rate = columns[1].get_text()
                self.data[date] = rate

    def get_parsed_data(self):
        return self.data

    def save_to_json(self, filename="cbrf_data.json"):
        with open(filename, "w", encoding="utf-8") as f:
            json.dump(self.data, f, indent=4)

# Пример использования класса ParserCBRF
parser = ParserCBRF()
parser.start()
parsed_data = parser.get_parsed_data()
print(parsed_data)

# Сохранение данных в JSON
parser.save_to_json()
