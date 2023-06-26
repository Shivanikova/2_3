CREATE TABLE IF NOT EXISTS public.readers (
    ticket_number bigserial PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    firts_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) UNIQUE NOT NULL,
    e_mail VARCHAR(100),
    date_of_issue DATE NOT NULL,
    stop_list BOOL NOT NULL,
    birthday DATE CHECK (birthday > '1900-01-01')
);
CREATE TABLE IF NOT EXISTS public.publisher(
    publisher_id serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.books (
    book_id bigserial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    date_of_issue DATE NOT NULL,
    sheets SMALLINT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    number_of_instances SMALLINT NOT NULL,
    bookcase SMALLINT NOT NULL,
    shelf SMALLINT NOT NULL,
    publisher_id INTEGER NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id) ON DELETE SET null 
);
CREATE TABLE IF NOT EXISTS public.staff(
    staff_id smallserial PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR,
    position VARCHAR(50),
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
    e_mail VARCHAR(100),
    current_employee_status BOOL NOT NULL
);
CREATE TABLE IF NOT EXISTS public.rent (
    rent_id serial PRIMARY KEY,
    book_id BIGINT NOT NULL,
    ticket_number BIGINT NOT NULL,
    FOREIGN KEY (ticket_number) REFERENCES readers (ticket_number) ON DELETE SET NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE SET NULL,
    date_of_issue DATE CHECK (date_of_issue > '1900-01-01'),
    return_date DATE CHECK (return_date > date_of_issue),
    actual_return_date DATE,
    staff_id SMALLINT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ON DELETE SET null 
);
CREATE TABLE IF NOT EXISTS public.authors(
    author_id serial PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50),
    middle_name VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS public.books_authors(
    id serial PRIMARY KEY,
    book_id BIGINT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books (book_id) ON DELETE SET null,
    FOREIGN KEY (author_id) REFERENCES authors (author_id) ON DELETE SET null 
);
CREATE TABLE IF NOT EXISTS public.damage(
    damage_id serial PRIMARY KEY,
    ticket_number BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    type_of_damage VARCHAR(50) NOT NULL,
    cost_of_damage DECIMAL(10,2) NOT NULL,
    date_of_damage DATE CHECK (date_of_damage > '1900-01-01'),
    date_of_damage_compensation DATE,
    FOREIGN KEY (ticket_number) REFERENCES readers(ticket_number) ON DELETE SET null,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE SET null
);
INSERT INTO public.readers 
    (last_name, firts_name, middle_name, address, phone_number, e_mail, date_of_issue, stop_list, birthday) VALUES
    ('Иванов', 'Иван', 'Иванович', '111111 Иваново, Ивановская-15-25', '+7 916-123-45-67', 'Ivanov@mail.ru', '2022-01-01', '0', '1990-01-01'),
    ('Петров', 'Петр', 'Петрович', '111222 Иваново, Самарская-10-7', '+7 925-111-22-33', 'Petrov@mail.ru', '2022-01-01', '0', '2000-05-09'),
    ('Соколов', 'Иван', 'Иванович', '111112 Иваново, Ивановская-1-20', '+7 325-222-22-22', 'Sokolov@mail.ru', '2022-02-02', '0', '1999-03-08'),
    ('Голубев', 'Владимир', 'Владимирович', '111212 Владимирское, Владимирская-5-55', '+7 926-333-33-33', 'Golubev@mail.ru', '2022-02-02',  '0', '1982-02-14'),
    ('Скворцов', 'Виктор' , 'Викторович', '212121 Скворцово, Главная-20-1', '+7 815-111-11-11', 'Skvortsov@mail.ru', '2022-02-03',
 '0', '1999-07-07'),
    ('Прошкин', 'Прохор' , 'Прохорович', '212121 Скворцово, Окраинная-20-1', '+7 815-333-11-11', 'proshkin@mail.ru', '2022-02-03',
 '0', '2003-07-07');

INSERT INTO public.publisher (name, city) VALUES 
    ('Качели', 'Санкт-Петербург'),
    ('Малыш', 'Москва');

