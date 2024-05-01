import requests
from urllib.parse import urljoin
from bs4 import BeautifulSoup

def find_hidden_apis(url):

    try:
        response = requests.get(url)
        response.raise_for_status()

        soup = BeautifulSoup(response.content, 'html.parser')

        potential_api_urls = []

        for tag in soup.find_all(['a', 'script']):
            href = tag.get('href')
            src = tag.get('src')
            if href and any(keyword in href for keyword in ['/api/', '.json', 'graphql']):
                potential_api_urls.append(urljoin(url, href))
            if src and any(keyword in src for keyword in ['/api/', '.json', 'graphql']):
                potential_api_urls.append(urljoin(url, src))

        for string in soup.find_all(string=True):
            if any(keyword in string for keyword in ['api_key', 'access_token', 'client_secret']):
                print(f"[INFO] упоминание API ключа: {string}")

        return potential_api_urls

    except requests.exceptions.RequestException as e:
        print(f"[ERROR] Ошибка к {url}: {e}")
        return []

url = "https://fedresurs.ru/"
potential_apis = find_hidden_apis(url)
if potential_apis:
    print("[INFO] Возможные скрытые API:")
    for api_url in potential_apis:
        print(api_url)
else:
    print("[INFO] Скрытые API не найдены.")
