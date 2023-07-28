use [master]
go

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS(SELECT name
          FROM sys.databases
          WHERE name = N'SWP_V1')
    BEGIN
        ALTER DATABASE SWP_V1 SET OFFLINE WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE SWP_V1 SET ONLINE;
        DROP DATABASE SWP_V1;
    END

create database SWP_V1
go

use SWP_V1
go

CREATE TABLE [user]
(
    id          INT IDENTITY PRIMARY KEY,
    username    nvarchar(255) not null unique,
    [password]  VARCHAR(255)  NOT NULL,
    email       NVARCHAR(255) NOT NULL,
    [name]      NVARCHAR(255) NOT NULL,
    telephone   varchar(15),
    amount      int,
    [disabled]  BIT           NOT NULL DEFAULT 0,
    created_at  date                   DEFAULT GETDATE(),
    modified_at date
);


GO

CREATE TABLE admin_account
(
    id          INT IDENTITY PRIMARY KEY,
    username    nvarchar(255) not null unique,
    [password]  VARCHAR(255)  NOT NULL,
    [name]      NVARCHAR(255) NOT NULL,
    phone       nvarchar(15),
    email       nvarchar(255),
    type_id     int,
    created_at  date                   DEFAULT GETDATE(),
    modified_at date,
    [disabled]  BIT           NOT NULL DEFAULT 0,
);

GO

CREATE TABLE courses_level
(
    id         INT IDENTITY PRIMARY KEY,
    level_name nvarchar(50)
)

GO

CREATE TABLE instructor_detail
(
    id     INT IDENTITY PRIMARY KEY,
    email  nvarchar(50),
    slug   nvarchar(50),
    img    nvarchar(255),
    [name] nvarchar(255),
    bio    NVARCHAR(255),
    [job]  NVARCHAR(255),
)

GO

CREATE TABLE categories
(
    id            INT IDENTITY PRIMARY KEY,
    slug          nvarchar(255),
    img           nvarchar(255),
    [name]        NVARCHAR(255) NOT NULL UNIQUE,
    name_vn       NVARCHAR(255) NOT NULL UNIQUE,
    [description] nvarchar(max),
);
GO

CREATE TABLE courses
(
    id             INT IDENTITY PRIMARY KEY,
    [name]         NVARCHAR(500) NOT NULL,
    slug           nvarchar(500) not null,
    [image]        NVARCHAR(255) NULL,
    [description]  nvarchar(max) NULL,
    price          float         NOT NULL,
    categories     int references categories (id),
    NumberEnrolled INT           null,
    [level]        int REFERENCES courses_level (id),
    Objectives     NVARCHAR(max),
    create_at      date                              DEFAULT GETDATE(),
    modified_at    date,
    modified_by    int references admin_account (id) default null,
    approve_at     date                              default null,
    [disabled]     BIT           NOT NULL            DEFAULT 0
);


GO

CREATE TABLE instructors
(
    instructors_id INT NOT NULL references instructor_detail (id),
    course_id      INT NOT NULL references courses (id),
    PRIMARY KEY (instructors_id, course_id)
);

GO
CREATE TABLE lessons
(
    id            INT IDENTITY PRIMARY KEY,
    course_id     INT           NOT NULL,
    title         NVARCHAR(500) NOT NULL,
    slug          nvarchar(500),
    [description] nvarchar(max) null,
    lessons_type  nvarchar(50),
    created_at    date          NOT NULL DEFAULT getdate(),
    isDisable     bit                    default 0,
    FOREIGN KEY (course_id) REFERENCES courses (id)
);



create table video
(
    id        INT IDENTITY PRIMARY KEY,
    lessons   int references lessons (id) unique,
    videoName nvarchar(255),
    videoLink nvarchar(max),
)
GO
create table Docs
(
    id      INT IDENTITY PRIMARY KEY,
    lessons int references lessons (id) unique,
    [content] nvarchar(max)
)
GO
create table [File]
(
    id        INT IDENTITY PRIMARY KEY,
    lessons   int references lessons (id) unique,
    file_name nvarchar(500)
)

