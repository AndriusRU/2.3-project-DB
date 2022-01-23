-- DROP TABLE IF EXISTS staff.gender;
-- DROP TABLE IF EXISTS staff.post;
-- DROP TABLE IF EXISTS staff.employee;
-- DROP TABLE IF EXISTS staff.employee_info;
-- DROP TABLE IF EXISTS staff.department;

DROP SCHEMA IF EXISTS staff CASCADE;
CREATE SCHEMA IF NOT EXISTS staff;

CREATE TABLE IF NOT EXISTS staff.gender (
	id serial4 NOT NULL,
	gender_name varchar(100) NOT NULL,
	CONSTRAINT gender_pk PRIMARY KEY (id),
	CONSTRAINT gender_un UNIQUE (gender_name)
);
-- Permissions
ALTER TABLE staff.gender OWNER TO py44;
GRANT ALL ON TABLE staff.gender TO py44;

CREATE TABLE IF NOT EXISTS staff.post (
	id serial4 NOT NULL,
	post_name varchar(100) NOT NULL,
	CONSTRAINT post_pk PRIMARY KEY (id),
	CONSTRAINT post_fk UNIQUE (post_name)
);
-- Permissions
ALTER TABLE staff.post OWNER TO py44;
GRANT ALL ON TABLE staff.post TO py44;

CREATE TABLE IF NOT EXISTS staff.employee (
	id serial4 NOT NULL,
	surname varchar(100) NOT NULL,
	first_name varchar(100) NOT NULL,
	second_name varchar(100) NOT NULL,
	birthday date NOT NULL,
	gender_id int4 NOT NULL,
	post_id int4 NOT NULL,
	CONSTRAINT employee_pk PRIMARY KEY (id),
	CONSTRAINT employee_gender_fk FOREIGN KEY (gender_id) REFERENCES staff.gender(id),
	CONSTRAINT employee_post_fk FOREIGN KEY (post_id) REFERENCES staff.post(id)
);
-- Permissions
ALTER TABLE staff.employee OWNER TO py44;
GRANT ALL ON TABLE staff.employee TO py44;

CREATE TABLE IF NOT EXISTS staff.employee_info (
	id serial4 NOT NULL,
	employee_id serial4 NOT NULL,
	email varchar(100) DEFAULT 'unspecified'::character varying,
	address varchar(255) DEFAULT 'unspecified'::character varying,
	phone_number varchar(100) DEFAULT 'unspecified'::character varying,
	CONSTRAINT employee_info_pk PRIMARY KEY (id),
	CONSTRAINT employee_info_fk FOREIGN KEY (employee_id) REFERENCES staff.employee(id)
);
-- Permissions
ALTER TABLE staff.employee_info OWNER TO py44;
GRANT ALL ON TABLE staff.employee_info TO py44;

CREATE TABLE IF NOT EXISTS staff.department (
	id serial4 NOT NULL,
	department_name varchar(100) NOT NULL,
	phone varchar(100) NOT NULL,
	head int4 NOT NULL,
	CONSTRAINT department_pk PRIMARY KEY (id),
	CONSTRAINT department_head_fk FOREIGN KEY (head) REFERENCES staff.employee(id)
);
-- Permissions
ALTER TABLE staff.department OWNER TO py44;
GRANT ALL ON TABLE staff.department TO py44;

-- Один сотрудник может быт начальником нескольких отделов (например на период замещения, пока открыта вакансия).
-- Если рассматривать упрощенно, то можно сделать связь 1-к-1, когда один человек может быть начальником только 1 отдела.
-- Также допускаем, что у отдела может быть только 1 начальник.

ALTER TABLE staff.employee ADD COLUMN department_id int4 NOT NULL;
ALTER TABLE staff.employee ADD CONSTRAINT employee_department_fk FOREIGN KEY (department_id) REFERENCES staff.department (id);