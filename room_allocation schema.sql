create table basic_details(
	stud_rollno varchar(10) primary key,
    stud_fname varchar(50) not null,
    stud_mname varchar(50),
    stud_lname varchar(50),
    stud_email varchar(255) unique not null,
    adm_year int not null,
    gender enum('Male', 'Female', 'Other') not null,
    stud_phone char(10) not null
);
create table room_type(
	roll_no varchar(10) primary key,
	room_prf1 enum('AC: Triple Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater') not null,
    room_prf2 enum('AC: Triple Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater') not null,
    room_prf3 enum('AC: Triple Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater') not null,
    room_prf4 enum('AC: Triple Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater') not null,
    partner1_roll varchar(10),
    partner1_name varchar(100),
    partner2_roll varchar(10),
    partner2_name varchar(100),
    bld_grp varchar(5) not null,
    fd_choice enum('Veg', 'Non-veg') not null,
    adm_region enum('Delhi', 'Outside Delhi', 'DASA') not null,
    chronic_prob varchar(100),
    staying_hostel enum('Yes', 'No') not null,
    foreign key (roll_no) references basic_details(stud_rollno)
    on delete cascade
    on update cascade
);
-- adding 2 new columns to accomodate for sign and profile photo in the db
alter table room_type add profile_photo blob not null;
alter table room_type add signature blob not null;

create table delhi_region(
	roll_no varchar(10) primary key,
    allotment_priority varchar(100),
    dist_dtu int not null,
    foreign key (roll_no) references room_type(roll_no)
    on delete cascade
    on update cascade
);

create table academic_details(
	roll_no varchar(10) primary key,
	cgpa decimal(3, 2) not null,
    course enum('Btech', 'Mtech', 'PhD', 'B.Design', 'M.Design', 'M.Sc', 'MBA', 'IMSC') not null,
    back_paper integer not null,
    last_institute varchar(100),
    foreign key (roll_no) references room_type(roll_no)
	on delete cascade
    on update cascade
);

-- bank account details of 
create table bank_details(
	roll_no varchar(10) primary key,
	bank_name varchar(100),
    bank_holder_name varchar(100),
    acc_no varchar(20),
    bank_ifsc varchar(20),
    bank_branch varchar(100),
    bank_address varchar(255),
    foreign key (roll_no) references room_type(roll_no)
    on delete cascade
    on update cascade
);

-- parent details of students.
create table parent_details(
	roll_no varchar(10) primary key,
	parent_type enum('Father', 'Mother') not null,
    parent_name varchar(100) not null,
    parent_mobno char(10) not null,
    parent_email varchar(255) not null,
    parent_occupation varchar(255),
    parent_designation varchar(100),
    p_office_addr varchar(255), 
    p_office_no varchar(50),
    foreign key (roll_no) references room_type(roll_no)
    on delete cascade
    on update cascade
);

-- current and permanent addresses of student. Included a is_same_addr flag which is FALSE when curr_address is same as perm_address
create table student_address(
	roll_no varchar(10) primary key,
    curr_address text not null,
    is_same_addr bool not null,
    perm_address text not null,
    foreign key (roll_no) references room_type(roll_no)
    on delete cascade
    on update cascade
);

-- local guardian details 
create table lcl_guardian_details(
	roll_no varchar(10) primary key,
	guardian_name varchar(100) not null,
    guardian_phno char(10) not null,
    guardian_email varchar(255) not null,
    guardian_occupation varchar(100) not null,
    guardian_addr text not null,
    foreign key (roll_no) references room_type(roll_no)
    on delete cascade
    on update cascade
);

-- branches of btech course. (only for students who opted for btech course in academic_details table) 
create table branches(
	roll_no varchar(10) primary key,
    course enum('AE', 'BT', 'CE', 'CH', 'CO', 'EC', 'EE', 'EL', 'EN', 'EP', 'IT', 'MC', 'ME', 'PE', 'PS', 'SE') not null,
    foreign key (roll_no) references room_type(roll_no)
    on delete cascade
    on update cascade
);


-- allotment results
-- use hostel id instead of roll no
create table allot_results(
	roll_no varchar(10) primary key,
    hostel_name varchar(50),
    room_no varchar(10),
    room_type enum('AC: Triple Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater') not null,
    hostel_id varchar(10) unique not null,
    foreign key (roll_no) references room_type(roll_no)
    on delete cascade
    on update cascade
);

alter table allot_results add column hostel_id varchar(10) unique not null;

create table ac_triple_room(
	hostel_name varchar(50) not null,
    room_no varchar(10) unique not null,
    hostel_id1 varchar(10) unique not null,
    hostel_id2 varchar(10) unique not null,
    hostel_id3 varchar(10) unique not null,
    foreign key (hostel_id1) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
	foreign key (hostel_id2) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
    foreign key (hostel_id3) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
	foreign key (hostel_name) references hostels.hostel_warden_info(hostel_name)
		on delete cascade
		on update cascade
    
);

create table nonac_single_room(
	hostel_name varchar(50) not null,
    room_no varchar(10) unique not null,
    hostel_id1 varchar(10) unique not null,
    foreign key(hostel_id1) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
    foreign key (hostel_name) references hostels.hostel_warden_info(hostel_name)
		on delete cascade
		on update cascade
    
);

create table nonac_double_room(
	hostel_name varchar(50) not null,
    room_no varchar(10) unique not null,
    hostel_id1 varchar(10) unique not null,
    hostel_id2 varchar(10) unique not null,
    foreign key(hostel_id1) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
	foreign key(hostel_id2) references allot_results(hostel_id)
		on delete cascade
		on update cascade
        
);

create table nonac_triple_room(
	hostel_name varchar(50) not null,
    room_no varchar(10) unique not null,
    hostel_id1 varchar(10) unique not null,
    hostel_id2 varchar(10) unique not null,
    hostel_id3 varchar(10) unique not null,
    foreign key(hostel_id1) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
    foreign key(hostel_id2) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
    foreign key(hostel_id3) references allot_results(hostel_id)
		on delete cascade
		on update cascade,
    foreign key (hostel_name) references hostels.hostel_warden_info(hostel_name)
		on delete cascade
		on update cascade
    
);

