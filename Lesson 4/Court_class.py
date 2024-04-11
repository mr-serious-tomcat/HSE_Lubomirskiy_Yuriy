from datetime import datetime, timezone

class CourtCase:
    def __init__(self, case_number: str):
        self.case_number = case_number
        self.case_participants = set()
        self.listening_datetimes = []
        self.is_finished = False
        self.verdict = ""

    def set_a_listening_datetime(self, start: str, end: str, location: str, description: str):
        try:
            start_date = datetime.fromisoformat(start)
            end_date = datetime.fromisoformat(end)
        except ValueError as e:
            raise ValueError(f"Некорректный формат даты: {e}")

        new_listening = {
            "start": start_date,
            "end": end_date,
            "location": location,
            "description": description
        }
        self.listening_datetimes.append(new_listening)
        self.listening_datetimes.sort(key=lambda x: x["start"])

    def add_participant(self, inn: str):
        if inn not in self.case_participants:
            self.case_participants.add(inn)
            return f"Участник {inn} добавлен в дело."
        else:
            raise ValueError(f"Участник {inn} уже есть в деле.")

    def remove_participant(self, inn):
        if inn in self.case_participants:
            self.case_participants.remove(inn)
            return f"Участник {inn} удален из дела."
        else:
            raise ValueError(f"Такого участника нет в деле.")

    def make_a_decision(self, verdict):
        self.verdict = verdict
        self.is_finished = True
        return f"Дело закрыто с вердиктом: {verdict}"


    def next_listening(self):
        now = datetime.now(timezone.utc)
        next_date = None
        for listening in self.listening_datetimes:
            if listening['start'] > now:
                next_date = listening['start']
                break
        if next_date:
            print(f"Следующее судебное заседание {next_date.isoformat()}")
        else:
            print("Судебных заседаний не намечается")
