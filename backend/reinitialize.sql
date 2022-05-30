/**
This code is used to delete previous instance in order to initalize a new instance on DATABASE
**/

DROP TYPE IF EXISTS MajorList CASCADE;
DROP TABLE IF EXISTS CourseList CASCADE;
DROP TABLE IF EXISTS Student CASCADE;
DROP TABLE IF EXISTS Took CASCADE;
DROP TABLE IF EXISTS Taking CASCADE;
DROP TABLE IF EXISTS FAILED CASCADE;
DROP TABLE IF EXISTS Introduction CASCADE;
DROP TABLE IF EXISTS potentialMatches CASCADE;
DROP TABLE IF EXISTS successfulMatches CASCADE;

-- database schema / create database
CREATE TYPE MajorList AS ENUM (
'African American Studies',
'American Indian Studies',
'Anthropology',
'Architectural Studies',
'Art',
'Art History',
'Asian American Studies',
'Asian Humanities',
'Asian Languages and Linguistics',
'Asian Religions',
'Chinese',
'Japanese',
'Korean',
'Southeast Asian Studies',
'Atmospheric and Oceanic Sciences',
'Atmospheric and Oceanic Sciences/Mathematics',
'Atmospheric, Oceanic, and Environmental Sciences ',
'Climate Science',
'Bioengineering',
'Chemical Engineering',
'Biochemistry',
'Chemistry',
'Chemistry/Materials Science',
'General Chemistry',
'Chicana and Chicano Studies',
'Civil Engineering',
'Classical Civilization',
'Greek',
'Greek and Latin',
'Latin',
'Communication',
'Communication Studies',
'Comparative Literature',
'Computational and Systems Biology',
'Pre-Computational and Systems Biology',
'Computer Science and Engineering',
'Computer Science',
'Design | Media Arts',
'Earth and Environmental Science',
'Engineering Geology',
'Geology',
'Geophysics',
'Biology',
'Ecology, Behavior, and Evolution',
'Marine Biology',
'Business Economics',
'Economics',
'Pre-Business Economics',
'Pre-Economics',
'Pre-Education and Social Transformation',
'Education and Social Transformation',
'Computer Engineering',
'Electrical Engineering',
'Undeclared-Engineering and Applied Science',
'American Literature and Culture',
'English',
'Environmental Science',
'Ethnomusicology',
'European Languages and Transcultural Studies',
'European Languages and Transcultural Studies with French',
'European Languages and Transcultural Studies with German',
'European Languages and Transcultural Studies with Italian',
'European Languages and Transcultural Studies with Scandinavian',
'Nordic Studies',
'Film and Television',
'French and Linguistics ',
'French ',
'Gender Studies',
'Geography',
'Geography/Environmental Studies',
'German ',
'Glol Jazz Studies',
'Glol Studies',
'Pre-Glol Studies',
'History',
'Pre-History',
'Undeclared-Humanities',
'Physiological Science',
'African and Middle Eastern Studies',
'Asian Studies',
'European Studies',
'Latin American Studies',
'Pre-African and Middle Eastern Studies',
'Pre-Asian Studies',
'Pre-European Studies',
'Pre-Latin American Studies',
'International Development Studies',
'Pre-International Development Studies',
'Italian and Special Fields ',
'Italian ',
'Labor Studies',
'Undeclared',
'Undeclared-Life Science',
'Applied Linguistics',
'Linguistics and Anthropology',
'Linguistics and Asian Languages and Cultures',
'Linguistics and Computer Science',
'Linguistics and English',
'Linguistics and French',
'Linguistics and Italian',
'Linguistics and Philosophy',
'Linguistics and Psychology',
'Linguistics and Scandinavian Languages',
'Linguistics and Spanish',
'Linguistics',
'Materials Engineering',
'Applied Mathematics',
'Financial Actuarial Mathematics',
'Mathematics',
'Mathematics For Teaching',
'Mathematics of Computation',
'Mathematics/Applied Science',
'Pre-Applied Mathematics',
'Pre-Financial Actuarial Mathematics',
'Pre-Mathematics',
'Pre-Mathematics For Teaching',
'Pre-Mathematics of Computation',
'Pre-Mathematics/Applied Science',
'Mathematics/Atmospheric and Oceanic Sciences ',
'Mathematics/Economics',
'Pre-Mathematics/Economics',
'Aerospace Engineering',
'Mechanical Engineering',
'Microbiology, Immunology, and Molecular Genetics',
'Pre-Microbiology, Immunology, and Molecular Genetics',
'Molecular, Cell, and Developmental Biology',
'Music',
'Music Composition',
'Music Education',
'Music Performance',
'Music History',
'Music History and Industry',
'Musicology',
'Ancient Near East and Egyptology',
'Arabic',
'Iranian Studies',
'Jewish Studies',
'Middle Eastern Studies',
'Neuroscience',
'Nursing',
'Nursing-Prelicensure',
'Philosophy',
'Undeclared-Physical Science',
'Astrophysics',
'Biophysics',
'Physics',
'Political Science',
'Pre-Political Science',
'Cognitive Science',
'Pre-Cognitive Science',
'Pre-Psychology',
'Psychobiology',
'Psychology',
'Pre-Public Affairs',
'Public Affairs',
'Study of Religion',
'Nordic Studies ',
'Scandinavian Languages and Cultures ',
'Central and East European Languages and Cultures',
'Russian Language and Literature',
'Russian Studies',
'Undeclared-Social Science',
'Human Biology and Society',
'Pre-Human Biology and Society',
'Pre-Sociology',
'Sociology',
'Portuguese ',
'Portuguese and Brazilian Studies',
'Spanish and Community and Culture',
'Spanish and Linguistics',
'Spanish and Portuguese',
'Spanish',
'Data Theory',
'Pre-Data Theory',
'Pre-Statistics',
'Statistics',
'Theater',
'Individual Field of Concentration',
'Dance',
'World Arts and Cultures'
);
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
CREATE TABLE IF NOT EXISTS successfulMatches(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE
	);
