-- \i /Projects/bruin-study/backend/database/database.sql
-- admin username : bruinstudy
-- admin password: bsforever2022!
CREATE TABLE IF NOT EXISTS students (
    uid varchar(9) NOT NULL PRIMARY KEY,
    email varchar(50) NOT NULL,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    password varchar NOT NULL,
    major varchar,
    oldcourses varchar[],
    currcourses varchar[],
    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS courseslist (
    courseabbrev varchar Primary Key
);

CREATE TABLE IF NOT EXISTS coursestaken (
    uid varchar(9) REFERENCES students(uid) NOT NULL,
    course varchar REFERENCES courseslist(courseabbrev) NOT NULL

);

CREATE TABLE IF NOT EXISTS coursestaking (
    uid varchar(9) REFERENCES students(uid) NOT NULL,
    course varchar REFERENCES courseslist(courseabbrev) NOT NULL
);

CREATE TABLE IF NOT EXISTS matches (
    uid varchar(9) NOT NULL PRIMARY KEY,
    matched_ids BIGINT[]
);

insert into students (uid, email, first_name, last_name, major, password, oldcourses, currcourses) values ('034437703', 'mchristoforou0@cargocollective.com', 'Michele', 'Christoforou', null, 'FZCMWO3G5', ARRAY ['CompSci 1', 'CompSci 2'] , null);
insert into students (uid, email, first_name, last_name, major, password, oldcourses, currcourses) values ('382032768', 'kstandbrooke1@nps.gov', 'Kristofer', 'Standbrooke', null, 'R62DAYCHD', null, null);
insert into students (uid, email, first_name, last_name, major, password, oldcourses, currcourses) values ('009884023', 'dstonuary2@google.com', 'Doralia', 'Stonuary', null, 'V6R5HD31O', null, null);
insert into students (uid, email, first_name, last_name, major, password, oldcourses, currcourses) values ('855676577', 'lgoulbourn3@techcrunch.com', 'Lennard', 'Goulbourn', null, 'CRJZC2PVE', null, null);
insert into students (uid, email, first_name, last_name, major, password, oldcourses, currcourses) values ('708017749', 'mvanyashkin4@theglobeandmail.com', 'Mirabelle', 'Vanyashkin', null, 'E17RYC8TT', null, null);

insert into courseslist (courseabbrev) values ('Marketing');
insert into courseslist (courseabbrev) values ('Product Management');
insert into courseslist (courseabbrev) values ('Product Management');
insert into courseslist (courseabbrev) values ('Engineering');
insert into courseslist (courseabbrev) values ('Accounting');
insert into courseslist (courseabbrev) values ('Business Development');
insert into courseslist (courseabbrev) values ('Product Management');
insert into courseslist (courseabbrev) values ('Engineering');
insert into courseslist (courseabbrev) values ('Marketing');
insert into courseslist (courseabbrev) values ('Business Development');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Engineering');
insert into courseslist (courseabbrev) values ('Sales');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Sales');
insert into courseslist (courseabbrev) values ('Research and Development');
insert into courseslist (courseabbrev) values ('Research and Development');
insert into courseslist (courseabbrev) values ('Services');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Services');
insert into courseslist (courseabbrev) values ('Product Management');
insert into courseslist (courseabbrev) values ('Engineering');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Training');
insert into courseslist (courseabbrev) values ('Human Resources');
insert into courseslist (courseabbrev) values ('Product Management');
insert into courseslist (courseabbrev) values ('Sales');
insert into courseslist (courseabbrev) values ('Business Development');
insert into courseslist (courseabbrev) values ('Business Development');
insert into courseslist (courseabbrev) values ('Accounting');
insert into courseslist (courseabbrev) values ('Business Development');
insert into courseslist (courseabbrev) values ('Sales');
insert into courseslist (courseabbrev) values ('Services');
insert into courseslist (courseabbrev) values ('Sales');
insert into courseslist (courseabbrev) values ('Sales');
insert into courseslist (courseabbrev) values ('Human Resources');
insert into courseslist (courseabbrev) values ('Human Resources');
insert into courseslist (courseabbrev) values ('Business Development');
insert into courseslist (courseabbrev) values ('Human Resources');
insert into courseslist (courseabbrev) values ('Research and Development');
insert into courseslist (courseabbrev) values ('Human Resources');
insert into courseslist (courseabbrev) values ('Legal');
insert into courseslist (courseabbrev) values ('Services');
insert into courseslist (courseabbrev) values ('Support');
insert into courseslist (courseabbrev) values ('Legal');
insert into courseslist (courseabbrev) values ('Sales');
insert into courseslist (courseabbrev) values ('Marketing');

insert into coursestaken (uid, course) values ('034437703', 'Product Management');
insert into coursestaken (uid, course) values ('034437703', 'Human Resources');
insert into coursestaken (uid, course) values ('034437703', 'Marketing');
insert into coursestaken (uid, course) values ('382032768', 'Research and Development');
insert into coursestaken (uid, course) values ('382032768', 'Business Development');
insert into coursestaken (uid, course) values ('382032768', 'Sales');
insert into coursestaken (uid, course) values ('009884023', 'Support');
insert into coursestaken (uid, course) values ('009884023', 'Legal');
insert into coursestaken (uid, course) values ('009884023', 'Services');
insert into coursestaken (uid, course) values ('855676577', 'Marketing');
insert into coursestaken (uid, course) values ('855676577', 'Support');
insert into coursestaken (uid, course) values ('855676577', 'Product Management');
insert into coursestaken (uid, course) values ('708017749', 'Training');
insert into coursestaken (uid, course) values ('708017749', 'Marketing');
insert into coursestaken (uid, course) values ('708017749', 'Product Management');

insert into coursestaking (uid, course) values ('034437703', 'Product Management');
insert into coursestaking (uid, course) values ('034437703', 'Human Resources');
insert into coursestaking (uid, course) values ('034437703', 'Marketing');
insert into coursestaking (uid, course) values ('382032768', 'Research and Development');
insert into coursestaking (uid, course) values ('382032768', 'Business Development');
insert into coursestaking (uid, course) values ('382032768', 'Sales');
insert into coursestaking (uid, course) values ('009884023', 'Support');
insert into coursestaking (uid, course) values ('009884023', 'Legal');
insert into coursestaking (uid, course) values ('009884023', 'Services');
insert into coursestaking (uid, course) values ('855676577', 'Marketing');
insert into coursestaking (uid, course) values ('855676577', 'Support');
insert into coursestaking (uid, course) values ('855676577', 'Product Management');
insert into coursestaking (uid, course) values ('708017749', 'Training');
insert into coursestaking (uid, course) values ('708017749', 'Marketing');
insert into coursestaking (uid, course) values ('708017749', 'Product Management');