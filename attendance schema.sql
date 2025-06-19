create table hostel_attendance(
	attendance_id int auto_increment primary key,
	roll_no varchar(10) not null,
    hostel_name varchar(100) not null,
    attendance_marked_time datetime not null,
    stud_status enum('Present', 'Absent', 'Leave') not null,
    foreign key (roll_no) references room_allocation.basic_details(stud_rollno)
		on delete cascade
		on update cascade,
    foreign key(hostel_name) references hostels.hostel_warden_info(hostel_name)
		on delete cascade
        on update cascade
);

create table mess_attendance(
	mess_attendance_id int auto_increment primary key,
    roll_no varchar(10) not null,
    mess_attendance_time datetime not null,
    stud_status enum('Present', 'Absent', 'Leave') not null,
    foreign key (roll_no) references room_allocation.basic_details(stud_rollno)
		on delete cascade
		on update cascade
);

