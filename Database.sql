create database newspaper;
use newspaper;
create table NewsPaper(
    Name varchar(25) primary key not null,
    Frequency varchar(25) not null,
    Owner varchar(25) not null
);

create table Paper(
    PaperNo INT primary key not null auto_increment,
    ParentNP varchar(25),
    Rel DATE not null,
    Pages TINYINT not null,
    Printed INT not null,
    Returned INT not null,
    constraint parent foreign key (ParentNP) references NewsPaper(Name)
    on delete cascade
);

create table Article(
    Path varchar(100) primary key not null,
    ParentPaper int,
    CatID int,
    Auth varchar(25),
    Title varchar(25) not null,
    Summary text not null,
    KW varchar(25) not null,
    ord int not null,
    acdate DATE not null,
    page int not null,
    length int not null,
    Status enum('accepted','to_be_revised','rejected') not null,
    Revised boolean not null,
    constraint ParentPaper foreign key (ParentPaper) references Paper(PaperNo)
    on delete cascade,
    constraint Category foreign key (CatID) references Category(ID)
    on delete cascade,
    constraint Author foreign key(Auth) references Journalist(Username)
    on update cascade
);

create table Worker(
    email varchar(50) primary key not null,
    ParentNP varchar(25),
    DOB date not null,
    Name varchar(25) not null,
    Surname varchar(25) not null,
    Salary float not null,
    Username varchar(25) not null,
    Password varchar(25) not null,
    constraint NP foreign key (ParentNP) references NewsPaper(Name)
    on update cascade,
    role enum('Journalist','Admin','Editor In Chief','Publisher') not null
);

create table Category(
    ID int primary key not null auto_increment,
    ParentID int not null,
    Name varchar(25) not null,
    Description text not null
);

create table Journalist(
    Username varchar(25) primary key not null,
    Experience int not null,
    CV text not null
);

create table Admin(
    Username varchar(25) primary key not null,
    Duties text not null,
    Phone int(10) not null,
    Street varchar(25) not null,
    Number int not null,
    City varchar(25) not null
);

create table EiC(
    Username varchar(25) primary key not null,
    npname varchar(25) not null,
    constraint newspaper foreign key (npname) references NewsPaper(Name)
    on delete cascade
);

create table Publisher(
    Username varchar(25) primary key not null,
    npname varchar(25) not null,
    constraint nppr foreign key (npname) references NewsPaper(Name)
    on delete cascade
);

insert into NewsPaper values ('Kathimerini','Kathe Mera','Idioktitis 1');
insert into NewsPaper values ('Parapolitika','Kathe Evdomada','Idioktitis 2');

Insert into Paper values (null,'Kathimerini',curdate(),20,1000,200);
Insert into Paper values (null,'Kathimerini',20191225,22,1000,200);
Insert into Paper values (null,'Parapolitika',curdate(),35,2000,386);
Insert into Paper values (null,'Parapolitika',20200113,35,2000,386);

Insert into Worker values ('Worker1@Kathimerini.gr','Kathimerini',20170914,'Dimitrios','Papadopoulos',897.35,'DimPap','Password','Journalist');
Insert into Worker values ('Worker2@Kathimerini.gr','Kathimerini',20170914,'Ioannis','Georgiou',732.68,'JohnGeo','Password','Editor In Chief');
Insert into Worker values ('Worker3@Kathimerini.gr','Kathimerini',20170914,'Giorgos','Dimitriadis',922.94,'GioDim','Password','Admin');
Insert into Worker values ('Worker4@Kathimerini.gr','Kathimerini',20170914,'Kostas','Papadopoulos',1258.87,'KosPap','Password','Publisher');

Insert into Worker values ('Worker1@Parapolitika.gr','Parapolitika',20170914,'Dimitrios','Papadopoulos',897.35,'DimPap','Password','Editor In Chief');
Insert into Worker values ('Worker2@Parapolitika.gr','Parapolitika',20170914,'Ioannis','Georgiou',732.68,'JohnGeo','Password','Publisher');
Insert into Worker values ('Worker3@Parapolitika.gr','Parapolitika',20170914,'Giorgos','Dimitriadis',922.94,'GioDim','Password','Journalist');
Insert into Worker values ('Worker4@Parapolitika.gr','Parapolitika',20170914,'Kostas','Papadopoulos',1258.87,'KosPap','Password','Admin');

Insert into Admin values ('Giodim','Diaxeirish','2610123456','Korinthou','35','Patra');
Insert into Admin values ('KosPap','Diaxeirish','2610654321','Maizwnos','188','Patra');

Insert into EiC values ('JohnGeo','Kathimerini');
Insert into EiC values ('DimPap','Parapolitika');

Insert into Journalist values ('DimPap',3,'Kati Liga');
Insert into Journalist values ('GioDim',8,'Kati Pio Liga');

Insert into Publisher values ('KosPap','Kathimerini');
Insert into Publisher values ('JohnGeo','Parapolitika');

Insert into Category values (null,null,'Politiki','Ta nea ths politikis');
Insert into Category values (null,null,'Koinwnia','Ta nea ths koinwnias');

Insert into Article values ('C://Users/Administrator/Article1.Docx',1,1,'DimPap','Titlos','Kati simantiko sunevh','politiki',1,20201127,1,3,'to_be_revised',1);
Insert into Article values ('C://Users/Administrator/Article2.Docx',2,2,'GioDim','Titlos Titlos Titlos','Kati akoma pio simantiko sunevh','astunomia',1,20201127,3,2,'accepted',1);