-- database schema
CREATE TYPE MajorList AS ENUM ('Mathematics','Computer Science','Electrical Engineering','Physics','Mechanical Engineering');
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
CREATE TABLE IF NOT EXISTS potentialMatches(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE
	);
CREATE TABLE IF NOT EXISTS Ignore(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	PRIMARY KEY (id1, id2)
	);
CREATE TABLE IF NOT EXISTS Introduction(
	id  numeric(9,0) REFERENCES Student(id) PRIMARY KEY,
	Intro text
);
