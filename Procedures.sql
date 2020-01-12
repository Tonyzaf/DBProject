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

/*2o trigger*/
delimiter $
create trigger check EIC
after insert on Article
for each row
begin
    declare tempauth varchar(25);
    declare temprole enum('Journalist','Admin','Editor In Chief','Publisher') not null;
    set @tempauth = NEW.Auth;
    select role into temprole from Worker where Username=tempauth;
    if @temprole = 'Editor In Chief' then
        set NEW.Status = 'accepted';
    end if;
end $
delimiter ;