GO

CREATE TABLE course_reviews
(
    id          INT IDENTITY PRIMARY KEY,
    [user_id]   INT  NOT NULL,
    course_id   INT  NOT NULL,
    rating      INT  NOT NULL,
    review_text nvarchar(max),
    created_at  date NOT NULL DEFAULT getdate(),
    FOREIGN KEY (user_id) REFERENCES [user] (id),
    FOREIGN KEY (course_id) REFERENCES courses (id)
);

CREATE TABLE enrollments
(
    user_id     INT  NOT NULL,
    course_id   INT  NOT NULL,
	price		float not null,
    enrolled_at date NOT NULL DEFAULT getdate(),
    PRIMARY KEY (user_id, course_id),
    FOREIGN KEY (user_id) REFERENCES [user] (id),
    FOREIGN KEY (course_id) REFERENCES courses (id)
);


GO

create table Recharge
(
    id            int identity
        primary key clustered,
    user_id       int,
    [status]        nvarchar(50),
    recharge_date datetime,
    amount        float,
    bankAccount   nvarchar(255),
    [description]   nvarchar(500)
);


GO
Create table FollowUS
(
    id            int identity primary key,
    gmail		varchar(255)
)
GO
create table NewsGroup
(
    id   int identity primary key clustered,
    Name nvarchar(255)
)
GO
create table NewsItem
(
    id  int identity primary key clustered,
    [Name]         varchar(255),
    Name_VN      nvarchar(255),
    href         varchar(255),
    slug         varchar(255),
    [Content]      varchar(max),
    Content_VN   nvarchar(max),
	[Description] nvarchar(255),
    created_date date,
	modified_date date,
	approve_date date ,
    [image]        varchar(100),
    Parent_id    int,
	Created_By int references admin_account(id),
	Modified_By int references admin_account(id),
    NewsGroup   int references NewsGroup (id)
)
--Created_By,Modified_By,
GO
INSERT INTO SWP_V1.dbo.Recharge (user_id, status, recharge_date, amount, bankAccount, description)
VALUES (-1, N'Error', N'2023-06-26 23:35:54.000', 599000, N'88888888', N'giao dich thu nghiem'),
       (-1, N'Error', N'2023-06-26 23:15:54.000', 599000, N'88888888', N'giao dich thu nghiem'),
       (-1, N'Error', N'2023-06-26 23:25:54.000', 599000, N'88888888', N'giao dich thu nghiem'),
       (1, N'Success', N'2023-06-26 23:45:54.000', 599000, N'88888888', N'giao dich thu nghiem');

GO
insert into admin_account (username, [password], [name], phone, email, [type_id], created_at, modified_at)
values (N'admin1', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'admin1', 0338627463,
        'academy@gmail.com', 1, '2022-05-14', '2022-05-14'),
       (N'admin2', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'admin2', null, null, 2,
        '2022-05-13', '2022-05-13'),
       (N'admin3', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'admin3', null, null, 2,
        '2022-05-12', '2022-05-14'),
       (N'admin4', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'admin4', null, null, 2,
        '2022-05-11', '2022-05-14'),
       (N'admin5', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'admin5', null, null, 2,
        '2022-05-10', '2022-05-14')
GO
INSERT INTO NewsGroup (Name) VALUES (N'Header'),(N'Footer'),(N'Slide'),(N'Contact'),(N'AboutUs'),(N'News');

