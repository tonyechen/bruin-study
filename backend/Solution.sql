CREATE TYPE IF NOT EXIST MajorList AS ENUM ('Computer Science', 'Mathematics', 'Electrical Engineering'); 
CREATE TABLE IF NOT Exist Student(
	email varchar(40) PRIMARY KEY,
	Name varchar(100) NOT NULL,
	username varchar(30) UNIQUE NOT NULL,
	password varchar(30) NOT NULL,
	Major majorlist NOT NULL
	);
CREATE TABLE IF NOT EXIST CourseList(
	Abbreviation varchar(30) PRIMARY KEY ON UPDATE CASCADE,
	Name varchar (100) UNIQUE NOT NULL
	);
CREATE TABLE IF NOT EXIST CourseTook(
	email varchar(100) REFERENCES Student.email,
	Taken varchar(100) REFERENCES CourseList.Abbreviation
	);