class Chainsaw:
    def __init__(self, brand, model, year):
        self.brand = brand
        self.model = model
        self.year = year
        self.is_engine_working = False

    def start_engine(self):
        self.is_engine_working = True
        print("Двигатель запущен")

    def stop_engine(self):
        self.is_engine_working = False
        print("Двигатель выключен")

    def cut(self, material):
        if self.is_engine_working:
            print(f"Бензопила {self.brand} {self.model} ({self.year}) года выпуска режет {material}")
        else:
            print("Сначала нужно запустить двигатель")

    def sharpen(self):
        print("Проводится заточка цепи")