GO
INSERT INTO NewsItem (Name, Name_VN, href, created_date, Created_by, NewsGroup) VALUES (N'Home', N'Trang Chủ', N'/SWP391_Group3/', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, created_date, Created_by, NewsGroup) VALUES (N'About', N'Giới Thiệu', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, href, created_date, Created_by, NewsGroup) VALUES (N'Instructor', N'Giảng Viên', N'/SWP391_Group3/list-instructor', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, created_date,Created_by, NewsGroup) VALUES (N'Course', N'Khóa Học', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, href,created_date, Created_by,NewsGroup) VALUES (N'News', N'Tin Tức', N'/SWP391_Group3/listNews', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, href, created_date,image,Created_by,NewsGroup) VALUES (N'Logo', N'/SWP391_Group3/', N'2023-06-19', N'/SWP391_Group3/images/home/logo.png', 1, 2);
INSERT INTO NewsItem (Name, href, created_date,image,Created_by,NewsGroup) VALUES (N'Logo', N'/SWP391_Group3/', N'2023-06-19', N'/SWP391_Group3/images/home/logo.jpg', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, created_date,Created_by,NewsGroup) VALUES (N'Our Courses', N'Khóa học của chúng tôi', N'2023-06-19', 1, 2);
INSERT INTO NewsItem (Name, Name_VN, created_date,Created_by,NewsGroup) VALUES (N'Contact', N'Liên Hệ', N'2023-06-19', 1, 2);
INSERT INTO NewsItem (Name, Name_VN,created_date,image,Created_by,NewsGroup) VALUES (N'Various courses', N'Khóa Học Đa Dạng', N'2023-06-19', N'/SWP391_Group3/images/home/imghome1.jpg', 1, 3);
INSERT INTO NewsItem (Name, Name_VN, created_date, image,Created_by, NewsGroup) VALUES (N'Quality teachers team', N'Đội Ngũ Giáo Viên Chất Lượng', N'2023-06-19', N'/SWP391_Group3/images/home/imghome2.jpg', 1, 3);
INSERT INTO NewsItem (Name, Name_VN, created_date, image, Created_by,NewsGroup) VALUES (N'Learn every where', N'Học Mọi Lúc Mọi Nơi', N'2023-06-19', N'/SWP391_Group3/images/home/imghome3.jpg',1, 3);

--about type
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, NewsGroup) values('AboutUs', N'Giới thiệu', '/SWP391_Group3/viewAbout?type=13','/SWP391_Group3/viewAbout/about-us-13', 1, 5)
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, NewsGroup) values('Mission',N'Sứ mệnh','/SWP391_Group3/viewAbout?type=14', '/SWP391_Group3/viewAbout/mission-14', 1, 5)

--aboutUs
INSERT INTO NewsItem (Name, Name_VN, Content, Content_VN, Parent_id, Created_By) 
VALUES ('About Us', N'Giới thiệu', 'We provide users with the necessary knowledge and skills to develop themselves, improve their professional and professional qualifications.  access to new career opportunities. By providing quality and effective courses,  This website helps learners save time and money for finding and participating in live courses. ', 
N'Chúng tôi cung cấp cho người dùng những kiến thức, kỹ năng cần thiết để phát triển bản thân, nâng cao trình độ chuyên môn, nghiệp vụ.  tiếp cận với các cơ hội nghề nghiệp mới. Bằng cách cung cấp các khóa học chất lượng và hiệu quả,  Trang web này giúp người học tiết kiệm thời gian và tiền bạc cho việc tìm kiếm và tham gia các khóa học trực tiếp.', 
13, 1),
('Philosophy', N'Triết lý', 'Bring value to customers: The website should focus on providing high quality courses,  meet the learning needs of users and bring real value to customers.',
 N'Mang lại giá trị cho khách hàng: Trang web nên tập trung vào việc cung cấp các khóa học chất lượng cao,  đáp ứng nhu cầu học tập của người dùng và mang lại giá trị thực cho khách hàng.',
14, 1),
('Rule', N'Luật lệ', 'Students need to be given the most favorable conditions to learn. The learning environment should be designed so that students  can access learning materials and participate in learning activities easily.',
N'Học sinh cần được tạo điều kiện thuận lợi nhất để học tập. Môi trường học tập phải được thiết kế sao cho học sinh  có thể truy cập tài liệu học tập và tham gia các hoạt động học tập một cách dễ dàng.'
, 14, 1),
('The key to success', N'Chìa khóa thành công', 'Proper study planning is very important. You need to plan what to learn and how to learn.  Make sure your plan is specific, clear, and has a clear timetable.', 
N'Lập kế hoạch học tập thích hợp là rất quan trọng. Bạn cần lên kế hoạch học những gì và học như thế nào.  Hãy đảm bảo kế hoạch của bạn cụ thể, rõ ràng và có thời gian biểu rõ ràng.', 14, 1)

