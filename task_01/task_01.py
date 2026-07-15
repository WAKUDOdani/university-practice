# Кейс-задача № 1
# Найти сумму отрицательных элементов между максимальным и минимальным элементами массива

A = [4, -2, 10, -5, 3, -7, 1]

N = len(A)

# Находим максимальный и минимальный элементы
max_value = max(A)
min_value = min(A)

# Находим их индексы
max_index = A.index(max_value)
min_index = A.index(min_value)

# Определяем границы участка между max и min
left_index = min(max_index, min_index)
right_index = max(max_index, min_index)

# Считаем сумму отрицательных элементов между найденными границами
negative_sum = 0

for i in range(left_index + 1, right_index):
    if A[i] < 0:
        negative_sum += A[i]

# Вывод результата
print("Кейс-задача № 1")
print("Массив A:", A)
print("Размер массива N:", N)
print("Максимальный элемент:", max_value)
print("Минимальный элемент:", min_value)
print("Сумма отрицательных элементов между max и min:", negative_sum)