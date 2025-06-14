create table surrender_room(
	roll_no varchar(10) primary key,
	stud_fname varchar(50) not null,
    stud_mname varchar(50),
    stud_lname varchar(50),
    room_no varchar(10) not null,
    academic_year varchar(10) not null,
    hostel_roll varchar(10) not null,
    date_of_surrender date not null,
    foreign key (roll_no) references room_allocation.basic_details(stud_rollno)
    on delete cascade
    on update cascade
);