--news id = 19
INSERT INTO NewsItem (Name, Name_VN, slug, created_by, NewsGroup) 
values('News Hot', N'Tin Nóng', 'news-hot-19', 1, 6),
('News Sale', N'Tin Tức Giảm Giá', 'news-hot-20', 1, 6),
('Top News', N'Tin Mới Nhất', 'news-hot-21', 1, 6)

--news details id=22
INSERT INTO NewsItem (Name, slug, Content, [description], image, Parent_id, Created_By, approve_date)
Values('New Course', 'new-course-22', 'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14',
'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14', 
'/SWP391_Group3/images/news/newimg4.jpg' ,21,1, '2023-06-18')
INSERT INTO NewsItem (Name, slug, Content, [description], image, Parent_id, Created_By, approve_date)
Values('New Update', 'new-course-23', 'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14',
'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%.', 
'/SWP391_Group3/images/news/newimg3.jpg' ,19,1, '2023-06-20')
INSERT INTO NewsItem (Name, slug, Content, [description], image, Parent_id, Created_By, approve_date)
Values('New Sale', 'new-sale-24', 'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14',
'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%.', 
'/SWP391_Group3/images/news/newimg2.jpg' ,20, 1, '2023-06-19')
INSERT INTO NewsItem (Name, slug, Content, [description], image, Parent_id, Created_By, approve_date)
Values('New Course', 'new-course-25', 'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14',
'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14', 
'/SWP391_Group3/images/news/newimg4.jpg' ,21,1, '2023-06-20')

INSERT INTO NewsItem (Name, slug, Content, [description], image, Parent_id, Created_By, approve_date)
Values('New Sale', 'new-sale-26', 'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14',
'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14', 
'/SWP391_Group3/images/news/newimg2.jpg' ,20,1, null)

INSERT INTO NewsItem(Name, Name_VN, Content, Created_by, NewsGroup) values('phone company', N'Thông tin liên hệ', '0762034981', 1, 4)
INSERT INTO NewsItem(Name, Name_VN, Content, Created_by, NewsGroup) values('email company', N'Hòm thư điện tử', 'academyswpg3@gmail.com', 1, 4)

INSERT INTO NewsItem(Name, Name_VN, Content, href, Created_by, Parent_id) values('Phone number: ', N'Đường dây nóng: ',  '0762034981', 'tel://', 1, 9)
INSERT INTO NewsItem(Name, Name_VN, Content, href, Created_by, Parent_id) values('Email: ', N'Hòm thư điện tử: ', 'academyswpg3@gmail.com', 'mailto://academyswpg3@gmail.com', 1,  9)


INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id) values('AboutUs', N'Giới thiệu', '/SWP391_Group3/viewAbout?type=13','/SWP391_Group3/viewAbout/about-us-13', 1, 2)
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id) values('Mission',N'Sứ mệnh','/SWP391_Group3/viewAbout?type=14', '/SWP391_Group3/viewAbout/mission-14', 1, 2)

INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id) values('My Course',N'Khoá Học Của Tôi','/SWP391_Group3/mycourseprofile/myCourse', '/SWP391_Group3/mycourseprofile/myCourse' , 1, 4)
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id) values('All Course',N'Tất Cả Khoá Học','/SWP391_Group3/listcourse', '/SWP391_Group3/listcourse', 1, 4)

INSERT INTO NewsItem(Name, name_vn, href, slug, Created_by, Parent_id) values('Web Development', N'Lập Trình Web', '/SWP391_Group3/listcoursebycategory', '/web-development-1', 1,  8)
INSERT INTO NewsItem(Name, name_vn, href, slug, Created_by, Parent_id) values('AI', N'Trí Tuệ Nhân Tạo', '/SWP391_Group3/listcoursebycategory', '/ai-2', 1,  8)
INSERT INTO NewsItem(Name, name_vn, href, slug, Created_by, Parent_id) values('Mobile Development', N'Lập Trình Di Động', '/SWP391_Group3/listcoursebycategory', '/mobile-development-3', 1,  8)
GO



