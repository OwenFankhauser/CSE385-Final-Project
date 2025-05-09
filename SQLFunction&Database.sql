-- SQL Script to Create Normalized Tables in MySQL (3NF)
-- Compatible with MySQL 8.0+ with spatial support

CREATE TABLE Ref (
    Ref_ID INT PRIMARY KEY AUTO_INCREMENT,
    Citation TEXT
);

CREATE TABLE Sites (
    Site_ID INT PRIMARY KEY,
    Site_Name VARCHAR(255),
    Site_Type VARCHAR(100),
    Shape POINT SRID 4326
);

CREATE TABLE Site_Features (
    Ftr_ID INT PRIMARY KEY,
    Site_ID INT,
    Feature_Name VARCHAR(255),
    Feature_Type VARCHAR(100),
    Shape POINT SRID 4326,
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID)
);

CREATE TABLE Minerals (
    Mineral_ID INT PRIMARY KEY AUTO_INCREMENT,
    Mineral_Name VARCHAR(255)
);

CREATE TABLE Site_Minerals (
    Site_ID INT,
    Mineral_ID INT,
    PRIMARY KEY (Site_ID, Mineral_ID),
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID),
    FOREIGN KEY (Mineral_ID) REFERENCES Minerals(Mineral_ID)
);

CREATE TABLE Production (
    Production_ID INT PRIMARY KEY AUTO_INCREMENT,
    Site_ID INT,
    Year INT,
    Material VARCHAR(255),
    Amount DECIMAL(15, 2),
    Unit VARCHAR(50),
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID)
);

CREATE TABLE Resources (
    Resource_ID INT PRIMARY KEY AUTO_INCREMENT,
    Site_ID INT,
    Resource_Type VARCHAR(255),
    Amount DECIMAL(15, 2),
    Unit VARCHAR(50),
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID)
);

CREATE TABLE Geology (
    Geology_ID INT PRIMARY KEY AUTO_INCREMENT,
    Site_ID INT,
    Lithology VARCHAR(255),
    Age VARCHAR(255),
    Structure VARCHAR(255),
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID)
);

CREATE TABLE Alteration (
    Alteration_ID INT PRIMARY KEY AUTO_INCREMENT,
    Site_ID INT,
    Alteration_Type VARCHAR(255),
    Description TEXT,
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID)
);

CREATE TABLE Host_Rocks (
    HostRock_ID INT PRIMARY KEY AUTO_INCREMENT,
    Site_ID INT,
    Rock_Type VARCHAR(255),
    Age VARCHAR(255),
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID)
);

CREATE TABLE References_Sites (
    Ref_ID INT,
    Site_ID INT,
    PRIMARY KEY (Ref_ID, Site_ID),
    FOREIGN KEY (Ref_ID) REFERENCES Ref(Ref_ID),
    FOREIGN KEY (Site_ID) REFERENCES Sites(Site_ID)
);

CREATE TABLE References_Features (
    Ref_ID INT,
    Ftr_ID INT,
    PRIMARY KEY (Ref_ID, Ftr_ID),
    FOREIGN KEY (Ref_ID) REFERENCES Ref(Ref_ID),
    FOREIGN KEY (Ftr_ID) REFERENCES Site_Features(Ftr_ID)
);
