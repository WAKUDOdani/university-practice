-- Кейс-задача №4
-- База данных для WEB-приложения "Туристическое агентство"
-- MS SQL Server

IF DB_ID('tourism_web_db') IS NOT NULL
BEGIN
    ALTER DATABASE tourism_web_db SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE tourism_web_db;
END;
GO

CREATE DATABASE tourism_web_db;
GO

USE tourism_web_db;
GO

-- Таблица-справочник клиентов
CREATE TABLE clients (
    client_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    email NVARCHAR(100)
);

-- Таблица-справочник туров
CREATE TABLE tours (
    tour_id INT IDENTITY(1,1) PRIMARY KEY,
    tour_name NVARCHAR(100) NOT NULL,
    country NVARCHAR(50) NOT NULL,
    city NVARCHAR(50) NOT NULL,
    duration_days INT NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL
);

-- Таблица-справочник услуг
CREATE TABLE services (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    service_name NVARCHAR(100) NOT NULL,
    service_price DECIMAL(10, 2) NOT NULL
);

-- Таблица-справочник менеджеров
CREATE TABLE managers (
    manager_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL
);

-- Таблица переменной информации: заказы туров
CREATE TABLE tour_orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL,
    tour_id INT NOT NULL,
    service_id INT NOT NULL,
    manager_id INT NOT NULL,
    order_date DATE NOT NULL,
    people_count INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_status NVARCHAR(30) NOT NULL,

    CONSTRAINT fk_orders_clients
        FOREIGN KEY (client_id) REFERENCES clients(client_id),

    CONSTRAINT fk_orders_tours
        FOREIGN KEY (tour_id) REFERENCES tours(tour_id),

    CONSTRAINT fk_orders_services
        FOREIGN KEY (service_id) REFERENCES services(service_id),

    CONSTRAINT fk_orders_managers
        FOREIGN KEY (manager_id) REFERENCES managers(manager_id)
);

-- Добавление клиентов
INSERT INTO clients (full_name, phone, email) VALUES
(N'Иванов Иван Иванович', N'+79001234567', N'ivanov@example.com'),
(N'Петрова Анна Сергеевна', N'+79007654321', N'petrova@example.com'),
(N'Сидоров Алексей Павлович', N'+79005553322', N'sidorov@example.com');

-- Добавление туров
INSERT INTO tours (tour_name, country, city, duration_days, base_price) VALUES
(N'Отдых в Анталье', N'Турция', N'Анталья', 7, 85000.00),
(N'Экскурсионный тур в Рим', N'Италия', N'Рим', 5, 120000.00),
(N'Пляжный тур в Пхукет', N'Таиланд', N'Пхукет', 10, 150000.00);

-- Добавление услуг
INSERT INTO services (service_name, service_price) VALUES
(N'Трансфер из аэропорта', 5000.00),
(N'Медицинская страховка', 3000.00),
(N'Экскурсионная программа', 15000.00),
(N'Оформление визы', 10000.00);

-- Добавление менеджеров
INSERT INTO managers (full_name, phone) VALUES
(N'Смирнова Ольга Викторовна', N'+79001112233'),
(N'Кузнецов Дмитрий Андреевич', N'+79004445566');

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
(1, 1, 1, 1, '2026-07-09', 2, 175000.00, N'оформлен'),
(2, 2, 3, 2, '2026-07-10', 1, 135000.00, N'оплачен'),
(3, 3, 2, 1, '2026-07-11', 2, 303000.00, N'в обработке');

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