--insert bang user


Insert into [user] (username, [password], email, [name], telephone, amount)
values ('john_doe', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'john_doe@example.com',
        'John Doe', '555-1234', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('jane_smith', 'daaad6e5604e8e17bd9f108d91e26afe6281dac8fda0091040a7a6d7bd9b43b5', 'jane_smith@example.com',
        'Jane Smith', '555-5678', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('bob_jones', '9b0eb22aef89516d6fb4b31ccf008a68abe0d10a3fc606316389613eccf96854', 'bob_jones@example.com',
        'Bob Jones', '555-9012', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('sara_davis', 'c6ba91b90d922e159893f46c387e5dc1b3dc5c101a5a4522f03b987177a24a91', 'sara_davis@example.com',
        'Sara Davis', '555-3456', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('mike_jackson', '5efc2b017da4f7736d192a74dde5891369e0685d4d38f2a455b6fcdab282df9c', 'mike_jackson@example.com',
        'Mike Jackson', '555-7890', 10000);


go

INSERT INTO instructor_detail (email, img, [name], bio, [job], slug)
VALUES ('john.doe@example.com', '/SWP391_Group3/images/instructors/1.jpg', 'John Doe',
        'John is a seasoned software developer with 10+ years of experience. He specializes in object-oriented programming and has worked on several large-scale projects.',
        'Senior Developer', 'john-doe-1'),
       ('jane.smith@example.com', '/SWP391_Group3/images/instructors/2.jpg', 'Jane Smith',
        'Jane is a data analyst with a passion for statistics. She holds a PhD in Mathematics and has worked on numerous research projects.',
        'Data Analyst', 'jane-smith-2'),
       ('mark.jones@example.com', '/SWP391_Group3/images/instructors/3.jpg', 'Mark Jones',
        'Mark is a cyber security expert with over 15 years of experience. He has worked for several Fortune 500 companies and is a sought-after speaker at security conferences.',
        'Security Consultant', 'mark-jones-3'),
       ('sarah.liu@example.com', '/SWP391_Group3/images/instructors/4.jpg', 'Sarah Liu',
        'Sarah is an AI researcher with expertise in natural language processing. She has published several papers on the subject and is currently working on a cutting-edge chatbot project.',
        'AI Researcher', 'sarah-liu-4'),
       ('tom.wilson@example.com', '/SWP391_Group3/images/instructors/5.jpg', 'Tom Wilson',
        'Tom is a web designer who specializes in user experience (UX) design. He has worked on several high-profile websites and is known for his clean and modern designs.',
        'UX Designer', 'tom-wilson-5');


--Insert data
insert into categories(slug, name, name_vn, description)
values ('web-development-1', 'Web Development', N'Lập Trình Web', 'HTML, CSS3, JavaScript, Php, ReactJS'),
       ('ai-2', 'AI', N'Trí Tuệ Nhân Tạo', 'Python, Machine Learning, Deep Learning'),
       ('mobile-development-3', 'Mobile Development', N'Lập Trình Di Động', 'Flutter, Typescript, Kotlin/Java, Swift')


insert into courses_level(level_name)
values ('Ease'),
       ('Medium'),
       ('Hard')

GO
-- Inserting a record for a Web Development course
INSERT INTO courses (slug, [name], [image], [description], price, categories, NumberEnrolled, [level],
                     Objectives,
                     approve_at)
VALUES ('full-stack-web-developer-bootcamp-1', 'Full Stack Web Developer Bootcamp',
        '/SWP391_Group3/images/course/2.jpg',
        'Learn how to build full stack web applications using popular web technologies like HTML5, CSS3, JavaScript, Node.js, MongoDB, and React.',
        199.99, 1, 2, 3,
        'Understand the basics of web development. Build a RESTful API using Node.js and Express.Use React for frontend development.',
        '2023-01-25'),
       ('flutter-&-firebase---build-real-world-ios-and-android-apps-2',
        'Flutter & Firebase - Build Real-World iOS and Android Apps', '/SWP391_Group3/images/course/3.jpg',
        'Learn how to build real-world mobile app projects using Flutter and Firebase, including chat apps, social networks, and more.',
        299.99, 3, 1, 3,
        'Understand the basics of Flutter and Dart programming language. Build a complete mobile app project using Firebase for authentication, storage, and real-time communication. Deploy the app to Google Play Store and Apple App Store.',
        '2023-01-25'),
       ('javascript:-the-complete-guide-3', 'JavaScript: The Complete Guide', '/SWP391_Group3/images/course/4.jpg',
        'Master JavaScript programming language from beginner to advanced level, including ES6 features, asynchronous programming, OOP, and more.',
        0, 1, 1, 2,
        'Understand the basics of JavaScript programming language. Use modern ES6 features like arrow functions, template literals, and destructuring. Implement asynchronous programming using promises and async/await.',
        '2023-01-25'),
       ('data-science-and-machine-learning-bootcamp-4', 'Data Science and Machine Learning Bootcamp',
        '/SWP391_Group3/images/course/5.jpg',
        'Learn how to build data pipelines, perform exploratory data analysis, implement machine learning algorithms, and more using Python and popular libraries like Pandas, NumPy, Matplotlib, and scikit-learn.',
        249.99, 2, 1, 2,
        'Understand the basics of data science and machine learning. Build a complete data pipeline using Python and Pandas. Implement various machine learning algorithms using scikit-learn and evaluate model performance.',
        '2023-01-25'),
       ('the-complete-sql-bootcamp-5', 'The Complete SQL Bootcamp', '/SWP391_Group3/images/course/6.jpg',
        'Master SQL database programming language from beginner to advanced level, including complex queries, joins, subqueries, and more.',
        129.99, 1, 99.99, 2,
        '1Understand the basics of SQL database programming language. Write complex queries using joins, subqueries, and window functions. Create and modify tables, indexes, and views.',
        '2023-01-25'),
       ('natural-language-processing-with-python-6', 'Natural Language Processing with Python',
        '/SWP391_Group3/images/course/7.jpg',
        'Learn how to process and analyze human language data using Python and popular libraries like NLTK and spaCy.',
        149.99, 2, 1, 3,
        'Understand the basics of natural language processing. Use Python and NLTK for text preprocessing, tokenization, and POS tagging. Implement various NLP techniques like sentiment analysis, named entity recognition, and topic modeling.',
        '2023-01-25'),
       ('ios-swift-the-complete-ios-app-development-bootcamp-7',
        'iOS & Swift - The Complete iOS App Development Bootcamp', '/SWP391_Group3/images/course/8.jpg',
        'Learn how to build iOS mobile applications using Swift programming language and popular frameworks like UIKit, CoreData, and Firebase.',
        299.99, 3, NULL, 3,
        'Understand the basics of Swift programming language. Build user interfaces using storyboard and UIKit. Use CoreData for data persistence and Firebase for real-time communication and authentication.',
        '2023-01-25'),
       ('python-django-web-development-todo-application-8', 'Python Django Web Development: To-Do Application',
        '/SWP391_Group3/images/course/9.jpg',
        'Learn how to build a real-world web application using Python and Django framework, including user authentication, CRUD operations, and more.',
        79.99, 1, NULL, 1,
        'Understand the basics of web development using Python and Django. Build a complete web application project with user authentication, CRUD operations, and RESTful API endpoints. Deploy the app to Heroku.',
        '2023-01-25'),
       ('deep-reinforcement-learning-with-python-9', 'Deep Reinforcement Learning with Python',
        '/SWP391_Group3/images/course/10.jpg',
        'Learn how to apply deep reinforcement learning techniques to solve complex problems in robotics, game playing, and more.',
        199.99, 2, NULL, 2,
        'Understand the basics of reinforcement learning and deep learning. Build various deep reinforcement learning algorithms using Python and TensorFlow. Apply the models to solve real-world problems like game playing and robotics.',
        '2023-01-25');

GO

insert into instructors(instructors_id, course_id)
values (1, 1),
       (5, 2),
       (2, 3),
       (2, 4),
       (2, 5),
       (4, 6),
       (5, 7),
       (2, 8),
       (3, 9)
GO
INSERT INTO course_reviews ([user_id], course_id, rating, review_text)
VALUES (1, 1, 4, 'This course was very helpful and informative.'),
       (2, 2, 3, 'The course content was good but the instructor could have been more engaging.'),
       (3, 3, 5, 'I loved everything about this course! The instructor was knowledgeable and engaging.'),
       (4, 4, 2, 'This course did not meet my expectations. The material was too basic.'),
       (5, 5, 4, 'Great course with practical examples and exercises.'),
       (1, 6, 5, 'This course exceeded my expectations! I learned so much and had a great time.'),
       (2, 7, 3, 'The course had some good information but it was poorly organized.'),
       (3, 8, 4, 'I would definitely recommend this course to others.'),
       (4, 1, 2, 'This course was a waste of time. The instructor was unorganized and unprepared.'),
       (5, 2, 5, 'I learned a lot from this course and the instructor was very helpful.'),
       (1, 3, 3, 'The course had some good information but it was presented in a boring way.'),
       (2, 4, 4, 'The course had a good balance of theory and practice.'),
       (3, 5, 5, 'This is one of the best courses I have ever taken! The instructor was amazing.'),
       (4, 6, 3, 'The course had some useful information but it was too basic for my needs.'),
       (5, 7, 2, 'I was disappointed with this course. The material was outdated and not very useful.'),
       (1, 8, 4, 'This course provided a good introduction to the topic.'),
       (2, 9, 5, 'I loved this course! The instructor was engaging and the material was relevant.'),
       (3, 1, 3, 'The course had some good information but there were a lot of technical difficulties.'),
       (4, 2, 4, 'I found this course very helpful for my job.'),
       (5, 3, 2, 'This course was a waste of money. I did not learn anything new.');
GO
INSERT INTO lessons (course_id, title, [description], lessons_type)
VALUES (1, 'Introduction to HTML', 'Learn the basics of HTML and how to create web pages with it.', 'Docs'),
       (1, 'Advanced HTML Concepts',
        'Explore more advanced HTML techniques for creating complex layouts and forms.', 'Docs'),
       (1, 'Introduction to CSS', 'Learn how to style your web pages using CSS.', 'Docs'),
       (1, 'CSS Layouts', 'Explore different layout techniques using CSS Flexbox and Grid.', 'Docs'),
       (1, 'JavaScript Basics', 'Learn the basics of JavaScript programming language.', 'Docs'),
       (1, 'DOM Manipulation', 'Learn how to manipulate the Document Object Model (DOM) with JavaScript.', 'Docs'),
       (1, 'Introduction to Node.js',
        'Learn the basics of Node.js and how to build server-side applications with it.', 'Docs'),
       (2, 'Introduction to Flutter', 'Learn the basics of Flutter and set up your development environment.', 'Docs'),
       (2, 'Building Your First Flutter App', 'Build a simple Flutter app with basic functionality.', 'Docs'),
       (2, 'Working with Widgets', 'Learn about the various types of widgets in Flutter and how to use them.', 'Docs'),
       (2, 'NewsGroup and Routing', 'Explore how to navigate between screens and handle routing in a Flutter app.',
        'Docs'),
       (2, 'Firebase Authentication', 'Learn how to integrate Firebase Authentication in a Flutter app.', 'Docs'),
       (3, 'Introduction to JavaScript',
        'Learn the basics of JavaScript programming language and how it is used in web development.', 'Docs'),
       (3, 'JavaScript Data Types and Variables',
        'Explore the different data types in JavaScript and how to work with variables.', 'Docs'),
       (3, 'Operators and Control Structures',
        'Learn about operators and control structures such as if statements and loops in JavaScript.', 'Docs'),
       (3, 'Functions and Scope',
        'Explore the concept of functions in JavaScript and how scope works in the language.', 'Docs'),
       (3, 'Objects and Arrays', 'Learn how to work with objects and arrays in JavaScript.', 'Docs'),
       (3, 'Document Object Model (DOM)',
        'Explore the Document Object Model (DOM) and how to manipulate it using JavaScript.', 'Docs'),
       (3, 'Events and Event Handling',
        'Learn how to handle events in JavaScript and how they are used in web development.', 'Docs'),
       (3, 'Asynchronous JavaScript',
        'Explore asynchronous programming in JavaScript and how to work with callbacks, promises, and async/await.',
        'Docs'),
       (3, 'APIs and AJAX',
        'Learn how to use APIs and AJAX to fetch data from external sources and update your web pages dynamically.',
        'Docs'),
       (3, 'ES6+ Features',
        'Explore the new features introduced in ECMAScript 6 (ES6) and how they can improve your JavaScript code.',
        'Docs'),
       (4, 'Introduction to Data Science', 'Learn what data science is and its importance in today''s world.', 'Docs'),
       (4, 'Data Cleaning and Preprocessing',
        'Explore techniques for cleaning and preprocessing data before analysis.', 'Docs'),
       (4, 'Exploratory Data Analysis (EDA)',
        'Learn how to perform EDA on datasets using Python libraries such as Pandas and Matplotlib.', 'Docs'),
       (4, 'Model Selection and Evaluation',
        'Explore different machine learning models and how to select and evaluate the best one for your problem.',
        'Docs'),
       (4, 'Supervised Learning',
        'Learn about supervised learning techniques such as regression and classification, and how to implement them using Python libraries such as Scikit-Learn.',
        'Docs'),
       (5, 'Introduction to SQL', 'Learn the basics of SQL and why it is important in data management.', 'Docs'),
       (5, 'Data Definition Language (DDL)',
        'Explore SQL commands for creating and modifying database structures, such as tables and indexes.', 'Docs'),
       (5, 'Data Manipulation Language (DML)',
        'Learn how to use SQL commands for querying and manipulating data, such as SELECT, UPDATE, and DELETE.',
        'Docs'),
       (5, 'Aggregate Functions and Grouping',
        'Explore SQL functions for performing calculations on groups of data, such as SUM and AVG.', 'Docs'),
       (5, 'Joins and Subqueries', 'Learn how to combine data from multiple tables using joins and subqueries.',
        'Docs'),
       (6, 'Introduction to Natural Language Processing',
        'Learn what natural language processing is and its importance in data science.', 'Docs'),
       (6, 'Text Preprocessing',
        'Explore techniques for cleaning and preprocessing text data before analysis, such as tokenization and stop word removal.',
        'Docs'),
       (6, 'Sentiment Analysis',
        'Learn how to perform sentiment analysis on text data using machine learning techniques and Python libraries like NLTK.',
        'Docs'),
       (6, 'Named Entity Recognition',
        'Explore techniques for identifying and extracting named entities from text data, such as people and locations.',
        'Docs'),
       (7, 'Introduction to iOS Development',
        'Learn the basics of iOS app development and the tools needed to get started.', 'Docs'),
       (7, 'Swift Programming Language',
        'Explore the Swift programming language and how it is used in iOS app development.', 'Docs'),
       (8, 'Introduction to Django', 'Learn the basics of web development with Python and the Django framework.',
        'Docs')

GO
-- insert bang enrollments


Insert INTO FollowUS (gmail) values('daoquangkhai2002@gmail.com'),
('khaidqhe163770@fpt.edu.vn'),
('tuandao090202@gmail.com'),
('nguyentuanninh02@gmail.com'),
('nguyentuanninh30@gmail.com'),
('ninhnthe161847@fpt.edu.vn'),
('giangnthe163050@fpt.edu.vn'),
('Nghiachinhmh@gmail.com')