INSERT INTO public.books (name, date_of_issue, sheets, price, number_of_instances, bookcase, shelf, publisher_id) VALUES
    ('Колобок', '2020-01-01', 10, 100.00, 3, 1, 1, 1),
    ('Колобок', '2020-01-01', 10, 100.00, 3, 1, 1, 1),
    ('Колобок', '2020-01-01', 10, 100.00, 3, 1, 1, 1),
    ('Теремок', '2017-01-01', 20, 200.00, 2, 2, 1, 1),
    ('Теремок', '2017-01-01', 20, 200.00, 2, 2, 1, 1),
    ('Малыш и Карлсон', '2022-01-01', 200, 1000.00, 2,2,2,1),
    ('Малыш и Карлсон', '2022-01-01', 200, 1000.00, 2,2,2,1),
    ('Чебурашка', '2015-01-01', 300, 800.00, 3,2,2,2),
    ('Чебурашка', '2015-01-01', 300, 800.00, 3,2,2,2),
    ('Чебурашка', '2015-01-01', 300, 800.00, 3,2,2,2),
    ('Простоквашино', '2019-01-01', 500, 1500.00, 2, 3, 3, 2),
    ('Простоквашино', '2019-01-01', 500, 1500.00, 2, 3, 3, 2),
    ('Сказки', '2022-01-01', 700, 1000.00, 3, 1, 2, 2),
    ('Сказки', '2022-01-01', 700, 1000.00, 3, 1, 2, 2),
    ('Сказки', '2022-01-01', 700, 1000.00, 3, 1, 2, 2),
    ('Европейские сказки', '2020-01-01', 1200, 1500.00, 4, 2, 1, 1),
    ('Европейские сказки', '2020-01-01', 1200, 1500.00, 4, 2, 1, 1),
    ('Европейские сказки', '2020-01-01', 1200, 1500.00, 4, 2, 1, 1),
    ('Европейские сказки', '2020-01-01', 1200, 1500.00, 4, 2, 1, 1);

INSERT INTO public.staff (last_name, first_name, middle_name, position, address, phone_number, e_mail, current_employee_status) VALUES
    ('Чеснокова', 'Нина', 'Петровна', 'младший специалист', '111111 Иваноно, Ивановская, 5-11', '+7 325-111-11-11', 'chesnokova@mail.ru', '1'),
    ('Лаврова', 'Елизавета', 'Петровна', 'старший специалист', '111111 Иваново, Нижегородская, 2-33', '+7 915- 111-22-22', 'lavrova@yandex.ru', '1');

INSERT INTO public.rent (book_id, ticket_number, date_of_issue, return_date, actual_return_date, staff_id) VALUES
    (1, 1, '2022-01-01', '2022-01-15', '2022-01-10', 1),
    (2, 3, '2022-05-10', '2022-05-24', '2022-05-15', 1); 
INSERT INTO public.rent (book_id, ticket_number, date_of_issue, return_date, staff_id) VALUES
    (19, 6, '2022-05-10', '2022-05-24', 1);
INSERT INTO public.rent (book_id, ticket_number, date_of_issue, return_date, actual_return_date, staff_id) VALUES
    (1, 1, '2022-05-10', '2022-05-24', '2022-06-10', 1),
    (3, 4, '2022-05-11', '2022-05-26', '2022-05-11', 1),
    (4, 5, '2022-06-01', '2022-06-15', '2022-06-10', 2),
    (5, 1, '2022-07-01', '2022-07-15', '2022-07-13', 2),
    (6, 2, '2022-08-01', '2022-08-15', '2022-08-10', 1),
    (7, 3, '2022-09-01', '2022-09-15', '2022-09-11', 2),
    (8, 4, '2022-10-01', '2022-10-15', '2022-10-12', 1),
    (9, 5, '2022-11-01', '2022-11-15', '2022-11-09', 2),
    (10, 1, '2022-12-01', '2022-12-15', '2022-12-07', 1),
    (11, 3, '2023-01-01', '2023-01-15', '2023-01-11', 2),
    (12, 4, '2023-02-01', '2023-02-15', '2023-02-10', 1),
    (13, 5, '2023-03-01', '2023-03-15', '2023-03-07', 2),
    (14, 1, '2023-04-01', '2023-04-15', '2023-04-16', 1),
    (15, 3, '2023-05-01', '2023-05-15', '2023-05-20', 2);

INSERT INTO public.rent (book_id, ticket_number, date_of_issue, return_date, staff_id) VALUES
    (16, 2, '2023-06-01', '2023-06-15', 1),
    (17, 4, '2023-06-10', '2023-06-25', 2),
    (18, 5, '2023-06-10', '2023-06-25', 1);

INSERT INTO public.authors (last_name, first_name, middle_name) VALUES
    ('Толстой', 'Алексей', 'Николаевич'),
    ('Успенский', 'Эдуард', 'Николаевич'),
    ('Афанасьев', 'Александр', 'Николаевич'),
    ('Андерсен', 'Ганс', 'Кристиан');

INSERT INTO public.authors (last_name, first_name) VALUES
    ('Линдгрен', 'Астрид'),
    ('Перро', 'Шарль'),
    ('Гримм', 'Вильгельм'),
    ('Гримм', 'Якоб');

INSERT INTO public.books_authors (book_id, author_id) VALUES
   (1, 1),
   (2, 1),
   (3, 1),
   (4, 1),
   (5, 1),
   (6, 5),
   (7, 5),
   (8, 2),
   (9, 2),
   (10, 2),
   (11, 2),
   (12, 2),
   (13, 3),
   (14, 3),
   (15, 3),
   (16, 4),
   (16, 6),
   (16, 7),
   (16, 8),
   (17, 4),
   (17, 6),
   (17, 7),
   (17, 8),
   (18, 4),
   (18, 6),
   (18, 7),
   (18, 8),
   (19, 4),
   (19, 6),
   (19, 7),
   (19, 8);


