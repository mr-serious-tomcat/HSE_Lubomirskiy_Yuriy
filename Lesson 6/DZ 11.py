import requests

class LegalAPI:

    BASE_URL = "https://legal-api.sirotinsky.com"

    def __init__(self, token):

        self.token = token

    def _make_request(self, endpoint, inn):

        url = f"{self.BASE_URL}/{self.token}/efrsb/{endpoint}/{inn}"
        try:
            response = requests.get(url)
            response.raise_for_status()  # исключение, если ответ не успешный
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f"Ошибка при запросе к API: {e}")
            return None

    def get_organisation(self, inn):

        return self._make_request("organisation", inn)

    def get_person(self, inn):

        return self._make_request("person", inn)

    def get_trader(self, inn):

        return self._make_request("trader", inn)

    def get_manager(self, inn):

        return self._make_request("manager", inn)


api = LegalAPI("4123saedfasedfsadf4324234f223ddf23")
org_data = api.get_organisation("7707083893")
if org_data:
    print(org_data)
else:
    print("Не найдена или произошла ошибка.")
