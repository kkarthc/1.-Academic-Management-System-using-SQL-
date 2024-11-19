-- Create the StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY, -- Unique identifier for each student
    STU_NAME VARCHAR(50),   -- Student name
    DOB DATE,               -- Date of birth
    PHONE_NO VARCHAR(15),   -- Phone number
    EMAIL_ID VARCHAR(50),   -- Email address
    ADDRESS VARCHAR(100)    -- Residential address
);

-- Create the CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY, -- Unique identifier for each course
    COURSE_NAME VARCHAR(50),   -- Course name
    COURSE_INSTRUCTOR_NAME VARCHAR(50) -- Instructor name
);

-- Create the EnrollmentInfo table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY, -- Unique identifier for enrollment
    STU_ID INT,                    -- References StudentInfo table
    COURSE_ID INT,                 -- References CoursesInfo table
    ENROLL_STATUS VARCHAR(20),     -- Enrollment status (e.g., Enrolled/Not Enrolled)
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);
-- Insert data into StudentInfo table
INSERT INTO StudentInfo VALUES
(1, 'Karthick', '2000-01-01', '1234567890', 'karthick@example.com', '123 Chennai'),
(2, 'Aishwarya', '1998-05-15', '9876543210', 'aishwarya@example.com', '456 Anna Nagar'),
(3, 'Athish Vikram', '1999-03-12', '1122334455', 'athishVikram@example.com', '789 Airport'),
(4, 'Abdul', '1997-07-21', '5566778899', 'abdul@example.com', '321 Perungudi'),
(5, 'Shaji', '2001-02-10', '9988776655', 'shaji@example.com', '654 Padur'),
(6, 'Rangaraj', '1996-11-05', '4433221100', 'rangaraj@example.com', '987 Adyar'),
(7, 'Archana', '2002-06-18', '7766554433', 'archana@example.com', '111 Mylapore'),
(8, 'Subash', '1995-04-25', '2233445566', 'subash@example.com', '222 Perambur');

-- Insert data into CoursesInfo table
INSERT INTO CoursesInfo VALUES
(101, 'Mathematics', 'John'),
(102, 'Physics', 'Saran'),
(103, 'Chemistry', 'Saranya'),
(104, 'Biology', 'Anish'),
(105, 'Computer Science', 'Manish'),
(106, 'English Literature', 'Sethu'),
(107, 'History', 'Srinivasan'),
(108, 'Philosophy', 'SanjeevRA');

-- Insert data into EnrollmentInfo table
INSERT INTO EnrollmentInfo VALUES
(1, 1, 101, 'Enrolled'),
(2, 1, 102, 'Enrolled'),
(3, 2, 103, 'Enrolled'),
(4, 3, 104, 'Enrolled'),
(5, 4, 105, 'Not Enrolled'),
(6, 5, 106, 'Enrolled'),
(7, 6, 107, 'Enrolled'),
(8, 7, 108, 'Not Enrolled'),
(9, 8, 101, 'Enrolled'),
(10, 4, 102, 'Enrolled'),
(11, 3, 103, 'Not Enrolled'),
(12, 6, 104, 'Enrolled');

-- Retrieve student details and their enrollment status
SELECT 
    S.STU_NAME, 
    S.PHONE_NO, 
    S.EMAIL_ID, 
    E.ENROLL_STATUS
FROM 
    StudentInfo S
JOIN 
    EnrollmentInfo E ON S.STU_ID = E.STU_ID;
-- Retrieve courses in which the specific student is enrolled
SELECT 
    C.COURSE_NAME
FROM 
    CoursesInfo C
JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE 
    E.STU_ID = 7;
-- Retrieve all course details
SELECT 
    COURSE_NAME, 
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo;
-- Retrieve details for a specific course
SELECT 
    *
FROM 
    CoursesInfo
WHERE 
    COURSE_ID = 101;
-- Retrieve details for multiple courses
SELECT 
    *
FROM 
    CoursesInfo
WHERE 
    COURSE_ID IN (101, 102);

-- Test Query 1: Retrieve student details and their enrollment status
SELECT 
    S.STU_ID, 
    S.STU_NAME, 
    S.PHONE_NO, 
    S.EMAIL_ID, 
    E.ENROLL_STATUS
FROM 
    StudentInfo S
JOIN 
    EnrollmentInfo E ON S.STU_ID = E.STU_ID;

-- Test Query 2: List courses for a specific student
SELECT 
    E.STU_ID, 
    C.COURSE_NAME
FROM 
    EnrollmentInfo E
JOIN 
    CoursesInfo C ON E.COURSE_ID = C.COURSE_ID
WHERE 
    E.STU_ID = 1;
-- Test Query 3: Retrieve course details
SELECT 
    COURSE_ID, 
    COURSE_NAME, 
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo;
-- Test Query 4: Count students enrolled in each course
SELECT 
    C.COURSE_NAME, 
    COUNT(E.STU_ID) AS Student_Count
FROM 
    CoursesInfo C
LEFT JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY 
    C.COURSE_NAME;
-- Count students in each course
SELECT 
    C.COURSE_NAME, 
    COUNT(E.STU_ID) AS Student_Count
FROM 
    CoursesInfo C
LEFT JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY 
    C.COURSE_NAME;
-- Retrieve students for a specific course
SELECT 
    S.STU_NAME
FROM 
    StudentInfo S
JOIN 
    EnrollmentInfo E ON S.STU_ID = E.STU_ID
WHERE 
    E.COURSE_ID = 101;
-- Count students for each instructor
SELECT 
    C.COURSE_INSTRUCTOR_NAME, 
    COUNT(E.STU_ID) AS Student_Count
FROM 
    CoursesInfo C
LEFT JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY 
    C.COURSE_INSTRUCTOR_NAME;
-- Find students in multiple courses
SELECT 
    S.STU_NAME
FROM 
    StudentInfo S
JOIN 
    EnrollmentInfo E ON S.STU_ID = E.STU_ID
GROUP BY 
    S.STU_NAME
HAVING 
    COUNT(E.COURSE_ID) > 1;
-- Retrieve courses ordered by student count
SELECT 
    C.COURSE_NAME, 
    COUNT(E.STU_ID) AS Student_Count
FROM 
    CoursesInfo C
LEFT JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY 
    C.COURSE_NAME
ORDER BY 
    Student_Count DESC;




