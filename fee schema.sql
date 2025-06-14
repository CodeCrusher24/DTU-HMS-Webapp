create table fee_record(
	roll_no varchar(10) primary key,
    fee_paid decimal(10,2) not null,
    fee_due decimal(10,2) not null,
    foreign key (roll_no) references room_allocation.room_type(roll_no)
);