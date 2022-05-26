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
'Communication Studies ',
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
'World Arts and Cultures',
''
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
CREATE TABLE IF NOT EXISTS FAILED(
	id1 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	id2 numeric(9,0) REFERENCES Student(id) ON UPDATE CASCADE,
	PRIMARY KEY (id1, id2)
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

insert into CourseList (Abbreviation) values ('A&O SCI 1');
insert into CourseList (Abbreviation) values ('A&O SCI 104');
insert into CourseList (Abbreviation) values ('A&O SCI 145');
insert into CourseList (Abbreviation) values ('A&O SCI 188');
insert into CourseList (Abbreviation) values ('A&O SCI 1L');
insert into CourseList (Abbreviation) values ('A&O SCI 2');
insert into CourseList (Abbreviation) values ('A&O SCI 3');
insert into CourseList (Abbreviation) values ('A&O SCI 3L');
insert into CourseList (Abbreviation) values ('A&O SCI 90');
insert into CourseList (Abbreviation) values ('A&O SCI C110');
insert into CourseList (Abbreviation) values ('A&O SCI C170');
insert into CourseList (Abbreviation) values ('A&O SCI M105');
insert into CourseList (Abbreviation) values ('AERO ST A');
insert into CourseList (Abbreviation) values ('AF AMER 6');
insert into CourseList (Abbreviation) values ('AF AMER C191');
insert into CourseList (Abbreviation) values ('AF AMER M103A');
insert into CourseList (Abbreviation) values ('AF AMER M104B');
insert into CourseList (Abbreviation) values ('AF AMER M104E');
insert into CourseList (Abbreviation) values ('AF AMER M10A');
insert into CourseList (Abbreviation) values ('AF AMER M12A');
insert into CourseList (Abbreviation) values ('AF AMER M179A');
insert into CourseList (Abbreviation) values ('AF AMER M18');
insert into CourseList (Abbreviation) values ('AF AMER M7B');
insert into CourseList (Abbreviation) values ('AF AMER M9B');
insert into CourseList (Abbreviation) values ('AM IND M10');
insert into CourseList (Abbreviation) values ('AN N EA 12W');
insert into CourseList (Abbreviation) values ('AN N EA 14W');
insert into CourseList (Abbreviation) values ('AN N EA 15');
insert into CourseList (Abbreviation) values ('AN N EA 162');
insert into CourseList (Abbreviation) values ('AN N EA 175');
insert into CourseList (Abbreviation) values ('AN N EA M104A');
insert into CourseList (Abbreviation) values ('AN N EA M110B');
insert into CourseList (Abbreviation) values ('AN N EA M50B');
insert into CourseList (Abbreviation) values ('ANTHRO 1');
insert into CourseList (Abbreviation) values ('ANTHRO 100');
insert into CourseList (Abbreviation) values ('ANTHRO 111');
insert into CourseList (Abbreviation) values ('ANTHRO 113Q');
insert into CourseList (Abbreviation) values ('ANTHRO 119');
insert into CourseList (Abbreviation) values ('ANTHRO 126P');
insert into CourseList (Abbreviation) values ('ANTHRO 135');
insert into CourseList (Abbreviation) values ('ANTHRO 136B');
insert into CourseList (Abbreviation) values ('ANTHRO 140');
insert into CourseList (Abbreviation) values ('ANTHRO 141');
insert into CourseList (Abbreviation) values ('ANTHRO 149');
insert into CourseList (Abbreviation) values ('ANTHRO 152Q');
insert into CourseList (Abbreviation) values ('ANTHRO 154Q');
insert into CourseList (Abbreviation) values ('ANTHRO 155');
insert into CourseList (Abbreviation) values ('ANTHRO 163P');
insert into CourseList (Abbreviation) values ('ANTHRO 3');
insert into CourseList (Abbreviation) values ('ANTHRO 4');
insert into CourseList (Abbreviation) values ('ANTHRO M116R');
insert into CourseList (Abbreviation) values ('ANTHRO M128R');
insert into CourseList (Abbreviation) values ('ANTHRO M145P');
insert into CourseList (Abbreviation) values ('ANTHRO M148');
insert into CourseList (Abbreviation) values ('APPLING 40W');
insert into CourseList (Abbreviation) values ('ARABIC 103B');
insert into CourseList (Abbreviation) values ('ARABIC 181');
insert into CourseList (Abbreviation) values ('ARCH&UD 10A');
insert into CourseList (Abbreviation) values ('ARCH&UD 121');
insert into CourseList (Abbreviation) values ('ARCH&UD 132');
insert into CourseList (Abbreviation) values ('ARCH&UD 142');
insert into CourseList (Abbreviation) values ('ARCH&UD CM153');
insert into CourseList (Abbreviation) values ('ARMENIA 101B');
insert into CourseList (Abbreviation) values ('ARMENIA 102B');
insert into CourseList (Abbreviation) values ('ARMENIA 104B');
insert into CourseList (Abbreviation) values ('ARMENIA 105B');
insert into CourseList (Abbreviation) values ('ART 100');
insert into CourseList (Abbreviation) values ('ART 11A');
insert into CourseList (Abbreviation) values ('ART 11B');
insert into CourseList (Abbreviation) values ('ART 11D');
insert into CourseList (Abbreviation) values ('ART 11E');
insert into CourseList (Abbreviation) values ('ART 130');
insert into CourseList (Abbreviation) values ('ART 133');
insert into CourseList (Abbreviation) values ('ART 137');
insert into CourseList (Abbreviation) values ('ART 140');
insert into CourseList (Abbreviation) values ('ART 145');
insert into CourseList (Abbreviation) values ('ART 147');
insert into CourseList (Abbreviation) values ('ART 148');
insert into CourseList (Abbreviation) values ('ART 150');
insert into CourseList (Abbreviation) values ('ART 1A');
insert into CourseList (Abbreviation) values ('ART 1B');
insert into CourseList (Abbreviation) values ('ART 21B');
insert into CourseList (Abbreviation) values ('ART 31B');
insert into CourseList (Abbreviation) values ('ART HIS 121D');
insert into CourseList (Abbreviation) values ('ART HIS 133E');
insert into CourseList (Abbreviation) values ('ART HIS 144');
insert into CourseList (Abbreviation) values ('ART HIS 200');
insert into CourseList (Abbreviation) values ('ART HIS 25');
insert into CourseList (Abbreviation) values ('ART HIS 30');
insert into CourseList (Abbreviation) values ('ART HIS C115B');
insert into CourseList (Abbreviation) values ('ART HIS C126');
insert into CourseList (Abbreviation) values ('ART HIS C148G');
insert into CourseList (Abbreviation) values ('ART HIS C151');
insert into CourseList (Abbreviation) values ('ART HIS M114C');
insert into CourseList (Abbreviation) values ('ART HIS M119C');
insert into CourseList (Abbreviation) values ('ART HIS M127C');
insert into CourseList (Abbreviation) values ('ART M184');
insert into CourseList (Abbreviation) values ('ARTS ED 105');
insert into CourseList (Abbreviation) values ('ASIA AM 103');
insert into CourseList (Abbreviation) values ('ASIA AM 109');
insert into CourseList (Abbreviation) values ('ASIA AM 122B');
insert into CourseList (Abbreviation) values ('ASIA AM 125');
insert into CourseList (Abbreviation) values ('ASIA AM 132A');
insert into CourseList (Abbreviation) values ('ASIA AM 140SL');
insert into CourseList (Abbreviation) values ('ASIA AM 141A');
insert into CourseList (Abbreviation) values ('ASIA AM 170');
insert into CourseList (Abbreviation) values ('ASIA AM 175B');
insert into CourseList (Abbreviation) values ('ASIA AM 178');
insert into CourseList (Abbreviation) values ('ASIA AM 185');
insert into CourseList (Abbreviation) values ('ASIA AM 187B');
insert into CourseList (Abbreviation) values ('ASIA AM 19');
insert into CourseList (Abbreviation) values ('ASIA AM 191C');
insert into CourseList (Abbreviation) values ('ASIA AM 200B');
insert into CourseList (Abbreviation) values ('ASIA AM 30W');
insert into CourseList (Abbreviation) values ('ASIA AM 40');
insert into CourseList (Abbreviation) values ('ASIA AM 50');
insert into CourseList (Abbreviation) values ('ASIA AM C142B');
insert into CourseList (Abbreviation) values ('ASIA AM M112B');
insert into CourseList (Abbreviation) values ('ASIA AM M168');
insert into CourseList (Abbreviation) values ('ASIAN 100');
insert into CourseList (Abbreviation) values ('ASIAN 135');
insert into CourseList (Abbreviation) values ('ASIAN 162');
insert into CourseList (Abbreviation) values ('ASIAN 200');
insert into CourseList (Abbreviation) values ('ASIAN M60W');
insert into CourseList (Abbreviation) values ('ASL 2');
insert into CourseList (Abbreviation) values ('ASL 5');
insert into CourseList (Abbreviation) values ('ASL M115');
insert into CourseList (Abbreviation) values ('ASTR 115');
insert into CourseList (Abbreviation) values ('ASTR 5');
insert into CourseList (Abbreviation) values ('ASTR 6');
insert into CourseList (Abbreviation) values ('ASTR 81');
insert into CourseList (Abbreviation) values ('BIOENGR 120');
insert into CourseList (Abbreviation) values ('BIOENGR 177B');
insert into CourseList (Abbreviation) values ('BIOENGR 180');
insert into CourseList (Abbreviation) values ('BIOENGR C101');
insert into CourseList (Abbreviation) values ('BIOENGR C107');
insert into CourseList (Abbreviation) values ('BIOENGR C139A');
insert into CourseList (Abbreviation) values ('BIOENGR C155');
insert into CourseList (Abbreviation) values ('BIOENGR C175');
insert into CourseList (Abbreviation) values ('BIOENGR C185');
insert into CourseList (Abbreviation) values ('BIOENGR CM186');
insert into CourseList (Abbreviation) values ('BIOL CH M140');
insert into CourseList (Abbreviation) values ('BIOSTAT 100B');
insert into CourseList (Abbreviation) values ('BIOSTAT 200B');
insert into CourseList (Abbreviation) values ('BMD RES 194H');
insert into CourseList (Abbreviation) values ('BMD RES 5HA');
insert into CourseList (Abbreviation) values ('BMD RES 5HB');
insert into CourseList (Abbreviation) values ('C&EE 102');
insert into CourseList (Abbreviation) values ('C&EE 108');
insert into CourseList (Abbreviation) values ('C&EE 108L');
insert into CourseList (Abbreviation) values ('C&EE 121');
insert into CourseList (Abbreviation) values ('C&EE 130');
insert into CourseList (Abbreviation) values ('C&EE 135B');
insert into CourseList (Abbreviation) values ('C&EE 142');
insert into CourseList (Abbreviation) values ('C&EE 151');
insert into CourseList (Abbreviation) values ('C&EE 156B');
insert into CourseList (Abbreviation) values ('C&EE 157L');
insert into CourseList (Abbreviation) values ('C&EE 164');
insert into CourseList (Abbreviation) values ('C&EE 19');
insert into CourseList (Abbreviation) values ('C&EE 194');
insert into CourseList (Abbreviation) values ('C&EE C104');
insert into CourseList (Abbreviation) values ('C&EE M166');
insert into CourseList (Abbreviation) values ('C&S BIO M185');
insert into CourseList (Abbreviation) values ('C&S BIO M186');
insert into CourseList (Abbreviation) values ('CESC 151');
insert into CourseList (Abbreviation) values ('CESC 50SL');
insert into CourseList (Abbreviation) values ('CESC 98A');
insert into CourseList (Abbreviation) values ('CH ENGR 101B');
insert into CourseList (Abbreviation) values ('CH ENGR 102A');
insert into CourseList (Abbreviation) values ('CH ENGR 104A');
insert into CourseList (Abbreviation) values ('CH ENGR 104C');
insert into CourseList (Abbreviation) values ('CH ENGR 104CL');
insert into CourseList (Abbreviation) values ('CH ENGR 104D');
insert into CourseList (Abbreviation) values ('CH ENGR 107');
insert into CourseList (Abbreviation) values ('CH ENGR 108A');
insert into CourseList (Abbreviation) values ('CH ENGR 194');
insert into CourseList (Abbreviation) values ('CH ENGR 45');
insert into CourseList (Abbreviation) values ('CH ENGR C112');
insert into CourseList (Abbreviation) values ('CH ENGR C124');
insert into CourseList (Abbreviation) values ('CHEM 113A');
insert into CourseList (Abbreviation) values ('CHEM 147');
insert into CourseList (Abbreviation) values ('CHEM 14A');
insert into CourseList (Abbreviation) values ('CHEM 14B');
insert into CourseList (Abbreviation) values ('CHEM 14BL');
insert into CourseList (Abbreviation) values ('CHEM 14C');
insert into CourseList (Abbreviation) values ('CHEM 14CL');
insert into CourseList (Abbreviation) values ('CHEM 14D');
insert into CourseList (Abbreviation) values ('CHEM 153B');
insert into CourseList (Abbreviation) values ('CHEM 153C');
insert into CourseList (Abbreviation) values ('CHEM 166');
insert into CourseList (Abbreviation) values ('CHEM 17');
insert into CourseList (Abbreviation) values ('CHEM 192C');
insert into CourseList (Abbreviation) values ('CHEM 20A');
insert into CourseList (Abbreviation) values ('CHEM 20B');
insert into CourseList (Abbreviation) values ('CHEM 20BH');
insert into CourseList (Abbreviation) values ('CHEM 30B');
insert into CourseList (Abbreviation) values ('CHEM 30C');
insert into CourseList (Abbreviation) values ('CHEM 89');
insert into CourseList (Abbreviation) values ('CHEM C113B');
insert into CourseList (Abbreviation) values ('CHEM C123B');
insert into CourseList (Abbreviation) values ('CHEM C126A');
insert into CourseList (Abbreviation) values ('CHEM C143A');
insert into CourseList (Abbreviation) values ('CHICANO 109');
insert into CourseList (Abbreviation) values ('CHICANO 10A');
insert into CourseList (Abbreviation) values ('CHICANO 123');
insert into CourseList (Abbreviation) values ('CHICANO 142');
insert into CourseList (Abbreviation) values ('CHICANO 150');
insert into CourseList (Abbreviation) values ('CHICANO 153C');
insert into CourseList (Abbreviation) values ('CHICANO 161');
insert into CourseList (Abbreviation) values ('CHICANO 194');
insert into CourseList (Abbreviation) values ('CHICANO 89');
insert into CourseList (Abbreviation) values ('CHICANO C141');
insert into CourseList (Abbreviation) values ('CHICANO CM106');
insert into CourseList (Abbreviation) values ('CHICANO CM110');
insert into CourseList (Abbreviation) values ('CHICANO CM177');
insert into CourseList (Abbreviation) values ('CHICANO M105C');
insert into CourseList (Abbreviation) values ('CHICANO M119');
insert into CourseList (Abbreviation) values ('CHICANO M146');
insert into CourseList (Abbreviation) values ('CHICANO M156B');
insert into CourseList (Abbreviation) values ('CHICANO M170SL');
insert into CourseList (Abbreviation) values ('CHICANO M175');
insert into CourseList (Abbreviation) values ('CHIN 100B');
insert into CourseList (Abbreviation) values ('CHIN 101B');
insert into CourseList (Abbreviation) values ('CHIN 102B');
insert into CourseList (Abbreviation) values ('CHIN 110B');
insert into CourseList (Abbreviation) values ('CHIN 124');
insert into CourseList (Abbreviation) values ('CHIN 155');
insert into CourseList (Abbreviation) values ('CHIN 159');
insert into CourseList (Abbreviation) values ('CHIN 2A');
insert into CourseList (Abbreviation) values ('CHIN 5');
insert into CourseList (Abbreviation) values ('CHIN 50');
insert into CourseList (Abbreviation) values ('CHIN 5A');
insert into CourseList (Abbreviation) values ('CHIN M183');
insert into CourseList (Abbreviation) values ('CLASSIC 130');
insert into CourseList (Abbreviation) values ('CLASSIC 137');
insert into CourseList (Abbreviation) values ('CLASSIC 185');
insert into CourseList (Abbreviation) values ('CLASSIC 19');
insert into CourseList (Abbreviation) values ('CLASSIC 193');
insert into CourseList (Abbreviation) values ('CLASSIC 20');
insert into CourseList (Abbreviation) values ('CLASSIC 51A');
insert into CourseList (Abbreviation) values ('CLASSIC 88GE');
insert into CourseList (Abbreviation) values ('CLASSIC M153K');
insert into CourseList (Abbreviation) values ('CLUSTER 20B');
insert into CourseList (Abbreviation) values ('CLUSTER 21B');
insert into CourseList (Abbreviation) values ('CLUSTER 30B');
insert into CourseList (Abbreviation) values ('CLUSTER 48B');
insert into CourseList (Abbreviation) values ('CLUSTER 60B');
insert into CourseList (Abbreviation) values ('CLUSTER 70B');
insert into CourseList (Abbreviation) values ('CLUSTER 73B');
insert into CourseList (Abbreviation) values ('CLUSTER 80B');
insert into CourseList (Abbreviation) values ('CLUSTER M1B');
insert into CourseList (Abbreviation) values ('CLUSTER M71B');
insert into CourseList (Abbreviation) values ('CLUSTER M72B');
insert into CourseList (Abbreviation) values ('COM HLT 179');
insert into CourseList (Abbreviation) values ('COM HLT CM170');
insert into CourseList (Abbreviation) values ('COM LIT 100');
insert into CourseList (Abbreviation) values ('COM LIT 200B');
insert into CourseList (Abbreviation) values ('COM LIT 2DW');
insert into CourseList (Abbreviation) values ('COM LIT 4CW');
insert into CourseList (Abbreviation) values ('COM LIT M101');
insert into CourseList (Abbreviation) values ('COM SCI 111');
insert into CourseList (Abbreviation) values ('COM SCI 118');
insert into CourseList (Abbreviation) values ('COM SCI 130');
insert into CourseList (Abbreviation) values ('COM SCI 131');
insert into CourseList (Abbreviation) values ('COM SCI 133');
insert into CourseList (Abbreviation) values ('COM SCI 143');
insert into CourseList (Abbreviation) values ('COM SCI 152B');
insert into CourseList (Abbreviation) values ('COM SCI 161');
insert into CourseList (Abbreviation) values ('COM SCI 174A');
insert into CourseList (Abbreviation) values ('COM SCI 180');
insert into CourseList (Abbreviation) values ('COM SCI 181');
insert into CourseList (Abbreviation) values ('COM SCI 31');
insert into CourseList (Abbreviation) values ('COM SCI 32');
insert into CourseList (Abbreviation) values ('COM SCI 33');
insert into CourseList (Abbreviation) values ('COM SCI CM124');
insert into CourseList (Abbreviation) values ('COM SCI CM186');
insert into CourseList (Abbreviation) values ('COM SCI M146');
insert into CourseList (Abbreviation) values ('COM SCI M151B');
insert into CourseList (Abbreviation) values ('COMM 10');
insert into CourseList (Abbreviation) values ('COMM 100');
insert into CourseList (Abbreviation) values ('COMM 103B');
insert into CourseList (Abbreviation) values ('COMM 104');
insert into CourseList (Abbreviation) values ('COMM 105');
insert into CourseList (Abbreviation) values ('COMM 111');
insert into CourseList (Abbreviation) values ('COMM 119');
insert into CourseList (Abbreviation) values ('COMM 133');
insert into CourseList (Abbreviation) values ('COMM 145');
insert into CourseList (Abbreviation) values ('COMM 148');
insert into CourseList (Abbreviation) values ('COMM 150');
insert into CourseList (Abbreviation) values ('COMM 151');
insert into CourseList (Abbreviation) values ('COMM 154');
insert into CourseList (Abbreviation) values ('COMM 155');
insert into CourseList (Abbreviation) values ('COMM 160');
insert into CourseList (Abbreviation) values ('COMM 170');
insert into CourseList (Abbreviation) values ('COMM 185');
insert into CourseList (Abbreviation) values ('COMM 187');
insert into CourseList (Abbreviation) values ('COMM 188C');
insert into CourseList (Abbreviation) values ('COMM 189');
insert into CourseList (Abbreviation) values ('COMM 19');
insert into CourseList (Abbreviation) values ('COMM 191E');
insert into CourseList (Abbreviation) values ('COMM 89');
insert into CourseList (Abbreviation) values ('COMM M149');
insert into CourseList (Abbreviation) values ('COMPTNG 10A');
insert into CourseList (Abbreviation) values ('COMPTNG 16');
insert into CourseList (Abbreviation) values ('COMPTNG 20A');
insert into CourseList (Abbreviation) values ('COMPTNG 40A');
insert into CourseList (Abbreviation) values ('DANCE 10');
insert into CourseList (Abbreviation) values ('DANCE 11');
insert into CourseList (Abbreviation) values ('DANCE 116');
insert into CourseList (Abbreviation) values ('DANCE 117A');
insert into CourseList (Abbreviation) values ('DANCE 117C');
insert into CourseList (Abbreviation) values ('DANCE 13');
insert into CourseList (Abbreviation) values ('DANCE 16');
insert into CourseList (Abbreviation) values ('DANCE 44');
insert into CourseList (Abbreviation) values ('DANCE 5');
insert into CourseList (Abbreviation) values ('DANCE 67A');
insert into CourseList (Abbreviation) values ('DANCE 67B');
insert into CourseList (Abbreviation) values ('DANCE 70');
insert into CourseList (Abbreviation) values ('DANCE C122');
insert into CourseList (Abbreviation) values ('DANCE C145');
insert into CourseList (Abbreviation) values ('DANCE C180');
insert into CourseList (Abbreviation) values ('DESMA 152');
insert into CourseList (Abbreviation) values ('DESMA 153');
insert into CourseList (Abbreviation) values ('DESMA 154');
insert into CourseList (Abbreviation) values ('DESMA 156');
insert into CourseList (Abbreviation) values ('DESMA 160');
insert into CourseList (Abbreviation) values ('DESMA 161');
insert into CourseList (Abbreviation) values ('DESMA 163');
insert into CourseList (Abbreviation) values ('DESMA 171');
insert into CourseList (Abbreviation) values ('DESMA 172');
insert into CourseList (Abbreviation) values ('DESMA 173');
insert into CourseList (Abbreviation) values ('DESMA 22');
insert into CourseList (Abbreviation) values ('DESMA 24');
insert into CourseList (Abbreviation) values ('DESMA 25');
insert into CourseList (Abbreviation) values ('DESMA 28');
insert into CourseList (Abbreviation) values ('DESMA 8');
insert into CourseList (Abbreviation) values ('DGT HUM M145');
insert into CourseList (Abbreviation) values ('DIS STD 101W');
insert into CourseList (Abbreviation) values ('DIS STD M115');
insert into CourseList (Abbreviation) values ('DUTCH 103B');
insert into CourseList (Abbreviation) values ('EC ENGR 10');
insert into CourseList (Abbreviation) values ('EC ENGR 100');
insert into CourseList (Abbreviation) values ('EC ENGR 101A');
insert into CourseList (Abbreviation) values ('EC ENGR 101B');
insert into CourseList (Abbreviation) values ('EC ENGR 102');
insert into CourseList (Abbreviation) values ('EC ENGR 110H');
insert into CourseList (Abbreviation) values ('EC ENGR 110L');
insert into CourseList (Abbreviation) values ('EC ENGR 111L');
insert into CourseList (Abbreviation) values ('EC ENGR 113DB');
insert into CourseList (Abbreviation) values ('EC ENGR 115B');
insert into CourseList (Abbreviation) values ('EC ENGR 121B');
insert into CourseList (Abbreviation) values ('EC ENGR 128');
insert into CourseList (Abbreviation) values ('EC ENGR 132A');
insert into CourseList (Abbreviation) values ('EC ENGR 133A');
insert into CourseList (Abbreviation) values ('EC ENGR 141');
insert into CourseList (Abbreviation) values ('EC ENGR 163C');
insert into CourseList (Abbreviation) values ('EC ENGR 170A');
insert into CourseList (Abbreviation) values ('EC ENGR 170B');
insert into CourseList (Abbreviation) values ('EC ENGR 173DB');
insert into CourseList (Abbreviation) values ('EC ENGR 189');
insert into CourseList (Abbreviation) values ('EC ENGR 2H');
insert into CourseList (Abbreviation) values ('EC ENGR C147');
insert into CourseList (Abbreviation) values ('EC ENGR M16');
insert into CourseList (Abbreviation) values ('ECON 1');
insert into CourseList (Abbreviation) values ('ECON 101');
insert into CourseList (Abbreviation) values ('ECON 102');
insert into CourseList (Abbreviation) values ('ECON 103');
insert into CourseList (Abbreviation) values ('ECON 103L');
insert into CourseList (Abbreviation) values ('ECON 106I');
insert into CourseList (Abbreviation) values ('ECON 106IL');
insert into CourseList (Abbreviation) values ('ECON 106M');
insert into CourseList (Abbreviation) values ('ECON 106ML');
insert into CourseList (Abbreviation) values ('ECON 106V');
insert into CourseList (Abbreviation) values ('ECON 106VL');
insert into CourseList (Abbreviation) values ('ECON 107');
insert into CourseList (Abbreviation) values ('ECON 11');
insert into CourseList (Abbreviation) values ('ECON 112');
insert into CourseList (Abbreviation) values ('ECON 113');
insert into CourseList (Abbreviation) values ('ECON 122');
insert into CourseList (Abbreviation) values ('ECON 134');
insert into CourseList (Abbreviation) values ('ECON 137');
insert into CourseList (Abbreviation) values ('ECON 144');
insert into CourseList (Abbreviation) values ('ECON 147');
insert into CourseList (Abbreviation) values ('ECON 147L');
insert into CourseList (Abbreviation) values ('ECON 160');
insert into CourseList (Abbreviation) values ('ECON 165');
insert into CourseList (Abbreviation) values ('ECON 170');
insert into CourseList (Abbreviation) values ('ECON 187');
insert into CourseList (Abbreviation) values ('ECON 2');
insert into CourseList (Abbreviation) values ('ECON 41');
insert into CourseList (Abbreviation) values ('ECON M123');
insert into CourseList (Abbreviation) values ('EDUC 11');
insert into CourseList (Abbreviation) values ('EDUC 132');
insert into CourseList (Abbreviation) values ('EDUC 143');
insert into CourseList (Abbreviation) values ('EDUC 164');
insert into CourseList (Abbreviation) values ('EDUC 166');
insert into CourseList (Abbreviation) values ('EDUC 184');
insert into CourseList (Abbreviation) values ('EDUC 188A');
insert into CourseList (Abbreviation) values ('EDUC 19');
insert into CourseList (Abbreviation) values ('EDUC 191C');
insert into CourseList (Abbreviation) values ('EDUC 196C');
insert into CourseList (Abbreviation) values ('EDUC 196D');
insert into CourseList (Abbreviation) values ('EDUC 35');
insert into CourseList (Abbreviation) values ('EDUC M103');
insert into CourseList (Abbreviation) values ('EE BIOL 100');
insert into CourseList (Abbreviation) values ('EE BIOL 101');
insert into CourseList (Abbreviation) values ('EE BIOL 120');
insert into CourseList (Abbreviation) values ('EE BIOL 129');
insert into CourseList (Abbreviation) values ('EE BIOL 130');
insert into CourseList (Abbreviation) values ('EE BIOL 170');
insert into CourseList (Abbreviation) values ('EE BIOL 183');
insert into CourseList (Abbreviation) values ('EE BIOL 185');
insert into CourseList (Abbreviation) values ('EE BIOL 19');
insert into CourseList (Abbreviation) values ('EE BIOL 200B');
insert into CourseList (Abbreviation) values ('EE BIOL C119B');
insert into CourseList (Abbreviation) values ('EE BIOL C126');
insert into CourseList (Abbreviation) values ('EE BIOL C172');
insert into CourseList (Abbreviation) values ('EE BIOL C177');
insert into CourseList (Abbreviation) values ('EE BIOL CM173');
insert into CourseList (Abbreviation) values ('EE BIOL M139');
insert into CourseList (Abbreviation) values ('EE BIOL M157');
insert into CourseList (Abbreviation) values ('EE BIOL M178');
insert into CourseList (Abbreviation) values ('ENGCOMP 1');
insert into CourseList (Abbreviation) values ('ENGCOMP 130D');
insert into CourseList (Abbreviation) values ('ENGCOMP 132');
insert into CourseList (Abbreviation) values ('ENGCOMP 133');
insert into CourseList (Abbreviation) values ('ENGCOMP 134');
insert into CourseList (Abbreviation) values ('ENGCOMP 1B');
insert into CourseList (Abbreviation) values ('ENGCOMP 2I');
insert into CourseList (Abbreviation) values ('ENGCOMP 3E');
insert into CourseList (Abbreviation) values ('ENGL 106');
insert into CourseList (Abbreviation) values ('ENGL 109');
insert into CourseList (Abbreviation) values ('ENGL 10B');
insert into CourseList (Abbreviation) values ('ENGL 10C');
insert into CourseList (Abbreviation) values ('ENGL 11');
insert into CourseList (Abbreviation) values ('ENGL 110B');
insert into CourseList (Abbreviation) values ('ENGL 110T');
insert into CourseList (Abbreviation) values ('ENGL 118B');
insert into CourseList (Abbreviation) values ('ENGL 129');
insert into CourseList (Abbreviation) values ('ENGL 135');
insert into CourseList (Abbreviation) values ('ENGL 140A');
insert into CourseList (Abbreviation) values ('ENGL 141C');
insert into CourseList (Abbreviation) values ('ENGL 142R');
insert into CourseList (Abbreviation) values ('ENGL 145');
insert into CourseList (Abbreviation) values ('ENGL 146');
insert into CourseList (Abbreviation) values ('ENGL 150A');
insert into CourseList (Abbreviation) values ('ENGL 150B');
insert into CourseList (Abbreviation) values ('ENGL 150C');
insert into CourseList (Abbreviation) values ('ENGL 157');
insert into CourseList (Abbreviation) values ('ENGL 160A');
insert into CourseList (Abbreviation) values ('ENGL 163B');
insert into CourseList (Abbreviation) values ('ENGL 163C');
insert into CourseList (Abbreviation) values ('ENGL 164C');
insert into CourseList (Abbreviation) values ('ENGL 164D');
insert into CourseList (Abbreviation) values ('ENGL 166B');
insert into CourseList (Abbreviation) values ('ENGL 167A');
insert into CourseList (Abbreviation) values ('ENGL 170A');
insert into CourseList (Abbreviation) values ('ENGL 173C');
insert into CourseList (Abbreviation) values ('ENGL 174B');
insert into CourseList (Abbreviation) values ('ENGL 80');
insert into CourseList (Abbreviation) values ('ENGL 87');
insert into CourseList (Abbreviation) values ('ENGL 91A');
insert into CourseList (Abbreviation) values ('ENGL 91C');
insert into CourseList (Abbreviation) values ('ENGL 97H');
insert into CourseList (Abbreviation) values ('ENGL 98TA');
insert into CourseList (Abbreviation) values ('ENGL M102B');
insert into CourseList (Abbreviation) values ('ENGL M104B');
insert into CourseList (Abbreviation) values ('ENGL M104E');
insert into CourseList (Abbreviation) values ('ENGL M105C');
insert into CourseList (Abbreviation) values ('ENGL M118F');
insert into CourseList (Abbreviation) values ('ENGL M191A');
insert into CourseList (Abbreviation) values ('ENGL M191C');
insert into CourseList (Abbreviation) values ('ENGL M50');
insert into CourseList (Abbreviation) values ('ENGR 110');
insert into CourseList (Abbreviation) values ('ENGR 111');
insert into CourseList (Abbreviation) values ('ENGR 160');
insert into CourseList (Abbreviation) values ('ENGR 183EW');
insert into CourseList (Abbreviation) values ('ENGR 185EW');
insert into CourseList (Abbreviation) values ('ENGR 2');
insert into CourseList (Abbreviation) values ('ENGR 23');
insert into CourseList (Abbreviation) values ('ENGR 24');
insert into CourseList (Abbreviation) values ('ENGR 25');
insert into CourseList (Abbreviation) values ('ENGR 96E');
insert into CourseList (Abbreviation) values ('ENGR 96G');
insert into CourseList (Abbreviation) values ('ENV HLT 100');
insert into CourseList (Abbreviation) values ('ENV HLT C152D');
insert into CourseList (Abbreviation) values ('ENVIRON 150');
insert into CourseList (Abbreviation) values ('ENVIRON 180B');
insert into CourseList (Abbreviation) values ('ENVIRON 19');
insert into CourseList (Abbreviation) values ('ENVIRON 200B');
insert into CourseList (Abbreviation) values ('ENVIRON M109');
insert into CourseList (Abbreviation) values ('ENVIRON M127');
insert into CourseList (Abbreviation) values ('ENVIRON M153');
insert into CourseList (Abbreviation) values ('ENVIRON M167');
insert into CourseList (Abbreviation) values ('EPIDEM 100');
insert into CourseList (Abbreviation) values ('EPIDEM 200B');
insert into CourseList (Abbreviation) values ('EPS SCI 1');
insert into CourseList (Abbreviation) values ('EPS SCI 101');
insert into CourseList (Abbreviation) values ('EPS SCI 103A');
insert into CourseList (Abbreviation) values ('EPS SCI 112');
insert into CourseList (Abbreviation) values ('EPS SCI 116');
insert into CourseList (Abbreviation) values ('EPS SCI 13');
insert into CourseList (Abbreviation) values ('EPS SCI 136A');
insert into CourseList (Abbreviation) values ('EPS SCI 139');
insert into CourseList (Abbreviation) values ('EPS SCI 15');
insert into CourseList (Abbreviation) values ('EPS SCI 153');
insert into CourseList (Abbreviation) values ('EPS SCI 154');
insert into CourseList (Abbreviation) values ('EPS SCI 16');
insert into CourseList (Abbreviation) values ('EPS SCI 171');
insert into CourseList (Abbreviation) values ('EPS SCI 193B');
insert into CourseList (Abbreviation) values ('EPS SCI 200C');
insert into CourseList (Abbreviation) values ('EPS SCI 200E');
insert into CourseList (Abbreviation) values ('EPS SCI 9');
insert into CourseList (Abbreviation) values ('EPS SCI C109');
insert into CourseList (Abbreviation) values ('EPS SCI C143');
insert into CourseList (Abbreviation) values ('ETHNMUS 158');
insert into CourseList (Abbreviation) values ('ETHNMUS 161Z');
insert into CourseList (Abbreviation) values ('ETHNMUS 174');
insert into CourseList (Abbreviation) values ('ETHNMUS 188');
insert into CourseList (Abbreviation) values ('ETHNMUS 20C');
insert into CourseList (Abbreviation) values ('ETHNMUS C100');
insert into CourseList (Abbreviation) values ('ETHNMUS C178');
insert into CourseList (Abbreviation) values ('ETHNMUS C200');
insert into CourseList (Abbreviation) values ('ETHNMUS M12A');
insert into CourseList (Abbreviation) values ('ETHNMUS M50B');
insert into CourseList (Abbreviation) values ('FILIPNO 2');
insert into CourseList (Abbreviation) values ('FILIPNO 5');
insert into CourseList (Abbreviation) values ('FILM TV 106B');
insert into CourseList (Abbreviation) values ('FILM TV 109');
insert into CourseList (Abbreviation) values ('FILM TV 113');
insert into CourseList (Abbreviation) values ('FILM TV 122M');
insert into CourseList (Abbreviation) values ('FILM TV 135B');
insert into CourseList (Abbreviation) values ('FILM TV 183A');
insert into CourseList (Abbreviation) values ('FILM TV 194');
insert into CourseList (Abbreviation) values ('FILM TV 33');
insert into CourseList (Abbreviation) values ('FILM TV 4');
insert into CourseList (Abbreviation) values ('FILM TV 51');
insert into CourseList (Abbreviation) values ('FILM TV 6A');
insert into CourseList (Abbreviation) values ('FILM TV 98TA');
insert into CourseList (Abbreviation) values ('FILM TV M50');
insert into CourseList (Abbreviation) values ('FOOD ST 159');
insert into CourseList (Abbreviation) values ('FOOD ST M79');
insert into CourseList (Abbreviation) values ('FRNCH 100');
insert into CourseList (Abbreviation) values ('FRNCH 101');
insert into CourseList (Abbreviation) values ('FRNCH 104');
insert into CourseList (Abbreviation) values ('FRNCH 107');
insert into CourseList (Abbreviation) values ('FRNCH 108');
insert into CourseList (Abbreviation) values ('FRNCH 117');
insert into CourseList (Abbreviation) values ('FRNCH 119');
insert into CourseList (Abbreviation) values ('FRNCH 120');
insert into CourseList (Abbreviation) values ('FRNCH 14');
insert into CourseList (Abbreviation) values ('FRNCH 16');
insert into CourseList (Abbreviation) values ('GENDER 10');
insert into CourseList (Abbreviation) values ('GENDER 102');
insert into CourseList (Abbreviation) values ('GENDER 187');
insert into CourseList (Abbreviation) values ('GENDER 98T');
insert into CourseList (Abbreviation) values ('GENDER CM132A');
insert into CourseList (Abbreviation) values ('GENDER M110C');
insert into CourseList (Abbreviation) values ('GENDER M114');
insert into CourseList (Abbreviation) values ('GENDER M146');
insert into CourseList (Abbreviation) values ('GENDER M149');
insert into CourseList (Abbreviation) values ('GENDER M154P');
insert into CourseList (Abbreviation) values ('GENDER M174');
insert into CourseList (Abbreviation) values ('GENDER M186B');
insert into CourseList (Abbreviation) values ('GEOG 1');
insert into CourseList (Abbreviation) values ('GEOG 105');
insert into CourseList (Abbreviation) values ('GEOG 108');
insert into CourseList (Abbreviation) values ('GEOG 133');
insert into CourseList (Abbreviation) values ('GEOG 140');
insert into CourseList (Abbreviation) values ('GEOG 141');
insert into CourseList (Abbreviation) values ('GEOG 152');
insert into CourseList (Abbreviation) values ('GEOG 159C');
insert into CourseList (Abbreviation) values ('GEOG 161');
insert into CourseList (Abbreviation) values ('GEOG 168');
insert into CourseList (Abbreviation) values ('GEOG 170');
insert into CourseList (Abbreviation) values ('GEOG 177');
insert into CourseList (Abbreviation) values ('GEOG 182B');
insert into CourseList (Abbreviation) values ('GEOG 186');
insert into CourseList (Abbreviation) values ('GEOG 3');
insert into CourseList (Abbreviation) values ('GEOG 7');
insert into CourseList (Abbreviation) values ('GEOG M109');
insert into CourseList (Abbreviation) values ('GEOG M127');
insert into CourseList (Abbreviation) values ('GEOG M146');
insert into CourseList (Abbreviation) values ('GERMAN 104');
insert into CourseList (Abbreviation) values ('GERMAN 110');
insert into CourseList (Abbreviation) values ('GERMAN 116');
insert into CourseList (Abbreviation) values ('GERMAN 154');
insert into CourseList (Abbreviation) values ('GERMAN 174');
insert into CourseList (Abbreviation) values ('GERMAN 19');
insert into CourseList (Abbreviation) values ('GERMAN 3');
insert into CourseList (Abbreviation) values ('GERMAN 4');
insert into CourseList (Abbreviation) values ('GERMAN 5');
insert into CourseList (Abbreviation) values ('GJ STDS 101');
insert into CourseList (Abbreviation) values ('GJ STDS 122B');
insert into CourseList (Abbreviation) values ('GJ STDS 125B');
insert into CourseList (Abbreviation) values ('GJ STDS 127B');
insert into CourseList (Abbreviation) values ('GJ STDS 176C');
insert into CourseList (Abbreviation) values ('GJ STDS M12A');
insert into CourseList (Abbreviation) values ('GJ STDS M50B');
insert into CourseList (Abbreviation) values ('GLBL ST 103');
insert into CourseList (Abbreviation) values ('GLBL ST 19');
insert into CourseList (Abbreviation) values ('GREEK 100');
insert into CourseList (Abbreviation) values ('GREEK 2');
insert into CourseList (Abbreviation) values ('GREEK 200C');
insert into CourseList (Abbreviation) values ('GREEK 8B');
insert into CourseList (Abbreviation) values ('GRNTLGY M108');
insert into CourseList (Abbreviation) values ('HEBREW 102B');
insert into CourseList (Abbreviation) values ('HEBREW 110B');
insert into CourseList (Abbreviation) values ('HEBREW 1B');
insert into CourseList (Abbreviation) values ('HIN-URD 100B');
insert into CourseList (Abbreviation) values ('HIN-URD 2');
insert into CourseList (Abbreviation) values ('HIST 107A');
insert into CourseList (Abbreviation) values ('HIST 107B');
insert into CourseList (Abbreviation) values ('HIST 111C');
insert into CourseList (Abbreviation) values ('HIST 116A');
insert into CourseList (Abbreviation) values ('HIST 11A');
insert into CourseList (Abbreviation) values ('HIST 121E');
insert into CourseList (Abbreviation) values ('HIST 122B');
insert into CourseList (Abbreviation) values ('HIST 124C');
insert into CourseList (Abbreviation) values ('HIST 127B');
insert into CourseList (Abbreviation) values ('HIST 130');
insert into CourseList (Abbreviation) values ('HIST 139B');
insert into CourseList (Abbreviation) values ('HIST 13B');
insert into CourseList (Abbreviation) values ('HIST 141B');
insert into CourseList (Abbreviation) values ('HIST 146B');
insert into CourseList (Abbreviation) values ('HIST 148');
insert into CourseList (Abbreviation) values ('HIST 161');
insert into CourseList (Abbreviation) values ('HIST 162A');
insert into CourseList (Abbreviation) values ('HIST 170B');
insert into CourseList (Abbreviation) values ('HIST 173D');
insert into CourseList (Abbreviation) values ('HIST 176B');
insert into CourseList (Abbreviation) values ('HIST 179A');
insert into CourseList (Abbreviation) values ('HIST 179B');
insert into CourseList (Abbreviation) values ('HIST 187D');
insert into CourseList (Abbreviation) values ('HIST 187E');
insert into CourseList (Abbreviation) values ('HIST 187J');
insert into CourseList (Abbreviation) values ('HIST 19');
insert into CourseList (Abbreviation) values ('HIST 1B');
insert into CourseList (Abbreviation) values ('HIST 21');
insert into CourseList (Abbreviation) values ('HIST 3C');
insert into CourseList (Abbreviation) values ('HIST 3D');
insert into CourseList (Abbreviation) values ('HIST 5');
insert into CourseList (Abbreviation) values ('HIST 88');
insert into CourseList (Abbreviation) values ('HIST 8B');
insert into CourseList (Abbreviation) values ('HIST 97C');
insert into CourseList (Abbreviation) values ('HIST 97J');
insert into CourseList (Abbreviation) values ('HIST 98T');
insert into CourseList (Abbreviation) values ('HIST C187R');
insert into CourseList (Abbreviation) values ('HIST C200M');
insert into CourseList (Abbreviation) values ('HIST M104A');
insert into CourseList (Abbreviation) values ('HIST M10A');
insert into CourseList (Abbreviation) values ('HIST M110B');
insert into CourseList (Abbreviation) values ('HIST M122E');
insert into CourseList (Abbreviation) values ('HIST M178');
insert into CourseList (Abbreviation) values ('HIST M185F');
insert into CourseList (Abbreviation) values ('HIST M186B');
insert into CourseList (Abbreviation) values ('HLT POL 140');
insert into CourseList (Abbreviation) values ('HNGAR 101B');
insert into CourseList (Abbreviation) values ('HNRS 11W');
insert into CourseList (Abbreviation) values ('HNRS 129');
insert into CourseList (Abbreviation) values ('HNRS 146');
insert into CourseList (Abbreviation) values ('HNRS 165');
insert into CourseList (Abbreviation) values ('HNRS 37W');
insert into CourseList (Abbreviation) values ('HNRS 70A');
insert into CourseList (Abbreviation) values ('HNRS 80');
insert into CourseList (Abbreviation) values ('HNRS 87W');
insert into CourseList (Abbreviation) values ('I A STD 111A');
insert into CourseList (Abbreviation) values ('I A STD 33');
insert into CourseList (Abbreviation) values ('I A STD 50');
insert into CourseList (Abbreviation) values ('I A STD M5B');
insert into CourseList (Abbreviation) values ('I A STD M7B');
insert into CourseList (Abbreviation) values ('IL AMER 18B');
insert into CourseList (Abbreviation) values ('IL AMER M5B');
insert into CourseList (Abbreviation) values ('INDO 100B');
insert into CourseList (Abbreviation) values ('INDO 2');
insert into CourseList (Abbreviation) values ('INDO 5');
insert into CourseList (Abbreviation) values ('INF STD 10');
insert into CourseList (Abbreviation) values ('INF STD 139');
insert into CourseList (Abbreviation) values ('INF STD 180');
insert into CourseList (Abbreviation) values ('INF STD 20');
insert into CourseList (Abbreviation) values ('INTL DV 110');
insert into CourseList (Abbreviation) values ('INTL DV 130');
insert into CourseList (Abbreviation) values ('INTL DV 191');
insert into CourseList (Abbreviation) values ('IRANIAN 102B');
insert into CourseList (Abbreviation) values ('IRANIAN 103B');
insert into CourseList (Abbreviation) values ('IRANIAN 1B');
insert into CourseList (Abbreviation) values ('IRANIAN 55');
insert into CourseList (Abbreviation) values ('IRANIAN M105B');
insert into CourseList (Abbreviation) values ('IRANIAN M110B');
insert into CourseList (Abbreviation) values ('IRANIAN M178');
insert into CourseList (Abbreviation) values ('ISLM ST 151');
insert into CourseList (Abbreviation) values ('ISLM ST M111');
insert into CourseList (Abbreviation) values ('ISLM ST M20');
insert into CourseList (Abbreviation) values ('ITALIAN 122');
insert into CourseList (Abbreviation) values ('ITALIAN 125');
insert into CourseList (Abbreviation) values ('ITALIAN 140');
insert into CourseList (Abbreviation) values ('ITALIAN 3');
insert into CourseList (Abbreviation) values ('ITALIAN 4');
insert into CourseList (Abbreviation) values ('ITALIAN 42A');
insert into CourseList (Abbreviation) values ('ITALIAN 5');
insert into CourseList (Abbreviation) values ('ITALIAN 6');
insert into CourseList (Abbreviation) values ('JAPAN 100B');
insert into CourseList (Abbreviation) values ('JAPAN 101B');
insert into CourseList (Abbreviation) values ('JAPAN 103A');
insert into CourseList (Abbreviation) values ('JAPAN 105A');
insert into CourseList (Abbreviation) values ('JAPAN 124');
insert into CourseList (Abbreviation) values ('JAPAN 172');
insert into CourseList (Abbreviation) values ('JAPAN 80');
insert into CourseList (Abbreviation) values ('JAPAN C159');
insert into CourseList (Abbreviation) values ('JAPAN CM123');
insert into CourseList (Abbreviation) values ('JAPAN CM160');
insert into CourseList (Abbreviation) values ('JEWISH M144');
insert into CourseList (Abbreviation) values ('JEWISH M150A');
insert into CourseList (Abbreviation) values ('JEWISH M178');
insert into CourseList (Abbreviation) values ('KOREA 100B');
insert into CourseList (Abbreviation) values ('KOREA 101B');
insert into CourseList (Abbreviation) values ('KOREA 102B');
insert into CourseList (Abbreviation) values ('KOREA 104B');
insert into CourseList (Abbreviation) values ('KOREA 124');
insert into CourseList (Abbreviation) values ('KOREA 153');
insert into CourseList (Abbreviation) values ('KOREA 159');
insert into CourseList (Abbreviation) values ('KOREA 177');
insert into CourseList (Abbreviation) values ('KOREA 2A');
insert into CourseList (Abbreviation) values ('KOREA 50');
insert into CourseList (Abbreviation) values ('LATIN 1');
insert into CourseList (Abbreviation) values ('LATIN 100');
insert into CourseList (Abbreviation) values ('LATIN 107');
insert into CourseList (Abbreviation) values ('LGBTQS 182');
insert into CourseList (Abbreviation) values ('LGBTQS 183');
insert into CourseList (Abbreviation) values ('LGBTQS 19');
insert into CourseList (Abbreviation) values ('LGBTQS M114');
insert into CourseList (Abbreviation) values ('LIFESCI 107');
insert into CourseList (Abbreviation) values ('LIFESCI 15');
insert into CourseList (Abbreviation) values ('LIFESCI 23L');
insert into CourseList (Abbreviation) values ('LIFESCI 30A');
insert into CourseList (Abbreviation) values ('LIFESCI 30B');
insert into CourseList (Abbreviation) values ('LIFESCI 7C');
insert into CourseList (Abbreviation) values ('LING 1');
insert into CourseList (Abbreviation) values ('LING 102');
insert into CourseList (Abbreviation) values ('LING 103');
insert into CourseList (Abbreviation) values ('LING 104');
insert into CourseList (Abbreviation) values ('LING 120A');
insert into CourseList (Abbreviation) values ('LING 120B');
insert into CourseList (Abbreviation) values ('LING 120C');
insert into CourseList (Abbreviation) values ('LING 127');
insert into CourseList (Abbreviation) values ('LING 130');
insert into CourseList (Abbreviation) values ('LING 165A');
insert into CourseList (Abbreviation) values ('LING 165B');
insert into CourseList (Abbreviation) values ('LING 185A');
insert into CourseList (Abbreviation) values ('LING 20');
insert into CourseList (Abbreviation) values ('LING M141');
insert into CourseList (Abbreviation) values ('M E STD M111');
insert into CourseList (Abbreviation) values ('M E STD M144');
insert into CourseList (Abbreviation) values ('M E STD M50B');
insert into CourseList (Abbreviation) values ('M PHARM 19');
insert into CourseList (Abbreviation) values ('MAT SCI 104');
insert into CourseList (Abbreviation) values ('MAT SCI 111');
insert into CourseList (Abbreviation) values ('MAT SCI 120');
insert into CourseList (Abbreviation) values ('MAT SCI 122');
insert into CourseList (Abbreviation) values ('MAT SCI 140A');
insert into CourseList (Abbreviation) values ('MAT SCI 141L');
insert into CourseList (Abbreviation) values ('MAT SCI 143A');
insert into CourseList (Abbreviation) values ('MAT SCI 150');
insert into CourseList (Abbreviation) values ('MAT SCI 90L');
insert into CourseList (Abbreviation) values ('MAT SCI M105');
insert into CourseList (Abbreviation) values ('MATH 103B');
insert into CourseList (Abbreviation) values ('MATH 105B');
insert into CourseList (Abbreviation) values ('MATH 106');
insert into CourseList (Abbreviation) values ('MATH 110A');
insert into CourseList (Abbreviation) values ('MATH 110B');
insert into CourseList (Abbreviation) values ('MATH 115AH');
insert into CourseList (Abbreviation) values ('MATH 115B');
insert into CourseList (Abbreviation) values ('MATH 116');
insert into CourseList (Abbreviation) values ('MATH 118');
insert into CourseList (Abbreviation) values ('MATH 11N');
insert into CourseList (Abbreviation) values ('MATH 120A');
insert into CourseList (Abbreviation) values ('MATH 121');
insert into CourseList (Abbreviation) values ('MATH 131AH');
insert into CourseList (Abbreviation) values ('MATH 131B');
insert into CourseList (Abbreviation) values ('MATH 131BH');
insert into CourseList (Abbreviation) values ('MATH 132');
insert into CourseList (Abbreviation) values ('MATH 132H');
insert into CourseList (Abbreviation) values ('MATH 135');
insert into CourseList (Abbreviation) values ('MATH 142');
insert into CourseList (Abbreviation) values ('MATH 146');
insert into CourseList (Abbreviation) values ('MATH 151A');
insert into CourseList (Abbreviation) values ('MATH 151B');
insert into CourseList (Abbreviation) values ('MATH 155');
insert into CourseList (Abbreviation) values ('MATH 156');
insert into CourseList (Abbreviation) values ('MATH 164');
insert into CourseList (Abbreviation) values ('MATH 167');
insert into CourseList (Abbreviation) values ('MATH 168');
insert into CourseList (Abbreviation) values ('MATH 170A');
insert into CourseList (Abbreviation) values ('MATH 170B');
insert into CourseList (Abbreviation) values ('MATH 171');
insert into CourseList (Abbreviation) values ('MATH 174E');
insert into CourseList (Abbreviation) values ('MATH 177');
insert into CourseList (Abbreviation) values ('MATH 178A');
insert into CourseList (Abbreviation) values ('MATH 178B');
insert into CourseList (Abbreviation) values ('MATH 182');
insert into CourseList (Abbreviation) values ('MATH 184');
insert into CourseList (Abbreviation) values ('MATH 31A');
insert into CourseList (Abbreviation) values ('MATH 31AL');
insert into CourseList (Abbreviation) values ('MATH 32BH');
insert into CourseList (Abbreviation) values ('MATH 33A');
insert into CourseList (Abbreviation) values ('MATH 33AH');
insert into CourseList (Abbreviation) values ('MATH 33B');
insert into CourseList (Abbreviation) values ('MATH 3A');
insert into CourseList (Abbreviation) values ('MATH 3B');
insert into CourseList (Abbreviation) values ('MATH 3C');
insert into CourseList (Abbreviation) values ('MATH 61');
insert into CourseList (Abbreviation) values ('MATH 71SL');
insert into CourseList (Abbreviation) values ('MATH M114S');
insert into CourseList (Abbreviation) values ('MCD BIO 138');
insert into CourseList (Abbreviation) values ('MCD BIO 144');
insert into CourseList (Abbreviation) values ('MCD BIO 160');
insert into CourseList (Abbreviation) values ('MCD BIO 165A');
insert into CourseList (Abbreviation) values ('MCD BIO 168');
insert into CourseList (Abbreviation) values ('MCD BIO 30H');
insert into CourseList (Abbreviation) values ('MCD BIO 50');
insert into CourseList (Abbreviation) values ('MCD BIO 60');
insert into CourseList (Abbreviation) values ('MCD BIO 90');
insert into CourseList (Abbreviation) values ('MCD BIO CM156');
insert into CourseList (Abbreviation) values ('MCD BIO M175B');
insert into CourseList (Abbreviation) values ('MECH&AE 101');
insert into CourseList (Abbreviation) values ('MECH&AE 102');
insert into CourseList (Abbreviation) values ('MECH&AE 103');
insert into CourseList (Abbreviation) values ('MECH&AE 105A');
insert into CourseList (Abbreviation) values ('MECH&AE 105D');
insert into CourseList (Abbreviation) values ('MECH&AE 107');
insert into CourseList (Abbreviation) values ('MECH&AE 133A');
insert into CourseList (Abbreviation) values ('MECH&AE 150A');
insert into CourseList (Abbreviation) values ('MECH&AE 154A');
insert into CourseList (Abbreviation) values ('MECH&AE 156A');
insert into CourseList (Abbreviation) values ('MECH&AE 161B');
insert into CourseList (Abbreviation) values ('MECH&AE 166C');
insert into CourseList (Abbreviation) values ('MECH&AE 171A');
insert into CourseList (Abbreviation) values ('MECH&AE 182B');
insert into CourseList (Abbreviation) values ('MECH&AE 82');
insert into CourseList (Abbreviation) values ('MECH&AE 94');
insert into CourseList (Abbreviation) values ('MECH&AE C183C');
insert into CourseList (Abbreviation) values ('MECH&AE CM140');
insert into CourseList (Abbreviation) values ('MECH&AE M168');
insert into CourseList (Abbreviation) values ('MECH&AE M183B');
insert into CourseList (Abbreviation) values ('MECH&AE M20');
insert into CourseList (Abbreviation) values ('MGMT 108');
insert into CourseList (Abbreviation) values ('MGMT 120B');
insert into CourseList (Abbreviation) values ('MGMT 121');
insert into CourseList (Abbreviation) values ('MGMT 122');
insert into CourseList (Abbreviation) values ('MGMT 127B');
insert into CourseList (Abbreviation) values ('MGMT 142A');
insert into CourseList (Abbreviation) values ('MGMT 160');
insert into CourseList (Abbreviation) values ('MGMT 161');
insert into CourseList (Abbreviation) values ('MGMT 165');
insert into CourseList (Abbreviation) values ('MGMT 168');
insert into CourseList (Abbreviation) values ('MGMT 180');
insert into CourseList (Abbreviation) values ('MGMT 1B');
insert into CourseList (Abbreviation) values ('MIL SCI 110');
insert into CourseList (Abbreviation) values ('MIL SCI 12');
insert into CourseList (Abbreviation) values ('MIL SCI 132');
insert into CourseList (Abbreviation) values ('MIL SCI 142');
insert into CourseList (Abbreviation) values ('MIL SCI 22');
insert into CourseList (Abbreviation) values ('MIL SCI Z');
insert into CourseList (Abbreviation) values ('MIMG 10');
insert into CourseList (Abbreviation) values ('MIMG 101');
insert into CourseList (Abbreviation) values ('MIMG 102');
insert into CourseList (Abbreviation) values ('MIMG 109AL');
insert into CourseList (Abbreviation) values ('MIMG 158');
insert into CourseList (Abbreviation) values ('MIMG 191H');
insert into CourseList (Abbreviation) values ('MIMG C185A');
insert into CourseList (Abbreviation) values ('MIMG CM156');
insert into CourseList (Abbreviation) values ('MSC IND 101');
insert into CourseList (Abbreviation) values ('MSC IND 113');
insert into CourseList (Abbreviation) values ('MSC IND 124');
insert into CourseList (Abbreviation) values ('MSC IND M181');
insert into CourseList (Abbreviation) values ('MUSC 104B');
insert into CourseList (Abbreviation) values ('MUSC 110C');
insert into CourseList (Abbreviation) values ('MUSC 114B');
insert into CourseList (Abbreviation) values ('MUSC 114D');
insert into CourseList (Abbreviation) values ('MUSC 115A');
insert into CourseList (Abbreviation) values ('MUSC 119');
insert into CourseList (Abbreviation) values ('MUSC 15');
insert into CourseList (Abbreviation) values ('MUSC 160F');
insert into CourseList (Abbreviation) values ('MUSC 160G');
insert into CourseList (Abbreviation) values ('MUSC 160I');
insert into CourseList (Abbreviation) values ('MUSC 160L');
insert into CourseList (Abbreviation) values ('MUSC 185F');
insert into CourseList (Abbreviation) values ('MUSC 50');
insert into CourseList (Abbreviation) values ('MUSC 60A');
insert into CourseList (Abbreviation) values ('MUSC 60C');
insert into CourseList (Abbreviation) values ('MUSC 60D');
insert into CourseList (Abbreviation) values ('MUSC 60J');
insert into CourseList (Abbreviation) values ('MUSC 61A');
insert into CourseList (Abbreviation) values ('MUSC C171');
insert into CourseList (Abbreviation) values ('MUSC C175G');
insert into CourseList (Abbreviation) values ('MUSC C185A');
insert into CourseList (Abbreviation) values ('MUSC C185D');
insert into CourseList (Abbreviation) values ('MUSC C185E');
insert into CourseList (Abbreviation) values ('MUSC C185G');
insert into CourseList (Abbreviation) values ('MUSC M90T');
insert into CourseList (Abbreviation) values ('MUSCLG 125B');
insert into CourseList (Abbreviation) values ('MUSCLG 13');
insert into CourseList (Abbreviation) values ('MUSCLG 168');
insert into CourseList (Abbreviation) values ('MUSCLG 187B');
insert into CourseList (Abbreviation) values ('MUSCLG 19');
insert into CourseList (Abbreviation) values ('MUSCLG 200B');
insert into CourseList (Abbreviation) values ('MUSCLG 35');
insert into CourseList (Abbreviation) values ('MUSCLG 68');
insert into CourseList (Abbreviation) values ('NAV SCI 20A');
insert into CourseList (Abbreviation) values ('NAV SCI Z');
insert into CourseList (Abbreviation) values ('NEURBIO M169');
insert into CourseList (Abbreviation) values ('NEURBIO M171');
insert into CourseList (Abbreviation) values ('NEUROSC M101B');
insert into CourseList (Abbreviation) values ('NEUROSC M119N');
insert into CourseList (Abbreviation) values ('NEUROSC M176');
insert into CourseList (Abbreviation) values ('NURSING 115');
insert into CourseList (Abbreviation) values ('NURSING 162A');
insert into CourseList (Abbreviation) values ('NURSING 168');
insert into CourseList (Abbreviation) values ('NURSING 197');
insert into CourseList (Abbreviation) values ('NURSING 20');
insert into CourseList (Abbreviation) values ('NURSING 3');
insert into CourseList (Abbreviation) values ('OBGYN 19');
insert into CourseList (Abbreviation) values ('PBMED 200A');
insert into CourseList (Abbreviation) values ('PHILOS 100B');
insert into CourseList (Abbreviation) values ('PHILOS 131');
insert into CourseList (Abbreviation) values ('PHILOS 135');
insert into CourseList (Abbreviation) values ('PHILOS 136');
insert into CourseList (Abbreviation) values ('PHILOS 152A');
insert into CourseList (Abbreviation) values ('PHILOS 166');
insert into CourseList (Abbreviation) values ('PHILOS 168');
insert into CourseList (Abbreviation) values ('PHILOS 170');
insert into CourseList (Abbreviation) values ('PHILOS 173');
insert into CourseList (Abbreviation) values ('PHILOS 177B');
insert into CourseList (Abbreviation) values ('PHILOS 2');
insert into CourseList (Abbreviation) values ('PHILOS 21');
insert into CourseList (Abbreviation) values ('PHILOS 22W');
insert into CourseList (Abbreviation) values ('PHILOS 31');
insert into CourseList (Abbreviation) values ('PHILOS 7');
insert into CourseList (Abbreviation) values ('PHILOS 8');
insert into CourseList (Abbreviation) values ('PHILOS 98T');
insert into CourseList (Abbreviation) values ('PHILOS C111');
insert into CourseList (Abbreviation) values ('PHILOS C115');
insert into CourseList (Abbreviation) values ('PHILOS C119');
insert into CourseList (Abbreviation) values ('PHILOS C127B');
insert into CourseList (Abbreviation) values ('PHILOS C156');
insert into CourseList (Abbreviation) values ('PHILOS M118B');
insert into CourseList (Abbreviation) values ('PHILOS M187');
insert into CourseList (Abbreviation) values ('PHYSCI 111A');
insert into CourseList (Abbreviation) values ('PHYSCI 111L');
insert into CourseList (Abbreviation) values ('PHYSCI 121');
insert into CourseList (Abbreviation) values ('PHYSCI 13');
insert into CourseList (Abbreviation) values ('PHYSCI 167');
insert into CourseList (Abbreviation) values ('PHYSCI 175');
insert into CourseList (Abbreviation) values ('PHYSCI 177');
insert into CourseList (Abbreviation) values ('PHYSCI 187A');
insert into CourseList (Abbreviation) values ('PHYSCI 194A');
insert into CourseList (Abbreviation) values ('PHYSCI 200');
insert into CourseList (Abbreviation) values ('PHYSCI 5');
insert into CourseList (Abbreviation) values ('PHYSCI C126');
insert into CourseList (Abbreviation) values ('PHYSCI C127');
insert into CourseList (Abbreviation) values ('PHYSCI C130');
insert into CourseList (Abbreviation) values ('PHYSCI C152');
insert into CourseList (Abbreviation) values ('PHYSCI M145');
insert into CourseList (Abbreviation) values ('PHYSCI M176');
insert into CourseList (Abbreviation) values ('PHYSCI M180B');
insert into CourseList (Abbreviation) values ('PHYSICS 105A');
insert into CourseList (Abbreviation) values ('PHYSICS 110A');
insert into CourseList (Abbreviation) values ('PHYSICS 115C');
insert into CourseList (Abbreviation) values ('PHYSICS 117');
insert into CourseList (Abbreviation) values ('PHYSICS 132');
insert into CourseList (Abbreviation) values ('PHYSICS 140B');
insert into CourseList (Abbreviation) values ('PHYSICS 144');
insert into CourseList (Abbreviation) values ('PHYSICS 17');
insert into CourseList (Abbreviation) values ('PHYSICS 180A');
insert into CourseList (Abbreviation) values ('PHYSICS 180C');
insert into CourseList (Abbreviation) values ('PHYSICS 180D');
insert into CourseList (Abbreviation) values ('PHYSICS 180E');
insert into CourseList (Abbreviation) values ('PHYSICS 180F');
insert into CourseList (Abbreviation) values ('PHYSICS 18L');
insert into CourseList (Abbreviation) values ('PHYSICS 1A');
insert into CourseList (Abbreviation) values ('PHYSICS 1B');
insert into CourseList (Abbreviation) values ('PHYSICS 1BH');
insert into CourseList (Abbreviation) values ('PHYSICS 98XA');
insert into CourseList (Abbreviation) values ('POL SCI 113B');
insert into CourseList (Abbreviation) values ('POL SCI 114B');
insert into CourseList (Abbreviation) values ('POL SCI 116B');
insert into CourseList (Abbreviation) values ('POL SCI 121A');
insert into CourseList (Abbreviation) values ('POL SCI 123A');
insert into CourseList (Abbreviation) values ('POL SCI 124A');
insert into CourseList (Abbreviation) values ('POL SCI 126');
insert into CourseList (Abbreviation) values ('POL SCI 138B');
insert into CourseList (Abbreviation) values ('POL SCI 139');
insert into CourseList (Abbreviation) values ('POL SCI 140A');
insert into CourseList (Abbreviation) values ('POL SCI 141B');
insert into CourseList (Abbreviation) values ('POL SCI 145E');
insert into CourseList (Abbreviation) values ('POL SCI 147C');
insert into CourseList (Abbreviation) values ('POL SCI 151A');
insert into CourseList (Abbreviation) values ('POL SCI 151B');
insert into CourseList (Abbreviation) values ('POL SCI 159A');
insert into CourseList (Abbreviation) values ('POL SCI 163A');
insert into CourseList (Abbreviation) values ('POL SCI 164A');
insert into CourseList (Abbreviation) values ('POL SCI 20');
insert into CourseList (Abbreviation) values ('POL SCI 200B');
insert into CourseList (Abbreviation) values ('POL SCI 30');
insert into CourseList (Abbreviation) values ('POL SCI 50');
insert into CourseList (Abbreviation) values ('POLSH 101B');
insert into CourseList (Abbreviation) values ('PORTGSE 11A');
insert into CourseList (Abbreviation) values ('PORTGSE 11B');
insert into CourseList (Abbreviation) values ('PORTGSE 130B');
insert into CourseList (Abbreviation) values ('PORTGSE 26');
insert into CourseList (Abbreviation) values ('PORTGSE M35');
insert into CourseList (Abbreviation) values ('PSYCH 10');
insert into CourseList (Abbreviation) values ('PSYCH 101');
insert into CourseList (Abbreviation) values ('PSYCH 110');
insert into CourseList (Abbreviation) values ('PSYCH 112A');
insert into CourseList (Abbreviation) values ('PSYCH 115');
insert into CourseList (Abbreviation) values ('PSYCH 116');
insert into CourseList (Abbreviation) values ('PSYCH 119J');
insert into CourseList (Abbreviation) values ('PSYCH 120A');
insert into CourseList (Abbreviation) values ('PSYCH 121');
insert into CourseList (Abbreviation) values ('PSYCH 124F');
insert into CourseList (Abbreviation) values ('PSYCH 124G');
insert into CourseList (Abbreviation) values ('PSYCH 124J');
insert into CourseList (Abbreviation) values ('PSYCH 130');
insert into CourseList (Abbreviation) values ('PSYCH 131');
insert into CourseList (Abbreviation) values ('PSYCH 132A');
insert into CourseList (Abbreviation) values ('PSYCH 133A');
insert into CourseList (Abbreviation) values ('PSYCH 133B');
insert into CourseList (Abbreviation) values ('PSYCH 134J');
insert into CourseList (Abbreviation) values ('PSYCH 135');
insert into CourseList (Abbreviation) values ('PSYCH 136B');
insert into CourseList (Abbreviation) values ('PSYCH 137C');
insert into CourseList (Abbreviation) values ('PSYCH 15');
insert into CourseList (Abbreviation) values ('PSYCH 150');
insert into CourseList (Abbreviation) values ('PSYCH 151');
insert into CourseList (Abbreviation) values ('PSYCH 152');
insert into CourseList (Abbreviation) values ('PSYCH 164');
insert into CourseList (Abbreviation) values ('PSYCH 167');
insert into CourseList (Abbreviation) values ('PSYCH 186C');
insert into CourseList (Abbreviation) values ('PSYCH 19');
insert into CourseList (Abbreviation) values ('PSYCH 200C');
insert into CourseList (Abbreviation) values ('PSYCH 20B');
insert into CourseList (Abbreviation) values ('PSYCH 85');
insert into CourseList (Abbreviation) values ('PSYCH 98TA');
insert into CourseList (Abbreviation) values ('PSYCH 98TB');
insert into CourseList (Abbreviation) values ('PSYCH M117B');
insert into CourseList (Abbreviation) values ('PSYCH M119N');
insert into CourseList (Abbreviation) values ('PSYCTRY 174');
insert into CourseList (Abbreviation) values ('PUB AFF 10');
insert into CourseList (Abbreviation) values ('PUB AFF 111');
insert into CourseList (Abbreviation) values ('PUB AFF 113');
insert into CourseList (Abbreviation) values ('PUB AFF 114');
insert into CourseList (Abbreviation) values ('PUB AFF 115');
insert into CourseList (Abbreviation) values ('PUB AFF 145');
insert into CourseList (Abbreviation) values ('PUB AFF 170');
insert into CourseList (Abbreviation) values ('PUB AFF 174');
insert into CourseList (Abbreviation) values ('PUB AFF 20');
insert into CourseList (Abbreviation) values ('PUB AFF 40');
insert into CourseList (Abbreviation) values ('PUB AFF M130');
insert into CourseList (Abbreviation) values ('PUB AFF M142');
insert into CourseList (Abbreviation) values ('PUB AFF M161');
insert into CourseList (Abbreviation) values ('PUB AFF M176SL');
insert into CourseList (Abbreviation) values ('PUB HLT 150');
insert into CourseList (Abbreviation) values ('PUB HLT 200B');
insert into CourseList (Abbreviation) values ('PUB HLT M106');
insert into CourseList (Abbreviation) values ('PUB PLC 10D');
insert into CourseList (Abbreviation) values ('RELIGN 160');
insert into CourseList (Abbreviation) values ('RELIGN 191');
insert into CourseList (Abbreviation) values ('RELIGN M105B');
insert into CourseList (Abbreviation) values ('RELIGN M118B');
insert into CourseList (Abbreviation) values ('RELIGN M20');
insert into CourseList (Abbreviation) values ('RELIGN M40');
insert into CourseList (Abbreviation) values ('RELIGN M50');
insert into CourseList (Abbreviation) values ('RELIGN M60W');
insert into CourseList (Abbreviation) values ('ROMANIA 101B');
insert into CourseList (Abbreviation) values ('ROMANIA 152');
insert into CourseList (Abbreviation) values ('RUSSN 100B');
insert into CourseList (Abbreviation) values ('RUSSN 101B');
insert into CourseList (Abbreviation) values ('RUSSN 102B');
insert into CourseList (Abbreviation) values ('RUSSN 107B');
insert into CourseList (Abbreviation) values ('RUSSN 126');
insert into CourseList (Abbreviation) values ('RUSSN 130A');
insert into CourseList (Abbreviation) values ('RUSSN 25W');
insert into CourseList (Abbreviation) values ('RUSSN 31');
insert into CourseList (Abbreviation) values ('RUSSN 5');
insert into CourseList (Abbreviation) values ('RUSSN C124D');
insert into CourseList (Abbreviation) values ('SCAND 12');
insert into CourseList (Abbreviation) values ('SCAND 138');
insert into CourseList (Abbreviation) values ('SCAND 155');
insert into CourseList (Abbreviation) values ('SCAND 156');
insert into CourseList (Abbreviation) values ('SCAND 165B');
insert into CourseList (Abbreviation) values ('SCAND 2');
insert into CourseList (Abbreviation) values ('SCAND 50W');
insert into CourseList (Abbreviation) values ('SCAND C171');
insert into CourseList (Abbreviation) values ('SCI EDU 100SL');
insert into CourseList (Abbreviation) values ('SEASIAN 135');
insert into CourseList (Abbreviation) values ('SEASIAN 50');
insert into CourseList (Abbreviation) values ('SLAVC 191TB');
insert into CourseList (Abbreviation) values ('SLAVC M40');
insert into CourseList (Abbreviation) values ('SOC GEN 105B');
insert into CourseList (Abbreviation) values ('SOC GEN 108');
insert into CourseList (Abbreviation) values ('SOC GEN 180');
insert into CourseList (Abbreviation) values ('SOC GEN 188');
insert into CourseList (Abbreviation) values ('SOC GEN 191S');
insert into CourseList (Abbreviation) values ('SOC GEN 5');
insert into CourseList (Abbreviation) values ('SOC GEN M132');
insert into CourseList (Abbreviation) values ('SOC GEN M140');
insert into CourseList (Abbreviation) values ('SOC GEN M157');
insert into CourseList (Abbreviation) values ('SOC WLF M108');
insert into CourseList (Abbreviation) values ('SOCIOL 1');
insert into CourseList (Abbreviation) values ('SOCIOL 111');
insert into CourseList (Abbreviation) values ('SOCIOL 113');
insert into CourseList (Abbreviation) values ('SOCIOL 128');
insert into CourseList (Abbreviation) values ('SOCIOL 133');
insert into CourseList (Abbreviation) values ('SOCIOL 147A');
insert into CourseList (Abbreviation) values ('SOCIOL 151');
insert into CourseList (Abbreviation) values ('SOCIOL 156');
insert into CourseList (Abbreviation) values ('SOCIOL 158');
insert into CourseList (Abbreviation) values ('SOCIOL 173');
insert into CourseList (Abbreviation) values ('SOCIOL 180A');
insert into CourseList (Abbreviation) values ('SOCIOL 189');
insert into CourseList (Abbreviation) values ('SOCIOL 19');
insert into CourseList (Abbreviation) values ('SOCIOL 191V');
insert into CourseList (Abbreviation) values ('SOCIOL 20');
insert into CourseList (Abbreviation) values ('SOCIOL M174');
insert into CourseList (Abbreviation) values ('SPAN 100B');
insert into CourseList (Abbreviation) values ('SPAN 11A');
insert into CourseList (Abbreviation) values ('SPAN 120');
insert into CourseList (Abbreviation) values ('SPAN 12B');
insert into CourseList (Abbreviation) values ('SPAN 135');
insert into CourseList (Abbreviation) values ('SPAN 140');
insert into CourseList (Abbreviation) values ('SPAN 191B');
insert into CourseList (Abbreviation) values ('SPAN 3');
insert into CourseList (Abbreviation) values ('SPAN 4');
insert into CourseList (Abbreviation) values ('SPAN 42');
insert into CourseList (Abbreviation) values ('SPAN 5');
insert into CourseList (Abbreviation) values ('SPAN 7B');
insert into CourseList (Abbreviation) values ('SPAN 98T');
insert into CourseList (Abbreviation) values ('SPAN M155A');
insert into CourseList (Abbreviation) values ('SPAN M172SL');
insert into CourseList (Abbreviation) values ('SPAN M35');
insert into CourseList (Abbreviation) values ('SRB CRO 101B');
insert into CourseList (Abbreviation) values ('SRB CRO 187C');
insert into CourseList (Abbreviation) values ('STATS 10');
insert into CourseList (Abbreviation) values ('STATS 100A');
insert into CourseList (Abbreviation) values ('STATS 100C');
insert into CourseList (Abbreviation) values ('STATS 115');
insert into CourseList (Abbreviation) values ('STATS 12');
insert into CourseList (Abbreviation) values ('STATS 13');
insert into CourseList (Abbreviation) values ('STATS 141SL');
insert into CourseList (Abbreviation) values ('STATS 143');
insert into CourseList (Abbreviation) values ('STATS 20');
insert into CourseList (Abbreviation) values ('STATS 200B');
insert into CourseList (Abbreviation) values ('STATS C155');
insert into CourseList (Abbreviation) values ('STATS C173');
insert into CourseList (Abbreviation) values ('SWAHILI 2');
insert into CourseList (Abbreviation) values ('THAI 2');
insert into CourseList (Abbreviation) values ('THEATER 103F');
insert into CourseList (Abbreviation) values ('THEATER 113');
insert into CourseList (Abbreviation) values ('THEATER 116B');
insert into CourseList (Abbreviation) values ('THEATER 118D');
insert into CourseList (Abbreviation) values ('THEATER 120B');
insert into CourseList (Abbreviation) values ('THEATER 124A');
insert into CourseList (Abbreviation) values ('THEATER 124B');
insert into CourseList (Abbreviation) values ('THEATER 124D');
insert into CourseList (Abbreviation) values ('THEATER 125A');
insert into CourseList (Abbreviation) values ('THEATER 125B');
insert into CourseList (Abbreviation) values ('THEATER 126A');
insert into CourseList (Abbreviation) values ('THEATER 126B');
insert into CourseList (Abbreviation) values ('THEATER 13');
insert into CourseList (Abbreviation) values ('THEATER 130');
insert into CourseList (Abbreviation) values ('THEATER 138');
insert into CourseList (Abbreviation) values ('THEATER 14B');
insert into CourseList (Abbreviation) values ('THEATER 15');
insert into CourseList (Abbreviation) values ('THEATER 167B');
insert into CourseList (Abbreviation) values ('THEATER 180');
insert into CourseList (Abbreviation) values ('THEATER 2B');
insert into CourseList (Abbreviation) values ('THEATER C146A');
insert into CourseList (Abbreviation) values ('THEATER C153F');
insert into CourseList (Abbreviation) values ('THEATER C155F');
insert into CourseList (Abbreviation) values ('THEATER M103A');
insert into CourseList (Abbreviation) values ('TURKIC 101B');
insert into CourseList (Abbreviation) values ('URBN PL 185SL');
insert into CourseList (Abbreviation) values ('URBN PL CM151');
insert into CourseList (Abbreviation) values ('URBN PL M167');
insert into CourseList (Abbreviation) values ('VIETMSE 100B');
insert into CourseList (Abbreviation) values ('VIETMSE 2A');
insert into CourseList (Abbreviation) values ('VIETMSE 5');
insert into CourseList (Abbreviation) values ('WL ARTS 120');
insert into CourseList (Abbreviation) values ('WL ARTS 19');
insert into CourseList (Abbreviation) values ('WL ARTS 20');
insert into CourseList (Abbreviation) values ('WL ARTS 24');
insert into CourseList (Abbreviation) values ('WL ARTS 80');
insert into CourseList (Abbreviation) values ('WL ARTS C139');
insert into CourseList (Abbreviation) values ('WL ARTS C145');
insert into CourseList (Abbreviation) values ('WL ARTS C151');
insert into CourseList (Abbreviation) values ('WL ARTS C158');
insert into CourseList (Abbreviation) values ('WL ARTS M128');
insert into CourseList (Abbreviation) values ('WL ARTS M23');
insert into CourseList (Abbreviation) values ('WL ARTS M79');
insert into CourseList (Abbreviation) values ('YIDDS 101B');
insert into CourseList (Abbreviation) values ('ANTHRO C117');
insert into CourseList (Abbreviation) values ('ARABIC 102B');
insert into CourseList (Abbreviation) values ('ART HIS 185');
insert into CourseList (Abbreviation) values ('ASTR 127');
insert into CourseList (Abbreviation) values ('ASTR 3');
insert into CourseList (Abbreviation) values ('C&EE 128L');
insert into CourseList (Abbreviation) values ('C&EE 147');
insert into CourseList (Abbreviation) values ('C&EE 154');
insert into CourseList (Abbreviation) values ('CHEM 110A');
insert into CourseList (Abbreviation) values ('CHIN 2');
insert into CourseList (Abbreviation) values ('COMM 188D');
insert into CourseList (Abbreviation) values ('COMPTNG 10B');
insert into CourseList (Abbreviation) values ('COMPTNG 10C');
insert into CourseList (Abbreviation) values ('DGT HUM 140');
insert into CourseList (Abbreviation) values ('EC ENGR 180DB');
insert into CourseList (Abbreviation) values ('ENGCOMP 100W');
insert into CourseList (Abbreviation) values ('ENGCOMP 131B');
insert into CourseList (Abbreviation) values ('ENGL 177');
insert into CourseList (Abbreviation) values ('ENGL M138');
insert into CourseList (Abbreviation) values ('ENGR 163');
insert into CourseList (Abbreviation) values ('ENVIRON 10');
insert into CourseList (Abbreviation) values ('FRNCH 3');
insert into CourseList (Abbreviation) values ('FRNCH 4');
insert into CourseList (Abbreviation) values ('FRNCH 5');
insert into CourseList (Abbreviation) values ('FRNCH 6');
insert into CourseList (Abbreviation) values ('GENDER M185A');
insert into CourseList (Abbreviation) values ('GEOG 5');
insert into CourseList (Abbreviation) values ('GERMAN 1');
insert into CourseList (Abbreviation) values ('HIST 119A');
insert into CourseList (Abbreviation) values ('HIST 187C');
insert into CourseList (Abbreviation) values ('HIST 1A');
insert into CourseList (Abbreviation) values ('LATIN 2');
insert into CourseList (Abbreviation) values ('LIFESCI 7A');
insert into CourseList (Abbreviation) values ('LIFESCI 7B');
insert into CourseList (Abbreviation) values ('MATH 131A');
insert into CourseList (Abbreviation) values ('MATH 32A');
insert into CourseList (Abbreviation) values ('MATH 32B');
insert into CourseList (Abbreviation) values ('MCD BIO 191');
insert into CourseList (Abbreviation) values ('MGMT 1A');
insert into CourseList (Abbreviation) values ('MIMG 103BL');
insert into CourseList (Abbreviation) values ('MUSCLG 191G');
insert into CourseList (Abbreviation) values ('PHYSICS 115B');
insert into CourseList (Abbreviation) values ('PHYSICS 131');
insert into CourseList (Abbreviation) values ('PHYSICS 1C');
insert into CourseList (Abbreviation) values ('PHYSICS 5C');
insert into CourseList (Abbreviation) values ('POL SCI 191C');
insert into CourseList (Abbreviation) values ('PSYCH 100A');
insert into CourseList (Abbreviation) values ('PSYCH 100B');
insert into CourseList (Abbreviation) values ('PSYCH 127A');
insert into CourseList (Abbreviation) values ('PUB AFF M191P');
insert into CourseList (Abbreviation) values ('SPAN 2');
insert into CourseList (Abbreviation) values ('SPAN 25');
insert into CourseList (Abbreviation) values ('STATS 101A');
insert into CourseList (Abbreviation) values ('C&EE 170');
insert into CourseList (Abbreviation) values ('CHEM 153A');
insert into CourseList (Abbreviation) values ('CHEM 20L');
insert into CourseList (Abbreviation) values ('CHEM 30AL');
insert into CourseList (Abbreviation) values ('CHEM 30BL');
insert into CourseList (Abbreviation) values ('COMM 1');
insert into CourseList (Abbreviation) values ('EC ENGR 115C');
insert into CourseList (Abbreviation) values ('EC ENGR 11L');
insert into CourseList (Abbreviation) values ('EE BIOL 100L');
insert into CourseList (Abbreviation) values ('EE BIOL 103');
insert into CourseList (Abbreviation) values ('EE BIOL 110');
insert into CourseList (Abbreviation) values ('ENGCOMP 3');
insert into CourseList (Abbreviation) values ('GENDER 104');
insert into CourseList (Abbreviation) values ('GEOG 6');
insert into CourseList (Abbreviation) values ('GEOG M153');
insert into CourseList (Abbreviation) values ('HIST 113B');
insert into CourseList (Abbreviation) values ('ITALIAN 1');
insert into CourseList (Abbreviation) values ('JAPAN 2');
insert into CourseList (Abbreviation) values ('JAPAN 5');
insert into CourseList (Abbreviation) values ('KOREA 2');
insert into CourseList (Abbreviation) values ('KOREA 5');
insert into CourseList (Abbreviation) values ('LIFESCI 110');
insert into CourseList (Abbreviation) values ('LIFESCI 40');
insert into CourseList (Abbreviation) values ('MAT SCI 131');
insert into CourseList (Abbreviation) values ('MAT SCI 131L');
insert into CourseList (Abbreviation) values ('MATH 110BH');
insert into CourseList (Abbreviation) values ('MATH 115A');
insert into CourseList (Abbreviation) values ('MATH 134');
insert into CourseList (Abbreviation) values ('MATH 170S');
insert into CourseList (Abbreviation) values ('MATH 31B');
insert into CourseList (Abbreviation) values ('MGMT 120A');
insert into CourseList (Abbreviation) values ('MGMT 127A');
insert into CourseList (Abbreviation) values ('PHYSICS 4AL');
insert into CourseList (Abbreviation) values ('PHYSICS 4BL');
insert into CourseList (Abbreviation) values ('PHYSICS 5A');
insert into CourseList (Abbreviation) values ('PHYSICS 5B');
insert into CourseList (Abbreviation) values ('PSYCH 118');
insert into CourseList (Abbreviation) values ('PSYCH 20A');
insert into CourseList (Abbreviation) values ('SOCIOL 101');
insert into CourseList (Abbreviation) values ('SOCIOL 102');
insert into CourseList (Abbreviation) values ('SPAN 1');
insert into CourseList (Abbreviation) values ('SPAN 119');
insert into CourseList (Abbreviation) values ('STATS 100B');
insert into CourseList (Abbreviation) values ('STATS 102A');
insert into CourseList (Abbreviation) values ('THEATER 106');
insert into CourseList (Abbreviation) values ('THEATER 1B');
insert into CourseList (Abbreviation) values ('THEATER 20');
insert into CourseList (Abbreviation) values ('THEATER 30');
insert into CourseList (Abbreviation) values ('VIETMSE 2');
insert into CourseList (Abbreviation) values ('COM SCI 35L');
insert into CourseList (Abbreviation) values ('ENGCOMP 2');
insert into CourseList (Abbreviation) values ('ENGL 4W');
insert into CourseList (Abbreviation) values ('FRNCH 1');
insert into CourseList (Abbreviation) values ('FRNCH 2');
insert into CourseList (Abbreviation) values ('GERMAN 2');
insert into CourseList (Abbreviation) values ('ITALIAN 2');
insert into CourseList (Abbreviation) values ('MATH 170E');

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