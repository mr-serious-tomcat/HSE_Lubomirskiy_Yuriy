from datetime import datetime, timezone


class CourtCase:
    """Класс, представляющий судебное дело."""

    def __init__(self, case_number: str):
        """Инициализация нового дела с номером."""
        self.case_number = case_number
        self.case_participants = set()
        self.listening_datetimes = []
        self.is_finished = False
        self.verdict = ""

    def set_a_listening_datetime(self, start: str, end: str, location: str, description: str):
        """Установка даты и времени слушания."""
        try:
            start_date = datetime.fromisoformat(start)
            end_date = datetime.fromisoformat(end)
        except ValueError as e:
            raise ValueError(f"Некорректный формат даты: {e}")

        new_listening = {"start": start_date, "end": end_date, "location": location, "description": description}
        self.listening_datetimes.append(new_listening)
        self.listening_datetimes.sort(key=lambda x: x["start"], reverse=True)

    def add_participant(self, inn: str):
        """Добавление участника в дело."""
        if inn not in self.case_participants:
            self.case_participants.add(inn)
            return f"Участник {inn} добавлен в дело."
        return "Участник уже есть в деле."

    def remove_participant(self, inn):
        """Удаление участника из дела."""
        if inn in self.case_participants:
            self.case_participants.remove(inn)
            return f"Участник {inn} удален из дела."
        return "Такого участника нет в деле."


    def make_a_decision(self, verdict):
        """Принятие решения по делу."""
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
