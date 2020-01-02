create database newspaper;
use newspaper;
create table NewsPaper(
    Name varchar(25) primary key not null,
    Frequency varchar(25) not null,
    Owner varchar(25) not null
);

create table Paper(
    PaperNo INT primary key not null auto_increment,
    Rel DATE not null,
    Pages INT not null,
    Printed INT not null,
    Returned INT not null
);

create table Article(
    Path varchar(100) primary key not null,
    Title varchar(25) not null,
    Summary text not null,
    KW varchar(25) not null,
    ord int not null,
    Status enum('accepted','to_be_revised','rejected') not null,
    Revised boolean not null
);