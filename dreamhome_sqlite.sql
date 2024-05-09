CREATE TABLE IF NOT EXISTS branch (
    branchNo TEXT PRIMARY KEY,
    street TEXT,
    city TEXT,
    postcode TEXT
);

INSERT INTO branch VALUES('B005','22 Deer Rd','London','SW1 4EH');
INSERT INTO branch VALUES('B007','16 Argyll St', 'Aberdeen','AB2 3SU');
INSERT INTO branch VALUES('B003','163 Main St', 'Glasgow','G11 9QX');
INSERT INTO branch VALUES('B004','32 Manse Rd', 'Bristol','BS99 1NZ');
INSERT INTO branch VALUES('B002','56 Clover Dr', 'London','NW10 6EU');

CREATE TABLE IF NOT EXISTS staff (
    staffNo TEXT PRIMARY KEY,
    fName TEXT,
    lName TEXT,
    position TEXT,
    sex TEXT,
    DOB DATE,
    salary INTEGER,
    branchNo TEXT,
    FOREIGN KEY (branchNo) REFERENCES branch(branchNo)
);

INSERT INTO staff VALUES('SL21','John','White','Manager','M','1965-10-01',30000,'B005');
INSERT INTO staff VALUES('SG37','Ann','Beech','Assistant','F','1980-11-10',12000,'B003');
INSERT INTO staff VALUES('SG14','David','Ford','Supervisor','M','1978-03-24',18000,'B003');
INSERT INTO staff VALUES('SA9','Mary','Howe','Assistant','F','1990-02-19',9000,'B007');
INSERT INTO staff VALUES('SG5','Susan','Brand','Manager','F','1960-06-03',24000,'B003');
INSERT INTO staff VALUES('SL41','Julie','Lee','Assistant','F','1985-06-13',9000,'B005');

CREATE TABLE IF NOT EXISTS privateOwner (
    ownerNo TEXT PRIMARY KEY,
    fName TEXT,
    lName TEXT,
    address TEXT,
    telNo TEXT,
    email TEXT,
    password TEXT
);

INSERT INTO privateOwner VALUES('CO46','Joe','Keogh','2 Fergus Dr. Aberdeen AB2 ','01224-861212', 'jkeogh@lhh.com', null);
INSERT INTO privateOwner VALUES('CO87','Carol','Farrel','6 Achray St. Glasgow G32 9DX','0141-357-7419', 'cfarrel@gmail.com', null);
INSERT INTO privateOwner VALUES('CO40','Tina','Murphy','63 Well St. Glasgow G42','0141-943-1728', 'tinam@hotmail.com', null);
INSERT INTO privateOwner VALUES('CO93','Tony','Shaw','12 Park Pl. Glasgow G4 0QR','0141-225-7025', 'tony.shaw@ark.com', null);

CREATE TABLE IF NOT EXISTS propertyForRent (
    propertyNo TEXT PRIMARY KEY,
    street TEXT,
    city TEXT,
    postcode TEXT,
    type TEXT,
    rooms INTEGER,
    rent INTEGER,
    ownerNo TEXT NOT NULL,
    staffNo TEXT,
    branchNo TEXT,
    FOREIGN KEY (ownerNo) REFERENCES privateOwner(ownerNo),
    FOREIGN KEY (staffNo) REFERENCES staff(staffNo),
    FOREIGN KEY (branchNo) REFERENCES branch(branchNo)
);

INSERT INTO propertyForRent VALUES('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007');
INSERT INTO propertyForRent VALUES('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005');
INSERT INTO propertyForRent VALUES('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40', NULL, 'B003');
INSERT INTO propertyForRent VALUES('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003');
INSERT INTO propertyForRent VALUES('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');
INSERT INTO propertyForRent VALUES('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003');

CREATE TABLE IF NOT EXISTS client (
    clientNo TEXT PRIMARY KEY,
    fName TEXT,
    lName TEXT,
    telNo TEXT,
    prefType TEXT,
    maxRent INTEGER,
    email TEXT
);

INSERT INTO client VALUES('CR76','John','Kay','0171-774-5632','Flat',425, 'john.kay@gmail.com');
INSERT INTO client VALUES('CR56','Aline','Steward','0141-848-1825','Flat',350, 'astewart@hotmail.com');
INSERT INTO client VALUES('CR74','Mike','Ritchie','01475-943-1728','House',750, 'mritchie@yahoo.co.uk');
INSERT INTO client VALUES('CR62','Mary','Tregear','01224-196720','Flat',600, 'maryt@hotmail.co.uk');

CREATE TABLE IF NOT EXISTS viewing (
    clientNo TEXT NOT NULL,
    propertyNo TEXT NOT NULL,
    viewDate DATE,
    comment TEXT
);

INSERT INTO viewing VALUES('CR56','PA14','2015-05-24','too small');
INSERT INTO viewing VALUES('CR76','PG4','2015-04-20','too remote');
INSERT INTO viewing VALUES('CR56','PG4','2015-05-26','');
INSERT INTO viewing VALUES('CR62','PA14','2015-05-14','no dining room');
INSERT INTO viewing VALUES('CR56','PG36','2015-04-28','');

CREATE TABLE IF NOT EXISTS registration (
    clientNo TEXT NOT NULL,
    branchNo TEXT NOT NULL,
    staffNo TEXT NOT NULL,
    dateJoined DATE,
    FOREIGN KEY (clientNo) REFERENCES client(clientNo),
    FOREIGN KEY (branchNo) REFERENCES branch(branchNo),
    FOREIGN KEY (staffNo) REFERENCES staff(staffNo)
);

INSERT INTO registration VALUES('CR76','B005','SL41','2015-01-13');
INSERT INTO registration VALUES('CR56','B003','SG37','2014-04-13');
INSERT INTO registration VALUES('CR74','B003','SG37','2013-11-16');
INSERT INTO registration VALUES('CR62','B007','SA9','2014-03-07');
