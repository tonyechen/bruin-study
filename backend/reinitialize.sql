/**
This code is used to delete previous instance in order to initalize a new instance on DATABASE
**/

DROP TYPE IF EXISTS MajorList CASCADE;
DROP TABLE IF EXISTS CourseList CASCADE;
DROP TABLE IF EXISTS Student CASCADE;
DROP TABLE IF EXISTS Took CASCADE;
DROP TABLE IF EXISTS Taking CASCADE;
DROP TABLE IF EXISTS FAILED CASCADE;
DROP TABLE IF EXISTS Messages CASCADE;
DROP TABLE IF EXISTS Introduction CASCADE;
DROP TABLE IF EXISTS Matches CASCADE;

-- database schema / create database
CREATE TYPE MajorList AS ENUM ('Mathematics','Computer Science','Electrical Engineering','Physics','Mechanical Engineering', '');
CREATE TABLE IF NOT EXISTS Student(
	id numeric(9,0) PRIMARY KEY,
	email varchar(40) UNIQUE NOT NULL,
	Name varchar(100) NOT NULL,
	major MajorList,
	username varchar(30) UNIQUE NOT NULL,
	password varchar(30) NOT NULL
	);
CREATE TABLE IF NOT EXISTS CourseList(
	Abbreviation varchar(30) PRIMARY KEY
	);
CREATE TABLE IF NOT EXISTS Took(
	id numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	course varchar(100) REFERENCES CourseList(Abbreviation) ON UPDATE CASCADE,
	PRIMARY KEY(id, course)
	);
CREATE TABLE IF NOT EXISTS Taking(
	id numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	course varchar(100) REFERENCES CourseList(Abbreviation) ON UPDATE CASCADE,
	PRIMARY KEY(id, course)
);
CREATE TABLE IF NOT EXISTS FAILED(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	PRIMARY KEY (id1, id2)
	);
CREATE TABLE IF NOT EXISTS Matches(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE
	);
CREATE TABLE IF NOT EXISTS Messages(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	content text,
	stamp timestamptz,
	PRIMARY KEY (id1,id2,stamp)
	);
CREATE TABLE IF NOT EXISTS Introduction(
	id  numeric(9,0) REFERENCES Student(id) PRIMARY KEY,
	Intro text
	);


-- sample data
insert into Student (id,email, name, major, username, password) values (111111111,'zidane@g.ucla.edu', 'Zidane Tribal','Computer Science','zidane','123456' );
insert into Student (id,email, name, major, username, password) values (222222222,'garnet@g.ucla.edu', 'Garnet Til Alexandros XVII', 'Mathematics', 'Garnet','123456');
insert into Student (id,email, name, major, username, password) values (333333333,'steiner@g.ucla.edu', 'Adelbert Steiner','Mechanical Engineering','Adelbert', '123456');
insert into Student (id,email, name, major, username, password) values (444444444,'freya@g.ucla.edu', 'Freya Crescent','Computer Science','Freya','123456');
insert into Student (id,email, name, major, username, password) values (555555555,'armarant@g.ucla.edu', 'Amarant Coral',NULL,'armarant', '123456');

\copy CourseList FROM 'ucla-course-list.txt';

insert into Took (id, course) values (111111111,'COM SCI M148');
insert into Took (id, course) values (111111111,'COM SCI 152B');
insert into Took (id, course) values (111111111,'COM SCI 131');
insert into Took (id, course) values (111111111,'COM SCI 174A');
insert into Took (id, course) values (111111111,'EC ENGR 10H');
insert into Took (id, course) values (111111111,'MATH 110A');
insert into Took (id, course) values (222222222,'MATH 110A' );
insert into Took (id, course) values (222222222,'EC ENGR 100' );
insert into Took (id, course) values (222222222, 'COM SCI 161');
insert into Took (id, course) values (222222222, 'COM SCI 143');
insert into Took (id, course) values (222222222, 'COM SCI 131');
insert into Took (id, course) values (222222222, 'COM SCI CM124');
insert into Took (id, course) values (444444444, 'MATH 110A');
insert into Took (id, course) values (444444444, 'COM SCI 131');
insert into Took (id, course) values (444444444,'COM SCI 143');
insert into Took (id, course) values (444444444,'EC ENGR 3');
insert into Took (id, course) values (444444444, 'COM SCI M151B');
insert into Took (id, course) values (444444444, 'COM SCI 174A');
insert into Took (id, course) values (555555555,'MATH 110A');
insert into Took (id, course) values (555555555,'MATH 110B');
insert into Took (id, course) values (555555555,'COM SCI M119');
insert into Took (id, course) values (555555555,'EC ENGR 100');
insert into Took (id, course) values (555555555,'COM SCI 131');
insert into Took (id, course) values (555555555,'COM SCI M148');
insert into Took (id, course) values (555555555, 'EC ENGR 113DA');
insert into Took (id, course) values (222222222, 'COM SCI 132');
insert into Took (id, course) values (111111111,'MATH 95');
insert into Took (id, course) values (444444444, 'MATH 110B');
insert into Took (id, course) values (444444444, 'COM SCI M152A');
insert into Took (id, course) values (555555555, 'COM SCI 97');

