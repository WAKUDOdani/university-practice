-- Кейс-задача № 3
-- База данных "Туризм"

-- Создание базы данных
CREATE DATABASE IF NOT EXISTS tourism_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Выбор базы данных
USE tourism_db;

-- Удаление таблиц, если они уже были созданы ранее
DROP TABLE IF EXISTS tour_orders;
DROP TABLE IF EXISTS managers;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS tours;
DROP TABLE IF EXISTS clients;

-- Таблица-справочник клиентов
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100)
);

-- Таблица-справочник туров
CREATE TABLE tours (
    tour_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    duration_days INT NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL
);

-- Таблица-справочник услуг
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_price DECIMAL(10, 2) NOT NULL
);

-- Таблица-справочник менеджеров
CREATE TABLE managers (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- Таблица переменной информации: заказы туров
CREATE TABLE tour_orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    tour_id INT NOT NULL,
    service_id INT NOT NULL,
    manager_id INT NOT NULL,
    order_date DATE NOT NULL,
    people_count INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_status VARCHAR(30) NOT NULL,

    -- Связь заказа с клиентом
    CONSTRAINT fk_orders_clients
        FOREIGN KEY (client_id) REFERENCES clients(client_id),

    -- Связь заказа с туром
    CONSTRAINT fk_orders_tours
        FOREIGN KEY (tour_id) REFERENCES tours(tour_id),

    -- Связь заказа с услугой
    CONSTRAINT fk_orders_services
        FOREIGN KEY (service_id) REFERENCES services(service_id),

    -- Связь заказа с менеджером
    CONSTRAINT fk_orders_managers
        FOREIGN KEY (manager_id) REFERENCES managers(manager_id)
);

-- Добавление клиентов
INSERT INTO clients (full_name, phone, email) VALUES
('Иванов Иван Иванович', '+79001234567', 'ivanov@example.com'),
('Петрова Анна Сергеевна', '+79007654321', 'petrova@example.com'),
('Сидоров Алексей Павлович', '+79005553322', 'sidorov@example.com');

-- Добавление туров
INSERT INTO tours (tour_name, country, city, duration_days, base_price) VALUES
('Отдых в Анталье', 'Турция', 'Анталья', 7, 85000.00),
('Экскурсионный тур в Рим', 'Италия', 'Рим', 5, 120000.00),
('Пляжный тур в Пхукет', 'Таиланд', 'Пхукет', 10, 150000.00);

-- Добавление услуг
INSERT INTO services (service_name, service_price) VALUES
('Трансфер из аэропорта', 5000.00),
('Медицинская страховка', 3000.00),
('Экскурсионная программа', 15000.00),
('Оформление визы', 10000.00);

-- Добавление менеджеров
INSERT INTO managers (full_name, phone) VALUES
('Смирнова Ольга Викторовна', '+79001112233'),
('Кузнецов Дмитрий Андреевич', '+79004445566');

-- Добавление заказов туров
INSERT INTO tour_orders (
    client_id,
    tour_id,
    service_id,
    manager_id,
    order_date,
    people_count,
    total_price,
    order_status
) VALUES
(1, 1, 1, 1, '2026-07-09', 2, 175000.00, 'оформлен'),
(2, 2, 3, 2, '2026-07-10', 1, 135000.00, 'оплачен'),
(3, 3, 2, 1, '2026-07-11', 2, 303000.00, 'в обработке');

-- Проверочный запрос для вывода заказов с данными из справочников
SELECT
    tour_orders.order_id,
    clients.full_name AS client_name,
    tours.tour_name,
    tours.country,
    tours.city,
    services.service_name,
    managers.full_name AS manager_name,
    tour_orders.order_date,
    tour_orders.people_count,
    tour_orders.total_price,
    tour_orders.order_status
FROM tour_orders
JOIN clients ON tour_orders.client_id = clients.client_id
JOIN tours ON tour_orders.tour_id = tours.tour_id
JOIN services ON tour_orders.service_id = services.service_id
JOIN managers ON tour_orders.manager_id = managers.manager_id;