CREATE TABLE IF NOT EXISTS FAILED(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	PRIMARY KEY (id1, id2)
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
insert into Student (id,email, name, major, username, password) values (666666666,'eiko@g.ucla.edu', 'Eiko Carol','Anthropology','Eiko', '654321');
insert into Student (id,email, name, major, username, password) values (777777777,'quina@g.ucla.edu', 'Quina Quen','History','Quina', '8765421');
insert into Student (id,email, name, major, username, password) values (888888888,'beatrix@g.ucla.edu', 'Beatrix','Biology','Beatrix', 'GodSaveTheQueen');
insert into Student (id,email, name, major, username, password) values (999999999,'barhne@g.ucla.edu', 'Brahne Raza Alexandros XVI','African American Studies','Barhne', '139496849');

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
insert into Took (id, course) values (777777777, 'HIST 1A');
insert into Took (id, course) values (777777777, 'HIST 13B');
insert into Took (id, course) values (777777777, 'HIST 130');
insert into Took (id, course) values (777777777, 'HIST 161');
insert into Took (id, course) values (777777777, 'HIST 19');
insert into Took (id, course) values (777777777, 'HIST 146B');
insert into Took (id, course) values (888888888, 'MATH 1');
insert into Took (id, course) values (888888888, 'ANTHRO 4');
insert into Took (id, course) values (888888888, 'ANTHRO 1');

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
insert into Taking (id, course) values (666666666, 'ANTHRO 1');
insert into Taking (id, course) values (666666666, 'ANTHRO 3');
insert into Taking (id, course) values (666666666, 'SOCIOL 1');
insert into Taking (id, course) values (666666666, 'HIST 1A');
insert into Taking (id, course) values (888888888, 'MATH 31A');
insert into Taking (id, course) values (888888888, 'MATH 31AL');
insert into Taking (id, course) values (888888888, 'ANTHRO 3');
insert into Taking (id, course) values (999999999, 'AF AMER 1');
insert into Taking (id, course) values (999999999, 'PSYCH 10');
insert into Taking (id, course) values (999999999, 'PSYCH 15');

insert into FAILED (id1, id2) values (555555555, 111111111);
insert into FAILED (id1, id2) values (555555555,444444444);
insert into FAILED (id1, id2) values (555555555,222222222);

insert into successfulMatches (id1, id2) values (111111111,444444444);
insert into successfulMatches (id1, id2) values (888888888,333333333);

insert into Introduction (id, Intro) values (111111111,'Zidane Tribal is the main protagonist of Final Fantasy IX. He is a thief who works for the Tantalus Theater Troupe set to kidnap the princess of Alexandria, an event that escalates to a quest to protect the planet of Gaia.');
insert into Introduction (id, Intro) values (222222222,'Garnet Til Alexandros XVII, alias Dagger and birth name Sarah, is the deuteragonist of Final Fantasy IX, and the heir of Alexandria in the 17th generation. Garnet notices a change in her mother, Queen Brahne, and seeks to escape Alexandria Castle.');
insert into Introduction (id, Intro) values (333333333,'Captain Adelbert Steiner is a playable character in Final Fantasy IX. He leads the Knights of Pluto and is assigned to protect Princess Garnet.');
insert into Introduction (id, Intro) values (444444444, NULL);
insert into Introduction (id, Intro) values (555555555, 'Amarant Coral (known as Salamander Coral in the Japanese version) is a playable character from Final Fantasy IX. He is introduced to the player as Red-headed Man');
insert into Introduction (id, Intro) values (666666666, 'Eiko Carol, known as Little Girl for the short period before a name is selected, is a playable character in Final Fantasy IX. She hails from Madain Sari on the Outer Continent. She has a horn on her forehead and can summon eidolons.');
insert into Introduction (id, Intro) values (777777777, 'Quina Quen is a playable character in Final Fantasy IX. S/he is apparently a genderless Qu who specializes in blue magic, and loves eating frogs. Quina serves as comic relief, often failing in their eternal quest to consume new cuisine. They speak in broken English, as all Qu do, and will often eat anything they see. Quina"s eating habits are one of their greatest skills, as Quina learns Blu Mag by consuming an enemy.');
insert into Introduction (id, Intro) values (888888888, 'Beatrix is a temporary player character and boss in Final Fantasy IX. She is the top general and most trusted warrior of the all-female army of Alexandria.');
insert into Introduction (id, Intro) values (999999999, 'Brahne Raza Alexandros XVI is Alexandria"s ruler and mother of Princess Garnet in Final Fantasy IX. Though she ends up causing much death and destruction, Garnet testifies she had once been a kind and well-liked monarch and not the power-hungry villain she became after her husband passed away and the mysterious Kuja started to show his face within Alexandria Castle.');

insert into potentialMatches (id1,id2) values (111111111,222222222);
insert into potentialMatches (id1,id2) values (555555555,111111111);
insert into potentialMatches (id1,id2) values (666666666,111111111);