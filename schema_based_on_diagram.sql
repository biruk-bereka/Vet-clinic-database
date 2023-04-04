CREATE TABLE PATIENTS (
ID INT GENERATED ALWAYS AS IDENTITY,
NAME VARCHAR(255) NOT NULL,
DATE_OF_BIRTH DATE NOT NULL,

PRIMARY KEY(ID)
);

CREATE TABLE MEDICAL_HISTORIES (
    ID INT GENERATED ALWAYS AS IDENTITY,
    ADMITTED_AT TIMESTAMP,
    PATIENT_ID INT NOT NULL,
    STATUS VARCHAR(120),

    CONSTRAINT patient_fk
    FOREIGN KEY (PATIENT_ID)
    REFERENCES PATIENTS(ID),

    PRIMARY KEY(ID)
);

CREATE TABLE INVOICES (
    ID INT GENERATED ALWAYS AS IDENTITY, 
    TOTAL_AMOUNT DECIMAL NOT NULL,
    GENERATED_AT TIMESTAMP,
    PAYED_AT TIMESTAMP,
    MEDICAL_HISTORY_ID INT,

    CONSTRAINT medical_history_fk
    FOREIGN KEY (MEDICAL_HISTORY_ID)
    REFERENCES MEDICAL_HISTORIES(ID),

    PRIMARY KEY (ID)
);