--Creación de tablas e introducción de datos--

CREATE TABLE job (
	job_id INTEGER PRIMARY KEY AUTOINCREMENT,
	name_job TEXT,
	job_type TEXT,
	working_hours TEXT,
	region_id INTEGER 
);

CREATE TABLE user (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name TEXT,
	last_name TEXT,
	telephone NUMERIC,
	employer TEXT,
	region_id INTEGER 
);

CREATE TABLE job_user (
	job_user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	job_id INTEGER,
	user_id INTEGER
);

CREATE TABLE company (
	company_id INTEGER PRIMARY KEY AUTOINCREMENT,
	company_name TEXT,
	adress TEXT,
	region_id INTEGER 
);

CREATE TABLE job_company (
	job_company_id INTEGER PRIMARY KEY AUTOINCREMENT,
	job_id INTEGER,
	company_id INTEGER
);

CREATE TABLE region (
	region_id INTEGER PRIMARY KEY AUTOINCREMENT,
	city TEXT,
	town TEXT,
	country TEXT
);

CREATE TABLE category (
	category_id INTEGER PRIMARY KEY AUTOINCREMENT,
	category TEXT
);

CREATE TABLE job_category (
	job_category_id INTEGER PRIMARY KEY AUTOINCREMENT,
	job_id INTEGER,
	category_id INTEGER
);

INSERT INTO category (category_id, category) VALUES ('1', 'comercial');
INSERT INTO category (category_id, category) VALUES ('2', 'marketing');
INSERT INTO category (category_id, category) VALUES ('3', 'web developer');


INSERT INTO region (region_id, city, town, country) VALUES ('1', 'málaga', 'torremolinos', 'españa');
INSERT INTO region (region_id, city, town, country) VALUES ('2', 'núremberg', 'mitte', 'alemania');
INSERT INTO region (region_id, city, town, country) VALUES ('3', 'londres', 'battersea', 'inglaterra');


INSERT INTO company (company_id, company_name, adress, region_id) VALUES ('1', 'google', 'calle fulanito', '1');
INSERT INTO company (company_id, company_name, adress, region_id) VALUES ('2', 'microsoft', 'street hill', '3');
INSERT INTO company (company_id, company_name, adress, region_id) VALUES ('3', 'apple', 'burgstraBe', '2');


INSERT INTO job (job_id, name_job, job_type, working_hours, region_id) VALUES ('1', 'full stack', 'full-time', '08:00-16:00', '2');
INSERT INTO job (job_id, name_job, job_type, working_hours, region_id) VALUES ('2', 'marketing-comercial', 'part-time', '10:00-14:00', '1');
INSERT INTO job (job_id, name_job, job_type, working_hours, region_id) VALUES ('3', 'web developer', 'student', '18:00-21:00', '3');
INSERT INTO job (job_id, name_job, job_type, working_hours, region_id) VALUES ('4', 'testing', 'part-time', '16:00-20:00', '1');


INSERT INTO job_category (job_category_id, job_id, category_id) VALUES ('1', '1', '3');
INSERT INTO job_category (job_category_id, job_id, category_id) VALUES ('2', '2', '1');
INSERT INTO job_category (job_category_id, job_id, category_id) VALUES ('3', '2', '2');
INSERT INTO job_category (job_category_id, job_id, category_id) VALUES ('4', '3', '3');


INSERT INTO job_company (job_company_id, job_id, company_id) VALUES ('1', '1', '3');
INSERT INTO job_company (job_company_id, job_id, company_id) VALUES ('2', '2', '1');
INSERT INTO job_company (job_company_id, job_id, company_id) VALUES ('3', '3', '2');
INSERT INTO job_company (job_company_id, job_id, company_id) VALUES ('4', '3', '1');

INSERT INTO user (user_id, first_name, last_name, telephone, employer, region_id) VALUES ('1', 'Alejandro', 'Cruz', '003461834', 'yes', '1');
INSERT INTO user (user_id, first_name, last_name, telephone, employer, region_id) VALUES ('2', 'Pepe', 'Barbero', '004478365', 'no', '3');
INSERT INTO user (user_id, first_name, last_name, telephone, employer, region_id) VALUES ('3', 'Dirk', 'H.', '00491775', 'no', '2');
INSERT INTO user (user_id, first_name, last_name, telephone, employer, region_id) VALUES ('4', 'Prueba', 'test', '666', 'no', '2');


INSERT INTO job_user (job_user_id, job_id, user_id) VALUES ('1', '1', '1');
INSERT INTO job_user (job_user_id, job_id, user_id) VALUES ('2', '3', '2');
INSERT INTO job_user (job_user_id, job_id, user_id) VALUES ('3', '2', '3');

--CONSULTAS--
	--How many jobs are in each of the regions?--
SELECT region.city, region.town, region.country, COUNT(job.region_id) AS cuanto
FROM region
INNER JOIN job ON region.region_id=job.region_id
GROUP BY region.town;

	--Which company offers web developer jobs?--
SELECT company.company_name, category.category
FROM company
INNER JOIN job_company ON company.company_id=job_company.company_id
INNER JOIN job ON job_company.job_id=job.job_id
INNER JOIN job_category ON job.job_id=job_category.job_id
INNER JOIN category ON job_category.category_id=category.category_id
WHERE category.category='web developer';

	---Who applied for an web developer?---
	
SELECT user.first_name, user.last_name, user.telephone, category.category
FROM user
INNER JOIN job_user ON user.user_id=job_user.user_id
INNER JOIN job ON job_user.job_id=job.job_id
INNER JOIN job_category ON job.job_id=job_category.job_id
INNER JOIN category ON job_category.category_id=category.category_id
WHERE category.category='web developer';

	
	---How many of the jobs are part-time jobs?---

SELECT COUNT(job.job_type) 
FROM job
where job.job_type='part-time';
