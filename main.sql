CREATE DATABASE OPAL;

USE OPAL;

CREATE TABLE
    PATIENT (
        Fname VARCHAR(15),
        Mname VARCHAR(15),
        Lname VARCHAR(15),
        ssn INT (10) PRIMARY KEY,
        sex CHAR(1),
        doB DATE,
        blood_type VARCHAR(2),
        phone_no INT (15),
        subcity VARCHAR(12),
        woreda VARCHAR(12),
        house_no INT (4)
    );

CREATE TABLE
    EMERGENCY_CONTACT (
        Pssn INT (10),
        Fname VARCHAR(15),
        Lname VARCHAR(15),
        subcity VARCHAR(12),
        woreda VARCHAR(12),
        house_no INT (4),
        phone_no INT (15),
        PRIMARY KEY (Pssn, Fname),
        FOREIGN KEY (Pssn) REFERENCES PATIENT (ssn)
    );

CREATE TABLE
    PATIENT_ROOM (room_no INT (4) PRIMARY KEY, type VARCHAR(15));

CREATE TABLE
    OCCUPIES (
        Pssn INT (10),
        room INT (4),
        PRIMARY KEY (Pssn, room),
        FOREIGN KEY (room) REFERENCES PATIENT_ROOM (room_no)
    );

ALTER TABLE OCCUPIES ADD FOREIGN KEY (Pssn) REFERENCES PATIENT (ssn);

CREATE TABLE
    STAFF (
        Fname VARCHAR(15),
        Mname VARCHAR(15),
        Lname VARCHAR(15),
        ssn INT (10) PRIMARY KEY,
        sex CHAR(1),
        phone_no INT (15),
        email VARCHAR(25),
        subcity VARCHAR(12),
        woreda VARCHAR(12),
        house_no INT (4),
        role VARCHAR(25),
        start_date DATE,
        salary INT (7),
        super_intendent INT (10),
        works_in INT (4)
    );

ALTER TABLE STAFF ADD FOREIGN KEY (super_intendent) REFERENCES STAFF (ssn);

CREATE TABLE
    OPERATIONAL_ROOM (
        room_no INT (4) PRIMARY KEY,
        type VARCHAR(15),
        manager_ssn INT (10),
        FOREIGN KEY (manager_ssn) REFERENCES STAFF (ssn)
    );

ALTER TABLE STAFF ADD FOREIGN KEY (works_in) REFERENCES OPERATIONAL_ROOM (room_no);

CREATE TABLE
    OVERSEES (
        Pssn INT (10),
        Sssn INT (10),
        PRIMARY KEY (Pssn, Sssn),
        FOREIGN KEY (Sssn) REFERENCES STAFF (ssn),
        FOREIGN KEY (Pssn) REFERENCES PATIENT (ssn)
    );

CREATE TABLE
    HAS_APPOINTMENT (
        Pssn INT (10),
        Sssn INT (10),
        Date DATE,
        PRIMARY KEY (Pssn, Sssn),
        FOREIGN KEY (Pssn) REFERENCES PATIENT (ssn),
        FOREIGN KEY (Sssn) REFERENCES STAFF (ssn)
    );

CREATE TABLE
    PRESCRIBES (
        Pssn INT (10),
        Sssn INT (10),
        presc_num INT (15) UNIQUE NOT NULL,
        PRIMARY KEY (Pssn, Sssn),
        FOREIGN KEY (Pssn) REFERENCES PATIENT (ssn),
        FOREIGN KEY (Sssn) REFERENCES STAFF (ssn)
    );

CREATE TABLE
    PRESCRIPTION (
        presc_num INT (15) PRIMARY KEY,
        price DECIMAL(10, 2),
        date DATE,
        dosage VARCHAR(20),
        medication VARCHAR(25),
        FOREIGN KEY (presc_num) REFERENCES PRESCRIBES (presc_num)
    );