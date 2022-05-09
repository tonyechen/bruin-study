/**
Test code to test our create table operation
DROP TYPE IF EXISTS MajorList CASCADE;
DROP TABLE IF EXISTS CourseList CASCADE;
DROP TABLE IF EXISTS Student CASCADE;
DROP TABLE IF EXISTS Took CASCADE;
DROP TABLE IF EXISTS Taking CASCADE;
DROP TABLE IF EXISTS FAILED CASCADE;
DROP TABLE IF EXISTS Messages CASCADE;
DROP TABLE IF EXISTS Introduction CASCADE;
**/
CREATE TYPE MajorList AS ENUM ('Computer Science', 'Mathematics', 'Electrical Engineering','Mechanical Engineering'); 
CREATE TABLE IF NOT EXISTS Student(
	email varchar(40) PRIMARY KEY,
	Name varchar(100) NOT NULL,
	username varchar(30) UNIQUE NOT NULL,
	password varchar(30) NOT NULL,
	major MajorList NOT NULL
	);
CREATE TABLE IF NOT EXISTS CourseList(
	Abbreviation varchar(30) PRIMARY KEY
	);
CREATE TABLE IF NOT EXISTS Took(
	email varchar(100) REFERENCES Student(email) ON UPDATE CASCADE,
	course varchar(100) REFERENCES CourseList(Abbreviation) ON UPDATE CASCADE,
	PRIMARY KEY(email, course)
	);
CREATE TABLE IF NOT EXISTS Taking(
	email varchar(100) REFERENCES Student(email) ON UPDATE CASCADE,
	course varchar(100) REFERENCES CourseList(Abbreviation) ON UPDATE CASCADE,
	PRIMARY KEY(email, course)
);
CREATE TABLE IF NOT EXISTS FAILED(
	email1 varchar(100) REFERENCES Student(email) ON UPDATE CASCADE,
	email2 varchar(100) REFERENCES Student(email) ON UPDATE CASCADE,
	PRIMARY KEY (email1, email2)
	);
CREATE TABLE IF NOT EXISTS Messages(
	email1 varchar(100) REFERENCES Student(email) ON UPDATE CASCADE,
	email2 varchar(100) REFERENCES Student(email) ON UPDATE CASCADE,
	content text,
	stamp timestamptz,
	PRIMARY KEY (email1,email2,stamp)
	);
CREATE TABLE IF NOT EXISTS Introduction(
	email varchar(100) REFERENCES Student(email) PRIMARY KEY,
	Introduction text
	);
/**
Sample data:
insert into Student (email, name, major, username, password) values ('zidane@g.ucla.edu', 'Zidane Tribal','Computer Science','zidane','123456' );
insert into Student (email, name, major, username, password) values ('garnet@g.ucla.edu', 'Garnet Til Alexandros XVII', 'Mathematics', 'Garnet','123456');
insert into Student (email, name, major, username, password) values ('steiner@g.ucla.edu', 'Adelbert Steiner','Mechanical Engineering','Adelbert', '123456');
insert into Student (email, name, major, username, password) values ('freya@g.ucla.edu', 'Freya Crescent','Computer Science','Freya','123456');
insert into Student (email, name, major, username, password) values ('armarant@g.ucla.edu', 'Amarant Coral','Mathematics','armarant', '123456');

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

insert into Took (email, course) values ('zidane@g.ucla.edu','COM SCI M148');
insert into Took (email, course) values ('zidane@g.ucla.edu','COM SCI 152B');
insert into Took (email, course) values ('zidane@g.ucla.edu','COM SCI 131');
insert into Took (email, course) values ('zidane@g.ucla.edu','COM SCI 174A');
insert into Took (email, course) values ('zidane@g.ucla.edu','EC ENGR 10H');
insert into Took (email, course) values ('zidane@g.ucla.edu','MATH 110A');
insert into Took (email, course) values ('garnet@g.ucla.edu','MATH 110A' );
insert into Took (email, course) values ('garnet@g.ucla.edu','EC ENGR 100' );
insert into Took (email, course) values ('garnet@g.ucla.edu', 'COM SCI 161');
insert into Took (email, course) values ('garnet@g.ucla.edu', 'COM SCI 143');
insert into Took (email, course) values ('garnet@g.ucla.edu', 'COM SCI 131');
insert into Took (email, course) values ('garnet@g.ucla.edu', 'COM SCI CM124');
insert into Took (email, course) values ('freya@g.ucla.edu', 'MATH 110A');
insert into Took (email, course) values ('freya@g.ucla.edu', 'COM SCI 131');
insert into Took (email, course) values ('freya@g.ucla.edu','COM SCI 143');
insert into Took (email, course) values ('freya@g.ucla.edu','EC ENGR 3');
insert into Took (email, course) values ('freya@g.ucla.edu', 'COM SCI M151B');
insert into Took (email, course) values ('freya@g.ucla.edu', 'COM SCI 174A');
insert into Took (email, course) values ('armarant@g.ucla.edu','MATH 110A');
insert into Took (email, course) values ('armarant@g.ucla.edu','MATH 110B');
insert into Took (email, course) values ('armarant@g.ucla.edu','COM SCI M119');
insert into Took (email, course) values ('armarant@g.ucla.edu','EC ENGR 100');
insert into Took (email, course) values ('armarant@g.ucla.edu','COM SCI 131');
insert into Took (email, course) values ('armarant@g.ucla.edu','COM SCI M148');
insert into Took (email, course) values ('armarant@g.ucla.edu', 'EC ENGR 113DA');
insert into Took (email, course) values ('garnet@g.ucla.edu', 'COM SCI 132');
insert into Took (email, course) values ('zidane@g.ucla.edu','MATH 95');
insert into Took (email, course) values ('freya@g.ucla.edu', 'MATH 110B');
insert into Took (email, course) values ('freya@g.ucla.edu', 'COM SCI M152A');
insert into Took (email, course) values ('armarant@g.ucla.edu', 'COM SCI 97');

insert into Failed (email1, email2) values ('armarant@g.ucla.edu', 'zidane@g.ucla.edu');
insert into Failed (email1, email2) values ('zidane@g.ucla.edu','freya@g.ucla.edu');
insert into Failed (email1, email2) values ('armarant@g.ucla.edu','freya@g.ucla.edu');
insert into Failed (email1, email2) values ('armarant@g.ucla.edu','garnet@g.ucla.edu');
**/