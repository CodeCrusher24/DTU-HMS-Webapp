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

-- allotment results (to be completed)
create table allot_results(
	
);

-- basic info mandatory for student registration on hostel website portal
INSERT INTO basic_details VALUES
('2023DTU001', 'Rohan', 'Kumar', 'Singh', 'rohan.singh@dtu.ac.in', 2023, 'Male', '9876543210'),
('2023DTU002', 'Priya', 'Anita', 'Verma', 'priya.verma@dtu.ac.in', 2023, 'Female', '9876543211'),
('2023DTU003', 'Aarav', NULL, 'Sharma', 'aarav.sharma@dtu.ac.in', 2022, 'Male', '9876543212'),
('2023DTU004', 'Ishita', 'Rani', 'Patel', 'ishita.patel@dtu.ac.in', 2021, 'Female', '9876543213'),
('2023DTU005', 'Dev', 'Prakash', 'Yadav', 'dev.yadav@dtu.ac.in', 2023, 'Male', '9876543214');

-- room preferences and related info
INSERT INTO room_type VALUES
('2023DTU001', 'AC: Triple Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater', '2023DTU003', 'Aarav Sharma', NULL, NULL, 'B+', 'Veg', 'Delhi', 'Asthma', 'Yes', '', ''),
('2023DTU002', 'NON AC: Double Seater', 'NON AC: Triple Seater', 'AC: Triple Seater', 'NON AC: Single Seater', NULL, NULL, NULL, NULL, 'O-', 'Non-veg', 'Outside Delhi', '', 'No', '', ''),
('2023DTU003', 'NON AC: Single Seater', 'NON AC: Single Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater', NULL, NULL, NULL, NULL, 'A+', 'Veg', 'Delhi', 'Diabetes', 'Yes', '', ''),
('2023DTU004', 'AC: Triple Seater', 'NON AC: Double Seater', 'NON AC: Triple Seater', 'NON AC: Single Seater', NULL, NULL, NULL, NULL, 'AB-', 'Veg', 'DASA', '', 'No', '', ''),
('2023DTU005', 'NON AC: Triple Seater', 'AC: Triple Seater', 'NON AC: Double Seater', 'NON AC: Single Seater', NULL, NULL, NULL, NULL, 'B-', 'Non-veg', 'Delhi', '', 'Yes', '', '');

-- details of students living in Delhi
INSERT INTO delhi_region VALUES
('2023DTU001', 'Medical Condition', 12),
('2023DTU003', 'Academic Excellence', 18);

-- academic details of students 
INSERT INTO academic_details VALUES
('2023DTU001', 8.91, 'Btech', 0, 'Springfield Public School'),
('2023DTU002', 9.12, 'Mtech', 1, 'IIT Kharagpur'),
('2023DTU003', 7.55, 'PhD', 0, 'St. Xavier School'),
('2023DTU004', 8.10, 'MBA', 0, 'Amity University'),
('2023DTU005', 9.25, 'Btech', 0, 'Ryan International');

-- Bank account details
INSERT INTO bank_details VALUES
('2023DTU001', 'SBI', 'Rohan Singh', 'SBIN000001', 'SBIN0001234', 'DTU Branch', 'Bawana Road, Delhi'),
('2023DTU002', 'HDFC', 'Priya Verma', 'HDFC00002', 'HDFC001234', 'Rohini Branch', 'Rohini Sector 7'),
('2023DTU003', 'ICICI', 'Aarav Sharma', 'ICICI00003', 'ICICI004567', 'Pitampura', 'North Delhi'),
('2023DTU004', 'PNB', 'Ishita Patel', 'PNB00004', 'PNB006789', 'Dwarka', 'South-West Delhi'),
('2023DTU005', 'BOB', 'Dev Yadav', 'BOB00005', 'BOB009876', 'Delhi Cantt', 'New Delhi');

-- details of parents of students
INSERT INTO parent_details VALUES
('2023DTU001', 'Father', 'Mahesh Singh', '9811122233', 'mahesh.singh@email.com', 'Engineer', 'Manager', 'Noida Office', '1204567890'),
('2023DTU002', 'Mother', 'Sunita Verma', '9877788899', 'sunita.verma@email.com', 'Teacher', 'Lecturer', 'Delhi Public School', '9819988776'),
('2023DTU003', 'Father', 'Rajeev Sharma', '9988776655', 'rajeev.sharma@email.com', 'Doctor', 'Surgeon', 'AIIMS Delhi', '8800556677'),
('2023DTU004', 'Mother', 'Anjali Patel', '9123456789', 'anjali.patel@email.com', 'Lawyer', 'Advocate', 'Patel Chambers', '9123987654'),
('2023DTU005', 'Father', 'Suresh Yadav', '9345678901', 'suresh.yadav@email.com', 'Banker', 'Clerk', 'BOB Connaught Place', '9111223344');

-- address of students
INSERT INTO student_address VALUES
('2023DTU001', '123 Delhi Street, Rohini', TRUE, ''),
('2023DTU002', '456 Green Park, Delhi', FALSE, '789 New Town, Gurgaon'),
('2023DTU003', 'Plot 12, East Delhi', TRUE, ''),
('2023DTU004', 'Vasant Vihar, New Delhi', FALSE, 'MG Road, Bengaluru'),
('2023DTU005', 'Mayur Vihar, Phase 1', FALSE, 'Sector 49, Noida');

-- info of local guardians
INSERT INTO lcl_guardian_details VALUES
('2023DTU001', 'Rakesh Malhotra', '9876543123', 'rakesh.malhotra@email.com', 'Accountant', 'West Patel Nagar'),
('2023DTU002', 'Kiran Mehra', '9876543219', 'kiran.mehra@email.com', 'Professor', 'Saket'),
('2023DTU003', 'Sanjay Thakur', '9876500001', 'sanjay.thakur@email.com', 'Architect', 'Vikaspuri'),
('2023DTU004', 'Nikita Bansal', '9876511223', 'nikita.bansal@email.com', 'Entrepreneur', 'Greater Kailash'),
('2023DTU005', 'Manoj Mehta', '9876523456', 'manoj.mehta@email.com', 'Retired Officer', 'Karol Bagh');

-- btech branch 
INSERT INTO branches VALUES
('2023DTU001', 'CO'),
('2023DTU005', 'ME');