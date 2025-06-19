-- hostel and warden information
create table hostel_warden_info(
	hostel_name varchar(100) primary key,
    warden_name varchar(100) not null,
    asst_warden varchar(100) not null
);

-- type of rooms in hostel and whether girls or boys hostel
create table hostel_type(
	hostel_name varchar(100) primary key,
    type_hostel enum('Girls', 'Boys') not null,
    room_type enum('AC: Triple Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater') not null,
    foreign key (hostel_name) references hostel_warden_info(hostel_name)
    on delete cascade
    on update cascade
);

-- hostel capacities(total rooms, student capacity, occupied rooms, vacant rooms)
create table hostel_cap(
	hostel_name varchar(100) primary key,
	total_rooms integer not null,
    stud_capacity integer not null,
    occupied_rooms integer not null,
    vacant_rooms integer not null,
    foreign key (hostel_name) references hostel_warden_info(hostel_name)
    on delete cascade
    on update cascade
);

-- asset inventory
create table requests(
	sno integer auto_increment primary key,
    item_name varchar(255) not null,
    item_qty integer not null,
    reason text not null,
    remarks text
);

create table request_approval(
	sno integer primary key,
    request_status enum('Submitted', 'Under process', 'Approved', 'Rejected', 'Completed') default 'Submitted',
    foreign key (sno) references requests(sno)
    on delete cascade
    on update cascade
);

