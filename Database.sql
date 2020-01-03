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
    Pages INT not null,
    Printed INT not null,
    Returned INT not null,
    constraint parent foreign key (ParentNP) references NewsPaper(Name)
    on delete cascade
);

create table Article(
    Path varchar(100) primary key not null,
    ParentPaper int,
    CatID int,
    Title varchar(25) not null,
    Summary text not null,
    KW varchar(25) not null,
    ord int not null,
    Status enum('accepted','to_be_revised','rejected') not null,
    Revised boolean not null,
    constraint ParentPaper foreign key (ParentPaper) references Paper(PaperNo)
    on delete cascade,
    constraint Category foreign key (CatID) references Category(ID)
    on delete cascade
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

