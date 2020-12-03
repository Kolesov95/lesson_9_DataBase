-- Задание № 1.1

drop database if exists sample;
create database sample;


use sample;
create table users(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
birthday_at DATE,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

start transaction;
insert into sample.users (select * from shop1.users where id = 1);
commit;


-- Задание № 2
-- Создайте представление, которое выводит название name товарной позиции 
-- из таблицы products и соответствующее название каталога name из таблицы catalogs.

create or replace view name_catalog (name, `catalog`) as 
select 
p.name,
c.name
from 
products p
left join
catalogs c 
on p.id = c.id;

select * from name_catalog;


-- Задание № 3

-- Не понял, что от меня хотят в этом задании


-- Задание № 4
-- Воспользуюсь таблицей, которую создавал для предыдущего задания и добавлю несколько значений

insert into task values
('2020-11-01'),
('2019-01-04'),
('2023-05-17'),
('2000-04-17'),
('2025-12-16'),
('2026-11-17'),
('2030-11-17'),
('2040-11-17');

delete from task where created_at not in (select * from (select * from task order by created_at desc limit 5) as top5);

-- select * from task where created_at not in (select * from (select * from task order by created_at desc limit 5) as top5);
prepare old_delete from 'delete from task where created_at not in (select * from (select * from task order by created_at desc limit 5) as top5)';
execute old_delete;
select * from task;

-- Задание № 3.1

-- Не понимаю почему, но, когда ставлю 00:00:00 в elseif Добрый вечер, попадаю в ветку else, поставил 23:59

drop function if exists hello;
delimiter //
create function hello()
returns varchar(255) deterministic 
begin
	if (curtime() between '06:00:00' and '12:00:00') then 
		return 'Доброе утро';
	elseif (curtime() between '12:00:00' and '18:00:00') then 
		return 'Добрый день';
	elseif (curtime() between '18:00:00' and '23:59:59') then 
		return 'Добрый вечер';
	else return 'Доброй ночи';
	end if;
end  //
delimiter ;

select hello();

-- Задание № 3.2

drop trigger if exists name_description_null;
delimiter // 
create trigger name_description_null before insert on products
for each row 
begin 
	if (isnull(new.name) and isnull(new.descripton)) then
		signal sqlstate '45000' set message_text = 'Должны присутствовать или имя или описание';
	end if;
end //

delimiter ;

-- Задание № 3.3 

-- Не справился. Посмотрел как делать. Понял, но сам бы не догадался.