insert into Taking (id, course) values (111111111,'COM SCI M148');
insert into Taking (id, course) values (111111111,'COM SCI 152B');
insert into Taking (id, course) values (111111111,'COM SCI 131');
insert into Taking (id, course) values (111111111,'COM SCI 174A');
insert into Taking (id, course) values (111111111,'EC ENGR 10H');
insert into Taking (id, course) values (111111111,'MATH 110A');
insert into Taking (id, course) values (222222222,'MATH 110A' );
insert into Taking (id, course) values (222222222,'EC ENGR 100' );
insert into Taking (id, course) values (222222222, 'COM SCI 161');
insert into Taking (id, course) values (222222222, 'COM SCI 143');
insert into Taking (id, course) values (222222222, 'COM SCI 131');
insert into Taking (id, course) values (222222222, 'COM SCI CM124');
insert into Taking (id, course) values (444444444, 'MATH 110A');
insert into Taking (id, course) values (444444444, 'COM SCI 131');
insert into Taking (id, course) values (444444444,'COM SCI 143');
insert into Taking (id, course) values (444444444,'EC ENGR 3');
insert into Taking (id, course) values (444444444, 'COM SCI M151B');
insert into Taking (id, course) values (444444444, 'COM SCI 174A');
insert into Taking (id, course) values (555555555,'MATH 110A');
insert into Taking (id, course) values (555555555,'MATH 110B');
insert into Taking (id, course) values (555555555,'COM SCI M119');
insert into Taking (id, course) values (555555555,'EC ENGR 100');
insert into Taking (id, course) values (555555555,'COM SCI 131');
insert into Taking (id, course) values (555555555,'COM SCI M148');
insert into Taking (id, course) values (555555555, 'EC ENGR 113DA');
insert into Taking (id, course) values (222222222, 'COM SCI 132');
insert into Taking (id, course) values (111111111,'MATH 95');
insert into Taking (id, course) values (444444444, 'MATH 110B');
insert into Taking (id, course) values (444444444, 'COM SCI M152A');
insert into Taking (id, course) values (555555555, 'COM SCI 97');

insert into Failed (id1, id2) values (555555555, 111111111);
insert into Failed (id1, id2) values (111111111,444444444);
insert into Failed (id1, id2) values (555555555,444444444);
insert into Failed (id1, id2) values (555555555,222222222);

insert into Introduction (id, Intro) values (111111111,'Zidane Tribal is the main protagonist of Final Fantasy IX. He is a thief who works for the Tantalus Theater Troupe set to kidnap the princess of Alexandria, an event that escalates to a quest to protect the planet of Gaia.');
insert into Introduction (id, Intro) values (222222222,'Garnet Til Alexandros XVII, alias Dagger and birth name Sarah, is the deuteragonist of Final Fantasy IX, and the heir of Alexandria in the 17th generation. Garnet notices a change in her mother, Queen Brahne, and seeks to escape Alexandria Castle.');
insert into Introduction (id, Intro) values (333333333,'Captain Adelbert Steiner is a playable character in Final Fantasy IX. He leads the Knights of Pluto and is assigned to protect Princess Garnet.');
insert into Introduction (id, Intro) values (444444444, NULL);
insert into Introduction (id, Intro) values (555555555, 'Amarant Coral (known as Salamander Coral in the Japanese version) is a playable character from Final Fantasy IX. He is introduced to the player as Red-headed Man');

insert into Matches (id1,id2) values (111111111,222222222);
insert into Matches (id1,id2) values (222222222,111111111);
insert into Matches (id1,id2) values (555555555,111111111);