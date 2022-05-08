CREATE TYPE IF NOT EXIST MajorList AS ENUM ('Computer Science', 'Mathematics', 'Electrical Engineering'); 
CREATE TABLE IF NOT EXIST Student(
	email varchar(40) PRIMARY KEY,
	Name varchar(100) NOT NULL,
	username varchar(30) UNIQUE NOT NULL,
	password varchar(30) NOT NULL,
	Major majorlist NOT NULL
	);
CREATE TABLE IF NOT EXIST CourseList(
	Abbreviation varchar(30) PRIMARY KEY ON UPDATE CASCADE,
	);
CREATE TABLE IF NOT EXIST CourseTook(
	email varchar(100) REFERENCES Student.email,
	Taken varchar(100) REFERENCES CourseList.Abbreviation
	);

insert into Student (email, name, major, username, password) values ('zidane@g.ucla.edu', 'Zidane Tribal','Computer Science','zidane','123456' );
insert into Student (email, name, major, username, password) values ('garnet@garnet@g.ucla.edu', 'Garnet Til Alexandros XVII', 'Garnet','123456');
insert into Student (email, name, major, username, password) values ('steiner@g.ucla.edu', 'Adelbert Steiner','Adelbert', '123456');
insert into Student (email, name, major, username, password) values ('freya@g.ucla.edu', 'Freya Crescent','Freya','123456');
insert into Student (email, name, major, username, password) values ('armarant@g.ucla.edu', 'Amarant Coral','armarant', '123456');

insert into CourseList (Abbreviation) values ('MATH 1');
insert into CourseList (Abbreviation) values ('MATH 31A');
insert into CourseList (Abbreviation) values ('MATH 31B');
insert into CourseList (Abbreviation) values ('MATH 32A');
insert into CourseList (Abbreviation) values ('MATH 32B');
insert into CourseList (Abbreviation) values ('MATH 33A');
insert into CourseList (Abbreviation) values ('MATH 33B');
insert into CourseList (Abbreviation) values ('MATH 61');
insert into CourseList (Abbreviation) values ('MATH 95');
insert into CourseList (Abbreviation) values ('MATH 106');
insert into CourseList (Abbreviation) values ('MATH 110A');
insert into CourseList (Abbreviation) values ('MATH 110B');
insert into CourseList (Abbreviation) values ('COM SCI 1');
insert into CourseList (Abbreviation) values ('COM SCI 30');
insert into CourseList (Abbreviation) values ('COM SCI 31');
insert into CourseList (Abbreviation) values ('COM SCI 32');
insert into CourseList (Abbreviation) values ('COM SCI 33');
insert into CourseList (Abbreviation) values ('COM SCI 35L');
insert into CourseList (Abbreviation) values ('COM SCI M51A');
insert into CourseList (Abbreviation) values ('COM SCI 97');
insert into CourseList (Abbreviation) values ('COM SCI 111');
insert into CourseList (Abbreviation) values ('COM SCI 118');
insert into CourseList (Abbreviation) values ('COM SCI M119');
insert into CourseList (Abbreviation) values ('COM SCI CM124');
insert into CourseList (Abbreviation) values ('COM SCI 130');
insert into CourseList (Abbreviation) values ('COM SCI 131');
insert into CourseList (Abbreviation) values ('COM SCI 132');
insert into CourseList (Abbreviation) values ('COM SCI 143');
insert into CourseList (Abbreviation) values ('COM SCI 145');
insert into CourseList (Abbreviation) values ('COM SCI M146');
insert into CourseList (Abbreviation) values ('COM SCI M148');
insert into CourseList (Abbreviation) values ('COM SCI M151B');
insert into CourseList (Abbreviation) values ('COM SCI M152A');
insert into CourseList (Abbreviation) values ('COM SCI 152B');
insert into CourseList (Abbreviation) values ('COM SCI 161');
insert into CourseList (Abbreviation) values ('COM SCI 174A'); 
insert into CourseList (Abbreviation) values ('EC ENGR 1');
insert into CourseList (Abbreviation) values ('EC ENGR 2');
insert into CourseList (Abbreviation) values ('EC ENGR 3');
insert into CourseList (Abbreviation) values ('EC ENGR 10');
insert into CourseList (Abbreviation) values ('EC ENGR 10H');
insert into CourseList (Abbreviation) values ('EC ENGR 11L');
insert into CourseList (Abbreviation) values ('EC ENGR M16');
insert into CourseList (Abbreviation) values ('EC ENGR 100');
insert into CourseList (Abbreviation) values ('EC ENGR 101A');
insert into CourseList (Abbreviation) values ('EC ENGR 102');
insert into CourseList (Abbreviation) values ('EC ENGR 110L');
insert into CourseList (Abbreviation) values ('EC ENGR 112');
insert into CourseList (Abbreviation) values ('EC ENGR 113');
insert into CourseList (Abbreviation) values ('EC ENGR 113DA');

insert into CourseTook (email, course) values ('zidane@g.ucla.edu','COM SCI M148');
insert into CourseTook (email, course) values ('zidane@g.ucla.edu','COM SCI 152B');
insert into CourseTook (email, course) values ('zidane@g.ucla.edu','COM SCI 131');
insert into CourseTook (email, course) values ('zidane@g.ucla.edu','COM SCI 17A');
insert into CourseTook (email, course) values ('zidane@g.ucla.edu','EC ENGR 10H');
insert into CourseTook (email, course) values ('zidane@g.ucla.edu','MATH 110A');
insert into CourseTook (email, course) values ('garnet@garnet@g.ucla.edu','MATH 110A' );
insert into CourseTook (email, course) values ('garnet@garnet@g.ucla.edu','EC ENGR 100' );
insert into CourseTook (email, course) values ('garnet@garnet@g.ucla.edu', 'COM SCI 161');
insert into CourseTook (email, course) values ('garnet@garnet@g.ucla.edu', 'COM SCI 143');
insert into CourseTook (email, course) values ('garnet@garnet@g.ucla.edu', 'COM SCI 131');
insert into CourseTook (email, course) values ('garnet@garnet@g.ucla.edu', 'COM SCI CM124');
insert into CourseTook (email, course) values ('freya@g.ucla.edu', 'MATH 110A');
insert into CourseTook (email, course) values ('freya@g.ucla.edu', 'COM SCI 131');
insert into CourseTook (email, course) values ('freya@g.ucla.edu','COM SCI 143');
insert into CourseTook (email, course) values ('freya@g.ucla.edu','EC ENGR 3');
insert into CourseTook (email, course) values ('freya@g.ucla.edu', 'COM SCI M151B');
insert into CourseTook (email, course) values ('freya@g.ucla.edu', 'COM SCI 174A');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu','MATH 110A');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu','MATH 110B');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu','COM SCI M119');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu','EC ENGR 100');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu','COM SCI 131');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu','COM SCI M148');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu', 'EC ENGR 113DA');
insert into CourseTook (email, course) values ('garnet@garnet@g.ucla.edu', 'COM SCI 132');
insert into CourseTook (email, course) values ('zidane@g.ucla.edu','MATH 95');
insert into CourseTook (email, course) values ('freya@g.ucla.edu', 'MATH 110B');
insert into CourseTook (email, course) values ('freya@g.ucla.edu', 'COM SCI M152A');
insert into CourseTook (email, course) values ('armarant@g.ucla.edu', 'COM SCI 97');