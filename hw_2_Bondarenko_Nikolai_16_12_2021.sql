drop database if exists vk;
create database vk;
use vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(100),
    lastname VARCHAR(100) COMMENT 'Фамилия', -- COMMENT на случай, если имя неочевидное
    email VARCHAR(100) UNIQUE,
    password_hash varchar(100),
    phone BIGINT,
    is_deleted bit default 0,
    -- INDEX users_phone_idx(phone), -- помним: как выбирать индексы
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

/* взял для выполнения задания базу vk, на ее основе
 *  необходимо создать 3 новых таблицы
 */

drop table if exists music;
create table music (
    id serial primary key,
    title_of_sound varchar(100),
    singer varchar(100),
    user_id bigint unsigned not null,
    foreign key (user_id) references users(id) on update cascade on delete cascade
    );
/* создал таблицу музыка, связь один к одному*/ 

drop table if exists gift;
create table gift (
    id serial primary key,
    title_of_gift varchar(100),
    user_id_gifter bigint unsigned not null,
    user_id_recipient bigint unsigned not null,
    foreign key (user_id_gifter) references users(id) on update cascade on delete cascade,
    foreign key (user_id_recipient) references users(id) on update cascade on delete cascade
    );
   
/* создал таблицу подарки, связь многие к одному  */

/*создаю связь многие ко многим на основе таблицы истории (истории могут включать в себя песни и видео)
 * для этого создаю дополнительную таблицу видео*/
drop table if exists movie;
create table movie (
    id serial primary key,
    title_of_movie varchar(100),
    movie_maker_id bigint unsigned not null,
    foreign key (movie_maker_id) references users(id) on update cascade on delete cascade
    );
   
drop table if exists stories;
create table stories (
    id serial primary key,
    id_music bigint unsigned not null,
    id_movie bigint unsigned not null,
    created datetime default now(),
    foreign key (id_music) references music(id) on update cascade on delete cascade,
    foreign key (id_movie) references movie(id) on update cascade on delete cascade
    );

   
