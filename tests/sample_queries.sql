/* Retrievals */
-- Retrieve the room numbers of all Emergency patient rooms.
SELECT
    room_no
FROM
    PATIENT_ROOM
WHERE
    type = 'Emergency';

-- Retrieve the social security number of all staff members that primarily reside in Bole sub city.
SELECT
    Fname,
    Mname,
    Lname
FROM
    STAFF
WHERE
    subcity = 'Bole';

-- Retrieve the names of all patients with blood type O ordered alphabetically based on their first names.
SELECT
    Fname,
    Mname,
    Lname
FROM
    PATIENT
WHERE
    blood_type = 'O'
ORDER BY
    Fname;

-- Retrieve the price, dosage and medication of the prescription given to the patient Abel Y. Yisak.
SELECT
    price,
    dosage,
    medication
FROM
    PRESCRIPTION AS PT,
    PRESCRIBES AS PE,
    PATIENT AS P
WHERE
    PT.presc_num = PE.presc_num
    AND PE.Pssn = P.ssn
    AND P.Fname = 'Abel'
    AND P.Lname = 'Yisak';

-- Retrieve the room number and type of the room occupied by the patient with a social security number of 0000000333.
SELECT
    PR.room_no,
    PR.type
FROM
    OCCUPIES AS O,
    PATIENT AS P,
    PATIENT_ROOM AS PR
WHERE
    O.Pssn = P.ssn
    AND PR.room_no = O.room
    AND P.ssn = 333;

-- Retrieve all the laboratory room numbers in the medical center.
SELECT
    room_no
FROM
    OPERATIONAL_ROOM
WHERE
    type = 'Laboratory';

-- Retrieve the phone numbers of all emergency contacts of Abebe Balcha Teferi.
SELECT
    EC.phone_no
FROM
    PATIENT AS P,
    EMERGENCY_CONTACT AS EC
WHERE
    P.ssn = EC.Pssn
    AND P.Fname = 'Abebe'
    AND P.Mname = 'Balcha'
    AND P.Lname = 'Teferi';

-- Retrieve the full names of all patients that are overseen by Dr. Jonka S. Shmels ordered alphabetically by their first names.
SELECT
    P.Fname,
    P.Mname,
    P.Lname
FROM
    PATIENT AS P,
    OVERSEES AS O,
    STAFF AS S
WHERE
    P.ssn = O.Pssn
    AND O.Sssn = S.ssn
    AND S.Fname = 'Jonka'
    AND S.Lname = 'Shmels'
    AND S.role = 'Doctor'
ORDER BY
    P.Fname;

-- Retrieve the full names and roles of staff members who are super intended by Dr. Debora K. Eshetu.
SELECT
    I.Fname,
    I.Mname,
    I.Lname,
    I.role
FROM
    STAFF AS S,
    STAFF AS I
WHERE
    S.ssn = I.super_intendent
    AND S.Fname = 'Debora'
    AND S.Lname = 'Eshetu';

-- Retrieve the full names and appointment dates of all patients who have reserved an appointment with Dr. Debora K. Eshetu.
SELECT
    P.Fname,
    P.Mname,
    P.Lname,
    HA.date
FROM
    PATIENT AS P,
    STAFF AS S,
    HAS_APPOINTMENT AS HA
WHERE
    P.ssn = HA.Pssn
    AND S.ssn = HA.Sssn
    AND S.Fname = 'Debora'
    AND S.Lname = 'Eshetu';

/* Updates */
-- The price of the prescription with number 1114 has been mistakenly entered as 5000 when the correct price was 500.
UPDATE PRESCRIPTION
SET
    price = 500
WHERE
    presc_num = 1114;

-- All appointments that have been made prior to August 2023 need to be moved to August 1, 2023.
UPDATE HAS_APPOINTMENT
SET
    date = 20230801
WHERE
    date < 20230731;

-- The social security number of the patient Yonas Yusuf Tubata was actually 443 instead of the value that is currently in the database.
UPDATE PATIENT
SET
    ssn = 0000000443
WHERE
    Fname = "Yonas"
    AND Mname = "Yusuf"
    AND Lname = "Tubata";

-- The social security number of Dr. Chobra Petu Wako was mistakenly filled as 107 when it was 170.
UPDATE STAFF
SET
    ssn = 170
WHERE
    ssn = 107;

-- To increase the salaries of all staff members who oversee a patient from the Yeka subcity by 1,000:
UPDATE STAFF
SET
    salary = salary + 1000
WHERE
    ssn IN (
        SELECT
            O.Sssn
        FROM
            PATIENT AS P,
            OVERSEES AS O
        WHERE
            O.Pssn = P.ssn
            AND P.subcity = 'Yeka'
    );

/* Deletions */
-- Patient Sofia Yasin Kedir has requested that all her data be deleted from the database. 
DELETE FROM PATIENT
WHERE
    Fname = 'Sofia'
    AND Mname = 'Yasin'
    AND Lname = 'Kedir';

-- The medical center has decided to delete the data of all the nurses.
DELETE FROM STAFF
WHERE
    role = 'nurse';

-- The medical center has decided to remove occupation of all rooms whose residents have blood type AB.
DELETE FROM OCCUPIES
WHERE
    Pssn IN (
        SELECT
            ssn
        FROM
            PATIENT
        WHERE
            blood_type = 'AB'
    );