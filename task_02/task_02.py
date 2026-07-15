# Кейс-задача № 2
# Демонстрация работы методов базового и производного классов

# Базовый класс
class Transport:
    def __init__(self, brand, speed):
        self.brand = brand
        self.speed = speed

    # Метод вывода информации
    def show_info(self):
        print("Транспорт")
        print("Марка:", self.brand)
        print("Скорость:", self.speed, "км/ч")

    # Метод движения
    def move(self):
        print("Транспорт движется")


# Производный класс
class Car(Transport):
    def __init__(self, brand, speed, fuel_type):
        super().__init__(brand, speed)
        self.fuel_type = fuel_type

    # Переопределяем метод базового класса
    def show_info(self):
        print("Автомобиль")
        print("Марка:", self.brand)
        print("Скорость:", self.speed, "км/ч")
        print("Тип топлива:", self.fuel_type)

    # Метод производного класса
    def start_engine(self):
        print("Двигатель автомобиля запущен")


# Создание объектов
transport = Transport("Обычный транспорт", 80)
car = Car("Toyota", 180, "бензин")

# Проверка работы методов базового класса
print("Кейс-задача № 2")
print("Работа базового класса:")
transport.show_info()
transport.move()

print()

# Проверка работы методов производного класса
print("Работа производного класса:")
car.show_info()
car.move()
car.start_engine()