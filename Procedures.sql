/*1o procedure*/
delimiter $
create procedure showarticles(in number int,in name varchar(25))
begin
    declare tempnum int;
    declare tempname varchar(25);
    select PaperNo,Title,Auth,acdate,page,length from Paper inner join Article where PaperNo=number and ParentNP like name order by Article.ord ASC;
end$
delimiter ;

/*2o procedure*/
delimiter $
create procedure salarycalc(in usr varchar(25))
begin
    declare tempdate DATE;
    declare exp int;
    declare tempsalary float;
    select DOB into tempdate from Worker where Username=usr;
    set @tempdate = CURDATE() - @tempdate;
    select Experience into exp from Journalist where Username=usr;
    set @exp = Experience + exp;
    select Salary into tempsalary from Worker where Username=usr;
    set @tempsalary = @tempsalary + @tempsalary * (0,5 * @exp);
    update Worker
    set 
        Salary = @tempsalary
    where 
        Username = usr;
end$
delimiter ;

/*1o trigger*/
DELIMITER $
CREATE TRIGGER new_wrkr_sal
BEFORE INSERT ON Worker
FOR EACH ROW
BEGIN 
    SET NEW.Salary=650;
END $
DELIMITER ;

/*2o trigger*/
delimiter $
create trigger check_EIC
before insert on Article
for each row
begin
    declare tempauth varchar(25);
    declare temprole enum('Journalist','Admin','Editor In Chief','Publisher');
    set tempauth = NEW.Auth;
    select role into temprole from Worker where Username=tempauth;
    if @temprole = 'Editor In Chief' then
        set NEW.Status = 'accepted';
    end if;
end $
delimiter ;

/*3o trigger*/
delimter $
create trigger check_capacity
before insert on Article
for each row
begin
    declare templength int(11);
    set @templength = NEW.length;
    declare tempparent varchar(25);
    set @tempparent = NEW.ParentPaper;
    declare tempsum int(10);
    select sum(Page) into tempsum from Article where ParentPaper=tempparent group by ParentPaper;
    if @tempsum >= ParentPaper.length then 
        signal sqlstate value '45000' set
        message_text = 'To Fullo exei gemisei.H eisagwgh den mporei na oloklirwthei!';
    end if;
end$
delimiter ;