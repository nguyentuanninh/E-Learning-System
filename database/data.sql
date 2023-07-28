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
    id        INT IDENTITY PRIMARY KEY,
    lessons   int references lessons (id) unique,
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
    user_id     INT   NOT NULL,
    course_id   INT   NOT NULL,
    price       float not null,
    enrolled_at date  NOT NULL DEFAULT getdate(),
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
    [status]      nvarchar(50),
    recharge_date datetime,
    amount        float,
    bankAccount   nvarchar(255),
    [description] nvarchar(500)
);


GO
Create table FollowUS
(
    id    int identity primary key,
    gmail varchar(255)
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
    id            int identity primary key clustered,
    [Name]        nvarchar(255),
    Name_VN       nvarchar(255),
    href          varchar(255),
    slug          varchar(255),
    [Content]     nvarchar(max),
    Content_VN    nvarchar(max),
    [Description] nvarchar(255),
    created_date  date default getdate() not null,
    modified_date date,
    approve_date  date,
    [image]       nvarchar(100),
    Parent_id     int,
    Created_By    int references admin_account (id),
    Modified_By   int references admin_account (id),
    NewsGroup     int references NewsGroup (id)
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
INSERT INTO NewsGroup (Name)
VALUES (N'Header'),
       (N'Footer'),
       (N'Slide'),
       (N'Contact'),
       (N'AboutUs'),
       (N'News');

GO
INSERT INTO NewsItem (Name, Name_VN, href, created_date, Created_by, NewsGroup)
VALUES (N'Home', N'Trang Chủ', N'/SWP391_Group3/', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, created_date, Created_by, NewsGroup)
VALUES (N'About', N'Giới Thiệu', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, href, created_date, Created_by, NewsGroup)
VALUES (N'Instructor', N'Giảng Viên', N'/SWP391_Group3/list-instructor', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, created_date, Created_by, NewsGroup)
VALUES (N'Course', N'Khóa Học', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, href, created_date, Created_by, NewsGroup)
VALUES (N'News', N'Tin Tức', N'/SWP391_Group3/listNews', N'2023-06-19', 1, 1);
INSERT INTO NewsItem (Name, href, created_date, image, Created_by, NewsGroup)
VALUES (N'Logo', N'/SWP391_Group3/', N'2023-06-19', N'/SWP391_Group3/images/home/logo.png', 1, 2);
INSERT INTO NewsItem (Name, href, created_date, image, Created_by, NewsGroup)
VALUES (N'Logo', N'/SWP391_Group3/', N'2023-06-19', N'/SWP391_Group3/images/home/logo.jpg', 1, 1);
INSERT INTO NewsItem (Name, Name_VN, created_date, Created_by, NewsGroup)
VALUES (N'Our Courses', N'Khóa học của chúng tôi', N'2023-06-19', 1, 2);
INSERT INTO NewsItem (Name, Name_VN, created_date, Created_by, NewsGroup)
VALUES (N'Contact', N'Liên Hệ', N'2023-06-19', 1, 2);
INSERT INTO NewsItem (Name, Name_VN, created_date, image, Created_by, NewsGroup)
VALUES (N'Various courses', N'Khóa Học Đa Dạng', N'2023-06-19', N'/SWP391_Group3/images/home/imghome1.jpg', 1, 3);
INSERT INTO NewsItem (Name, Name_VN, created_date, image, Created_by, NewsGroup)
VALUES (N'Quality teachers team', N'Đội Ngũ Giáo Viên Chất Lượng', N'2023-06-19',
        N'/SWP391_Group3/images/home/imghome2.jpg', 1, 3);
INSERT INTO NewsItem (Name, Name_VN, created_date, image, Created_by, NewsGroup)
VALUES (N'Learn every where', N'Học Mọi Lúc Mọi Nơi', N'2023-06-19', N'/SWP391_Group3/images/home/imghome3.jpg', 1, 3);

--about type
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, NewsGroup)
values ('AboutUs', N'Giới thiệu', '/SWP391_Group3/viewAbout?type=13', '/SWP391_Group3/viewAbout/about-us-13', 1, 5)
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, NewsGroup)
values ('Mission', N'Sứ mệnh', '/SWP391_Group3/viewAbout?type=14', '/SWP391_Group3/viewAbout/mission-14', 1, 5)

--aboutUs
INSERT INTO NewsItem (Name, Name_VN, Content, Content_VN, Parent_id, Created_By)
VALUES ('About Us', N'Giới thiệu',
        'We provide users with the necessary knowledge and skills to develop themselves, improve their professional and professional qualifications.  access to new career opportunities. By providing quality and effective courses,  This website helps learners save time and money for finding and participating in live courses. ',
        N'Chúng tôi cung cấp cho người dùng những kiến thức, kỹ năng cần thiết để phát triển bản thân, nâng cao trình độ chuyên môn, nghiệp vụ.  tiếp cận với các cơ hội nghề nghiệp mới. Bằng cách cung cấp các khóa học chất lượng và hiệu quả,  Trang web này giúp người học tiết kiệm thời gian và tiền bạc cho việc tìm kiếm và tham gia các khóa học trực tiếp.',
        13, 1)
INSERT INTO NewsItem (Name, Name_VN, Content, Content_VN, Parent_id, Created_By)
VALUES ('Philosophy', N'Triết lý',
        'Bring value to customers: The website should focus on providing high quality courses,  meet the learning needs of users and bring real value to customers.',
        N'Mang lại giá trị cho khách hàng: Trang web nên tập trung vào việc cung cấp các khóa học chất lượng cao,  đáp ứng nhu cầu học tập của người dùng và mang lại giá trị thực cho khách hàng.',
        14, 1)
INSERT INTO NewsItem (Name, Name_VN, Content, Content_VN, Parent_id, Created_By)
VALUES ('Rule', N'Luật lệ',
        'Students need to be given the most favorable conditions to learn. The learning environment should be designed so that students  can access learning materials and participate in learning activities easily.',
        N'Học sinh cần được tạo điều kiện thuận lợi nhất để học tập. Môi trường học tập phải được thiết kế sao cho học sinh  có thể truy cập tài liệu học tập và tham gia các hoạt động học tập một cách dễ dàng.'
           , 14, 1)
INSERT INTO NewsItem (Name, Name_VN, Content, Content_VN, Parent_id, Created_By)
VALUES ('The key to success', N'Chìa khóa thành công',
        'Proper study planning is very important. You need to plan what to learn and how to learn.  Make sure your plan is specific, clear, and has a clear timetable.',
        N'Lập kế hoạch học tập thích hợp là rất quan trọng. Bạn cần lên kế hoạch học những gì và học như thế nào.  Hãy đảm bảo kế hoạch của bạn cụ thể, rõ ràng và có thời gian biểu rõ ràng.',
        14, 1)

--news id = 19
INSERT INTO NewsItem (Name, Name_VN, slug, created_by, NewsGroup)
values ('Blog', N'Chia sẻ', 'blog-19', 1, 6)
INSERT INTO NewsItem (Name, Name_VN, slug, created_by, NewsGroup)
values ('Front-end', N'Front-end', 'front-end-20', 1, 6)
INSERT INTO NewsItem (Name, Name_VN, slug, created_by, NewsGroup)
values ('Back-end', N'Back-end', 'news-hot-21', 1, 6)
GO

--news details id=22

INSERT INTO SWP_V1.dbo.NewsItem (Name, Name_VN, href, slug, Content, Content_VN, Description, created_date,
                                 modified_date, approve_date, image, Parent_id, Created_By, Modified_By, NewsGroup)
VALUES (N'Many programmers start to fear AI', null, null, N'many-programmers-start-to-fear-ai-22',
        N'<p>Many programmers and people in the technology industry are concerned about the risk of being taken over by AI.</p><p>On the anonymous network Blind, programmers are questioning whether AI will make their work meaningless, especially after ChatGPT created a fever. Dozens of articles about this issue were posted, while many people said that "the golden age of programmers is over".</p><p>"The job of software engineer is dying. ChatGPT is very good, and you are in a difficult position," a Microsoft programmer wrote. The article attracted 500 responses, some of which said that the programming industry was still stable, but many said that "all white-collar jobs are dying".</p><p>One person conducted a survey on Blind, asking if young software engineers were about to lose their jobs, and garnered more than 12,000 votes. 41.3% agreed, 37% said that job opportunities have not changed, while 21.7% confirmed that there is more job potential now.</p><p>Blind is a platform that allows participants to anonymously comment on their work and company. Account registrants must provide a job email address, title, location... so that the platform can assess their career status before being accepted to work. This social network also regularly sends verification requests via email after a certain time to determine if a person is still working at that company or not.</p><p>ChatGPT is used more and more in the office environment.</p><figure class="image"><img src="https://i1-sohoa.vnecdn.net/2023/04/29/chatgpt-update-5266-1674724795-3649-1682782382.jpg?w=0&amp;h=0&amp;q=100&amp;dpr=2&amp;fit=crop&amp;s=vrfpWa1DbD24ISYdeo4p7w"></figure><p>ChatGPT image on laptop. Photo: Searchengine Journal</p><p>Many speakers are worried about the future given the popularity of AI. One Google engineer said he was wondering if he should start over from scratch. An Amazon employee says the field they''ve been cultivating for the past 15 years is changing.</p><p>"I tried playing with GPT-4, the result scared and saddened me," this person said.</p><p>The anxiety comes as tech corporations bet on the future of AI. The company OpenAI has started training AI to learn and program software since the beginning of the year. American media reports that AI advancements like ChatGPT are starting to threaten the job security of software engineers. Emad Mostaque, CEO of Stability AI, even predicts that there will be no programmers in the next 5 years.</p><p>The tech world is also experiencing massive layoffs, prompting engineers to consider the possibility of not being able to maintain their current high salaries. The notion that learning to code is always a guarantee of work is also being erased.</p><p>Still, there are those who are optimistic that AI will benefit software engineers. One Shopify employee compared the current "dark sentiment to ChatGPT" to the negative statements about 5G, blockchain and Web3 in the past. Others expressed skepticism that companies are advanced enough to adopt AI technology comprehensively.</p><p>"All will be well. Think of AI as a productivity booster, not a competitor. We make it, not the other way around," said an engineer at Microsoft.</p>',
        null,
        N'Many programmers and people in the technology industry are concerned about the risk of being taken over by AI.',
        N'2023-07-12', null, N'2023-07-12',
        N'/SWP391_Group3/images/news/359733382_952047792515187_4370057778047321286_n.jpg', 19, 1, null, null);
INSERT INTO SWP_V1.dbo.NewsItem (Name, Name_VN, href, slug, Content, Content_VN, Description, created_date,
                                 modified_date, approve_date, image, Parent_id, Created_By, Modified_By, NewsGroup)
VALUES (N'IT engineers work ''selling the network'' to earn tens of millions', null, null,
        N'it-engineers-work-selling-the-network-to-earn-tens-of-millions-23',
        N'<p>"People like us have to ''plow'' hard all week, many nights have to sleep at the company''.</p><p>According to a recent survey, IT software personnel are among the highest-paid industries in Vietnam, with tens of millions of dong per month. With 1-3 years of experience, IT software personnel are paid 15-30 million VND, and over 5 years of experience is 30-50 million VND. For the IT industry, the salary is 13.8-25 million and 30-50 million, respectively.</p><p>Sharing about the job of an IT behind the salary that many people dream of, reader Thanh Ha commented: "I''m a female, used to be a Developer for nearly four years. I just got out of this industry. From my experience, I must admit that the number of years of experience in this industry is almost proportional to the salary.Although I know that working everywhere has its own difficulties and pressures, but I I also met many female colleagues who rose to the position of leader, or higher.</p><p>However, few people know that, in order to do that, people like us have to work hard all week, spend many nights at the company, especially when the deadline is near, thinking about it, I still can''t. Forget those days. After thinking for a while, I decided to quit my job, return to my hometown and apply for a job outside the industry. Although the salary is not as good as before, it is at least suitable for the living standard in the countryside and most importantly, I feel comfortable and less difficult."</p><p>Looking at IT jobs from the perspective of a new graduate looking for a job, NDT readers say: "It is a fact that currently IT engineers are at the level of ''sufficient supply and demand'', jobs for the field This depends a lot on other sectors, many of which are also being greatly affected by the global economic downturn.</p><p>It is very difficult for IT students who have just graduated from college to apply for a job, even applying for a half-year job without pay, but many companies still refuse. Most technology companies are prioritizing hiring experienced people who can fight right away, instead of hiring inexperienced people and taking time to train. It can be said that about 5 years ago, it was easy for IT students to find a job, but now the market is quite gloomy.</p><p>Meanwhile, acknowledging the pressures faced in the IT profession, but readers Eurthh believe that opportunities are always open to those who really make an effort: "Salary always comes with responsibility, dedication, and above all is to create maximum profit for the company.There is no such thing as ''sitting cool and eating a golden bowl'' and only working moderately and earning a high salary. receive the lowest possible salary or be fired soon by the company.In tough economic times, employees who can hold multiple roles in different stages of product development are always appreciated and bias.</p><p>Occupational diseases are available in every industry. Those who can adapt to the working environment will reduce the negative effects on health. The life expectancy of this industry is actually not low, there are people over 60 years old can still comfortably work in management or product development roles. Early dismissal is due to whether each person can meet the job or not. Take a look at this industry in the US and developed countries, we will see that this is a high-wage industry, employees work until retirement a lot (that is, working for more than 30 years).</p><p>Most occupations require positions for IT professionals and software developers; The more we move to digitization, the higher the demand for technology engineers will be. Therefore, right from the time when they are still studying majors in school, each person should also update their knowledge so that they can later apply and expand their career opportunities. People with the ability to embrace change and solid software knowledge should not worry about finding another opportunity, right?</p><p>No one knows the future, but everyone can know what to prepare to enter their future. Studying in the wrong industry, choosing the wrong profession is a big challenge, but it doesn''t mean the end. You just need to have a positive and dynamic mindset and dare to commit. In short, I still believe this is an industry worth investing in if you really love it."</p>',
        null, N'People like us have to ''plot'' hard all week, many nights have to sleep at the company.',
        N'2023-07-12', null, N'2023-07-12',
        N'/SWP391_Group3/images/news/it1625489142162548916112471625-4797-6015-1684740421.jpg', 19, 1, null, null);
INSERT INTO SWP_V1.dbo.NewsItem (Name, Name_VN, href, slug, Content, Content_VN, Description, created_date,
                                 modified_date, approve_date, image, Parent_id, Created_By, Modified_By, NewsGroup)
VALUES (N'Opportunity to become a programmer in Japan with VTI Education', null, null,
        N'opportunity-to-become-a-programmer-in-japan-with-vti-education-24',
        N'<p>VTI Education has just signed a cooperation agreement with Kyoto Computer Institute (KCG), opening up opportunities for international students to study and work in IT in Japan after one to two years.</p><p>At the signing ceremony, Mr. Nguyen Hai Duong - COO of VTI Japan - representative of VTI Group and VTI Education shared: "With KCG''s tradition and long training in information technology, the association will opening up many opportunities for VTI students to be trained, study in a methodical and standard way and have a lot of support to find good jobs when they graduate".</p><figure class="image"><img src="https://i1-vnexpress.vnecdn.net/2022/03/01/image-2729072-extractword-0-ou-5620-8928-1646128751.png?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=pm6rg4GcB0xxgOSkIwMLBQ" alt="Ông Nguyễn Hải Dương - COO của VTI Japan (bên phải) ký kết hợp tác Thầy Terashita - Hiệu trưởng trường Kyoto Computer Gakuin (KCG)."></figure><p style="text-align:center;"><i>Mr. Nguyen Hai Duong - COO of VTI Japan (right) signed a cooperation agreement with Mr. Terashita - Principal of Kyoto Computer Gakuin School (KCG).</i></p><p>Sharing more about the reason for choosing Kyoto Computer Academy (KCG) as a partner in the Vietnam - Japan Joint Training Program, Mr. Duong said, KCG is a school specializing in teaching computers and information technology. It is a long-standing trust in Japan, founded by leading professors of Kyoto University (one of the world''s leading universities and has many Nobel Prize-winning professors in Japan).</p><p>Not only the teaching content is up-to-date and suitable for the new era, the equipment here is also heavily invested by the school - the school has provided personal computers for each student since the 80s of the last century. Inheriting that tradition, the school always provides a good learning environment for students, with spacious facilities and modern curriculum. In addition, KCG also has a master training system specialized in IT, convenient for those who want to study further.</p><p>Mr. Duong also used to visit VTI Group Chairman - Mr. Tran Xuan Khoi to visit KCG school in Kyoto to experience student life before the signing ceremony took place. "The school''s campus is located in convenient locations for commuting, living and working. The campus used by Vietnamese international students is only a 5-minute walk from Kyoto Station," said Mr. Duong.</p><p>Students participating in the Vietnam - Japan joint training program of VTI Education take from one year of specialized study in Japan (normally it takes 2-4 years with a cost of about 320-720 million VND). If the cost of learning Japanese is included, this program has helped students save about 40-60% of the cost of studying abroad compared to other ways, a representative of VTI Education shared. According to this representative, after graduation, 100% of VTI Education students are committed to introduce jobs in Japan with a salary of 2,000-4,000 USD per month, have the opportunity to live and settle permanently in Japan. .</p><p>In addition, students are also committed to support and welcome from KCG and VTI Education, ready to accompany students from the moment they board the plane to Japan, to graduation and job placement. In addition, after graduating, students will be awarded a professional college degree from KCG, proving their own strength and being sought after by businesses in both Vietnam and Japan.</p><p>Mr. Duong also emphasized the role and support of VTI Japan for VTI Education students: "VTI Japan actively participates in the learning support process for students participating in the Vietnam - Japan Joint Training Program. We have a system of scholarship packages, internship support for Vietnamese students, as well as a commitment to recruit candidates who match VTI''s criteria, or introduce jobs with a high salary. high for VTI''s partner network in Japan".</p><figure class="image"><img src="https://i1-vnexpress.vnecdn.net/2022/03/02/image003-6956-1646187793.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=5bKkPmbadg5w4-7di5ii8w" alt="Ông Nguyễn Hải Dương (đứng) trong một buổi chia sẻ với sinh viên VTI."></figure><p style="text-align:center;"><i>Students participating in the joint training program at VTI Education take from one year of specialized study in Japan.</i></p><p>Mr. Nguyen Hai Duong is the Managing Director at VTI Japan - a company specializing in providing information technology solutions for the Japanese market with two headquarters in Tokyo and Osaka. Mr. Duong affirmed that he fully understands the problem of shortage of resources in this country known as Asia''s technology powerhouse.</p><p>Instead of insecurity and anxiety, Mr. Duong always sees it as a great potential and opportunity for the young generation of Vietnam. He shared: "Japan is a developed country in science and technology, peace, stability and gentle people. Japan is in a period of a lot of transformation in terms of technology platforms, in the process. create many job opportunities for IT profession".</p><figure class="image"><img src="https://i1-vnexpress.vnecdn.net/2022/03/01/dai-dien-2232-1646122961-16461-6075-1585-1646128751.png?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=DPqQTY8AQdLcZw50hHjAlA" alt="Đại diện ban lãnh đạo của VTI Education và KCG."></figure><p style="text-align:center;"><i>Representatives of the leadership of VTI Education and KCG.</i></p><p>In fact, at the beginning of 2022, information technology enterprises in Japan reported a shortage of resources of up to 450,000 employees - 1.5 times the number of shortages in Vietnam. With a serious shortage of human resources, experts warn that Japan may lack up to 790,000 IT workers in 2030.</p><p>Japan constantly calls for investment and development of resources from abroad, among them, the Vietnamese are the second largest community - accounting for 15% of total resources. Vietnamese students are highly appreciated in Japan for their quickness in work, diligence, hard work, hard work, as well as the level of cultural similarity between the two countries.</p>',
        null,
        N'VTI Education has just signed a cooperation agreement with Kyoto Computer Institute (KCG), opening up opportunities for students to study and work in IT in Japan after one to two years.',
        N'2023-07-12', null, N'2023-07-12',
        N'/SWP391_Group3/images/news/image-2729072-extractword-0-ou-5620-8928-1646128751.jpg', 19, 1, null, null);
INSERT INTO SWP_V1.dbo.NewsItem (Name, Name_VN, href, slug, Content, Content_VN, Description, created_date,
                                 modified_date, approve_date, image, Parent_id, Created_By, Modified_By, NewsGroup)
VALUES (N'Learn JavaScript while Playing Games — Gamify Your Learning', null, null,
        N'learn-javascript-while-playing-games--gamify-your-learning-25',
        N'<p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Trong bài viết này, tôi muốn giới thiệu các trang web khác nhau mà bạn có thể sử dụng để học JavaScript khi chơi trò chơi. Phương pháp này được gọi là game hóa và là một kỹ thuật nổi tiếng hiện nay.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Giới thiệu:</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Thông thường, nếu bạn học một công nghệ hoặc ngôn ngữ mới, bạn có thể không giữ được động lực của mình. Điều này là do số lượng công nghệ dường như vô tận. Có thể khó tiếp tục gắn bó với công nghệ đặc biệt phức tạp và việc học bị bế tắc.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Gamification là một giải pháp tốt cho vấn đề này. Nó sử dụng một nỗ lực chiến lược đơn giản để thúc đẩy và thu hút người dùng trong khi tìm hiểu điều gì đó mới. Đó là một kỹ thuật thêm các yếu tố thiết kế điển hình từ các trò chơi để nâng cao quá trình học tập. Điều này được thực hiện bằng cách thúc đẩy mong muốn tự nhiên của mọi người về giao tiếp xã hội, học tập, làm chủ, cạnh tranh, thành tích, địa vị hoặc thể hiện bản thân. Việc triển khai sớm Gamification sử dụng một hệ thống phần thưởng đơn giản cho người chơi sau khi họ hoàn thành nhiệm vụ để thu hút họ. Phần thưởng bao gồm điểm số, huy hiệu thành tích hoặc tiền ảo để sử dụng.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Một cách tiếp cận khác của Gamification biến đổi chính nhiệm vụ trong trò chơi. Điều này được thực hiện bằng cách bao gồm một lựa chọn có ý nghĩa, hướng dẫn giới thiệu hoặc thêm một câu chuyện.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Trong chương tiếp theo, tôi sẽ chỉ ra các trang web khác nhau có thể được sử dụng để học JavaScript bằng cách chơi trò chơi hoặc giải câu đố.</p><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>CheckiO</strong></h1><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">CheckiO là một trang web dạy lập trình bằng cách cung cấp một thế giới trò chơi trực tuyến với nhiều tính năng Gamification như tính điểm, bảng xếp hạng hoặc xã hội hóa. Nó giúp bạn cải thiện kỹ năng mã hóa của mình. Ngoài ra, nó chứa nhiều trò chơi mã hóa cho người mới bắt đầu và lập trình viên nâng cao. Bạn có thể hoàn thành các bài tập bằng Python hoặc TypeScript bao gồm nhiều chủ đề khác nhau, bao gồm chuỗi, vòng lặp, đối tượng, lớp, ngoại lệ và giải quyết vấn đề. Sau khi hoàn thành các thử thách, bạn sẽ kiếm được điểm, mở khóa các trò chơi mới và thăng cấp lên các cấp độ cao hơn. Hơn nữa, có một phần bình luận và Diễn đàn nơi bạn có thể tham khảo trợ giúp hoặc xem cách những người dùng khác giải câu đố.</p><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6935/6422ae52f16da.png" alt="image.png"></figure><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>CodeCombat</strong></h1><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Trong TwilioQuest, bạn sẽ dẫn dắt phi hành đoàn dũng cảm của mình thực hiện một nhiệm vụ tới The Cloud. Đây là một trò chơi nhập vai miễn phí trên PC được lấy cảm hứng từ những tác phẩm kinh điển của thời đại 16-bit.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Hơn nữa, đây là một trò chơi giáo dục được thiết kế để dạy lập trình bằng JavaScript hoặc Python cho các nhà phát triển mới. Trò chơi sẽ chuẩn bị cho bạn các vấn đề trong thế giới thực bằng cách giúp bạn định cấu hình môi trường phát triển cục bộ và giải thích các công cụ được các lập trình viên chuyên nghiệp sử dụng.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Bạn sẽ học cách sử dụng thiết bị đầu cuối của mình, học cách viết mã bằng Python hoặc JavaScript và đóng góp cho các dự án Nguồn mở. Tất cả những kỹ năng công nghệ phần mềm thực tế này sẽ được đề cập nếu bạn chơi TwilioQuest</p><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6935/6422ae114e79d.png" alt="image.png"></figure><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>Elevator Saga</strong></h1><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Đây là một trò chơi lập trình! Nhiệm vụ của bạn là lập trình chuyển động của thang máy, bằng cách viết chương trình bằng JavaScript .</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Elevator Saga là trò chơi mà bạn phải sử dụng JavaScript để vận chuyển người bằng thang máy một cách hiệu quả. Trong khi tiến bộ qua các giai đoạn khác nhau, bạn phải hoàn thành những thử thách khó khăn hơn.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Chỉ những chương trình hiệu quả mới có thể hoàn thành mọi thử thách.</p><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6935/6422add046c0f.png" alt="image.png"></figure><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>jsdares</strong></h1><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Tại <a style="-webkit-tap-highlight-color:transparent;background-color:transparent;box-sizing:inherit;color:var(--primary-color);" href="https://fullstack.edu.vn/external-url?continue=http%3A%2F%2Fjsdares.com%2F" target="_blank" rel="noreferrer"><u>jsdares.com</u></a>, bạn sẽ học lập trình JavaScript bằng cách hoàn thành “dám”. Những thử thách này là những câu đố ngắn trong đó bạn giảm thiểu số lượng chức năng được sử dụng để hoàn thành nhiệm vụ. Chúng rất đơn giản lúc đầu nhưng sẽ trở nên khó khăn hơn khi bạn tiến bộ.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Hiện tại, jsdares chỉ cung cấp một số lượng nhỏ các thử thách nhưng họ đang làm việc trên một bộ sưu tập lớn hơn để bắt đầu. Ngoài ra, bạn có cơ hội để tạo và chia sẻ những thách thức của riêng bạn.</p><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6935/6422adaec2a9e.png" alt="image.png"></figure><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>WarriorJS</strong></h1><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Truyền thuyết kể về một thanh kiếm huyền thoại, bị lãng quên trong đống đổ nát của một tòa tháp bỏ hoang. Hàng nghìn chiến binh đã bắt đầu hành trình tìm kiếm thanh kiếm, người mang thanh kiếm này sẽ được khai sáng bằng ngôn ngữ JavaScript.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+WarriorJS là một nền tảng học tập JavaScript dạy bạn JavaScript khi bạn chơi trò chơi nhập vai. Trò chơi này được thiết kế cho các lập trình viên JavaScript mới hoặc nâng cao và sẽ kiểm tra các kỹ năng của bạn!</p><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6935/6422ad8755671.png" alt="image.png"></figure><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>JSRobot</strong></h1><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">JSRobot là một trò chơi mà bạn sẽ điều khiển một robot thu thập tiền xu và sẽ đi đến cuối cấp độ. Tất cả chương trình được thực hiện bằng JavaScript và mọi thử thách đều chứa thông tin về tất cả các chức năng JavaScript cần thiết để hoàn thành nó.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">+Thật không may, đây là một trò chơi rất đơn giản, không có giao diện người dùng và cách trình bày đẹp mắt. Nhưng nó vẫn có thể được sử dụng để thực hành kỹ năng mã hóa của bạn.</p><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6935/6422aea071947.png" alt="image.png"></figure><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>Closing Notes</strong></h1><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Nếu bạn thử bất kỳ trò chơi nào trong số này, chúng có thể giúp bạn bắt đầu học JavaScript và trở thành nhà phát triển JavaScript. Họ đang khuyến khích hài hước và có rất nhiều thứ để cung cấp. Bên cạnh đó, bạn sẽ tiếp xúc với lập trình và sẽ có kiến ​​thức sâu hơn về cú pháp, thuật toán và các khái niệm quan trọng khác trong lập trình.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Cá nhân tôi khuyên bạn nên sử dụng CheckiO, TwilioQuest, CodeCombat và WarriorJS. Chúng đặc biệt hữu ích cho những người muốn làm việc như một nhà phát triển.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">JSRobot, ElevatorSage và jsdares rất tốt để thực hành một số chức năng cơ bản và không nên tránh nhưng tôi không khuyên bạn nên bắt đầu với những trò chơi này.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Tôi hy vọng bạn sẽ kiểm tra bất kỳ trang web nào trong số này và sẽ thấy chúng hữu ích như tôi có. Nếu vậy tôi rất thích nghe suy nghĩ của bạn. Ngoài ra, nếu bạn có bất kỳ câu hỏi, ý tưởng hoặc đề xuất nào, vui lòng ghi lại chúng bên dưới. Tôi cố gắng trả lời chúng nếu có thể.</p><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Ngoài ra, tôi rất muốn nghe suy nghĩ và phản hồi của bạn về các tài nguyên Gamification này. Ngoài ra, hãy chia sẻ bài viết này với bạn bè và đồng nghiệp của bạn để cùng học JavaScript bằng Gamification.</p>',
        null,
        N'Often, if you learn a new technology or language, you may not be able to stay motivated. This is due to the seemingly endless amount of technology. It can be difficult to stay attached to particularly complex technology and learning is at a standstill.',
        N'2023-07-12', null, null, N'/SWP391_Group3/images/news/6422afa5a62f8.jpg', 19, 1, null, null);
INSERT INTO SWP_V1.dbo.NewsItem (Name, Name_VN, href, slug, Content, Content_VN, Description, created_date,
                                 modified_date, approve_date, image, Parent_id, Created_By, Modified_By, NewsGroup)
VALUES (N'Tailwind css và cách cài đặt cơ bản', null, null, N'tailwind-css-va-cach-cai-at-co-ban-26', N'<p><i>Bạn đang lo lắng vì đặt tên lớp, sợ bị trùng css không mong muốn, hay muốn một framework hỗ trợ css dễ học mà dễ tùy biến theo ý thích đã có tailwind css.</i></p><h1 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:2em;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;margin:0.67em 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><strong>I, Tailwind css là gì?</strong></h1><ul style="list-style-type:none;"><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Tailwind css là một utility-first CSS framework nó hỗ trợ phát triển xây dựng nhanh chóng giao diện người dùng, nó cũng có điểm chung giống như Bootstrap &amp; điểm làm nó nổi bật hơn cả đó là chúng ta có thể tùy biến phát triển css theo cách mà chúng ta định nghĩa ra.</li></ul><h2 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;orphans:2;scroll-margin-top:100px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;" id="ii-cach-cai-dat-va-su-dung" data-appended="true"><strong>II, Cách cài đặt và sử dụng</strong></h2><ol><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Sử dụng thông qua link CDN</li></ol><ul style="list-style-type:none;"><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Ở phiên bản tailwind css hiện tại là V3.0.0 thì có thể sử dụng link viết theo dạng script:</li></ul><pre style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:monospace, monospace;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;widows:2;word-spacing:0px;"><code class="language-plaintext" style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">&lt;script src="https://cdn.tailwindcss.com"&gt;&lt;/script&gt;
</code></pre><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">hoặc có thể dùng link CDN theo dạng link css ở phiên bản V2</p><pre style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:monospace, monospace;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;widows:2;word-spacing:0px;"><code class="language-plaintext" style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">&lt;link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet"&gt;
</code></pre><p style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:6px 0px;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Có 1 điều đặc biệt ở phiên bản V3 khi dùng link script là bạn có thể tùy biến thêm css trong script:</p><pre style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:monospace, monospace;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;widows:2;word-spacing:0px;"><code class="language-plaintext" style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">&lt;script src="https://cdn.tailwindcss.com"&gt;&lt;/script&gt;
  &lt;script&gt;
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            clifford: ''#da373d'',
          }
        }
      }
    }
  &lt;/script&gt;
</code></pre><ol start="2"><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;" start="2">Cài tailwind css trên project (Tailwind CLI)</li></ol><ul style="list-style-type:none;"><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Sau khi cài xong npm hoặc yarn chúng ta có thể cài tailwind css đơn giản theo cách sau:</li></ul><blockquote style="-webkit-text-stroke-width:0px;border-left:3px solid var(--primary-color);box-sizing:inherit;color:rgb(117, 117, 117);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin-left:0px;orphans:2;padding:0px 0px 2px 20px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><p style="box-sizing:inherit;margin:0px;">Cài đặt tailwind css qua npm &amp; yarn : <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">npm install -D tailwindcss</code> hoặc <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">yarn add tailwindcss</code>.</p></blockquote><blockquote style="-webkit-text-stroke-width:0px;border-left:3px solid var(--primary-color);box-sizing:inherit;color:rgb(117, 117, 117);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin-left:0px;orphans:2;padding:0px 0px 2px 20px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><p style="box-sizing:inherit;margin:0px;">Cài đặt file tailwind.config.js dùng để sử dụng tạo cấu hình tailwindcss cơ bản: <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">npx tailwindcss init</code></p></blockquote><blockquote style="-webkit-text-stroke-width:0px;border-left:3px solid var(--primary-color);box-sizing:inherit;color:rgb(117, 117, 117);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin-left:0px;orphans:2;padding:0px 0px 2px 20px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><p style="box-sizing:inherit;margin:0px;">Định nghĩa các đường path mà bạn sử dụng tailwind css:</p></blockquote><pre style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:monospace, monospace;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;widows:2;word-spacing:0px;"><code class="language-plaintext" style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">module.exports = {
  content: ["./src/**/*.{html,js}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
</code></pre><blockquote style="-webkit-text-stroke-width:0px;border-left:3px solid var(--primary-color);box-sizing:inherit;color:rgb(117, 117, 117);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin-left:0px;orphans:2;padding:0px 0px 2px 20px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><p style="box-sizing:inherit;margin:0px;">Tạo 1 file css để chứa từng lớp tệp lệnh tailwind sau đó thêm đoạn code sau vào file css đó:</p></blockquote><pre style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:monospace, monospace;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;orphans:2;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;widows:2;word-spacing:0px;"><code class="language-plaintext" style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">@tailwind base;
@tailwind components;
@tailwind utilities;
</code></pre><blockquote style="-webkit-text-stroke-width:0px;border-left:3px solid var(--primary-color);box-sizing:inherit;color:rgb(117, 117, 117);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin-left:0px;orphans:2;padding:0px 0px 2px 20px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><p style="box-sizing:inherit;margin:0px;">Câu lệnh build tailwind css:</p></blockquote><ul style="list-style-type:none;"><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Ở đây bạn có thể bật terminal và viết thẳng <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">npx tailwindcss -i ./src/input.css -o ./dist/output.css --watch</code></li><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Trong đó<code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;"> /src/input.css</code> là file mà chúng ta tạo ở bước trước đó và <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">./dist/output.css</code> là file mà các css được build ra để sử dụng.</li><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Cách nữa là viết câu lệnh build trong scripts của file <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">package.json</code> để dễ gọi hơn: <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">"scripts": { "build": "npx tailwindcss -i ./src/input.css -o ./dist/output.css --watch" },</code> và đơn giản sau đó là bật terminal và gọi <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">npm run build.</code></li></ul><blockquote style="-webkit-text-stroke-width:0px;border-left:3px solid var(--primary-color);box-sizing:inherit;color:rgb(117, 117, 117);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;margin-left:0px;orphans:2;padding:0px 0px 2px 20px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;"><p style="box-sizing:inherit;margin:0px;">Bước cuối nhúng file css vào link: <code style="background-color:rgba(96, 125, 139, 0.2);border-radius:3px;box-sizing:inherit;font-family:var(--font-code);font-size:1.4rem;padding:3px 4px;white-space:pre-wrap !important;">&lt;link href="/dist/output.css" rel="stylesheet"&gt;</code></p></blockquote><h2 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;orphans:2;scroll-margin-top:100px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;" id="iii-mot-so-framework-duoc-tailwind-ho-tro" data-appended="true"><strong>III, Một số framework được tailwind hỗ trợ</strong></h2><ul style="list-style-type:none;"><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">AngularJS, ReactJS, VueJS, NextJS, Laravel, Gatsby, Nuxt.js.</li></ul><h2 style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;letter-spacing:normal;orphans:2;scroll-margin-top:100px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;" id="iv-tong-ket" data-appended="true"><strong>IV, Tổng kết</strong></h2><ul style="list-style-type:none;"><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Tailwind css là framework rất dễ học cho người mới bắt đầu sử dụng css, tuy nhiên để sử dụng tốt thì cần phải nắm vững kiến thức của css thuần trước.</li><li style="-webkit-text-stroke-width:0px;box-sizing:inherit;color:rgb(41, 41, 41);font-family:system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;font-size:18px;font-style:normal;font-variant-caps:normal;font-variant-ligatures:normal;font-weight:400;letter-spacing:normal;list-style-type:none;margin:28px 0px;orphans:2;padding-left:24px;text-align:start;text-decoration-color:initial;text-decoration-style:initial;text-decoration-thickness:initial;text-indent:0px;text-transform:none;white-space:normal;widows:2;word-spacing:0px;">Trên là giới thiệu cũng như cách cài đặt tailwind css cơ bản, mọi người có thể tham khảo cách sử dụng cũng như cách cài đặt trong 1 số framework khác <a style="-webkit-tap-highlight-color:transparent;background-color:transparent;box-sizing:inherit;color:var(--primary-color);" href="https://fullstack.edu.vn/blog/tailwind-css-va-cach-cai-dat-co-ban.html" target="_blank" rel="noreferrer"><u>https://tailwindcss.com</u></a>.</li></ul>',
        null,
        N'Bạn đang lo lắng vì đặt tên class, sợ bị trùng css không mong muốn, hay muốn một framework hỗ trợ css dễ học mà dễ tùy biến theo ý thích đã có tailwind css.',
        N'2023-07-12', N'2023-07-12', null, N'/SWP391_Group3/images/news/61b46a3d757cc.jpg', 19, 1, 1, null);
INSERT INTO SWP_V1.dbo.NewsItem (Name, Name_VN, href, slug, Content, Content_VN, Description, created_date,
                                 modified_date, approve_date, image, Parent_id, Created_By, Modified_By, NewsGroup)
VALUES (N'Path to learn C# .NET Core(5, 6)', null, null, N'path-to-learn-c-net-core5-6-27',
        N'<p>Hi everybody,</p><p>Today I will share about the C#, .Net core (5, 6) learning path for beginners. Don''t let everyone wait too long, let''s get started.</p><p><span style="font-size:22px;"><strong>I. Environment settings:</strong></span></p><p>.NET 6 SDK: <a href="https://dotnet.microsoft.com/en-us/download/visual-studio-sdks" download="file">https://dotnet.microsoft.com/en-us/download/visual-studio-sdks</a><br>Visual studio Community 2022: <a href="https://visualstudio.microsoft.com/vs/community/">https://visualstudio.microsoft.com/vs/community/</a><br>SQL Server 2019 Developer: <a href="https://www.microsoft.com/en-us/sql-server/sql-server-downloads">https://www.microsoft.com/en-us/sql-server/sql-server-downloads</a><br>SQL Server Management Studio : <a href="https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16">https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16</a></p><p>Visual studio Code: <a href="https://code.visualstudio.com/" download="file">https://code.visualstudio.com/</a><br>Git: <a href="https://git-scm.com/downloads" download="file">https://git-scm.com/downloads</a></p><p><span style="font-size:22px;"><strong>II. Learning Project</strong></span></p><p>Learning must go hand in hand with practice, so when learning C#, .NET I think you should build your own projects. Below is a sample project with basic requirements and functions.</p><p><strong><u>Describe project:</u></strong></p><p>Develop blog site for programmers.<br>Display 10 list of latest articles for users to view, paginate. Displays a list of articles by category.<br>Allows managing categories of articles (category) such as C#, Java, PHP, Database, BE, FE... List view, search, pagination, add, delete, edit category categories.<br>Manage posts (Posts) belonging to a category (xategory). List view, search, pagination, add, delete, edit posts.<br>Administrators must be logged in to access the administration page.</p><p><br><strong><u>Function:</u></strong></p><p>Get the list<br>Searching/Filter<br>Paging (paging)<br>Add data (add) (upload images, integrate with ckeditor to write articles)<br>Edit data (update)<br>Delete data (delete)<br>Sign in, log out</p><p><strong><u>Technology (Tech stack):</u></strong></p><p>Backend:.Net 6, Entity Framework Core, Sql Server (database) to build API<br>Frontend: HTML, CSS, Javascript interact with BE via API</p><p><span style="font-size:22px;"><strong>III. Content C#, .NET, SQL Server</strong></span></p><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/3795/62a83e17e9e21.png" alt="image.png"></figure><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/3795/62a83e17e9e21.png" alt="image.png"></figure><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/3795/62a83e22539aa.png" alt="image.png"></figure><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/3795/62a83e27f2e23.png" alt="image.png"></figure><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/3795/62a83e2bc4b10.png" alt="image.png"></figure><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/3795/62a83e3265ec0.png" alt="image.png"></figure><figure class="image"><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/3795/62a83e362dbbb.png" alt="image.png"></figure><p><span style="font-size:22px;"><strong>IV. Summary</strong></span></p><p>So we have gone through the overview of the content of the c#, .NET roadmap.<br>Thank you to everyone who viewed the article. Have a nice weekend everyone.<br>If you have any questions about the parts in this article, you can inbox via facebook: <a href="https://www.facebook.com/FriendsCode-108096425243996" download="file">https://www.facebook.com/FriendsCode-108096425243996</a>. I will answer questions to the best of my knowledge. Thanks everyone.</p>',
        null,
        N'Today I will share about the C#, .Net core (5, 6) learning path for beginners. Don''t let everyone wait too long, let''s get started.',
        N'2023-07-12', null, N'2023-07-12', N'/SWP391_Group3/images/news/62a83eb1bb7d9.jpg', 19, 1, null, null);


GO
INSERT INTO NewsItem (Name, slug, Content, [description], image, Parent_id, Created_By, approve_date)
Values ('New Sale', 'new-sale-26',
        'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14',
        'Opening the basic C/C++ course exclusively for you at a discounted price, register for the class today to  Apply promotions from 20%. Quickly register today!! The program applies to all customers from 2023-05-10 until 2023-05-14',
        '/SWP391_Group3/images/news/newimg2.jpg', 20, 1, null)

--
INSERT INTO NewsItem(Name, Name_VN, Content, Created_by, NewsGroup)
values ('phone company', N'Thông tin liên hệ', '0762034981', 1, 4)
INSERT INTO NewsItem(Name, Name_VN, Content, Created_by, NewsGroup)
values ('email company', N'Hòm thư điện tử', 'academyswpg3@gmail.com', 1, 4)

INSERT INTO NewsItem(Name, Name_VN, Content, href, Created_by, Parent_id)
values ('Phone number: ', N'Đường dây nóng: ', '0762034981', 'tel://', 1, 9)
INSERT INTO NewsItem(Name, Name_VN, Content, href, Created_by, Parent_id)
values ('Email: ', N'Hòm thư điện tử: ', 'academyswpg3@gmail.com', 'mailto://academyswpg3@gmail.com', 1, 9)


INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id)
values ('AboutUs', N'Giới thiệu', '/SWP391_Group3/viewAbout?type=13', '/SWP391_Group3/viewAbout/about-us-13', 1, 2)
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id)
values ('Mission', N'Sứ mệnh', '/SWP391_Group3/viewAbout?type=14', '/SWP391_Group3/viewAbout/mission-14', 1, 2)

INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id)
values ('My Course', N'Khoá Học Của Tôi', '/SWP391_Group3/mycourseprofile/myCourse',
        '/SWP391_Group3/mycourseprofile/myCourse', 1, 4)
INSERT INTO NewsItem (Name, Name_VN, href, slug, created_by, Parent_id)
values ('All Course', N'Tất Cả Khoá Học', '/SWP391_Group3/listcourse', '/SWP391_Group3/listcourse', 1, 4)

INSERT INTO NewsItem(Name, name_vn, href, slug, Created_by, Parent_id)
values ('Web Development', N'Lập Trình Web', '/SWP391_Group3/listcoursebycategory', '/web-development-1', 1, 8)
INSERT INTO NewsItem(Name, name_vn, href, slug, Created_by, Parent_id)
values ('AI', N'Trí Tuệ Nhân Tạo', '/SWP391_Group3/listcoursebycategory', '/ai-2', 1, 8)
INSERT INTO NewsItem(Name, name_vn, href, slug, Created_by, Parent_id)
values ('Mobile Development', N'Lập Trình Di Động', '/SWP391_Group3/listcoursebycategory', '/mobile-development-3', 1,
        8)

GO



--DONE

--coursem, lesson, Doc, File, Video, instructor, category, course_level, followUS, instructor_detail


--insert bang user
Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user1', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'john_doe@example.com',
        'John Doe', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user2', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'jane_smith@example.com',
        'Jane Smith', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user3', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'bob_jones@example.com',
        'Bob Jones', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user4', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'sara_davis@example.com',
        'Sara Davis', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user5', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'mike_jackson@example.com',
        'Mike Jackson', '0346231353', 10000);
Insert into [user] (username, [password], email, [name], telephone, amount)
values ('nguyenminh', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'nguyenminh7902@gmail.com',
        'Nguyen Minh', '0866187621', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('tiengiang', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'giangnthe163050@fpt.edu.vn',
        'Tien Giang', '0338564262', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('daokhai', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'khaidqhe163770@fpt.edu.vn',
        'Dao Khai', '0877567313', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('tuanninh', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'nguyentuanninh30@gmail.com',
        'Tuan Ninh', '03533753610', 10000);
Insert into [user] (username, [password], email, [name], telephone, amount)
values ('nguyentoan', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'nguyentuanninh02@gmail.com',
        'Nguyen Toan', '0346231353', 10000);
Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user11', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'john_doe@example.com',
        'John Doe', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user21', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'jane_smith@example.com',
        'Jane Smith', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user31', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'bob_jones@example.com',
        'Bob Jones', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user41', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'sara_davis@example.com',
        'Sara Davis', '0346231353', 10000);

Insert into [user] (username, [password], email, [name], telephone, amount)
values ('user51', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'mike_jackson@example.com',
        'Mike Jackson', '0346231353', 10000);

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

Insert INTO FollowUS (gmail)
values ('daoquangkhai2002@gmail.com'),
       ('khaidqhe163770@fpt.edu.vn'),
       ('tuandao090202@gmail.com'),
       ('nguyentuanninh02@gmail.com'),
       ('nguyentuanninh30@gmail.com'),
       ('ninhnthe161847@fpt.edu.vn'),
       ('giangnthe163050@fpt.edu.vn'),
       ('Nghiachinhmh@gmail.com')

insert into categories(slug, name, name_vn, description)
values ('web-development-1', 'Web Development', N'Lập Trình Web', 'HTML, CSS3, JavaScript, Php, ReactJS'),
       ('ai-2', 'AI', N'Trí Tuệ Nhân Tạo', 'Python, Machine Learning, Deep Learning'),
       ('mobile-development-3', 'Mobile Development', N'Lập Trình Di Động', 'Flutter, Typescript, Kotlin/Java, Swift')


insert into courses_level(level_name)
values ('Ease'),
       ('Medium'),
       ('Hard')


GO
SET IDENTITY_INSERT [dbo].[courses] ON
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (1, N'Basic JavaScript', N'basic-javascript-1', N'/SWP391_Group3/images/course/1687797033464_Javascript.png',
        N'The Basic Java Course is a practical and comprehensive course that aims to help students understand and become familiar with the Java programming language. In this course, students will learn Java syntax and operating principles, declaring variables and using basic data types, using control structures such as branches and loops, working with arrays, and understand object-oriented programming (OOP). The course will combine theory and practice to give students the skills they need to start developing simple Java applications.',
        1000000, 1, 0, 2,
        N'After completing the Java Basics course, you will be able to understand and apply the syntax and working principles of the Java language. You can declare and use variables, basic data types in Java, and work with control structures such as branches and loops. In addition, you will also master the basics of object-oriented programming (OOP) and learn how to build simple applications using Java. You will be able to read and write data from files, handle exceptions, and have a basic understanding of web application development with Java.',
        CAST(N'2023-06-26' AS Date), NULL, NULL, CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (2, N'C# fundamentals', N'c-fundamentals-2', N'/SWP391_Group3/images/course/1687797592864_download.png',
        N'Key to learn C# is an object-oriented programming course that helps learners grasp the knowledge of the C# language and develop applications on the .NET platform. The course focuses on C# syntax, OOP, exception handling, and web application development with ASP.NET.',
        500000, 1, 0, 2,
        N'After completing the basic C# course, learners will understand and master the syntax and basic concepts of the C# language. Have knowledge of object-oriented programming (OOP) and know how to build classes, objects, inheritance, polymorphism, and encapsulation in C#. Be able to handle exceptions and know how to handle errors in C# applications. Proficient in manipulating data types, variables, operators, and control structures in C#. Know how to use C#''s standard libraries to handle strings, files, and data streams. Basic knowledge of web application development with ASP.NET.',
        CAST(N'2023-06-26' AS Date), NULL, NULL, CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (3, N'C for Beginners', N'c-for-beginners-3', N'/SWP391_Group3/images/course/1687798021839_download.jfif',
        N'The C language programming course for beginners provides basic knowledge and skills to understand and use the C programming language. Learners will be introduced to C syntax, data types, variables, operators and basic control structures. The course provides a foundation for learning other programming concepts and is the first step in your journey to becoming a programmer.',
        1000000, 1, 0, 3,
        N'After completing the basic C course, learners will achieve many remarkable results. You will have a basic knowledge of the C programming language, including syntax, variables, data types, and control structures. You will be able to write and execute simple C code. Plus, you''ll understand how data is handled in C, from declaring and using variables to using operators and control statements to perform calculations, and the Course also gives you the knowledge you need. Knowledge of basic array, string, and data structure handling in C. By practicing and solving programming exercises, you will practice problem solving and programming logic.',
        CAST(N'2023-06-26' AS Date), NULL, NULL, CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (4, N'C++ for Beginners', N'c-for-beginners-4', N'/SWP391_Group3/images/course/1687798623824_images (1).jfif',
        N'C++ is a powerful and multi-purpose programming language. It combines the features of the C language with object-oriented programming capabilities, allowing the development of rich and efficient software applications. C++ supports concepts like classes, inheritance, polymorphism, and encapsulation, allowing code reuse and creating highly extensible applications. It also offers powerful features such as manual memory management, pointers, and hardware-closed math. C++ is widely used in game development, system software, mobile applications, and many other areas that require high performance and control.',
        500000, 1, 0, 3,
        N'After completing the C++ course, you will understand the syntax and structure of the C++ language: You will have a solid knowledge of the syntax, coding rules and program structure in C++. This allows you to write clean and readable source code. Memory handling: You will understand memory management in C++ and how to use pointers. This allows you to directly interact with the memory and optimize the performance of the application. Realistic Application Development: You will be able to build real applications using C++. You can develop games, computer applications, embedded systems and many other applications in different fields. ',
        CAST(N'2023-06-26' AS Date), NULL, NULL, CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (5, N'Python', N'python-5', N'/SWP391_Group3/images/course/1687799052975_khoa-hoc-python-2.png',
        N'Python is an interpreted programming language that is easy to learn and use. It is designed for enhanced portability and readability, and is especially suitable for web application development, data analysis, artificial intelligence and other fields. Python has a simple and clear syntax that allows users to write short, readable, and maintainable code. It supports many programming styles such as object-oriented programming, structured programming, and functional programming. Python provides a rich library and strong community, including diverse modules and frameworks, helping to solve many problems from simple to complex. Python also benefits from continued development and community support, making it one of the most popular programming languages in the world today.',
        500000, 1, 0, 3,
        N'Understand and Apply Python Syntax: You will master the syntax and semantics of the Python language, from basic code blocks to control structures and functions. This allows you to write Python code that is easy to read, maintain, and efficient. Web Application Development: You will be able to use popular web frameworks like Django or Flask to build dynamic web applications. You will learn how to handle HTTP requests, interact with databases, and create beautiful and user-friendly user interfaces. Data processing and analysis: Python provides powerful libraries for data processing and analysis. ',
        CAST(N'2023-06-27' AS Date), NULL, NULL, CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (6, N'Introduction to Deep Learning', N'introduction-to-deep-learning-6',
        N'/SWP391_Group3/images/course/1687963205839_z4446232228582_4ddf7d77531185121f67c22ebe6d49de.jpg',
        N'The course covers the fundamentals of deep learning, including neural networks, convolutional neural networks, recurrent neural networks, and generative models. It also covers various applications of deep learning, such as computer vision, natural language processing, and speech recognition',
        599000, 2, 0, 2, N'Understand the basic concepts of artificial intelligence and deep learning.Know how to build and train deep learning models.
Understand applications of deep learning in various fields, including computer vision, natural language processing, and autonomous driving.Ability to apply deep learning techniques to solve real-world problems.',
        CAST(N'2023-06-28' AS Date), NULL, NULL, CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (7, N'AI For Everyone', N'ai-for-everyone-7',
        N'/SWP391_Group3/images/course/1687963676574_z4446246540105_e74993502538fe2dd750a7053f0fd572.jpg',
        N'The "AI for Everyone" course provides the basics of artificial intelligence to everyone, with no specialized knowledge required. It covers a variety of topics such as history, machine learning, deep learning, natural language processing, computer vision, and robotics.',
        700000, 2, 0, 2,
        N'The "AI for Everyone" course aims to provide learners with the basics of Artificial Intelligence, helping them understand the concepts and applications of AI, its history and development, and its potential applications. applications of AI in various industries.',
        CAST(N'2023-06-28' AS Date), NULL, NULL, CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (8, N'Google AI education', N'google-ai-education-8',
        N'/SWP391_Group3/images/course/1687964233876_z4446266969463_c77d13ca059a279c279254aff578f569.jpg',
        N'This is a site that provides learning resources including videos, courses, seminars, documents, and more. Google''s AI for everyone from curious people, students, entrepreneurs, researchers',
        670000, 2, 0, 2,
        N'The goal of Google''s artificial intelligence educational resources is to provide learners with the knowledge and skills to understand and apply AI technologies. Upon completion of these courses, learners will be able to understand the basics of AI, apply AI technologies to real-life problems, and keep up to date with the latest AI trends.',
        CAST(N'2023-06-28' AS Date), NULL, NULL, CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (9, N'React native', N'react-native-9',
        N'/SWP391_Group3/images/course/1687964703199_z4446331072880_4eef110d8b3f297e1a63943d55f7f8d0.jpg',
        N'In this course, you''ll learn how to use React Native to create UI components, manage app state, interact with APIs, and deploy apps on different mobile platforms. You will be guided by experts and have the opportunity to practice through practical exercises and projects.',
        600000, 3, 0, 2, N'Understand how to build mobile apps with React Native
Know how to use UI components and manage application state
Interact with APIs and deploy apps on different mobile platforms
Practice through exercises and real projects to improve your programming skills', CAST(N'2023-06-28' AS Date), NULL,
        NULL, null, 0)
GO
INSERT [dbo].[courses] ([id], [name], [slug], [image], [description], [price], [categories], [NumberEnrolled], [level],
                        [Objectives], [create_at], [modified_at], [modified_by], [approve_at], [disabled])
VALUES (10, N'objectivec-c', N'objectivec-c-10',
        N'/SWP391_Group3/images/course/1687965297524_z4452131043945_09c53e7a9a769531e2d84bb62b900719.jpg',
        N'The Objective-C course is an iOS programming course that helps you learn how to use Objective-C to develop iOS apps, including how to use frameworks like UIKit, Foundation, Core Data, and Core Animation. Upon completion of the course, you will have the knowledge and skills needed to develop high-quality iOS applications.',
        820000, 3, 0, 3,
        N'The course objective is to provide students with a comprehensive understanding of a particular subject or skill set. It outlines the goals and learning outcomes that students can expect to achieve by the end of the course. The course objective may include specific topics to be covered, skills to be developed, and assessments to be completed.',
        CAST(N'2023-06-28' AS Date), NULL, NULL, CAST(N'2023-06-28' AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[courses] OFF
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (1, 1)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (2, 5)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (2, 9)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (2, 10)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (3, 4)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (4, 2)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (4, 6)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (4, 7)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (5, 3)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (5, 6)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (5, 7)
GO
INSERT [dbo].[instructors] ([instructors_id], [course_id])
VALUES (5, 8)
GO
SET IDENTITY_INSERT [dbo].[lessons] ON
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (1, 1, N'First program and comments', N'first-program-and-comments-2', N'Introduction to JavaScript', N'Video',
        CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (2, 1, N'JavaScript Introduction', N'javascript-introduction-2', N'JavaScript Change  Attribute Values', N'Docs',
        CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (3, 1, N'External JavaScript ', N'external-javascript--3', N'External JavaScript Advantages', N'Docs',
        CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (4, 1, N'JavaScript Functions and Events', N'javascript-functions-and-events-4',
        N'JavaScript Can Change HTML Content', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (5, 1, N'JavaScript', N'javascript-5', N'JavaScript Introduction', N'File', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (6, 2, N'C# Introduction', N'c-introduction-6', N'What is C#?', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (7, 2, N'C# Get Started', N'c-get-started-7', N'C# Install', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (8, 2, N'Learning C#', N'learning-c-8', N'C# Syntax', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (9, 2, N'C#', N'c-9', N'C# Introduction', N'File', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (10, 2, N'Introduction to C#', N'introduction-to-c-10', N'Basic Commands and Introduction to C#', N'Video',
        CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (11, 3, N'C Introduction ', N'c-introduction--11', N'What is C?', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (12, 3, N'C Get Started ', N'c-get-started--12', N'C Install
', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (13, 3, N'Learning C', N'learning-c-13', N'C Syntax', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (14, 3, N'C', N'c-14', N'C Introduction', N'File', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (15, 3, N'Introduction to C', N'introduction-to-c-15', N'Basic Commands and Introduction to C', N'Video',
        CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (16, 4, N'C++ Getting Started', N'c-getting-started-16', N'C++ Install IDE', N'Docs',
        CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (17, 4, N'Learning C++ ', N'learning-c--17', N'C++ Output (Print Text)', N'Docs', CAST(N'2023-06-26' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (18, 4, N'C++ Syntax', N'c-syntax-18', N'C++ New Lines', N'Docs', CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (19, 4, N'C++', N'c-19', N'C++ Introduction', N'File', CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (20, 4, N'C++ Introduction', N'c-introduction-20', N'This tutorial will teach you the basics of C++.', N'Video',
        CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (21, 5, N'Python Introduction', N'python-introduction-21', N'Python Can Change HTML Content', N'Docs',
        CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (22, 5, N'Python Functions and Events', N'python-functions-and-events-22', N'Python Change  Attribute Values',
        N'Docs', CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (23, 5, N'External Python', N'external-python-23', N'External Python Advantages', N'Docs',
        CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (24, 5, N'Python', N'python-24', N'Python Introduction', N'File', CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (25, 5, N'Python Introduction', N'python-introduction-25', N'Basic Commands and Introduction to Python ',
        N'Video', CAST(N'2023-06-27' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (26, 6, N'Introduction to Deep Learning  with PyTorch', N'introduction-to-deep-learning--with-pytorch-26',
        N'This is the first video in a series of tutorials on deep  learning with PyTorch. In this video, the instructor  introduces the basics of deep learning and PyTorch',
        N'Video', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (27, 6, N'Intro to Deep Learning', N'intro-to-deep-learning-27',
        N'Deep learning is a type of machine learning that is capable of achieving high levels of flexibility and power by learning to represent the world as a nested hierarchy of concepts. Each concept is defined in relation to simpler concepts, and more abstract representations are computed in terms of less abstract ones',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (28, 6, N'Deep Learning History', N'deep-learning-history-28',
        N'The increasing use of terms like "artificial intelligence," "machine learning," and "deep learning" is due to the emergence of deep learning in the past 5-6 years, as mentioned in the first post of this blog.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (29, 6, N'Introduction to NLP and Deep Learning', N'introduction-to-nlp-and-deep-learning-29', N'The first article includes the following main topics:
What is natural language processing? The nature of human language.
What is Deep Learning?
Why is natural language processing such a difficult task?
Application of Deep Learning for NLP.', N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (30, 6, N'Introduction to Deep Learning', N'introduction-to-deep-learning-30',
        N'Introduction to Deep Learning is an introductory course to Deep Learning, an area of Artificial Intelligence (AI) and Machine Learning. This course provides the basics of Deep Learning, including deep neural network architectures, deep learning algorithms, and applications of Deep Learning.',
        N'File', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (31, 7, N'AI For Everyone', N'ai-for-everyone-31',
        N'Introduction to Artificial Intelligence: This lesson provides an overview of AI, its history, and current state of development. It also covers different types of AI and their applications.',
        N'Video', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (32, 7, N'Overview of Artificial Intelligence. Distinguishing AI - Machine Learning - Deep Learning',
        N'overview-of-artificial-intelligence-distinguishing-ai---machine-learning---deep-learning-32',
        N'AI involves creating machines that can perform tasks that typically require human intelligence. Machine learning and deep learning are subfields of AI that enable machines to learn from data. Deep learning is a type of machine learning that involves training artificial neural networks to recognize patterns in data.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (33, 7, N'Artificial intelligence', N'artificial-intelligence-33',
        N'Artificial Intelligence (AI) refers to machines demonstrating intelligence, as opposed to natural human intelligence. It involves machines mimicking cognitive functions associated with the human mind, such as learning and problem-solving.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (34, 7, N'Mathematics for Machine Learning', N'mathematics-for-machine-learning-34',
        N'The Mathematics for Machine Learning course provides the fundamental math to understand and apply machine learning algorithms and models.',
        N'File', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (35, 8, N'Google AI education', N'google-ai-education-35',
        N'Lessons focus on fundamental topics of artificial intelligence, including machine learning, deep learning, neural networks, natural language processing, and computer vision. Lessons also provide real-life examples and projects to help learners apply their knowledge to real-life problems.',
        N'Video', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (36, 8, N'A Comprehensive Guide To Google AI', N'a-comprehensive-guide-to-google-ai-36',
        N'A Comprehensive Guide to Google AI là một tài liệu tổng quan về các dự án và sản phẩm Trí tuệ nhân tạo của Google, bao gồm các chủ đề như Machine Learning, Deep Learning, Natural Language Processing, Computer Vision, Robotics và các công cụ AI của Google như TensorFlow, Google Cloud AI Platform và Google AutoML',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (37, 8, N'Responsible AI practices', N'responsible-ai-practices-37',
        N'Responsible AI Practices is an introductory course on principles and methods for responsible development and implementation of Artificial Intelligence (AI), including ethics, social responsibility, security and privacy, and AI-related regulations and standards.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (38, 8, N'Educational resources', N'educational-resources-38',
        N'Educational resources are educational resources in Artificial Intelligence and Machine Learning, including online courses, books, articles, videos, and other materials to provide basic and advanced knowledge of algorithms and machine learning models, AI tools and libraries, and applications of AI in various fields.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (39, 8, N'AI Principles  2020 Progress', N'ai-principles--2020-progress-39',
        N'AI Principles 2020 Progress is Google''s report on progress in implementing the company''s Artificial Intelligence principles, including ethics, social responsibility, security and privacy, and related regulations and standards. related to AI.',
        N'File', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (40, 9, N'React native', N'react-native-40',
        N'In this series, we''ll go from beginner to ninja and create React Native apps from scratch. However, first, we''ll set up and talk about what React Native really is.',
        N'Video', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (41, 9, N'Networking', N'networking-41',
        N'A Comprehensive Guide to Google AI is an overview document of Google''s Artificial Intelligence projects and products, covering topics such as Machine Learning, Deep Learning, Natural Language Processing, Computer Vision, Robotics, and tools. Google AI like TensorFlow, Google Cloud AI Platform and Google AutoML',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (42, 9, N'Responsible AI practices', N'responsible-ai-practices-42',
        N'Responsible AI Practices is an introductory course on principles and methods for responsible development and implementation of Artificial Intelligence (AI), including ethics, social responsibility, security and privacy, and AI-related regulations and standards.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (43, 9, N'Educational resources', N'educational-resources-43',
        N'Educational resources are educational resources in Artificial Intelligence and Machine Learning, including online courses, books, articles, videos, and other materials to provide basic and advanced knowledge of algorithms and machine learning models, AI tools and libraries, and applications of AI in various fields.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (44, 9, N'React Up & Running', N'react-up--running-44',
        N'React is a popular JavaScript library for building user interfaces for web and mobile applications. It is developed by Facebook and uses a "component-based" approach to separate the components of the user interface and allow them to be reused in different applications.',
        N'File', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (45, 10, N'Starting out', N'starting-out-45',
        N'The lesson is about starting the steps to familiarize yourself with objectivec-c from the basics', N'Video',
        CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (46, 10, N'Objective-C Tutorial', N'objective-c-tutorial-46',
        N'Objective-C is a general-purpose, object-oriented programming language that adds Smalltalk-style messaging to the C programming language. This is the main programming language used by Apple for the OS X and iOS operating systems and their respective APIs, Cocoa and Cocoa Touch. This reference will take you through simple and practical approach while learning Objective-C Programming language',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (47, 10, N'Objective C Tutorial - Objective-C Tutorial', N'objective-c-tutorial---objective-c-tutorial-47',
        N'Foundation Framework has libraries and features that we can use.It includes an extended list of data types like NSArray, NSDictionary, NSSet, etc.Foundation Framework has a set of functions that we can use to manipulate files, strings, etc.',
        N'Docs', CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (48, 10, N'Advantages and disadvantages of Swift compared to Objective C',
        N'advantages-and-disadvantages-of-swift-compared-to-objective-c-48',
        N'Swift và Objective C,Advantages of Swift over Objective C,Nhược điểm của Swift so với Objective C', N'Docs',
        CAST(N'2023-06-28' AS Date), 0)
GO
INSERT [dbo].[lessons] ([id], [course_id], [title], [slug], [description], [lessons_type], [created_at], [isDisable])
VALUES (49, 10, N'The Objective-C Programming Language', N'the-objective-c-programming-language-49',
        N'object-oriented programming language based on standard C, and provides a foundation for learning about Mac OS X''s Objective-C application development.',
        N'File', CAST(N'2023-06-28' AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[lessons] OFF
GO
SET IDENTITY_INSERT [dbo].[video] ON
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (2, 10, N'Introduction to C# Programming Language', N'https://www.youtube.com/embed/02iadn_qqSE')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (3, 15, N'Introduction to C Programming Language', N'https://www.youtube.com/embed/false')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (4, 20, N'C++ Introduction', N'https://www.youtube.com/embed/jcYaWFhV8oY')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (5, 25, N'Python Introduction', N'https://www.youtube.com/embed/kqtD5dpn9C8')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (6, 26, N'MIT Introduction to Deep Learning', N'https://www.youtube.com/embed/QDX-1M5Nj7s')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (7, 31, N'AI For Everyone LESSON 1: Introduction to Artificial Intelligence for Absolute Beginners',
        N'https://www.youtube.com/embed/gD_HWj_hvbo')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (8, 35, N'Introduction to Generative AI', N'https://www.youtube.com/embed/G2fqAlgmoPo')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (9, 40, N'React Native Tutorial #1 - Introduction', N'https://www.youtube.com/embed/ur6I5m2nTvk')
GO
INSERT [dbo].[video] ([id], [lessons], [videoName], [videoLink])
VALUES (10, 45, N'Objective-C on the Mac L1 - Starting out', N'https://www.youtube.com/embed/1jDS9KCYwFI')
GO
SET IDENTITY_INSERT [dbo].[video] OFF
GO
SET IDENTITY_INSERT [dbo].[Docs] ON
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (1, 2, N'<header>
<h1>Element: setAttribute() method</h1>
</header>
<div class="section-content">
<p>Sets the value of an attribute on the specified element. If the attribute already exists, the value is updated; otherwise a new attribute is added with the specified name and value.</p>
<p>To get the current value of an attribute, use&nbsp;<a title="getAttribute()" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttribute"><code>getAttribute()</code></a>; to remove an attribute, call&nbsp;<a title="removeAttribute()" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttribute"><code>removeAttribute()</code></a>.</p>
</div>
<section aria-labelledby="syntax">
<h2 id="syntax"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#syntax">Syntax</a></h2>
<div class="section-content">
<div class="code-example">
<p class="example-header"><span class="language-name">JS</span><button class="icon copy-icon" type="button"><span class="visually-hidden">Copy to Clipboard</span></button></p>
<pre class="brush: js notranslate"><code><span class="token function">setAttribute</span><span class="token punctuation">(</span>name<span class="token punctuation">,</span> value<span class="token punctuation">)</span>
</code></pre>
<p>&nbsp;</p>
</div>
</div>
</section>
<section aria-labelledby="parameters">
<h3 id="parameters"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#parameters">Parameters</a></h3>
<div class="section-content">
<dl>
<dt><code>name</code></dt>
<dd>
<p>A string specifying the name of the attribute whose value is to be set. The attribute name is automatically converted to all lower-case when&nbsp;<code>setAttribute()</code>&nbsp;is called on an HTML element in an HTML document.</p>
</dd>
<dt id="value"><code>value</code></dt>
<dd>
<p>A string containing the value to assign to the attribute. Any non-string value specified is converted automatically into a string.</p>
</dd>
</dl>
<p>Boolean attributes are considered to be&nbsp;<code>true</code>&nbsp;if they''re present on the element at all. You should set&nbsp;<code>value</code>&nbsp;to the empty string (<code>""</code>) or the attribute''s name, with no leading or trailing whitespace. See the&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#examples">example</a>&nbsp;below for a practical demonstration.</p>
<p>Since the specified&nbsp;<code>value</code>&nbsp;gets converted into a string, specifying&nbsp;<code>null</code>&nbsp;doesn''t necessarily do what you expect. Instead of removing the attribute or setting its value to be&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/null"><code>null</code></a>, it instead sets the attribute''s value to the string&nbsp;<code>"null"</code>. If you wish to remove an attribute, call&nbsp;<a title="removeAttribute()" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttribute"><code>removeAttribute()</code></a>.</p>
</div>
</section>
<section aria-labelledby="return_value">
<h3 id="return_value"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#return_value">Return value</a></h3>
<div class="section-content">
<p>None (<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/undefined"><code>undefined</code></a>).</p>
</div>
</section>
<section aria-labelledby="exceptions">
<h3 id="exceptions"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#exceptions">Exceptions</a></h3>
<div class="section-content">
<dl>
<dt id="invalidcharactererror"><code>InvalidCharacterError</code>&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/API/DOMException"><code>DOMException</code></a></dt>
<dd>
<p>The specified attribute&nbsp;<code>name</code>&nbsp;contains one or more characters which are not valid in attribute names.</p>
</dd>
</dl>
</div>
</section>
<section aria-labelledby="examples">
<h2 id="examples"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#examples">Examples</a></h2>
<div class="section-content">
<p>In the following example,&nbsp;<code>setAttribute()</code>&nbsp;is used to set attributes on a&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/button"><code>&lt;button&gt;</code></a>.</p>
</div>
</section>
<section aria-labelledby="html">
<h3 id="html"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#html">HTML</a></h3>
<div class="section-content">
<div class="code-example">
<p class="example-header"><span class="language-name">HTML</span><button class="play-button external" title="Open in Playground" type="button" data-play="examples">Play</button><button class="icon copy-icon" type="button"><span class="visually-hidden">Copy to Clipboard</span></button></p>
<pre class="brush: html notranslate"><code><span class="token tag"><span class="token punctuation">&lt;</span>button<span class="token punctuation">&gt;</span></span>Hello World<span class="token tag"><span class="token punctuation">&lt;/</span>button<span class="token punctuation">&gt;</span></span>
</code></pre>
<p>&nbsp;</p>
</div>
<div class="code-example">&nbsp;</div>
</div>
</section>
<section aria-labelledby="javascript">
<h3 id="javascript"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#javascript">JavaScript</a></h3>
<div class="section-content">
<div class="code-example">
<p class="example-header"><span class="language-name">JS</span><button class="play-button external" title="Open in Playground" type="button" data-play="examples">Play</button><button class="icon copy-icon" type="button"><span class="visually-hidden">Copy to Clipboard</span></button></p>
<pre class="brush: js notranslate"><code><span class="token keyword">const</span> button <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">querySelector</span><span class="token punctuation">(</span><span class="token string">"button"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

button<span class="token punctuation">.</span><span class="token function">setAttribute</span><span class="token punctuation">(</span><span class="token string">"name"</span><span class="token punctuation">,</span> <span class="token string">"helloButton"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
button<span class="token punctuation">.</span><span class="token function">setAttribute</span><span class="token punctuation">(</span><span class="token string">"disabled"</span><span class="token punctuation">,</span> <span class="token string">""</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre>
<p>&nbsp;</p>
</div>
<div id="sect1" class="code-example">
<p class="example-header"><button class="play-button external" title="Open in Playground" type="button" data-play="examples">Play</button></p>
<iframe id="frame_examples" class="sample-code-frame" title="Examples sample" src="https://live.mdnplay.dev/en-US/docs/Web/API/Element/setAttribute/runner.html?id=examples" width="300" height="60" loading="lazy"></iframe></div>
<p>This demonstrates two things:</p>
<ul>
<li>The first call to&nbsp;<code>setAttribute()</code>&nbsp;above shows changing the&nbsp;<code>name</code>&nbsp;attribute''s value to "helloButton". You can see this using your browser''s page inspector (<a class="external" href="https://developer.chrome.com/docs/devtools/dom/properties/" target="_blank" rel="noopener">Chrome</a>,&nbsp;<a class="external" href="https://docs.microsoft.com/microsoft-edge/devtools-guide-chromium/css/inspect" target="_blank" rel="noopener">Edge</a>,&nbsp;<a class="external" href="https://firefox-source-docs.mozilla.org/devtools-user/page_inspector/how_to/open_the_inspector/index.html" target="_blank" rel="noopener">Firefox</a>,&nbsp;<a class="external" href="https://support.apple.com/en-us/guide/safari-developer/welcome/mac" target="_blank" rel="noopener">Safari</a>).</li>
<li>To set the value of a Boolean attribute, such as&nbsp;<code>disabled</code>, you can specify any value. An empty string or the name of the attribute are recommended values. All that matters is that if the attribute is present at all,&nbsp;<em>regardless of its actual value</em>, its value is considered to be&nbsp;<code>true</code>. The absence of the attribute means its value is&nbsp;<code>false</code>. By setting the value of the&nbsp;<code>disabled</code>&nbsp;attribute to the empty string (<code>""</code>), we are setting&nbsp;<code>disabled</code>&nbsp;to&nbsp;<code>true</code>, which results in the button being disabled.</li>
</ul>
<p>DOM methods dealing with element''s attributes:</p>
<figure class="table-container">
<table class="standard-table">
<thead>
<tr>
<th>Not namespace-aware, most commonly used methods</th>
<th>Namespace-aware variants (DOM Level 2)</th>
<th>DOM Level 1 methods for dealing with&nbsp;<code>Attr</code>&nbsp;nodes directly (seldom used)</th>
<th>DOM Level 2 namespace-aware methods for dealing with&nbsp;<code>Attr</code>&nbsp;nodes directly (seldom used)</th>
</tr>
</thead>
<tbody>
<tr>
<td><a title="setAttribute" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute" aria-current="page"><code>setAttribute</code></a>&nbsp;(DOM 1)</td>
<td><a title="setAttributeNS" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNS"><code>setAttributeNS</code></a></td>
<td><a title="setAttributeNode" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNode"><code>setAttributeNode</code></a></td>
<td><a title="setAttributeNodeNS" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNodeNS"><code>setAttributeNodeNS</code></a></td>
</tr>
<tr>
<td><a title="getAttribute" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttribute"><code>getAttribute</code></a>&nbsp;(DOM 1)</td>
<td><a title="getAttributeNS" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNS"><code>getAttributeNS</code></a></td>
<td><a title="getAttributeNode" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNode"><code>getAttributeNode</code></a></td>
<td><a title="getAttributeNodeNS" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNodeNS"><code>getAttributeNodeNS</code></a></td>
</tr>
<tr>
<td><a title="hasAttribute" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttribute"><code>hasAttribute</code></a>&nbsp;(DOM 2)</td>
<td><a title="hasAttributeNS" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttributeNS"><code>hasAttributeNS</code></a></td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td><a title="removeAttribute" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttribute"><code>removeAttribute</code></a>&nbsp;(DOM 1)</td>
<td><a title="removeAttributeNS" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNS"><code>removeAttributeNS</code></a></td>
<td><a title="removeAttributeNode" href="https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNode"><code>removeAttributeNode</code></a></td>
<td>-</td>
</tr>
</tbody>
</table>
</figure>
</div>
</section>
<h2 id="specifications"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#specifications">Specifications</a></h2>
<table class="standard-table">
<thead>
<tr>
<th scope="col">Specification</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://dom.spec.whatwg.org/#ref-for-dom-element-setattribute%E2%91%A0">DOM Standard<br><small>#&nbsp;ref-for-dom-element-setattribute①</small></a></td>
</tr>
</tbody>
</table>
<h2 id="browser_compatibility"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#browser_compatibility">Browser compatibility</a></h2>
<p><a class="bc-github-link external external-icon" title="Report an issue with this compatibility data" href="https://github.com/mdn/browser-compat-data/issues/new?mdn-url=https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FAPI%2FElement%2FsetAttribute&amp;metadata=%3C%21--+Do+not+make+changes+below+this+line+--%3E%0A%3Cdetails%3E%0A%3Csummary%3EMDN+page+report+details%3C%2Fsummary%3E%0A%0A*+Query%3A+%60api.Element.setAttribute%60%0A*+Report+started%3A+2023-06-26T16%3A32%3A52.992Z%0A%0A%3C%2Fdetails%3E&amp;title=api.Element.setAttribute+-+%3CSUMMARIZE+THE+PROBLEM%3E&amp;template=data-problem.yml" target="_blank" rel="noopener noreferrer">Report problems with this compatibility data on GitHub</a></p>
<figure class="table-container">
<figure class="table-container-inner">
<table class="bc-table bc-table-web">
<thead>
<tr class="bc-platforms">
<td>&nbsp;</td>
<th class="bc-platform bc-platform-desktop" title="desktop" colspan="5"><span class="visually-hidden">desktop</span></th>
<th class="bc-platform bc-platform-mobile" title="mobile" colspan="6"><span class="visually-hidden">mobile</span></th>
</tr>
<tr class="bc-browsers">
<td>&nbsp;</td>
<th class="bc-browser bc-browser-chrome">
<div class="bc-head-txt-label bc-head-icon-chrome">Chrome</div>
<div class="bc-head-icon-symbol icon icon-chrome">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-edge">
<div class="bc-head-txt-label bc-head-icon-edge">Edge</div>
<div class="bc-head-icon-symbol icon icon-edge">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-firefox">
<div class="bc-head-txt-label bc-head-icon-firefox">Firefox</div>
<div class="bc-head-icon-symbol icon icon-simple-firefox">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-opera">
<div class="bc-head-txt-label bc-head-icon-opera">Opera</div>
<div class="bc-head-icon-symbol icon icon-opera">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-safari">
<div class="bc-head-txt-label bc-head-icon-safari">Safari</div>
<div class="bc-head-icon-symbol icon icon-safari">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-chrome_android">
<div class="bc-head-txt-label bc-head-icon-chrome_android">Chrome Android</div>
<div class="bc-head-icon-symbol icon icon-chrome">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-firefox_android">
<div class="bc-head-txt-label bc-head-icon-firefox_android">Firefox for Android</div>
<div class="bc-head-icon-symbol icon icon-simple-firefox">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-opera_android">
<div class="bc-head-txt-label bc-head-icon-opera_android">Opera Android</div>
<div class="bc-head-icon-symbol icon icon-opera">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-safari_ios">
<div class="bc-head-txt-label bc-head-icon-safari_ios">Safari on iOS</div>
<div class="bc-head-icon-symbol icon icon-safari">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-samsunginternet_android">
<div class="bc-head-txt-label bc-head-icon-samsunginternet_android">Samsung Internet</div>
<div class="bc-head-icon-symbol icon icon-samsunginternet">&nbsp;</div>
</th>
<th class="bc-browser bc-browser-webview_android">
<div class="bc-head-txt-label bc-head-icon-webview_android">WebView Android</div>
<div class="bc-head-icon-symbol icon icon-webview">&nbsp;</div>
</th>
</tr>
</thead>
<tbody>
<tr>
<th class="bc-feature bc-feature-depth-0" scope="row">
<div class="bc-table-row-header"><code>setAttribute</code></div>
</th>
<td class="bc-support bc-browser-chrome bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2008-12-11">1</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-edge bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2015-07-28">12</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-firefox bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2004-11-09">1</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-opera bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2005-04-19">8</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-safari bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2003-06-23">1</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-chrome_android bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2012-06-27">18</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-firefox_android bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2011-03-29">4</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-opera_android bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2010-11-09">10.1</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-safari_ios bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2007-06-29">1</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-samsunginternet_android bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2013-04-27">1.0</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
<td class="bc-support bc-browser-webview_android bc-supports-yes bc-has-history" aria-expanded="false">
<div class="bcd-cell-text-wrapper">
<div class="bcd-cell-icons">&nbsp;</div>
<div class="bcd-cell-text-copy"><span class="bc-version-label" title="Released 2013-12-09">4.4</span></div>
</div>
<button title="Toggle history" type="button"><span class="offscreen">Toggle history</span></button></td>
</tr>
</tbody>
</table>
</figure>
</figure>
<section class="bc-legend">
<h3 id="Legend" class="visually-hidden">Legend</h3>
<p class="bc-legend-tip">Tip: you can click/tap on a cell for more information.</p>
<div class="bc-legend-item"><span class="bc-supports-yes bc-supports"><abbr class="bc-level bc-level-yes icon icon-yes" title="Full support"><span class="visually-hidden">Full support</span></abbr></span>Full support</div>
</section>
<section aria-labelledby="gecko_notes">
<h3 id="gecko_notes"><a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute#gecko_notes">Gecko notes</a></h3>
<div class="section-content">
<p>Using&nbsp;<code>setAttribute()</code>&nbsp;to modify certain attributes, most notably&nbsp;<code>value</code>&nbsp;in XUL, works inconsistently, as the attribute specifies the default value. To access or modify the current values, you should use the properties. For example, use&nbsp;<code>Element.value</code>&nbsp;instead of&nbsp;<code>Element.setAttribute()</code>.</p>
</div>
</section>
<aside class="metadata">
<div class="metadata-content-container">
<div id="on-github" class="on-github">
<h3>Found a content problem with this page?</h3>
<ul>
<li><a title="This will take you to GitHub, where you''ll need to sign in first." href="https://github.com/mdn/content/edit/main/files/en-us/web/api/element/setattribute/index.md" target="_blank" rel="noopener noreferrer">Edit the page on GitHub</a>.</li>
<li><a title="This will take you to GitHub to file a new issue." href="https://github.com/mdn/content/issues/new?template=page-report.yml&amp;mdn-url=https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FAPI%2FElement%2FsetAttribute&amp;metadata=%3C%21--+Do+not+make+changes+below+this+line+--%3E%0A%3Cdetails%3E%0A%3Csummary%3EPage+report+details%3C%2Fsummary%3E%0A%0A*+Folder%3A+%60en-us%2Fweb%2Fapi%2Felement%2Fsetattribute%60%0A*+MDN+URL%3A+https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FAPI%2FElement%2FsetAttribute%0A*+GitHub+URL%3A+https%3A%2F%2Fgithub.com%2Fmdn%2Fcontent%2Fblob%2Fmain%2Ffiles%2Fen-us%2Fweb%2Fapi%2Felement%2Fsetattribute%2Findex.md%0A*+Last+commit%3A+https%3A%2F%2Fgithub.com%2Fmdn%2Fcontent%2Fcommit%2Fbbf7f25f9cf95fb154e2740a9fdc9c02818981bf%0A*+Document+last+modified%3A+2023-04-07T05%3A55%3A26.000Z%0A%0A%3C%2Fdetails%3E" target="_blank" rel="noopener noreferrer">Report the content issue</a>.</li>
<li><a title="Folder: en-us/web/api/element/setattribute (Opens in a new tab)" href="https://github.com/mdn/content/blob/main/files/en-us/web/api/element/setattribute/index.md?plain=1" target="_blank" rel="noopener noreferrer">View the source on GitHub</a>.</li>
</ul>
Want to get more involved?&nbsp;<a title="This will take you to our contribution guidelines on GitHub." href="https://github.com/mdn/content/blob/main/CONTRIBUTING.md" target="_blank" rel="noopener noreferrer">Learn how to contribute</a>.</div>
<p class="last-modified-date">This page was last modified on&nbsp;<time datetime="2023-04-07T05:55:26.000Z">Apr 7, 2023</time>&nbsp;by&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute/contributors.txt">MDN contributors</a>.</p>
<p class="last-modified-date"><img src="data:image/jpeg;base64,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" alt="How to Change HTML Attributes Value with JavaScript | HTML CSS JavaScript  Examples - YouTube"></p>
</div>
</aside>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (2, 3, N'<header class="entry-header">
<h1 class="entry-title">JavaScript : Advantages and disadvantages of External JavaScript ?</h1>
<div class="entry-meta"><span class="byline">By&nbsp;<span class="author vcard"><a class="url fn n" href="https://www.scmgalaxy.com/tutorials/author/vikashdev/">Vikashdev K</a></span></span><span class="posted-on"><a href="https://www.scmgalaxy.com/tutorials/2021/10/01/" rel="bookmark"><time class="entry-date published" datetime="2021-10-01T13:09:24+00:00">October 1, 2021</time></a></span><span class="cat-links"><a href="https://www.scmgalaxy.com/tutorials/category/javascript/" rel="category tag">JavaScript</a></span></div>
</header>
<div class="mt-3">&nbsp;</div>
<div class="entry-content">
<div class="post-views content-post post-9358 entry-meta">&nbsp;<span class="post-views-label">Post Views:</span>&nbsp;<span class="post-views-count">28</span></div>
<h3>Advantages :</h3>
<p>Following are the Advantages of javaScript over external :-</p>
<ul>
<li>Reusability of code.</li>
<li>Easy code readability.</li>
<li>It Enables both web designers and coders to work with html and js files.</li>
<li>With these small js files, you can use&nbsp;Google closure or YUI Compressor or other minifying tools to reduce the size and make it not readable by humans .</li>
</ul>
<h3>Disadvantages :</h3>
<p>Following are the disadvantages of javaScript over external :-</p>
<ul>
<li>Code can be downloaded using the url of&nbsp;the js file. This can help coders to steal your code easily.</li>
<li>If two js files are dependent on one another, then a failure in one file may affect the execution of the other dependent file.</li>
<li>A small change to a common&nbsp;js file may cause unexpected results in some of the HTML files .</li>
<li>The browser has to make an extra http request to get the js code.</li>
<li><img src="data:image/png;base64,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" alt="jquery - Change Attribute of Object Element in Javascript - Stack Overflow"></li>
<li><img src="data:image/jpeg;base64,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" alt="Change attribute value for a HTML element in JavaScript"></li>
</ul>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (3, 4, N'<p>The HTML DOM permits you to change the HTML content by utilizing the &ldquo;<strong>innerHTML</strong>&rdquo; property. The &ldquo;<strong>innerHTML</strong>&rdquo; is typically used in web pages to generate dynamic HTML content such as comment forms, registration forms, and links.</p>
<p>&nbsp;</p>
<p>This write-up will discuss the procedure for changing the HTML elements using JavaScript. Moreover, the examples related to the usage of innerHTML property will also be demonstrated in this article. So, let&rsquo;s start!</p>
<h2>Syntax of innerHTML JavaScript property</h2>
<div class="codecolorer-container java blackboard">
<div class="java codecolorer">element.<span class="me1">innerHTML</span>&nbsp;<span class="sy0">=</span>&nbsp;value</div>
</div>
<p>Here, &ldquo;<strong>element</strong>&rdquo; is the HTML element you have selected to change its content, and &ldquo;<strong>value</strong>&rdquo; is the content we will set.</p>
<p><img src="data:image/jpeg;base64,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" alt="Module 7: Accessing DOM with JavaScript - презентация онлайн"></p>
<p><img src="data:image/png;base64,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" alt="How to Change HTML Element''s Content in JavaScript"></p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (4, 6, N'<h3 class="section-title">What is C# (C-Sharp)?</h3>
<p>C#, pronounced "C-sharp," is an&nbsp;<a href="https://www.techtarget.com/searchapparchitecture/definition/object-oriented-programming-OOP">object-oriented programming</a>&nbsp;language from Microsoft that enables developers to build applications that run on the&nbsp;<a href="https://www.techtarget.com/whatis/definition/NET-Framework">.NET platform</a>. C# has its roots in the&nbsp;<a href="https://www.techtarget.com/searchwindowsserver/definition/C">C</a>&nbsp;family of programming languages and shares many of the same characteristics as those found in C and C++, as well as in&nbsp;<a href="https://www.theserverside.com/definition/Java">Java</a>&nbsp;and&nbsp;<a href="https://www.theserverside.com/definition/JavaScript">JavaScript</a>.</p>
<p>The C# language was developed within Microsoft primarily by Anders Hejlsberg, Scott Wiltamuth and Peter Golde. Microsoft released the first widely distributed implementation of C# in July 2000 as part of its .NET&nbsp;<a href="https://www.techtarget.com/whatis/definition/framework">framework</a>&nbsp;initiative. C# was intended to be a simple, modern and general-purpose programming language that could be used to develop software&nbsp;<a href="https://www.techtarget.com/whatis/definition/component">components</a>&nbsp;for a&nbsp;<a href="https://www.techtarget.com/searchnetworking/definition/DCE">distributed environment</a>. The newly released C# emphasized source code&nbsp;<a href="https://www.techtarget.com/searchstorage/definition/portability">portability</a>&nbsp;with support for both hosted and&nbsp;<a href="https://www.techtarget.com/iotagenda/definition/embedded-system">embedded systems</a>.</p>
<p>The following figure shows the C# code for a simple console application as it appears in&nbsp;<a href="https://www.techtarget.com/searchapparchitecture/tip/WebStorm-vs-Visual-Studio-and-how-to-choose-the-right-IDE">Visual Studio</a>. The application adds together two&nbsp;<a href="https://www.techtarget.com/whatis/definition/integer">integers</a>&nbsp;that are entered by the user and then returns the total to the console.</p>
<figure class="main-article-image full-col" data-img-fullsize="https://cdn.ttgtmedia.com/rms/onlineimages/c_image-f.jpg"><img class="" src="https://cdn.ttgtmedia.com/rms/onlineimages/c_image-f_mobile.jpg" srcset="https://cdn.ttgtmedia.com/rms/onlineimages/c_image-f_mobile.jpg 960w,https://cdn.ttgtmedia.com/rms/onlineimages/c_image-f.jpg 1280w" alt="C# code example screenshot." width="560" height="408" data-src="https://cdn.ttgtmedia.com/rms/onlineimages/c_image-f_mobile.jpg" data-srcset="https://cdn.ttgtmedia.com/rms/onlineimages/c_image-f_mobile.jpg 960w,https://cdn.ttgtmedia.com/rms/onlineimages/c_image-f.jpg 1280w">
<figcaption>C# code for a simple console application.</figcaption>
<div class="main-article-image-enlarge">&nbsp;</div>
</figure>
<p>C# provides a basic, readable language for building an&nbsp;<a href="https://infocenter.informationbuilders.com/wf80/index.jsp?topic=%2Fpubdocs%2Freporting%2FDevelopingAppsWithWFLanguage%2Fsource%2Ftopic9.htm" target="_blank" rel="noopener">application''s logic</a>, while hiding much of the underlying complexity of the language''s inherent capabilities. The language is currently standardized under the specification&nbsp;<a href="https://www.techtarget.com/searchdatacenter/definition/ISO">ISO</a>/IEC 23270: Information technology -- Programming languages -- C#. The specification was originally based on a submission from Hewlett-Packard, Intel and Microsoft. It is in its third edition, which was released in 2018.</p>
<figure class="main-article-image half-col" data-img-fullsize="https://cdn.ttgtmedia.com/rms/onlineimages/whatis-object_oriented_programming.png"><img class="" src="https://cdn.ttgtmedia.com/rms/onlineimages/whatis-object_oriented_programming_half_column_mobile.png" srcset="https://cdn.ttgtmedia.com/rms/onlineimages/whatis-object_oriented_programming_half_column_mobile.png 960w,https://cdn.ttgtmedia.com/rms/onlineimages/whatis-object_oriented_programming.png 1280w" alt="Diagram of the object-orientated programming structure." width="279" height="285" data-src="https://cdn.ttgtmedia.com/rms/onlineimages/whatis-object_oriented_programming_half_column_mobile.png" data-srcset="https://cdn.ttgtmedia.com/rms/onlineimages/whatis-object_oriented_programming_half_column_mobile.png 960w,https://cdn.ttgtmedia.com/rms/onlineimages/whatis-object_oriented_programming.png 1280w">
<figcaption>An example of the structure and naming in object-orientated programming.</figcaption>
<div class="main-article-image-enlarge">&nbsp;</div>
</figure>
<p>Since its introduction, C# has been widely adopted and is the de facto programming language for most Windows-based development. The language, along with the .NET framework, can also be used to develop applications for systems running&nbsp;<a href="https://www.techtarget.com/searchdatacenter/definition/Linux-operating-system">Linux</a>,&nbsp;<a href="https://www.techtarget.com/whatis/definition/Mac-OS">macOS</a>,&nbsp;<a href="https://www.techtarget.com/searchmobilecomputing/definition/iOS">iOS</a>&nbsp;or&nbsp;<a href="https://www.techtarget.com/searchmobilecomputing/definition/Android-OS">Android</a>, although C# is used primarily to develop&nbsp;<a href="https://www.techtarget.com/searchenterprisedesktop/definition/Windows-10">Windows</a>&nbsp;applications.</p>
<p>C# is considered a&nbsp;<a href="https://www.techtarget.com/whatis/definition/strongly-typed">strongly typed language</a>, which means that every variable and constant has a type, as do expressions that evaluate to values. The type describes the structure and behavior of the data. This is important when defining and working with&nbsp;<a href="https://www.techtarget.com/whatis/definition/variable">variables</a>, which can be thought of as&nbsp;<a href="https://www.techtarget.com/whatis/definition/instance">instances</a>&nbsp;of types. C# supports two categories of types:</p>
<ul class="default-list">
<li><strong>Value types.</strong>&nbsp;Variables defined with&nbsp;<a href="https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/value-types" target="_blank" rel="noopener">value types</a>&nbsp;contain their data directly -- each variable has its own copy of the data and is isolated from other variables. The operation of one value type variable does not affect other value type variables. C# supports five subcategories of value types: simple types, struct types, enum types, nullable value types and tuple value types.</li>
<li><strong>Reference types.</strong>&nbsp;Variables defined with&nbsp;<a href="https://www.theserverside.com/feature/Java-naming-conventions-explained">reference types</a>&nbsp;store only references to their data, which are referred to as&nbsp;<a href="https://www.techtarget.com/searchapparchitecture/definition/object">objects</a>. Reference types make it possible for two variables to reference the same object, which means that operations on one variable could affect the object being referenced by another variable. C# supports four subcategories of reference types: class types, interface types, array types and delegate types.</li>
</ul>
<p>When building C# applications, developers can use type declarations to create new types. A type declaration defines the name and members of the new type. Type declarations are based on six of the subcategories available to value and reference types. They include struct types, enum types, tuple value types, class types, interface types and delegate types.</p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (5, 7, N'<ul class="breadcrumb">
<li><a href="https://www.learnhowtoprogram.com/c-and-net">C# and .NET</a></li>
&nbsp;
<li><a href="https://www.learnhowtoprogram.com/c-and-net/getting-started-with-c">Getting Started with C#</a></li>
&nbsp;
<li class="active">Installing C# and .NET</li>
</ul>
<ul class="nav nav-tabs">
<li class="active"><a href="https://www.learnhowtoprogram.com/c-and-net/getting-started-with-c/installing-c-and-net#text" data-toggle="tab">Text</a></li>
</ul>
<div class="tab-content">
<div id="text" class="tab-pane active in">
<p>First we''ll install .NET, which provides access to the C# language. Follow along with instructions for your operating system below.</p>
<h2 id="installing-the-net-sdk">Installing the .NET SDK</h2>
<hr>
<p>C# and .NET programming are fully supported on Mac operating systems. We can install .NET and C# on Mac, Windows, or Linux in a few steps:</p>
<ol>
<li>
<p>If you use a Mac computer, you need to determine whether your computer was made with the Apple Chip or Intel Chip, because there is a different SDK to download for each chip.&nbsp;<a href="https://support.apple.com/en-us/HT211814" target="_blank" rel="noopener noreferrer">Follow this Apple support article to learn whether your computer has an Apple chip or Intel chip.</a></p>
</li>
<li>
<p><strong>Download the .NET 6 SDK (Software Development Kit)</strong>. To view all download options for the .NET 6 SDK,&nbsp;<a href="https://dotnet.microsoft.com/en-us/download/dotnet/6.0" target="_blank" rel="noopener noreferrer">visit this page</a>. Or, click on any of the following links for an immediate download from Microsoft:</p>
<ul>
<li><a href="https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-6.0.402-windows-x64-installer" target="_blank" rel="noopener noreferrer">For Windows</a></li>
<li><a href="https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-6.0.402-macos-arm64-installer" target="_blank" rel="noopener noreferrer">For Macs with Apple Chip</a></li>
<li><a href="https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-6.0.402-macos-x64-installer" target="_blank" rel="noopener noreferrer">For Macs with Intel Chip</a></li>
</ul>
</li>
<li>
<p><strong>Open the file.</strong>&nbsp;This will launch an installer which will walk you through installation steps. Use the default settings the installer suggests.</p>
</li>
<li>
<p><strong>Confirm the installation is successful.</strong>&nbsp;First, restart your command line shell (Terminal or GitBash) if it''s already open, and then run the command&nbsp;<code>$ dotnet --version</code>. You should see something like this in response:</p>
</li>
</ol>
<pre><code class="bash hljs language-bash">6.0.402
</code></pre>
<p>This means both .NET and C# are successfully installed and your computer recognizes the&nbsp;<code>dotnet</code>&nbsp;command.</p>
<p>In the next two lessons, we''ll install&nbsp;<code>dotnet-script</code> and MySQL.</p>
<p><img src="data:image/jpeg;base64,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" alt="How to Download and Install Visual Studio for C# in Windows"></p>
<p><img src="data:image/jpeg;base64,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" alt="How to Download and Install Visual Studio for C# in Windows"></p>
</div>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (6, 8, N'<p><strong>Summary</strong>: in this tutorial, you&rsquo;ll learn about the basic C# syntax, including whitespace, statements, identifiers, keywords, literals, and comments.</p>
<h2 class="wp-block-heading">Introduction to the C# syntax</h2>
<p>C# syntax is similar to C/C++. This tutorial focuses on whitespace, statements, identifiers, keywords, literals, and comments.</p>
<h2 class="wp-block-heading">Whitespace</h2>
<p>Whitespace refers to the characters that do not have visible output, including:</p>
<ul>
<li>Carriage return</li>
<li>Space</li>
<li>New Line</li>
<li>Tab</li>
</ul>
<p>C# compiler ignores whitespace. But you use whitespace to make the code readable.</p>
<p>For example, the C# compiler will treat the following code snippets the same despite their differences in the presentation:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-1" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-comment">// with whitespace</span>
<span class="hljs-keyword">bool</span> isDark = <span class="hljs-literal">false</span>;

<span class="hljs-keyword">if</span> (isDark)
{
    website.EnableDarkMode();
}</code><small id="shcb-language-1" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<pre class="wp-block-code" aria-describedby="shcb-language-2" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-keyword">bool</span> isDark = <span class="hljs-literal">false</span>;
<span class="hljs-keyword">if</span> (isDark){ website.EnableDarkMode();}</code><small id="shcb-language-2" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<h2 class="wp-block-heading">Statements</h2>
<p>A statement is a source code instruction that declares a type or instructs the program to do something. A simple statement is terminated by a semicolon (;).</p>
<p>For example, the following code has two simple statements:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-3" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-keyword">int</span> age = <span class="hljs-number">9</span>;
Console.WriteLine(<span class="hljs-string">"Welcome to C#"</span>);</code><small id="shcb-language-3" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<p>The first statement&nbsp;<a href="https://www.csharptutorial.net/csharp-tutorial/csharp-variables/">defines an integer variable</a>&nbsp;and initializes its values to 9. The second statement prints out a message to the console window.</p>
<h3 class="wp-block-heading">Blocks</h3>
<p>A block is a sequence of zero or more statements. A block starts with an opening curly brace (<code>{</code>) and ends with a closing curly brace (<code>}</code>).</p>
<p>For example, you can group the two statements above into a block like this:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-4" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs">{
    <span class="hljs-keyword">int</span> age = <span class="hljs-number">9</span>;
    Console.WriteLine(<span class="hljs-string">"Welcome to C#"</span>);
}</code><small id="shcb-language-4" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<p>Unlike a statment, a block does not require a semicolon (<code>;</code>).</p>
<h2 class="wp-block-heading">Identifiers</h2>
<p>Identifiers are names that you choose for&nbsp;<a href="https://www.csharptutorial.net/csharp-tutorial/csharp-variables/">variables</a>,&nbsp;<a href="https://www.csharptutorial.net/csharp-tutorial/csharp-functions/">functions</a>,&nbsp;<a href="https://www.csharptutorial.net/csharp-tutorial/csharp-class/">classes</a>, methods, and so on. The identifier names follow these rules:</p>
<ul>
<li>The alphabetic (a through z, A through Z) and underscore (<code>_</code>) characters can appear at any position.</li>
<li>Digits cannot appear in the first position but everywhere else.</li>
</ul>
<p>C# identifiers are case-sensitive. For example,&nbsp;<code>counter</code>&nbsp;and&nbsp;<code>Counter</code>&nbsp;identifiers are different.</p>
<h2 class="wp-block-heading">Keywords</h2>
<p>Keywords are names that have special meanings to the compiler. All keywords are reserved identifiers. Therefore, you cannot use them as identifiers.</p>
<p>The following table shows the C# keywords:</p>
<figure class="wp-block-table">
<table>
<tbody>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-abstract-class/">abstract</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-events/">event</a></td>
<td>namespace</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-static-classes/">static</a></td>
</tr>
<tr>
<td>as</td>
<td>explicit</td>
<td>new</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-string/">string</a></td>
</tr>
<tr>
<td>base</td>
<td>extern</td>
<td>null</td>
<td>struct</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-bool/">bool</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-bool/">false</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-object/">object</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/c-switch/">switch</a></td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-break/">break</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-try-catch-finally/">finally</a></td>
<td>operator</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-this/">this</a></td>
</tr>
<tr>
<td>byte</td>
<td>fixed</td>
<td>out</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-throw-exception/">throw</a></td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/c-switch/">case</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/c-float/">float</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-virtual/">override</a></td>
<td>true</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-try-catch/">catch</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-for-loop/">for</a></td>
<td>params</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-try-catch/">try</a></td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-char/">char</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-foreach/">foreach</a></td>
<td>private</td>
<td>typeof</td>
</tr>
<tr>
<td>checked</td>
<td>goto</td>
<td>protected</td>
<td>uint</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-class/">class</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-if/">if</a></td>
<td>public</td>
<td>ulong</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-constants/">const</a></td>
<td>implicit</td>
<td>readonly</td>
<td>unchecked</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-continue/">continue</a></td>
<td>in</td>
<td>ref</td>
<td>unsafe</td>
</tr>
<tr>
<td>decimal</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-integer/">int</a></td>
<td>return</td>
<td>ushort</td>
</tr>
<tr>
<td>default</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-interface/">interface</a></td>
<td>sbyte</td>
<td>using</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-delegate/">delegate</a></td>
<td>internal</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-sealed/">sealed</a></td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-virtual/">virtual</a></td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-do-while/">do</a></td>
<td>is</td>
<td>short</td>
<td>void</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/c-float/">double</a></td>
<td>lock</td>
<td>sizeof</td>
<td>volatile</td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-if-else/">else</a></td>
<td>long</td>
<td>stackalloc</td>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-while/">while</a></td>
</tr>
<tr>
<td><a href="https://www.csharptutorial.net/csharp-tutorial/csharp-enum/">enum</a></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
</tbody>
</table>
</figure>
<p>Besides these keywords, C# has contextual keywords that provide specific meanings in the code. However, they are not reserved identifiers. And you&rsquo;ll learn about them later tutorial.</p>
<p>If you must use an identifier with the same name as a reserved keyword, you can prefix it with the&nbsp;<code>@</code>&nbsp;symbol. For example:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-5" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs">@<span class="hljs-keyword">class</span></code><small id="shcb-language-5" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<p>Note that the&nbsp;<code>@</code>&nbsp;symbol is not a part of the identifier. So&nbsp;<code>@myVariable</code>&nbsp;identifier is the same as&nbsp;<code>myVariable</code>.</p>
<p>In practice, you use the&nbsp;<code>@</code>&nbsp;symbol when interfacing with libraries of other .NET languages that have different keywords.</p>
<h2 class="wp-block-heading">Literals</h2>
<p>Literals are primitive values in the program. For example, an integer has the following literal:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-6" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-number">10</span></code><small id="shcb-language-6" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<p>To form a string, you place the text inside the double quotes (<code>"</code>) like this:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-7" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-string">"Hello"</span></code><small id="shcb-language-7" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<h2 class="wp-block-heading">Comments</h2>
<p>You use comments to explain the code or document it. The C# compiler ignores comments when compiling the program.</p>
<p>C# support three types of comments:</p>
<ul>
<li>Single-line comments</li>
<li>Delimited comments</li>
<li>Documentation comments</li>
</ul>
<h3 class="wp-block-heading">Single-line comments</h3>
<p>A single-line comment begins with a double forward-slash (<code>//</code>) and continues to the end of the line. For example:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-8" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-keyword">int</span> age = <span class="hljs-number">18</span>; <span class="hljs-comment">// your age</span></code><small id="shcb-language-8" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<p>In this example, here&rsquo;s the single-line comment:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-9" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-comment">// your age</span></code><small id="shcb-language-9" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<h3 class="wp-block-heading">Delimited comments</h3>
<p>A delimited comment starts with&nbsp;<code>/*</code>&nbsp;and ends with&nbsp;<code>*/</code>. A delimited comment can span any number of lines. For example:</p>
<pre class="wp-block-code" aria-describedby="shcb-language-10" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs"><span class="hljs-comment">/*
    A delimited comment can span multiple lines
    and is ingored by the C# compiler
*/</span></code><small id="shcb-language-10" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<h3 class="wp-block-heading">Documentation comments</h3>
<p>The documentation comments contain XML text used to make the program documentation.</p>
<pre class="wp-block-code" aria-describedby="shcb-language-11" data-shcb-language-name="C#" data-shcb-language-slug="cs"><code class="hljs language-cs">
<span class="hljs-comment"><span class="hljs-doctag">///</span> <span class="hljs-doctag">&lt;summary&gt;</span></span>
<span class="hljs-comment"><span class="hljs-doctag">///</span> The main program</span>
<span class="hljs-comment"><span class="hljs-doctag">///</span> <span class="hljs-doctag">&lt;/summary&gt;</span></span>
<span class="hljs-keyword">class</span> <span class="hljs-title">Program</span>
{
    <span class="hljs-comment">// ...</span>
}</code><small id="shcb-language-11" class="shcb-language"><span class="shcb-language__label">Code language:</span> <span class="shcb-language__name">C#</span> <span class="shcb-language__paren">(</span><span class="shcb-language__slug">cs</span><span class="shcb-language__paren">)</span></small></pre>
<p>The documentation starts with three contiguous forward slashes (<code>///</code>).</p>
<h2 class="wp-block-heading">Summary</h2>
<ul>
<li>C# compiler ignores whitespace such as carriage return, space, newline, and tab.</li>
<li>A simple statement is terminated with a semicolon (<code>;</code>). A block starts and ends with a pair of matching curly braces (<code>{}</code>).</li>
<li>C# identifers are case-sensitive.</li>
<li>C# supports single-line (<code>//...</code>), delimited comments (<code>/*...*/</code>), and documenation comments (<code>///</code>).&nbsp;</li>
<li><img src="data:image/jpeg;base64,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" alt="visual studio code - C# syntax highlight coloring - Stack Overflow"></li>
<li><img src="data:image/png;base64,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" alt="C# Simple Syntax Highlighting | coding.vision"></li>
<li>&nbsp;</li>
</ul>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (7, 11, N'<div class="detail-banner article-banner-details banner-height">
<div class="article-info test-class">
<h1>What is C Programming?</h1>
<div id="autorLinks"><a href="https://www.simplilearn.com/authors/simplilearn" target="_blank" rel="noopener">By&nbsp;Simplilearn</a></div>
Last updated on&nbsp;Feb 13, 2023<span class="view">24469</span></div>
<div class="right-widget-main">
<div class="img-bg-colr"><img title="What is C Programming?" src="https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_C_programming.jpg" alt="What is C Programming?" width="375" height="211"></div>
</div>
</div>
<div id="jumpLinks">
<div class="jump-links-wrap">
<h2>Table of Contents</h2>
<div><a title="Features of C Programming" href="https://www.simplilearn.com/c-programming-article#features_of_c_programming">Features of C Programming</a></div>
<div><a title="C Program to Find the Factorial of a Number" href="https://www.simplilearn.com/c-programming-article#c_program_to_find_the_factorial_of_a_number">C Program to Find the Factorial of a Number</a></div>
<div><a title="Career Prospects" href="https://www.simplilearn.com/c-programming-article#career_prospects">Career Prospects</a></div>
</div>
</div>
<div class="info-details">
<div id="articleLongDescription">
<article class="desig_author empty-text">
<p>The C&nbsp;<a title="programming language" href="https://www.simplilearn.com/best-programming-languages-start-learning-today-article" target="_blank" rel="noopener">programming language</a>&nbsp;is a general-purpose, operating system-agnostic, and procedural language that supports structured programming and provides low-level access to the system memory. Dennis Ritchie invented C language in 1972 at AT&amp;T (then called Bell Laboratory), where it was implemented in the UNIX system on DEC PDP II. It was also the successor of the B programming language invented by Ken Thompson. C was designed to overcome the problems encountered by BASIC, B, and BPCL programming languages. By 1980, C became the most popular language for mainframes, microcomputers, and minicomputers.&nbsp;</p>
<article>
<h2 id="features_of_c_programming"><strong>Features of C Programming</strong></h2>
<p>Loved by programmers for doing low-level coding and embedded programming, C has found its way gradually into the semiconductor, hardware, and storage industries. The most important features provided by the C programming languages include:</p>
<ul>
<li>It has inbuilt functions and operators that can solve virtually any complex problem</li>
<li>C is the combination of both low level (assembly) and high-level programming languages; also, it can be used to write an application and interact with low-level system memory and hardware</li>
<li>It can be written on practically any operating system and even works in most handheld devices</li>
<li>Programs written in C are speedy due to the support provided by its datatypes and operators</li>
<li>It is easily extendable, as C++ was derived from C with additions like OOPS and other features</li>
<li>The functions and operators are supported by the libraries provided by the programming language itself</li>
</ul>
<p><picture><source class="blend-mode" srcset="https://www.simplilearn.com/ice9/free_resources_article_thumb/c_programming.JPG" media="(max-width:605px)"><img class="blend-mode" src="https://www.simplilearn.com/ice9/free_resources_article_thumb/c_programming.JPG" alt="Features of C" width="405" height="222"></picture></p>
<blockquote>Get a firm foundation in C, the most commonly used programming language in software development with the C Programming Course.</blockquote>
<p>&nbsp;</p>
<p><strong>C Program (&ldquo;Hello World&rdquo;)</strong></p>
<p>#include &lt;stdio.h&gt;</p>
<p>#include &lt;conio.h&gt;</p>
<p>int main ()</p>
<p>{</p>
<p>int a = 1, b=2, c=0;</p>
<p>int c = a + b;</p>
<p>printf(&ldquo;Hello World&rdquo;);</p>
<p>printf(&ldquo;C = &ldquo; %d, c);</p>
<p>return 0;</p>
<p>}</p>
</article>
</article>
</div>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (8, 12, N'<h2>How to Install C?</h2>
<p>C is a high-level general-purpose language developed by American computer scientist Dennis M. Ritchie between 1969 and 1973 at Bell Labs of AT&amp;T (American Telephone &amp; Telegraph) located in the U.S.A. It was invented for writing&nbsp;<a href="https://www.educba.com/uses-of-unix/">UNIX</a>&nbsp;operating system. It is written in&nbsp;<a href="https://www.educba.com/what-is-assembly-language/">assembly language</a>. Dennis Ritchie and Brian Kernighan published the first edition K &amp; R C or &ldquo;The C Programming Language&rdquo; in 1978. Linux OS, Perl, Matz&rsquo;s Ruby, NumPy, Java&rsquo;s first compiler, web servers like Apache, Nginx and RDBMS MySQL are all written in C. It is the successor of three structured languages i.e. BCPL (Basic Combined Programming Language), ALGOL (Algorithmic Language) and B. Many features of C were inherited from these languages while many new features were also introduced such as pointers, struct, data types etc.</p>
<div class="code-block code-block-19">&nbsp;</div>
<p>In 1983 American National Standards Institute (ANSI) set up a committee to standardize the language as it was being used in projects concerning commercial and government projects.</p>
<p>It is a structure oriented programming language. It allows direct access to memory and direct control over the low-level aspects of the computer. It is mainly used for system development work such as designing databases, operating systems, language interpreters, language compilers, assemblers, text editors and much more. Many legacy programs are also written in C.</p>
<p>It is simple, efficient and easy to learn. It is the base to learn many other programming languages so it is sometimes also referred to as Mother of all programming languages<em>.</em></p>
<p>One major advantage is that it can be compiled on various platforms and produces efficient programs. It is portable or machine-independent also i.e. program once written in C language can be executed on other machines also. It is robust and there are many built-in functions present, which help programmers to develop programs quickly and efficiently. We can create our own functions also and can add them to the C library. It has a modular structure that works as a catalyst for code debugging, code testing, and maintenance of code. It also has the ability to extend itself as it can adopt new features easily and effectively. Its versatility makes it an efficient choice for high-data manipulation software such as&nbsp;<a href="https://www.educba.com/careers-in-3d-animation/">3D animation</a>.</p>
<p>It is a case-sensitive language i.e. continue and CONTINUE is treated differently. C follows the rules and regulations strictly hence is a strongly tight syntax-based programming language. It also provides the functionality of&nbsp;<a href="https://www.educba.com/pointers-in-c/">pointers</a>&nbsp;by which the user can directly refer to or interact with the memory. We can use recursion, i.e., calling the function in its definition itself hence enabling the use of backtracking.</p>
<p>It is a procedural language i.e. instructions are carried out step by step. It is also a statically typed language (Statically typed languages are those in which the type of variable is checked during compile time, not at run time. They are faster in comparison to dynamically typed language) hence errors are detected during a software development cycle.</p>
<p>It has a total of 32 Keywords and 45 operators, so it is easy to memorize and simple to learn. It follows a top-down programming approach. There are 5 built-in data types, i.e., integer (int), float, character (char), double and void.</p>
<p>C programs are difficult to debug and understand (unless comments are properly written). C provides no data protection, and&nbsp;<a href="https://www.educba.com/best-c-compilers/">C compilers</a> can only detect errors; they cannot handle exceptions.</p>
<p><img src="data:image/jpeg;base64,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" alt="Install C | Learn Step By Step Instructions To Install C In Simple Way"></p>
<p><img src="data:image/jpeg;base64,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" alt="How To Install C Programming Software In Laptop | C Installation Tutorial  For Beginners |Simplilearn - YouTube"></p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (9, 13, N'<h2>Tokens in C</h2>
<p>A C program consists of various tokens and a token is either a keyword, an identifier, a constant, a string literal, or a symbol. For example, the following C statement consists of five tokens &minus;</p>
<pre class="prettyprint notranslate">printf("Hello, World! \n");
</pre>
<p>The individual tokens are &minus;</p>
<pre class="prettyprint notranslate">printf
(
   "Hello, World! \n"
)
;
</pre>
<h2>Semicolons</h2>
<p>In a C program, the semicolon is a statement terminator. That is, each individual statement must be ended with a semicolon. It indicates the end of one logical entity.</p>
<p>Given below are two different statements &minus;</p>
<pre class="prettyprint notranslate">printf("Hello, World! \n");
return 0;
</pre>
<h2>Comments</h2>
<p>Comments are like helping text in your C program and they are ignored by the compiler. They start with /* and terminate with the characters */ as shown below &minus;</p>
<pre class="result notranslate">/* my first program in C */
</pre>
<p>You cannot have comments within comments and they do not occur within a string or character literals.</p>
<h2>Identifiers</h2>
<p>A C identifier is a name used to identify a variable, function, or any other user-defined item. An identifier starts with a letter A to Z, a to z, or an underscore ''_'' followed by zero or more letters, underscores, and digits (0 to 9).</p>
<p>C does not allow punctuation characters such as @, $, and % within identifiers. C is a&nbsp;<strong>case-sensitive</strong>&nbsp;programming language. Thus,&nbsp;<em>Manpower</em>&nbsp;and&nbsp;<em>manpower</em>&nbsp;are two different identifiers in C. Here are some examples of acceptable identifiers &minus;</p>
<pre class="result notranslate">mohd       zara    abc   move_name  a_123
myname50   _temp   j     a23b9      retVal
</pre>
<h2>Keywords</h2>
<p>The following list shows the reserved words in C. These reserved words may not be used as constants or variables or any other identifier names.</p>
<table class="table table-bordered">
<tbody>
<tr>
<td>auto</td>
<td>else</td>
<td>long</td>
<td>switch</td>
</tr>
<tr>
<td>break</td>
<td>enum</td>
<td>register</td>
<td>typedef</td>
</tr>
<tr>
<td>case</td>
<td>extern</td>
<td>return</td>
<td>union</td>
</tr>
<tr>
<td>char</td>
<td>float</td>
<td>short</td>
<td>unsigned</td>
</tr>
<tr>
<td>const</td>
<td>for</td>
<td>signed</td>
<td>void</td>
</tr>
<tr>
<td>continue</td>
<td>goto</td>
<td>sizeof</td>
<td>volatile</td>
</tr>
<tr>
<td>default</td>
<td>if</td>
<td>static</td>
<td>while</td>
</tr>
<tr>
<td>do</td>
<td>int</td>
<td>struct</td>
<td>_Packed</td>
</tr>
<tr>
<td>double</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
</tbody>
</table>
<h2>Whitespace in C</h2>
<p>A line containing only whitespace, possibly with a comment, is known as a blank line, and a C compiler totally ignores it.</p>
<p>Whitespace is the term used in C to describe blanks, tabs, newline characters and comments. Whitespace separates one part of a statement from another and enables the compiler to identify where one element in a statement, such as int, ends and the next element begins. Therefore, in the following statement &minus;</p>
<pre class="prettyprint notranslate">int age;
</pre>
<p>there must be at least one whitespace character (usually a space) between int and age for the compiler to be able to distinguish them. On the other hand, in the following statement &minus;</p>
<pre class="prettyprint notranslate">fruit = apples + oranges;   // get the total fruit
</pre>
<p>no whitespace characters are necessary between fruit and =, or between = and apples, although you are free to include some if you wish to increase readability.</p>
<p><img src="data:image/jpeg;base64,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" alt="C Syntax Rules - Learn the ABCs of Programming in C Language - DataFlair"></p>
<p><img src="data:image/jpeg;base64,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" alt="C++ Syntax | Learn C++ Programming Language - TechVidvan"></p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (10, 16, N'<h1>C/C++ for Visual Studio Code</h1>
<p>C/C++ support for Visual Studio Code is provided by a&nbsp;<a class="external-link" href="https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools" target="_blank" rel="noopener">Microsoft C/C++ extension</a>&nbsp;to enable cross-platform C and C++ development on Windows, Linux, and macOS.</p>
<p><img src="https://code.visualstudio.com/assets/docs/languages/cpp/cpp-extension.png" alt="cpp extension" loading="lazy"></p>
<h2 id="_install-the-extension" data-needslink="_install-the-extension"><a class="hash-link" href="https://code.visualstudio.com/docs/languages/cpp#_install-the-extension">Install the extension</a></h2>
<ol>
<li>Open VS Code.</li>
<li>Select the Extensions view icon on the Activity bar or use the keyboard shortcut (<span class="dynamic-keybinding keybinding win" title="macOS: ⇧⌘X, Linux: Ctrl+Shift+X" data-commandid="workbench.view.extensions" data-osx="⇧⌘X" data-win="Ctrl+Shift+X" data-linux="Ctrl+Shift+X">Ctrl+Shift+X</span>).</li>
<li>Search for&nbsp;<code>''C++''</code>.</li>
<li>Select&nbsp;<strong>Install</strong>.</li>
</ol>
<p><img src="https://code.visualstudio.com/assets/docs/languages/cpp/search-cpp-extension.png" alt="Search for c++ in the Extensions view" loading="lazy"></p>
<p>After you install the extension, when you open or create a&nbsp;<code>*.cpp</code>&nbsp;file, you will have syntax highlighting (colorization), smart completions and hovers (IntelliSense), and error checking.</p>
<p><img src="https://code.visualstudio.com/assets/docs/languages/cpp/msg-intellisense.png" alt="C++ language features" loading="lazy"></p>
<h2 id="_install-a-compiler" data-needslink="_install-a-compiler"><a class="hash-link" href="https://code.visualstudio.com/docs/languages/cpp#_install-a-compiler">Install a compiler</a></h2>
<p>C++ is a compiled language meaning your program''s source code must be translated (compiled) before it can be run on your computer. VS Code is first and foremost an editor, and relies on command-line tools to do much of the development workflow. The C/C++ extension does not include a C++ compiler or debugger. You will need to install these tools or use those already installed on your computer.</p>
<p>There may already be a C++ compiler and debugger provided by your academic or work development environment. Check with your instructors or colleagues for guidance on installing the recommended C++ toolset (compiler, debugger, project system, linter).</p>
<p>Some platforms, such as Linux or macOS, have a C++ compiler already installed. Most Linux distributions have the&nbsp;<a class="external-link" href="https://wikipedia.org/wiki/GNU_Compiler_Collection" target="_blank" rel="noopener">GNU Compiler Collection</a>&nbsp;(GCC) installed and macOS users can get the&nbsp;<a class="external-link" href="https://wikipedia.org/wiki/Clang" target="_blank" rel="noopener">Clang</a>&nbsp;tools with&nbsp;<a class="external-link" href="https://developer.apple.com/xcode/" target="_blank" rel="noopener">Xcode</a>.</p>
<h3 id="_check-if-you-have-a-compiler-installed" data-needslink="_check-if-you-have-a-compiler-installed"><a class="hash-link" href="https://code.visualstudio.com/docs/languages/cpp#_check-if-you-have-a-compiler-installed">Check if you have a compiler installed</a></h3>
<p>Make sure your compiler executable is in your platform path (<code>%PATH</code>&nbsp;on Windows,&nbsp;<code>$PATH</code>&nbsp;on Linux and macOS) so that the C/C++ extension can find it. You can check availability of your C++ tools by opening the Integrated Terminal (<span class="dynamic-keybinding keybinding win" title="macOS: ⌃&#96;, Linux: Ctrl+&#96;" data-commandid="workbench.action.terminal.toggleTerminal" data-osx="⌃&#96;" data-win="Ctrl+&#96;" data-linux="Ctrl+&#96;">Ctrl+`</span>) in VS Code and trying to directly run the compiler.</p>
<p>Checking for the GCC compiler&nbsp;<code>g++</code>:</p>
<pre class="shiki"><code><span class="line">g++ --version</span>
</code></pre>
<p>Checking for the Clang compiler&nbsp;<code>clang</code>:</p>
<pre class="shiki"><code><span class="line">clang --version</span>
</code></pre>
<blockquote>
<p><strong>Note</strong>: If you would prefer a full Integrated Development Environment (IDE), with built-in compilation, debugging, and project templates (File &gt; New Project), there are many options available, such as the&nbsp;<a class="external-link" href="https://visualstudio.microsoft.com/vs/community" target="_blank" rel="noopener">Visual Studio Community</a>&nbsp;edition.</p>
</blockquote>
<p>If you don''t have a compiler installed, in the example below, we describe how to install the Minimalist GNU for Windows (MinGW) C++ tools (compiler and debugger). MinGW is a popular, free toolset for Windows. If you are running VS Code on another platform, you can read the&nbsp;<a href="https://code.visualstudio.com/docs/languages/cpp#_tutorials">C++ tutorials</a>, which cover C++ configurations for Linux and macOS.</p>
<h2 id="_example-install-mingwx64" data-needslink="_example-install-mingwx64"><a class="hash-link" href="https://code.visualstudio.com/docs/languages/cpp#_example-install-mingwx64">Example: Install MinGW-x64</a></h2>
<p>We will install Mingw-w64 via&nbsp;<a class="external-link" href="https://www.msys2.org/" target="_blank" rel="noopener">MSYS2</a>, which provides up-to-date native builds of GCC, Mingw-w64, and other helpful C++ tools and libraries. You can download the latest installer from the MSYS2 page or use this&nbsp;<a class="external-link" href="https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-x86_64-20220603.exe" target="_blank" rel="noopener">link to the installer</a>.</p>
<p>Follow the&nbsp;<strong>Installation</strong>&nbsp;instructions on the&nbsp;<a class="external-link" href="https://www.msys2.org/" target="_blank" rel="noopener">MSYS2 website</a>&nbsp;to install Mingw-w64. Take care to run each required Start menu and&nbsp;<code>pacman</code>&nbsp;command.</p>
<p>You will need to install the full Mingw-w64 toolchain (<code>pacman -S --needed base-devel mingw-w64-x86_64-toolchain</code>) to get the&nbsp;<code>gdb</code>&nbsp;debugger.</p>
<h3 id="_add-the-mingw-compiler-to-your-path" data-needslink="_add-the-mingw-compiler-to-your-path"><a class="hash-link" href="https://code.visualstudio.com/docs/languages/cpp#_add-the-mingw-compiler-to-your-path">Add the MinGW compiler to your path</a></h3>
<p>Add the path to your Mingw-w64&nbsp;<code>bin</code>&nbsp;folder to the Windows&nbsp;<code>PATH</code>&nbsp;environment variable by using the following steps:</p>
<ol>
<li>In the Windows search bar, type ''settings'' to open your Windows Settings.</li>
<li>Search for&nbsp;<strong>Edit environment variables for your account</strong>.</li>
<li>Choose the&nbsp;<code>Path</code>&nbsp;variable in your&nbsp;<strong>User variables</strong>&nbsp;and then select&nbsp;<strong>Edit</strong>.</li>
<li>Select&nbsp;<strong>New</strong>&nbsp;and add the Mingw-w64 destination folder path, with&nbsp;<code>\mingw64\bin</code>&nbsp;appended, to the system path. The exact path depends on which version of Mingw-w64 you have installed and where you installed it. If you used the settings above to install Mingw-w64, then add this to the path:&nbsp;<code>C:\msys64\mingw64\bin</code>.</li>
<li>Select&nbsp;<strong>OK</strong>&nbsp;to save the updated PATH. You will need to reopen any console windows for the new PATH location to be available.</li>
</ol>
<h3 id="_check-your-mingw-installation" data-needslink="_check-your-mingw-installation"><a class="hash-link" href="https://code.visualstudio.com/docs/languages/cpp#_check-your-mingw-installation">Check your MinGW installation</a></h3>
<p>To check that your Mingw-w64 tools are correctly installed and available, open a&nbsp;<strong>new</strong>&nbsp;Command Prompt and type:</p>
<pre class="shiki"><code><span class="line">gcc --version</span>
<span class="line">g++ --version</span>
<span class="line">gdb --version</span>
</code></pre>
<p>If you don''t see the expected output or&nbsp;<code>g++</code>&nbsp;or&nbsp;<code>gdb</code>&nbsp;is not a recognized command, make sure your PATH entry matches the Mingw-w64 binary location where the compiler tools are located.</p>
<p>If the compilers do not exist at that PATH entry, make sure you followed the instructions on the&nbsp;<a class="external-link" href="https://www.msys2.org/" target="_blank" rel="noopener">MSYS2 website</a>&nbsp;to install Mingw-w64.</p>
<h2 id="_hello-world" data-needslink="_hello-world"><a class="hash-link" href="https://code.visualstudio.com/docs/languages/cpp#_hello-world">Hello World</a></h2>
<p>To make sure the compiler is installed and configured correctly, we''ll create the simplest Hello World C++ program.</p>
<p>Create a folder called "HelloWorld" and open VS Code in that folder (<code>code .</code>&nbsp;opens VS Code in the current folder):</p>
<pre class="shiki"><code><span class="line">mkdir HelloWorld</span>
<span class="line">cd HelloWorld</span>
<span class="line">code .</span>
</code></pre>
<p>The "code ." command opens VS Code in the current working folder, which becomes your "workspace". Accept the&nbsp;<a href="https://code.visualstudio.com/docs/editor/workspace-trust">Workspace Trust</a>&nbsp;dialog by selecting&nbsp;<strong>Yes, I trust the authors</strong>&nbsp;since this is a folder you created.</p>
<p>Now create a new file called&nbsp;<code>helloworld.cpp</code>&nbsp;with the&nbsp;<strong>New File</strong>&nbsp;button in the File Explorer or&nbsp;<strong>File</strong>&nbsp;&gt;&nbsp;<strong>New File</strong> command.</p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (11, 17, N'<p>Most coding revolves around inputting data into something like an integrated development environment (IDE) to create a program that accomplishes a task. However, you&rsquo;ll likely need that program to output data at some point. In this guide, we&rsquo;ll look at how to print text in C++, covering ways to print a string and best format them.</p>
<h2>What Is a String?</h2>
<p>A C++ string is a variable that stores a sequence of characters, usually representing a word or phrase. We can call upon this variable later for use in our program by using the string command. If we&rsquo;re looking to output a string, we can type the string we want to print directly into our program without first storing it as a variable. Here is an example:</p>
<p><span id="more-8497"></span></p>
<pre class="wp-block-code"><code>std::cout &lt;&lt; "No need to store this string"; </code></pre>
<h2>Types of Output: Ways To Print a String</h2>
<p>C++ itself provides one way to print a string, but C++ can also use code from C to reach the same result. Here are the top ways that&nbsp;<a href="https://www.udacity.com/course/c-plus-plus-nanodegree--nd213">C++ developers</a>&nbsp;print strings in the language.</p>
<h3>The std::cout Object</h3>
<p>Std::cout is the preferred way to print a&nbsp;<a href="https://www.udacity.com/blog/2020/02/c-strings-explained.html">string in C++</a>. To better understand this object, let&rsquo;s take a closer look at its components.</p>
<p>When C++ first came to be, all objects like cout were part of a global namespace. However, this led to conflicts with user-created objects bearing the same name. Programs wouldn&rsquo;t know which object to use and would not compile.</p>
<p>To rectify this problem, the standard namespace (abbreviated: std) was created to store objects like cout to be used for their desired purpose. As a result, developers can now use an object like cout to print a string but must point to it in the standard namespace.</p>
<p>The scope resolution operator (::) is used to identify the namespace that our object belongs to. The object goes on the right and its corresponding namespace goes on the left. When we type std::cout, we&rsquo;re telling the program that we need to use the cout that exists in the std namespace.</p>
<p>Finally, the cout object is the bit of code we need to print text in C++. This object is what tells the program to output the string that follows.</p>
<pre class="wp-block-code"><code>#include &lt;iostream&gt;

int main()
{
  std::cout &lt;&lt; "Thanks for viewing my code!";
  return 0;
}</code></pre>
<p>In this simple program, we&rsquo;re reaching into the std namespace to use the cout object to print some text. Here&rsquo;s what we would see on the screen:</p>
<pre class="wp-block-code"><code>Thanks for viewing my code!</code></pre>
<p>Cout can do more than just print text; we can also use it to print variables:</p>
<pre class="wp-block-code"><code>#include &lt;iostream&gt;
using namespace std;
int main()
{
  int x = 10;
  cout &lt;&lt; "x is equal to " &lt;&lt; x;
  return 0;
}</code></pre>
<p>Here, cout outputs the string and also the value of the variable:</p>
<pre class="wp-block-code"><code>x is equal to 10</code></pre>
<h3>The Using Directive</h3>
<p>It&rsquo;s possible to make a declaration at the beginning of our code with a using directive. This tells the program to use a particular namespace when resolving identifiers below its location in the code. Any identifier without a prefix will be assumed to be in the std namespace.</p>
<pre class="wp-block-code"><code>#include &lt;iostream&gt;
using namespace std;
int main()
{
  cout &lt;&lt; "Thanks for reading my code!";
  return 0;
}</code></pre>
<p>Since cout in this example has no prefix, the compiler searches the std namespace and uses the cout from there. We end up with the same output as in our first program above:</p>
<pre class="wp-block-code"><code>Thanks for viewing my code!</code></pre>
<p>Just be careful not to declare a cout of your own, or the program will not know which one to use while compiling.&nbsp;</p>
<p>In the following example, we&rsquo;ll declare our own cout function and leave the program guessing which one we&rsquo;re referring to.</p>
<pre class="wp-block-code"><code>#include &lt;iostream&gt;

using namespace std;
int cout()
{
  return 5;
}  int main()
{
    cout &lt;&lt; "This code doesn''t work!";
    return 0;
}</code></pre>
<p>Since we told the program to look in the std namespace any time it sees an identifier without a prefix, it finds both the cout in the std namespace and the cout we declared, and does not know which one we want to use.</p>
<p>If you ever find yourself in this situation, it&rsquo;s best to omit the&nbsp;<strong>using</strong>&nbsp;directive and instead declare the namespace directly with the identifier.</p>
<h3>The Function printf</h3>
<p>printf is a C function that you may use in C++ to print from a program. Printf uses a somewhat similar structure to cout, but since it comes from C, the notable difference is that it requires a format specifier.</p>
<p>This format specifier is used to identify the output type of the variable. The format looks like this:</p>
<pre class="wp-block-code"><code>printf("string and format specifier", variable_name);</code></pre>
<p>Here are a few of the most common format specifiers that printf uses:</p>
<figure class="wp-block-table">
<table>
<tbody>
<tr>
<td><strong>Format Specifier</strong></td>
<td><strong>Definition</strong></td>
</tr>
<tr>
<td>%d</td>
<td>signed decimal integer</td>
</tr>
<tr>
<td>%i</td>
<td>unsigned decimal integer</td>
</tr>
<tr>
<td>%c</td>
<td>character</td>
</tr>
<tr>
<td>%s</td>
<td>string of characters</td>
</tr>
</tbody>
</table>
</figure>
<p>Here&rsquo;s an example of printf in action:</p>
<pre class="wp-block-code"><code>#include &lt;stdio.h&gt;
main(){
  char ch = ''N'';
  printf("We''ve chosen the character %c\n", ch);
  int x = 20;
  printf("x is equal to %d\n", x);
}</code></pre>
<p>When this program compiles, it generates the following output:</p>
<pre class="wp-block-code"><code>We''ve chosen the character N
x is equal to 20</code></pre>
<h3>The&nbsp;<strong>system</strong>&nbsp;Function</h3>
<p>The&nbsp;<strong>system</strong>&nbsp;function is located in the standard library of C++. It passes commands to the command processor for execution and returns the command upon completion of execution. Here&rsquo;s an example:</p>
<pre class="wp-block-code"><code>#include &lt;stdlib.h&gt;
int main(int argc, char** argv)
{
  system("echo Thanks for reading my code!\n");
} </code></pre>
<p>The system creates a subprocess that starts the default shell. It then runs a command in that shell.&nbsp;</p>
<p>This returns the following output:</p>
<pre class="wp-block-code"><code>Thanks for viewing my code!</code></pre>
<h2>Which C++ Print Method Should You Use?</h2>
<p>Each method described above can be used to print output in C++. However, printf and the&nbsp;<strong>system</strong>&nbsp;function have their origins in the C programming language. The cout object is the only print method specifically created for C++.</p>
<p>cout is an object of the ofstream type. C++ was designed around&nbsp;<a href="https://www.udacity.com/blog/2021/03/cpp-oop-explained.html?utm_source=rss&amp;utm_medium=rss&amp;utm_campaign=cpp-oop-explained">object-oriented programming</a>&nbsp;and has completely different syntax compared to the functions deriving from C. Accordingly, cout is considered the standard way of printing strings in C++.&nbsp;</p>
<p>Printf also requires a format specifier. Cout removes that need as it makes that determination for you. Cout is thus easier to use and understand.</p>
<h2>Output Formatting</h2>
<p>If you do not want your output to be left-justified or on a single line, we&rsquo;ll give you a few alternatives for formatting your output.</p>
<h3>The Endl Manipulator</h3>
<p>Endl is effectively a carriage return in C++. Putting endl at the end of a cout statement will place the following line of text on a new line:</p>
<pre class="wp-block-code"><code>#include &lt;iostream&gt;

using namespace std;

int main()
{
  cout &lt;&lt; "This is a" &lt;&lt; endl;
  cout &lt;&lt; "weird place for a new line";
  return 0;
}</code></pre>
<p>Compiling this code gives us the following output:</p>
<pre class="wp-block-code"><code>This is a
weird place for a new line</code></pre>
<p>Removing the endl manipulator would keep the print output on the same line, even though we&rsquo;ve used two cout statements.</p>
<p><img src="data:image/png;base64,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" alt="C++ Exercises: Print a welcome text in a separate line - w3resource"></p>
<p><img src="data:image/jpeg;base64,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" alt="How to print a text in a separate line in C++ - YouTube"></p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (12, 18, N'<h2>What Is a New Line in C++?</h2>
<p>When we output text in C++, we don&rsquo;t always want all of the information to appear on one line. This can result in output that&rsquo;s tough to read. The users of your program will have a tough time finding specific points in a large block of information, also known as the dreaded &ldquo;wall of text&rdquo;.&nbsp;</p>
<p>A chunk of text, also known as a &ldquo;string&rdquo; to&nbsp;&nbsp;<a href="https://www.udacity.com/course/c-plus-plus-nanodegree--nd213">C++ developers</a>, is a sequential series of characters terminated by the special end-of-string character, written as &lsquo;\0&rsquo;. There are many other such special characters, such as tab `\t` and newline `\n` (the topic of this blog post).</p>
<h2>Outputting Text in C++</h2>
<p>There are a few crucial components you need to output text in C++. Understanding how you can use these components will help to break lines in output.</p>
<h3>The cout Object</h3>
<p>C++ uses the&nbsp;<code>cout</code>&nbsp;object to display information from code. It&rsquo;s possible to use&nbsp;<code>cout</code>&nbsp;to output anything, from values of variables to strings:</p>
<div class="wp-block-syntaxhighlighter-code ">
<div>
<div id="highlighter_431669" class="syntaxhighlighter  cpp">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="cpp plain">cout &lt;&lt; </code><code class="cpp string">"The value of x is: "</code> <code class="cpp plain">&lt;&lt; x;</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<p>Even with multiple&nbsp;<code>cout</code>&nbsp;statements, the program won&rsquo;t put the second statement on a second line:</p>
<div class="wp-block-syntaxhighlighter-code ">
<div>
<div id="highlighter_386907" class="syntaxhighlighter  cpp">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="cpp plain">...</code></div>
<div class="line number2 index1 alt1"><code class="cpp color1 bold">int</code> <code class="cpp plain">main()</code></div>
<div class="line number3 index2 alt2"><code class="cpp plain">{</code></div>
<div class="line number4 index3 alt1"><code class="cpp spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="cpp plain">cout &lt;&lt; </code><code class="cpp string">"Hello! We want to output this text "</code><code class="cpp plain">;</code></div>
<div class="line number5 index4 alt2"><code class="cpp spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="cpp plain">cout &lt;&lt; </code><code class="cpp string">"on two different lines."</code><code class="cpp plain">;</code></div>
<div class="line number6 index5 alt1"><code class="cpp spaces">&nbsp;&nbsp;</code><code class="cpp keyword bold">return</code> <code class="cpp plain">0;</code></div>
<div class="line number7 index6 alt2"><code class="cpp plain">}</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<p>Try as we might, our program outputs everything on just one line:</p>
<div class="wp-block-syntaxhighlighter-code ">
<div>
<div id="highlighter_859802" class="syntaxhighlighter  cpp">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="cpp plain">Hello! We want to output </code><code class="cpp keyword bold">this</code> <code class="cpp plain">text on two different lines.</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<p>While the text appears on a single line, this is a straightforward output and is still easy to follow. Imagine how paragraphs of output would look without any formatting&hellip;</p>
<p>Similarly, a series of numbers can be hard to understand if displayed on the same line. The following for loop demonstrates this well:</p>
<div class="wp-block-syntaxhighlighter-code ">
<div>
<div id="highlighter_623662" class="syntaxhighlighter  cpp">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="cpp plain">...</code><code class="cpp color1 bold">int</code> <code class="cpp plain">main()</code></div>
<div class="line number2 index1 alt1"><code class="cpp plain">{</code></div>
<div class="line number3 index2 alt2"><code class="cpp spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="cpp keyword bold">for</code> <code class="cpp plain">(</code><code class="cpp color1 bold">int</code> <code class="cpp plain">i = 0; i &lt; 10; i++)</code></div>
<div class="line number4 index3 alt1"><code class="cpp spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="cpp plain">cout &lt;&lt; i;</code></div>
<div class="line number5 index4 alt2"><code class="cpp spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="cpp keyword bold">return</code> <code class="cpp plain">0;</code></div>
<div class="line number6 index5 alt1"><code class="cpp plain">}</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<p>This program returns ten different numbers all mashed together, rather than listing each individually:</p>
<div class="wp-block-syntaxhighlighter-code ">
<div>
<div id="highlighter_946958" class="syntaxhighlighter  cpp">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="cpp plain">0123456789</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<h3>The Stream Extraction Operator (&lt;&lt;)</h3>
<p>The &lt;&lt; symbol is used to put together output parts (it&rsquo;s also a&nbsp;<a href="https://www.udacity.com/blog/2021/04/our-guide-to-the-cpp-operator.html">left shift operator</a>&nbsp;in bitwise operations). Technically,&nbsp; &lt;&lt; is a stream extraction operator, designating text as output or commands to be executed as the result of&nbsp;<code>cout</code>.</p>
<p>A single&nbsp;<code>cout</code>&nbsp;statement can have multiple extraction operators, each representing a specific function or output. The extraction operators further serve to break up different types of outputs:</p>
<div class="wp-block-syntaxhighlighter-code ">
<div>
<div id="highlighter_922547" class="syntaxhighlighter  cpp">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="cpp plain">...</code><code class="cpp color1 bold">int</code> <code class="cpp plain">main()</code></div>
<div class="line number2 index1 alt1"><code class="cpp plain">{</code></div>
<div class="line number3 index2 alt2"><code class="cpp spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="cpp color1 bold">int</code> <code class="cpp plain">i = 3, j = 6;</code></div>
<div class="line number4 index3 alt1"><code class="cpp spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="cpp plain">cout &lt;&lt; </code><code class="cpp string">"The value of i is: "</code> <code class="cpp plain">&lt;&lt; i &lt;&lt; </code><code class="cpp string">". The value of j is: "</code> <code class="cpp plain">&lt;&lt; j;</code></div>
<div class="line number5 index4 alt2"><code class="cpp spaces">&nbsp;&nbsp;</code><code class="cpp keyword bold">return</code> <code class="cpp plain">0;</code></div>
<div class="line number6 index5 alt1"><code class="cpp plain">}</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<p>This block of code returns the following:</p>
<div class="wp-block-syntaxhighlighter-code ">
<div>
<div id="highlighter_509246" class="syntaxhighlighter  cpp">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="cpp plain">The value of i is: 3. The value of j is: 6</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<p>You can see how&nbsp;<code>cout</code> combines different data types into one output.</p>
<p><img src="data:image/png;base64,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" alt="C++ New Line Characters"></p>
<p><img src="data:image/jpeg;base64,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" alt="Visual C++ - Adding Line Breaks - YouTube"></p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (13, 21, N'<div>
<div class="article-title">
<h1>How to modify HTML using BeautifulSoup ?</h1>
</div>
<div class="article_button_copy">&nbsp;</div>
<div class="media"><a href="https://www.geeksforgeeks.org/how-to-modify-html-using-beautifulsoup/#article-meta-div">
<div class="badges"><img class="img restrict-popup-gfg no-zoom-in-cursor" src="https://media.geeksforgeeks.org/auth/avatar.png" alt="author">
<div>&nbsp;</div>
<div>
<div class="u-name">vin8rai</div>
</div>
</div>
</a></div>
</div>
<div class="main_wrapper">
<div id="nav-tab-main"><a class="nav_tab article active">Read</a><a class="nav_tab discuss" data-gfg-action="loadComments">Discuss</a><a id="nav_tab_courses" class="nav_tab courses" data-gfg-action="loadCourses"></a>Courses<a class="nav_tab practice" data-gfg-action="loadPractice">Practice</a></div>
<div class="article-buttons">
<div class="article--viewer_improve tooltip">&nbsp;</div>
<div class="article--viewer_bookmark tooltip">&nbsp;</div>
<div class="article--viewer_like tooltip">&nbsp;</div>
</div>
</div>
<div class="text">
<p><a href="https://www.geeksforgeeks.org/implementing-web-scraping-python-beautiful-soup/"><strong>BeautifulSoup</strong></a><strong>&nbsp;</strong>in Python helps in scraping the information from web pages made of HTML or XML. Not only it involves scraping data but also involves searching, modifying, and iterating the parse tree. In this article, we will discuss modifying the content directly on the HTML web page using BeautifulSoup.</p>
<p><strong>Syntax:</strong></p>
<div id="GFG_AD_gfg_mobile_336x280"></div>
<blockquote>
<p>old_text=soup.find(&ldquo;#Widget&rdquo;, {&ldquo;id&rdquo;:&rdquo;#Id name of widget in which you want to edit&rdquo;})</p>
<p>new_text=old_text.find(text=re.compile(&lsquo;#Text which you want to edit&rsquo;)).replace_with(&lsquo;#New text which you want to replace with&rsquo;)</p>
<div id="_GFG_ABP_Incontent_728x90"></div>
<div id="GFG_AD_InContent_Desktop_728x280" data-google-query-id="CIrMrdW14f8CFVJqiwod9b0AtA">
<div id="google_ads_iframe_/27823234/GFG_InContent_Desktop_728x280_0__container__"><iframe id="google_ads_iframe_/27823234/GFG_InContent_Desktop_728x280_0" tabindex="0" title="3rd party ad content" role="region" name="google_ads_iframe_/27823234/GFG_InContent_Desktop_728x280_0" width="728" height="280" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" aria-label="Advertisement" data-load-complete="true" data-google-container-id="1"></iframe></div>
</div>
</blockquote>
<h3>Terms Used:</h3>
<ul>
<li><strong>Widget:</strong>&nbsp;Here, widget stands for the particular widget in which the text you wish to replace from the website is currently stored.</li>
<li><strong>Id Name:</strong>&nbsp;Here, Id Name stands for the name you have given to the Id of the particular widget in which text is stored.</li>
</ul>
<p><strong>Example:</strong></p>
<p>For instance, consider this simple page source.</p>
<div class="noIdeBtnDiv">
<div class="responsive-tabs-wrapper">
<div class="responsive-tabs responsive-tabs--enabled">
<ul class="responsive-tabs__list" role="tablist">
<li id="tablist1-tab1" class="responsive-tabs__list__item responsive-tabs__list__item--active" tabindex="0" role="tab" aria-controls="tablist1-panel1">HTML</li>
</ul>
<div id="tablist1-panel1" class="tabcontent responsive-tabs__panel responsive-tabs__panel--active" role="tabpanel" aria-hidden="false" aria-labelledby="tablist1-tab1">
<div id="GFG_AD_Desktop_InContent_ATF_336x280"></div>
<div class="code-block">
<div class="code-gutter">
<div class="editor-buttons-container">
<div class="editor-buttons">
<div class="editor-buttons-div" title="Run and Edit"><em id="copy-code-button" class="gfg-icon gfg-icon_copy code-sidebar-button padding-2px copy-code-button" title="Copy Code"></em>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
</div>
</div>
</div>
<div class="code-container">
<div id="highlighter_257317" class="syntaxhighlighter nogutter">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="plain">&lt;!DOCTYPE html&gt;</code></div>
<div class="line number2 index1 alt1"><code class="plain">&lt;</code><code class="keyword">html</code><code class="plain">&gt;</code></div>
<div class="line number3 index2 alt2"><code class="undefined spaces">&nbsp;&nbsp;</code><code class="plain">&lt;</code><code class="keyword">head</code><code class="plain">&gt;</code></div>
<div class="line number4 index3 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">My First Heading</code></div>
<div class="line number5 index4 alt2"><code class="undefined spaces">&nbsp;&nbsp;</code><code class="plain">&lt;/</code><code class="keyword">head</code><code class="plain">&gt;</code></div>
<div class="line number6 index5 alt1"><code class="plain">&lt;</code><code class="keyword">body</code><code class="plain">&gt;</code></div>
<div class="line number7 index6 alt2"><code class="undefined spaces">&nbsp;&nbsp;</code><code class="plain">&lt;</code><code class="keyword">p</code> <code class="color1">id</code><code class="plain">=</code><code class="string">"para"</code><code class="plain">&gt;</code></div>
<div class="line number8 index7 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">Geeks For Geeks</code></div>
<div class="line number9 index8 alt2"><code class="undefined spaces">&nbsp;&nbsp;</code><code class="plain">&lt;/</code><code class="keyword">p</code><code class="plain">&gt;</code></div>
<div class="line number10 index9 alt1">&nbsp;</div>
<div class="line number11 index10 alt2"><code class="plain">&lt;/</code><code class="keyword">body</code><code class="plain">&gt;</code></div>
<div class="line number12 index11 alt1"><code class="plain">&lt;/</code><code class="keyword">html</code><code class="plain">&gt;</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<p>Once you have created a driver, you can replace the text &lsquo;<strong>Geeks For Geeks</strong>&lsquo; with &lsquo;<strong>Vinayak Rai</strong>&lsquo; using &ndash;</p>
<blockquote>
<p>old_text=soup.find(&ldquo;p&rdquo;, {&ldquo;id&rdquo;:&rdquo;para&rdquo;})</p>
<p>new_text=old_text.find(text=re.compile(&lsquo;Geeks For Geeks&rsquo;)).replace_with(&lsquo;Vinayak Rai&rsquo;)</p>
</blockquote>
<h3>Step-by-step Approach:</h3>
<p><strong>Step 1:&nbsp;</strong>First, import the libraries Beautiful Soup, os and re.</p>
<blockquote>
<p>from bs4 import BeautifulSoup as bs</p>
<p>import os</p>
<div id="GFG_AD_gfg_outstream_incontent" data-google-query-id="CJi-99W14f8CFQMFKgoda_kKzw">
<div id="google_ads_iframe_/27823234/gfg_outstream_incontent_0__container__"><iframe id="google_ads_iframe_/27823234/gfg_outstream_incontent_0" tabindex="0" title="3rd party ad content" role="region" src="https://ee488797d9c91a3006a09ecd56405dbf.safeframe.googlesyndication.com/safeframe/1-0-40/html/container.html" name="" width="1" height="1" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" data-is-safeframe="true" aria-label="Advertisement" data-google-container-id="3" data-load-complete="true"></iframe></div>
</div>
<p>import re</p>
</blockquote>
<p><strong>Step 2:</strong>&nbsp;Now, remove the last segment of the path.</p>
<blockquote>
<p>base=os.path.dirname(os.path.abspath(__file__))</p>
</blockquote>
<p><strong>Step 3:</strong>&nbsp;Then, open the HTML file in which you wish to make a change.</p>
<blockquote>
<p>html=open(os.path.join(base, &lsquo;#Name of HTML file in which you want to edit&rsquo;))</p>
</blockquote>
<p><strong>Step 4:</strong>&nbsp;Moreover, parse the HTML file in Beautiful Soup.</p>
<blockquote>
<p>soup=bs(html, &lsquo;html.parser&rsquo;)</p>
</blockquote>
<p><strong>Step 5:</strong>&nbsp;Further, give the appropriate location of the text which you wish to replace.&nbsp;</p>
<blockquote>
<p>old_text=soup.find(&ldquo;#Widget Name&rdquo;, {&ldquo;id&rdquo;:&rdquo;#Id name of widget in which you want to edit&rdquo;})</p>
</blockquote>
<p><strong>Step 6:</strong>&nbsp;Next, replace the already stored text with the new text you wish to assign.</p>
<div id="GFG_AD_gfg_outstream_incontent"></div>
<blockquote>
<p>new_text=old_text.find(text=re.compile(&lsquo;#Text which you want to edit&rsquo;)).replace_with(&lsquo;#New Text which you want to replace with&rsquo;)</p>
</blockquote>
<p><strong>Step 7:</strong>&nbsp;Finally, alter the HTML file to see the changes done in the previous step.</p>
<blockquote>
<p>with open(&ldquo;#Name of HTML file in which you want to store the edited text&rdquo;, &ldquo;wb&rdquo;) as f_output:</p>
<p>&nbsp; &nbsp;f_output.write(soup.prettify(&ldquo;utf-8&rdquo;))</p>
</blockquote>
<h3>Implementation:</h3>
<div class="noIdeBtnDiv">
<div class="responsive-tabs-wrapper">
<div class="responsive-tabs responsive-tabs--enabled">
<ul class="responsive-tabs__list" role="tablist">
<li id="tablist2-tab1" class="responsive-tabs__list__item responsive-tabs__list__item--active" tabindex="0" role="tab" aria-controls="tablist2-panel1">Python</li>
</ul>
<div id="tablist2-panel1" class="tabcontent responsive-tabs__panel responsive-tabs__panel--active" role="tabpanel" aria-hidden="false" aria-labelledby="tablist2-tab1">
<div class="code-block">
<div class="code-gutter">
<div class="editor-buttons-container">
<div class="editor-buttons">
<div class="editor-buttons-div" title="Run and Edit"><em id="copy-code-button" class="gfg-icon gfg-icon_copy code-sidebar-button padding-2px copy-code-button" title="Copy Code"></em>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
</div>
</div>
</div>
<div class="code-container">
<div id="highlighter_955894" class="syntaxhighlighter nogutter">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="comments"># Python program to modify HTML</code></div>
<div class="line number2 index1 alt1"><code class="comments"># with the help of Beautiful Soup</code></div>
<div class="line number3 index2 alt2">&nbsp;</div>
<div class="line number4 index3 alt1"><code class="comments"># Import the libraries</code></div>
<div class="line number5 index4 alt2"><code class="keyword">from</code> <code class="plain">bs4 </code><code class="keyword">import</code> <code class="plain">BeautifulSoup as bs</code></div>
<div class="line number6 index5 alt1"><code class="keyword">import</code> <code class="plain">os</code></div>
<div class="line number7 index6 alt2"><code class="keyword">import</code> <code class="plain">re</code></div>
<div class="line number8 index7 alt1">&nbsp;</div>
<div class="line number9 index8 alt2"><code class="comments"># Remove the last segment of the path</code></div>
<div class="line number10 index9 alt1"><code class="plain">base </code><code class="keyword">=</code> <code class="plain">os.path.dirname(os.path.abspath(__file__))</code></div>
<div class="line number11 index10 alt2">&nbsp;</div>
<div class="line number12 index11 alt1"><code class="comments"># Open the HTML in which you want to make changes</code></div>
<div class="line number13 index12 alt2"><code class="plain">html </code><code class="keyword">=</code> <code class="functions">open</code><code class="plain">(os.path.join(base, </code><code class="string">''gfg.html''</code><code class="plain">))</code></div>
<div class="line number14 index13 alt1">&nbsp;</div>
<div class="line number15 index14 alt2"><code class="comments"># Parse HTML file in Beautiful Soup</code></div>
<div class="line number16 index15 alt1"><code class="plain">soup </code><code class="keyword">=</code> <code class="plain">bs(html, </code><code class="string">''html.parser''</code><code class="plain">)</code></div>
<div class="line number17 index16 alt2">&nbsp;</div>
<div class="line number18 index17 alt1"><code class="comments"># Give location where text is</code></div>
<div class="line number19 index18 alt2"><code class="comments"># stored which you wish to alter</code></div>
<div class="line number20 index19 alt1"><code class="plain">old_text </code><code class="keyword">=</code> <code class="plain">soup.find(</code><code class="string">"p"</code><code class="plain">, {</code><code class="string">"id"</code><code class="plain">: </code><code class="string">"para"</code><code class="plain">})</code></div>
<div class="line number21 index20 alt2">&nbsp;</div>
<div class="line number22 index21 alt1"><code class="comments"># Replace the already stored text with</code></div>
<div class="line number23 index22 alt2"><code class="comments"># the new text which you wish to assign</code></div>
<div class="line number24 index23 alt1"><code class="plain">new_text </code><code class="keyword">=</code> <code class="plain">old_text.find(text</code><code class="keyword">=</code><code class="plain">re.</code><code class="functions">compile</code><code class="plain">(</code></div>
<div class="line number25 index24 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="string">''Geeks For Geeks''</code><code class="plain">)).replace_with(</code><code class="string">''Vinayak Rai''</code><code class="plain">)</code></div>
<div class="line number26 index25 alt1">&nbsp;</div>
<div class="line number27 index26 alt2"><code class="comments"># Alter HTML file to see the changes done</code></div>
<div class="line number28 index27 alt1"><code class="plain">with </code><code class="functions">open</code><code class="plain">(</code><code class="string">"gfg.html"</code><code class="plain">, </code><code class="string">"wb"</code><code class="plain">) as f_output:</code></div>
<div class="line number29 index28 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">f_output.write(soup.prettify(</code><code class="string">"utf-8"</code><code class="plain">))</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<p><strong>Output:</strong></p>
<p><img src="https://media.geeksforgeeks.org/wp-content/uploads/20210310182226/bandic.gif"></p>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (14, 22, N'<h1 class="kLpnE9Hp   ">Python Class Attributes: An Overly Thorough Guide</h1>
<div class="_3leAG6HP _1jESxs4f   ">
<p>In a recent phone screen, I decided to use a class attribute in my implementation of a certain Python API. My interviewer challenged me, questioning whether my code was syntactically valid, when it was executed, etc. In fact, I wasn&rsquo;t sure of the answers myself. So I did some digging.</p>
<p>Python class attributes: when (or how) to use them. In this guide, I walk you through common pitfalls and conclude with a list of valid use cases that could save you time, energy, and lines of code.</p>
<p>I recently had a&nbsp;<a href="https://www.toptal.com/python/job-description" target="_blank" rel="noopener">programming interview</a>&nbsp;phone screen in which we used a collaborative text editor and it got me thinking about Python class attributes.</p>
<p>I was asked to implement a&nbsp;<a href="https://www.toptal.com/api-developers/5-golden-rules-for-designing-a-great-web-api" target="_blank" rel="noopener">certain API</a>&nbsp;and chose to do so in&nbsp;<a href="https://www.toptal.com/python" target="_blank" rel="noopener">Python</a>. Abstracting away the problem statement, let&rsquo;s say I needed a class whose instances stored some&nbsp;<code>data</code>&nbsp;and some&nbsp;<code>other_data</code>.</p>
<p>I took a deep breath and started typing. After a few lines, I had something like this:</p>
<pre><code class="language-py hljs language-python">    <span class="hljs-keyword">class</span> <span class="hljs-title class_">Service</span>(<span class="hljs-title class_ inherited__">object</span>):
        data = []

        <span class="hljs-keyword">def</span> <span class="hljs-title function_">__init__</span>(<span class="hljs-params">self, other_data</span>):
            self.other_data = other_data
        ...
</code></pre>
<p>My interviewer stopped me:</p>
<ul>
<li>
<p>Interviewer: &ldquo;That line&nbsp;<code>data = []</code>. I don&rsquo;t think that&rsquo;s valid Python.&rdquo;</p>
</li>
<li>
<p>Me: &ldquo;I&rsquo;m pretty sure it is. It&rsquo;s just setting a default value for the instance attribute.&rdquo;</p>
</li>
<li>
<p>Interviewer: &ldquo;When does that code get executed?&rdquo;</p>
</li>
<li>
<p>Me: &ldquo;I&rsquo;m not really sure. I&rsquo;ll just fix it up to avoid confusion.&rdquo;</p>
</li>
</ul>
<p>For reference, and to give you an idea of what I was going for, here&rsquo;s how I amended the code:</p>
<pre><code class="language-py hljs language-python">    <span class="hljs-keyword">class</span> <span class="hljs-title class_">Service</span>(<span class="hljs-title class_ inherited__">object</span>):

        <span class="hljs-keyword">def</span> <span class="hljs-title function_">__init__</span>(<span class="hljs-params">self, other_data</span>):
            self.data = []
            self.other_data = other_data
        ...
</code></pre>
<p>As it turns out, we were both wrong. The real answer lay in understanding the distinction between Python class attributes and Python instance attributes.</p>
<p>&nbsp;</p>
<div class="Lrtvcx6w -zsi5Omm" data-testid="image-container">
<figure class="_27r4LbpO"><a class="_3ODq_Dz7" href="https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png" target="_blank" rel="noopener noreferrer"><picture class="pUoTTmUG  " data-testid="picture"><source srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=320" media="(max-width: 320px)" data-srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=320"><source srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=425" media="(min-width: 320.1px) and (max-width: 425px)" data-srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=425"><source srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=524" media="(min-width: 425.1px) and (max-width: 524px)" data-srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=524"><source srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=768" media="(min-width: 524.1px) and (max-width: 768px)" data-srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=768"><source srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=1024" media="(min-width: 768.1px) and (max-width: 1024px)" data-srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=1024"><source srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=1200" media="(min-width: 1024.1px) and (max-width: 1200px)" data-srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png&amp;width=1200"><source srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png" media="(min-width: 1200.1px)" data-srcset="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png"><img class="jzCFFdcc lazyloaded" src="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png" alt="Python class attributes vs. Python instance attributes" data-checker="" data-src="https://assets.toptal.io/images?url=https://bs-uploads.toptal.io/blackfish-uploads/public-files/python_class_attributes_1-8378b186b7fe03bad89e16b199a76f02.png"></picture></a></figure>
</div>
<p>&nbsp;</p>
<p><strong>Note:</strong>&nbsp;<em>If you have an expert handle on Python class attributes, you can skip ahead to use cases.</em></p>
<h2 id="python-class-attributes">Python Class Attributes</h2>
<p>My interviewer was wrong in that the above code&nbsp;<em>is</em>&nbsp;syntactically valid.</p>
<p>I was wrong in that the code isn&rsquo;t setting a &ldquo;default value&rdquo; for the instance attribute. Instead, it&rsquo;s defining&nbsp;<code>data</code>&nbsp;as a&nbsp;<em>class</em>&nbsp;attribute with value&nbsp;<code>[]</code>.</p>
<p>In my experience, Python class attributes are a topic that&nbsp;<em>many</em>&nbsp;people know&nbsp;<em>something</em>&nbsp;about, but few understand completely.</p>
<h3 id="python-class-variables-vs-instance-variables-whats-the-difference">Python Class Variables vs. Instance Variables: What&rsquo;s the Difference?</h3>
<p>A Python class attribute is an attribute of the class (circular, I know), rather than an attribute of an&nbsp;<em>instance</em>&nbsp;of a class.</p>
<p>Let&rsquo;s use a Python class example to illustrate the difference. Here,&nbsp;<code>class_var</code>&nbsp;is a class attribute, and&nbsp;<code>i_var</code>&nbsp;is an instance attribute:</p>
<pre><code class="language-py hljs language-python">{:lang=<span class="hljs-string">''python''</span>}
    <span class="hljs-keyword">class</span> <span class="hljs-title class_">MyClass</span>(<span class="hljs-title class_ inherited__">object</span>):
        class_var = <span class="hljs-number">1</span>

        <span class="hljs-keyword">def</span> <span class="hljs-title function_">__init__</span>(<span class="hljs-params">self, i_var</span>):
            self.i_var = i_var
</code></pre>
<p>Note that all instances of the class have access to&nbsp;<code>class_var</code>, and that it can also be accessed as a property of the&nbsp;<em>class itself</em>:</p>
<pre><code class="language-py hljs language-python">{:lang=<span class="hljs-string">''python''</span>}
    foo = MyClass(<span class="hljs-number">2</span>)
    bar = MyClass(<span class="hljs-number">3</span>)

    foo.class_var, foo.i_var
    <span class="hljs-comment">## 1, 2</span>
    bar.class_var, bar.i_var
    <span class="hljs-comment">## 1, 3</span>
    MyClass.class_var <span class="hljs-comment">## &lt;&mdash; This is key</span>
    <span class="hljs-comment">## 1</span>
</code></pre>
<p>For Java or C++ programmers, the class attribute is similar&mdash;but not identical&mdash;to the static member. We&rsquo;ll see how they differ later.</p>
<h3 id="python-class-properties-vs-instance-namespaces">Python Class Properties vs. Instance Namespaces</h3>
<p>To understand what&rsquo;s happening here, let&rsquo;s talk briefly about&nbsp;<strong>Python namespaces</strong>.</p>
<p>A&nbsp;<a href="http://docs.python.org/2/tutorial/classes.html" target="_blank" rel="noopener">namespace</a>&nbsp;is a mapping from names to objects, with the property that there is zero relation between names in different namespaces. They&rsquo;re usually implemented as Python dictionaries, although this is abstracted away.</p>
<p>Depending on the context, you may need to access a namespace using dot syntax (e.g.,&nbsp;<code>object.name_from_objects_namespace</code>) or as a local variable (e.g.,&nbsp;<code>object_from_namespace</code>). As a concrete example:</p>
<pre><code class="language-py hljs language-python">{:lang=<span class="hljs-string">''python''</span>}
    <span class="hljs-keyword">class</span> <span class="hljs-title class_">MyClass</span>(<span class="hljs-title class_ inherited__">object</span>):
        <span class="hljs-comment">## No need for dot syntax</span>
        class_var = <span class="hljs-number">1</span>

        <span class="hljs-keyword">def</span> <span class="hljs-title function_">__init__</span>(<span class="hljs-params">self, i_var</span>):
            self.i_var = i_var

    <span class="hljs-comment">## Need dot syntax as we&rsquo;ve left scope of class namespace</span>
    MyClass.class_var
    <span class="hljs-comment">## 1</span>
</code></pre>
<p>Python classes&nbsp;<em>and</em>&nbsp;instances of classes each have their own distinct namespaces represented by the&nbsp;<a href="http://www2.lib.uchicago.edu/keith/courses/python/class/5/#classinst" target="blank">pre-defined attributes</a>&nbsp;<code>MyClass.__dict__</code>&nbsp;and&nbsp;<code>instance_of_MyClass.__dict__</code>, respectively.</p>
<p>When you try to access Python attributes from an instance of a class, it first looks at its&nbsp;<em>instance</em>&nbsp;namespace. If it finds the attribute, it returns the associated value. If not, it&nbsp;<em>then</em>&nbsp;looks in the&nbsp;<em>class</em>&nbsp;namespace and returns the attribute (if it&rsquo;s present, otherwise throwing an error). For example:</p>
<pre><code class="language-py hljs language-python">{:lang=<span class="hljs-string">''python''</span>}
    foo = MyClass(<span class="hljs-number">2</span>)

    <span class="hljs-comment">## Finds i_var in foo&rsquo;s instance namespace</span>
    foo.i_var
    <span class="hljs-comment">## 2</span>

    <span class="hljs-comment">## Doesn&rsquo;t find class_var in instance namespace&hellip;</span>
    <span class="hljs-comment">## So looks in class namespace (MyClass.__dict__)</span>
    foo.class_var
    <span class="hljs-comment">## 1</span></code><br><img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBYWFRUVFhYVFRgZFRoYGBwaHRYaGhwZHx0dGhkaGhodLi4lHB4rIyEeJjgmKy8xNzU1HiU7QDs2Py40NTEBDAwMEA8QHhISHz4rJCs0NDQ2PTQ0NzQ0ND00NDQ9NDQ0NDQ9NDQ0MTQ0NDE0NDQ0NDQ0NDY0NTQ0NDQ0NDc0NP/AABEIAMYA/wMBIgACEQEDEQH/xAAaAAEAAwEBAQAAAAAAAAAAAAAAAgMEAQUG/8QAOxAAAgEDAgQFAgIJAwQDAAAAAQIRABIhAzEEIkFRBRMyYXGBkXKhFBUjQlJisdHwkrLBBjOC8UOi4f/EABcBAQEBAQAAAAAAAAAAAAAAAAABAgP/xAAhEQEAAgMAAwEAAwEAAAAAAAAAAQIRElEhMUGRAxOhYf/aAAwDAQACEQMRAD8A+CpSlVHNX0r+Jv6LVNbNBkDaZ1ASl5uA3Iha9PT1OELW2KJcQSdSAJlskriB2G5FMGXgUrVrOnmAgApKXABgDAF9oJuAJugEzB6U19TTOorIliArKm47Hm9TMT96istdr3zr8KzmVQhibSFKBRgKOVUH8Rkg9MmKxcTxKA6qIYRtNVIW8IzjUVpAYnZBEnrMb1cI8yletxLcOQ5RV5UlIuWXLMqLaxLGFYMxGJT3za+twcvCGPLhZZ8NzZOPX6e4wc0wZeJSvWGrpyvllUfySt3MAupK5ubYlb1nYFhnqMPDOsi/KhYG+MziPk/epPgZ6Vu09TTlCyrFkEAMObGWImcTt3p5iKBAUkos+qP3CQ2cmQ20dqmf+GWGlbnfSA5Vkid7s5xI7fWs5IZrQbUvME7KCQJ+wH2plY8qaVbwxAdSWKCfUJkfEZB9+la9biVZCpIuOpOAQoFzEtB65j4AmIzqI8ZSZ8vPpV2k9jqQRyvIJBjBwYGY+M1q19ZSji4sG1AUUklhE3uZ2BkDOTj+GnzJ9w8+lKVFKUpQKUpQKUpQKUpQKUpQX0pSqjmr6V/E39FqmtIS6xe7kf7ai/Dw9gP7wWc71FUUrRq8PD2KZJIUTjJgZ+tWr4axwGTeN2zgHGPegxUqzV0ip3BEAyJiD8gEVLS4csCQVETgzJhSxiB2B3igppWz9XNnmTAB3bqSsbbyCM1TxXDFCAxUmJwZjoQfegppV/E8MyWzGdsMP9wFNHQvgKQuADdMXFoAFoOMjf3oKKVr/V74yhJW6JyBiJ9+YVUmhLMtyi3cm6PUF6AncjpQU0rYvhzmMoMkZuwQQM46zio6vCFLWcgqWghTzRJEgEdYMfSaDLSlKBSlKBSlKBSlKBSlKBSlKBSlKBSlKC+lKVUc1Dyr+Jv6LVNxmZM96u1fSv4m/otUzUUnr1q0cQ8hrmJmcknPvO9VMIMHeYipppMQxAwoljsBmMz1nEb0A6rTJYkmJkkzG0zv9a6+uzbn7QP6VVcO9dBoLG13O7ufliag7kxJJgQJJMDsJ6Vylv8Az+W9ArqsRsSPj8q5Sgn5rY5mxtk4647ZA+1RB/z86lqaTLFwiVDDaCDsQRv/AHBHSoUFnnvte8fiPzUW1GIgsxEzBJiepjvUaUClKUClKUClKUClKUClKUClKUClKUClKUF9KUqot0NQIUYzAZ9t/SAIrmvx7MIUsksWMMZJhACSIlgVme5O1VavpX8Tf0Wqau0xGFbv1i3NAIudnwx3LIwPuRbv/Ma7+nKS5YMZdNRQxGpLJdyMTHIQxHtAwawUpMzJh7w/6ilybCAx5ue47KsnlFxAB+8V53iHGLqOWtb0hVJaT6i0tgXYNoGIFu8ZxUqZTCUL3b7D+9TfWnvsRv3/ALVVSrFpjxHh0i8xGI8LTrfiGIw0dtsY2/OoQvdvsP71GlJvM+/JN5n35aOI1VKoiyQgYkkAEsxkgAEwBAG+cnExWelKywUpSgUpSgUpSgUpSgUpSgUpSgUpSgUpSgUpSgvpSlVEgByXem8zmMcvXpWp9HTclgQgvCwCkAXKu25kEtO3LmsWr6V/E39FqmsWrmcxLdbYjEwtSy9fVZImSA0YnMQPtXpfq3TLuAzKo1UQC5HuDmEKsuDszEdo6zXlaWmWZVESzBRO0kwJrQ3DsqzeoW4MsF4JKhgygDBgjJg4+K3EeGZbm8M07XK6nOoW1LkZixHp5ZDknHKcT1qjR8PIVjqK6MCLVa3TNuZeHguoIAhc5ql+B9XMkDvdmEDsQANoM5j70PBKp1ZcEJA5QRLklQDcMAQSYB2gbyLMYRu1eA0G8111LbVdkUskkhtQYjdeVYG8OMnrDV4HTCuA2QVKEvpkvC6k22+hTCtDZwBuRWPU4IguAyPYJYi4QIJ2I9v/ALDvU/1Y/NlCFBkyYkFgVyN5U+3vUxPBn4cKbrv4HIzAuCkie/8AePip8TposWEnJBkjoFMiOnMR/wCNadLwwvhCJXTV3LGF5wGRVgHMHc4ntEmbeBuLZfS5iAMv6iwRV9O5Ygdt5gZrOs5y1mMYWp4boWozaszpFyFZJuFnLnbdhGfT9BT4j4aiFFR7mPd9OCtivcIPKMkQ28YrzIqSgsd+m5nYQB/wK3HnxCREzOAabfwt9jVioABPcTsI3xG46VFtL3G7d8Ad6iyQAZBn5+K3Ea+cf67RGszMx6TRFxPU5yP/AHUTpnorfafzGDUuF0w7ohkBnVTG8FgDHvV68EHCMjoDqOyojFy4ItwWChSTcB03HvGcxMemJtXGMKDpwkkEG+N12ifT6vrEfWqq9FPB3MAFCxMWy0jmsJOIw2DBnsDWd+CYavlcpYsFBB5SWiDJ6Z7VnDGYZqV6Gl4beoKOjsXKgC8XD9mAVuUbF83R7TUj4SVdVd0ALqgguS02k2cuCAw9UUwPNpWxuFC+ar3XoqtgiPUilSCMmG3BjHUVJ+DXntLf9tdVJjKEAlWjZhO4wY2yIgw0pSgUpSgUpSgUpSgvpSlVHNX0r+Jv6LVNXMJAHYk/eP7VDy6iuablWVhupBHyDIo+ozepmbM5JOdpz1iu+XTy6o4dRv4m+57Qfyx8VYOKfMsWuWw3c0ruBzTscjscioeXTy6CR4hiCCxMqFkkk2gyFBOwmMe1SfinZmYu8tIPM2xM2/h9qr8unl0zIsXi3AADssKVBU2m05tLDLL7GYqScfqAMA78wg8zTEyQDOJ696p8unl1BzzGwJkAQAcgCSYAOwkk47ml57x8AD8xXfLp5dWJmPrUWmPESiGPc/euhz3++R8wetd8unl0zMJFpj66muylWEAqwYcq7gyOnerE4x1Mg4vD2DGncNj5YhZGOnSqvLp5dJmZ9kzM+1rcY5VVveFYsILDmJLXfiknO9dPHPBlgSTJYqjak9/MIvn3nFU+XTy6iJPxTkyXcnqSzE9OpP8AKv8ApHYVP9N1JJ8zUlouN75jac5jpNVeXTy6Ca8U4DLIIYKpuCsbVIIUMZIWQMDGK6/FOb5Pri7CiQItUQMKIHKIGBjAqvy6eXQQpU/Lp5dBClT8unl0EKVPy6eXQQpU/Lp5dBZSpa4gSO9UIzEwN/pVRbW5V0yEuMC0TaUBuLgEnBbCknPbFedq3KYOD9Kh5h/wChD110NIKrliLkJElWhrYi0KCYJPN3Ud6LwujuXcKDbgq0kk2gNAA5RJna4TEGvJLMACQQDsYwe8HrUbz/gFB67aGhGHeYbc6cAgmAYknptvOK86qvMP+AU8w/4BQXUqkOx2z12G3WnmH/AKC6lQ0WJMH/itNgoKaVdYKWCgppV1gpYKCmlXWClgoKaVdYKWCgppV1gpYKCmlXWClgoKaVdYKWCgppV1gpYKCmlXWClgoKaVdYKWCgjxhkGP4vb37YqHAa1jgsCVOG3mJ6Vq09RlypKmNxitGtrayG12dTAMEkGCJBoMniPFq5VVXkUz1BM777Va3iS5ASFMyAqQZsnB29AH/lPTOd+P1boGo+8eo1LU4zUBYDVc27zcMzEDf84qVpiPBNvKa8esANpzDEkQgUyR7csAdN+tNPjUUBbLgoMXKpyVQFiBGTYev7/WMv0rVzGq8dMnYqzD/bFdGpr5/amAszc0dcA98Gtx/HafUJN6/ZZ9LUVBbh8k3KoO62j1gGVPMBsZ6VcOPWWhAoIYYVJFwcHMZm5f9OK6NfWmPOMxMXP7QNsnPSuJxWqxAGq4lZEs3wRjczNP67G0IvxikNyAE3DCoAAb4ggTswEbcnvjIjwCIOfy+OxrevEahCAazXMtxlnjciAI3+prqa2sbQNY5W4yXECYzjvV/rt8Tev1g4Yc30rXTzdRyqF3IMzJJAK5OOvQ/UVUdBxuwEb+rGGOYH8p2mkUtjOCbV6tpVZ0G/jyDmZgCWEyN/STtXG0mEC8Tcyxz4tiTMbdf8w0tw2jq2lU+W0hbs32HqM7Ee2/2po6bsAQ25gCTO4BPbdhTS3rBtX3ldSqAjQWvBA7FgSMTEj3FSdDcQGb1KMmcNGemxP5imkm0LaVS2mcw4MQPkkExyyOneK62g+ecdf4skXSBj+U700tw2jq2lVHSaWF4NoM5bcSSBI3gE1J+GcYvXY9WzEYGMnNNLcN69TpVSJMm8qIBBMdZEbjYgjEnG1F0m3LheW4eoyMdh7x8g1NLG9VtKr8ljBDiIBM3YJCYMDuw2muHSYYLZOIBOGIuUGRGdsVZpbhvVbSqvKMLDyzCbeu04gn8wKDT2lxkOcXYtnMxkY6U0sb1W0qs8O+ecYmctsLhO23Kff2rqaJyCxkMAY2tIm7P+e1I/jtPw3r1OlVPpm61WPqjJ7iVOOhE/b3rh02AJuECM83UAjpOQfyPapNLR8IvWWjScqQy4III2ORtg1r8T446jKbmYKigXbg2KHzvBYE/n1NYqs4jRKNaYm1Wx2ZQw/IistPO1PUfmtfEBhIZ0JGmjQR/FaRpiRkgMG7YPasmrufmreK4oO4cgzaoaWJuZQFJncSAO+ZzViZj1JMRPtPQXVdXsUsqrz2qsBctzQNsMfoavXhuJJwjk2DZP3DIHTbB+xrnEa502CrpppnD4fzA0o6qQ0kRa7bd/apHx7Ux6BERC9riBv3Zse/aBTe3Z/U1rxTZqKeb9nchYFlC3ACQBjMxAHuKrOo6W/u3LcvKolSYJGNiVj6VbxPF6mvbcbiiMdz6QJYwTGw2EbbVkZ5iAotWDaPc8ze+Yn2FNp7P6a1418Ppu0FGQmxmbKJYoa03M0ASYMT+8KsXhuIA04RucFkgLkdSI2/KqPDNd0cNphWcAxPSBcTuIIAP5jMxVnDeKuhRksDKrJcAQxVmLlSVIxcSREGm8x9n9Na8T0uB12HoIDKWEoOaIwMb5n6e1E0+JNsI+7KvJ1E3xjBEGfwnsa5xHirupWFAKBXMSXMRJP3jtJ3pxHjGq6FGIKkvjMc99wiY/faDE53pF7R6mf01rPxS7uoywVldlsgBlIiTEYkkj5BqCcS8jmiWBmBvtJx0rj8QWe9gGJe5h0OZI+DVTtJJgCTMDYew9qb27P6a140F3vKqQ7XWgqFNxBhSDE9oq5tHiDfKOYYBuSebAWcZOVj5HcVVw3FKgUjTUupkOWc5mRKbe3/AO1sXx14Y2L5lylHEcgBQwFIJM2L1+ndvbs/prXjLqtqLeHa1gVuRgLmkHMRkAAfQiqnd0YhhawwZVQR84rnGcS2o5d/UY6sdgAMsSdh3qDvLFrVGZtAhfgDtU3t9mTWOPQbw/UtZgdNlCh5AwwtLkqCoiFBPNHtM1kHFvzZBuEGQpMdtqufxRz5hARPMEPaGGMgxJMSCR8bRWTWcMZChcKIG2FCk/JIk+5Nai9o9STSs+4WvrMpw6m5VYlQOomDjcTB96v8riM8j+i88o9B6nG1Z+H1EWb9MPO0s6x/p3rYnjeqNio5AmLhgTBkGcScTGdqb27P6a14ofh9YBZRgGi3kXNxAEY6kj7jvVi6GtcgVTcUvUKgkJJEzGxPUGM98VSnHOrs4gMyBDjoAoB+RapB7gGuaXFsoC2oyhLLWWVK3nUz7hjM+1N7dNa8dc6iBWIKBhKm0CRABjHaPpFWDh3YaZSHL3QqplSkSDI6AjIxXW8TLqiaiDUVFtQXOsYAHpMYAAwB7zUeG8SfTYFIUAvA5tntlbpB/dXMg4qbW6a14kvDa8q3ltLGFNgyYJxjoAT9D2qxPD+IgKUKg32gquWRWLLaNm5WGRUNLxRriXUOrQHXAuAV1AJIP8ZO1Q4nxJnLyqC5tQjHMF1Lr0nqOY9N/tTa3TWvEWD+gkX+YUsgXXYEkR1Jt+hpw/mO6aYIDFwBIGG2nAJn4E1Tqa5Zy7BSS1xBHKfYjt7VBXzJVSJm0jlPsR2pvbs/prXjW16hnDqSr2NyEGTJDcygwbTvBBGQKztrsd4yZPKsz74z1+5q3W45nVwZufUDuQYBgG1bR0BYnc9Nozlq7W9ZNa8ejpahUhhEggiQCJHcHBrV4jx3mspsRAqgAKOwCyTucAY6AD5NPBaN7qkOZn0AM2ATgEgHbvtNavEPD/LUG3XEtH7RERdjsVZs+3zWVeFqbn5r0X8VlGWwpcoH7N7FwHFttplDdJWckTNedqbn5r0Gbh7GsABtFvmeaW2a70G2+bYJFsbgGZinDeKhQ4sJDaK6Rh7cBGQki0gzIPsVGd6u/XeZsczo+Uf2kSOmyi1duVYmMk5rn6RpOWbVa5vIRFZ/NJvCMLpWZIYL6sET2g9u4adlA8qP/nMancbXN7GFE7nqHj162n42wCADUFukdMldUqSOW0rCwkR2JMmSd68vT1GWSpglWU/hYFWH1BNejo8Romy9FMIikftYB81i7CGmbDODEnbpQZeK4xnCAkhURVVZkCFVSR2LRJrnEcTeqLaBYsXbu3ycco6Dp3NX8TxKDym0rEYIVa0OGmCpLXSpkHBXOTPSqNcpalk328+9v0mTd3OB2FBnpSlApSlApSlApSlApSlApSlApSlApSlApSlApSlApSlB6ei0EG1XicMJXIIyPz+RV+rxbFFQIiKAtxVYLlbrSx6+o/UmtfgiBoB2LGcx+7O8H+lb+N0FXSUg8xvuENPtM4/vVR8bqbn5r0DwWnY5D3kKCIbTSZDEta5uIBAFuGMzABE+fqbn5qNRXsfoqahdrkQjQRgFZEBcoTFp35gAQIgsKfq3SmLx/wBm8S+l6+zRMD+UXH3FePSglpakTgNKsM9JBAI9xuPivR0OH0WsuZkBRLoZLr21W0ySSIACw0RsB815lKD0OJREGk6LfchuudHF8FTyrBWDnPtHWs+voqqoQ8swllwSvvcsiD2MEdRWelApSlApSlApSlApSlApSlApSlApSlApSlApSlApSlApSlB7PB8YU2mZkEGCMRV+t4oziGLt+JiR85qHguij6qLqNasgiRIZpFqkdjtXpf8AUCcMUR9J0m4rbppYDsST3iR96qPlGQl4G5aB8kwK06/hWqhYFJtUMxBUgKboMj8Lfasxch5G4aR8gzUtXiXa64zc4dicm5QwGfhj+VRVjeG6omUYWrcZgQM/ng43wcYrh8O1RMowhLzMCFmJPvOI3qzW8TdwwYIwbcFEi6WJ1AIw8s2ferX8b1ma5mDNYUkgHB3/AM29qDFr8O6W3qVuUMJjY5Bjp9a2v4O4RGlZZGeP4UUEyY3JjYd/mMvE8W7hA0Qi2rAAxURxTSpxKoUGP3SGB/JjQXJ4Zqm3kKhlLqTsVADTiTsRiOopw/huo4kKcpeu3MAyrjtvMnECoLxzi0yOUyMDexdP/aoFdPiD2DT5bACALRMEq2/yooODw/V5eR+YkDEZWSZnbY79j2rj8I41H01BdkdlIUEklWtMDfetWp41rMAGZWALYZQVIaQQVOCMmsq8Y4dtQGHYuSQBu83EDpuY7YoLNPwzUayFzqMVUEgEwA0mcDHcz7VHX8PdEDleUzJEEKbmSCR7rvtkUPiL3XyJ8zzNhF+Bt2gARUX4piCsKqlbYUAALedQAduYmg5pcI7KGVCQWCA/zGAB9yB8kCpp4dqETbEuiAHBuYFgPbHeN/mO6fiOoqDSBBQOHCkSJBDfUSAYNQfjHJZiRLOjsYEl0mGPubiT3JmghrcM6OUZecECBDGTsBEzVr+G6oulG5YujMT8b+8bdarfimL+YLUa4MLQAAwMyBtvmrk8SdZsGmmZFqILSRaxTHKWAAPtQNfwzVQSUOEvb+UXOsH35ScdKhw3CM4YgqIwAbpY2s9qwDm1WOYHvJFaH8Y1SrpKqjraVVQogliYA6m5vvWXh+LdAwWIbuASDDLKk+k2swkdCfagopSlApSlApSlApSlApSlApSlB6CmIIwRkVPV1Wb1MzRtJJ/rSlVHnam5+ajSlRSlKUClKUClKUClKUClKUClKUClKUClKUClKUClKUClKUClKUClKUClKUH/2Q==" alt="5 Ways to Control Attributes in Python. An Example Led Guide | by Stephen  Fordham | Towards Data Science"><br><br><img src="data:image/png;base64,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" alt="Python setattr() &ndash; Be on the Right Side of Change"></pre>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (15, 23, N'<h2 id="what-is-python">What is Python?</h2>
<h3 id="the-history-of-python">The History of Python</h3>
<p>Python is an open source, general purpose programming language. Guido van Rossum developed Python based on the defunct ABC programming language and named it after the Monty Python comedy troupe. Python was designed to be simple, readable, and highly extensible through the use of modules. The first version of Python was released in 1991, and the more fully featured Python 2.0 followed in 2000. Both releases have since been discontinued.</p>
<p>Python 3.0 was introduced in 2008, but is not compatible with earlier releases. Even though Python included the&nbsp;<code>2to3</code>&nbsp;upgrade utility, this decision was highly controversial and created significant issues for the user base. Because the transition was so difficult, there is unlikely to be a release 4 of Python. Instead, new minor releases are planned for each year. The Python Software Foundation currently administers Python, and they continue to work on new features and ongoing performance improvements.</p>
<p>Python continues to increase in popularity and is now ranked as one of the top five languages. It is widely used in data science, machine learning, artificial intelligence, and server &amp; web applications. Many web developers use Python alongside external frameworks, including&nbsp;<a href="https://www.djangoproject.com/" target="_blank" rel="noopener">Django</a>&nbsp;and&nbsp;<a href="https://flask.palletsprojects.com/en/2.0.x/" target="_blank" rel="noopener">Flask</a>, or third-party libraries. These frameworks include ready-to-use components and are especially useful for web development.</p>
<h3 id="the-main-characteristics-of-python">The Main Characteristics of Python</h3>
<p>Python uses many of the same concepts, commands, and control structures as other traditional programming languages. But it is different in many respects, and can almost be considered a new programming paradigm. Python promotes flexibility and clear coding design, and code adhering to its principles is said to be &ldquo;Pythonic&rdquo;. Here are some of Python&rsquo;s main characteristics.</p>
<ul>
<li><strong>Python is a High-Level Language</strong>: High-level languages are more readable. They use meaningful variable names, and have meaningful syntax. No understanding of the underlying operating system is required. In this respect, Python is similar to other programming languages, including JavaScript, Rust, and C++, but is even more clear and legible. At the opposite end of the spectrum is assembly language. Assembly code refers to memory addresses and uses machine language instructions.</li>
<li><strong>Python Supports Object-Oriented Programming (OOP)</strong>: Python is an OOP language with support for classes, methods, inheritance, and encapsulation. Unlike Java, Python does not enforce an OOP model and object-oriented design principles are strictly optional. So it is possible to use Python strictly in imperative/procedural mode for short programs and simple utilities. Python now incorporates some features from the functional programming paradigm, but it is not considered a true functional programming language.</li>
<li><strong>Python is a General-Purpose Language</strong>: Domain-specific languages are intended for one specific purpose. For example, SQL is only used to communicate with relational database systems. However, Python is a general-purpose language, and has a wide range of applications.</li>
<li><strong>Python is an Interpreted Language</strong>: Unlike many languages, developers do not have to compile Python into assembly or machine code. When a developer completes a program, they can immediately run it with no intermediate steps. The Python interpreter deciphers each line at run time and executes it. This is different from languages like C/C++, which must be pre-compiled first. Python does have a compilation stage, but it takes place at run time and is hidden from the user. Python compiles a program down to low-level&nbsp;<em>bytecode</em>&nbsp;for the&nbsp;<em>Python Virtual Machine</em>&nbsp;(PVM) to interpret and execute.</li>
<li><strong>Python is Dynamically-Typed</strong>: Variables do not have to be assigned a type, such as &ldquo;integer&rdquo;, when they are first used. Python determines the type of variable at run time. Python uses a technique known as &ldquo;duck typing&rdquo;. It assigns a type to a variable depending on its value and how it is used. Python allows a variable to change type dynamically over the duration of the program.</li>
<li><strong>Python Programs are Platform-Independent</strong>: Because Python programs are interpreted, they can be ported to any platform. Only the Python Virtual Machine is platform-specific. It translates the Python code into valid machine code for the platform it is running on.</li>
</ul>
<h2 id="pros-and-cons-of-python">Pros and Cons of Python</h2>
<p>Python is a very distinctive language that has both pros and cons. It is great for certain situations and not as good for others. This section highlights both the advantages and disadvantages of Python.</p>
<h3 id="advantages-of-python">Advantages of Python</h3>
<p>Python has become widely used and well liked due to a cluster of positive attributes. Here are some of the benefits of Python.</p>
<ul>
<li><strong>Ease of Use</strong>: Python has a simple, concise, and straightforward syntax. A Python program looks a lot like plain English and is highly readable. This makes Python programs easy to read and debug. Python&rsquo;s control structures are intuitive and easy to use. In addition, Python is dynamically typed, so there is no requirement to declare the type of each variable. For these reasons, Python is one of the most efficient and productive languages.</li>
<li><strong>Gentle Learning Curve</strong>: Python is one of the simpler languages to learn and is a good option for people learning to program. Programmers switching to Python from languages like C or Java can quickly reach peak efficiency. The Python package contains a useful&nbsp;<em>Integrated Development and Learning Environment</em>&nbsp;(IDLE).</li>
<li><strong>Versatility</strong>: Python is a flexible, general purpose language that fully supports both procedural and object-oriented programming. Due to its built-in and third-party packages, it is suitable for a wide range of tasks. It is dominant in the areas of data science and machine learning. It is also widely used for back-end web development and the&nbsp;<em>Internet of Things</em>&nbsp;(IoT). Even when it is not the best choice for a particular task, it is usually still a viable option. In addition, Python code can be embedded into projects written in other languages, such as C++, and code from other languages can be embedded in Python.</li>
<li><strong>Efficient for Rapid Development</strong>: Because Python is easy to use and does not have to be compiled, programs take less time to develop. Python programs are typically much shorter than equivalent programs in other languages. It is a great choice for quickly constructing prototypes in a rapid software development environment.</li>
<li><strong>True Portability</strong>: A huge Python advantage is that it can be written once and run anywhere. Python does not have to be compiled in advance, so users run a true Python program and not a Python executable. The program is not compiled until it is run, using the platform-specific PVM. This means any Python program can potentially run on any system that supports Python.</li>
<li><strong>No Compile Process</strong>: Python is an interpreted language and programs are automatically compiled at run time. A program can be run as soon as it is written. There is no separate compiler, no time-consuming compilation step, and no opaque compiler errors. Python programs are easy to write, debug, and change incrementally.</li>
<li><strong>Automatic Memory Allocation</strong>: Python does not have pointers and developers do not have to assign free space in memory. Python allocates memory automatically and a garbage collector recycles memory from discarded objects. This means developers do not have to worry about scribblers, memory leaks, invalid pointer references, or the size of each object.</li>
<li><strong>Extensive Built-In Objects and Libraries</strong>: Python has a large number of built-in compound objects including lists, sets, and record-like dictionaries. Each of these objects provides a collection of methods allowing for easy processing. In addition, Python has an extensive library containing tens of thousands of functions. These packages can be used for network communications, web integration, data processing, and hardware interactions. This makes it much faster to write programs because so many of the necessary routines have already been written.</li>
<li><strong>Third-Party Library Availability</strong>: In addition to Python&rsquo;s extensive built-in library, developers can access many free external libraries. These third-party libraries are easy to import and install using Python&rsquo;s&nbsp;<code>pip</code>&nbsp;package manager. Packages can be downloaded from the&nbsp;<a href="https://pypi.org/" target="_blank" rel="noopener">Python Package Index (PyPI) repository</a>. PyPI also allows developers to publish their own packages.</li>
<li><strong>Open Source and Free to Use</strong>: All Python releases are available for free under an open source license. Python can even be modified and re-distributed at no cost. This greatly reduces development costs. For more information about Python licensing, see the&nbsp;<a href="https://docs.python.org/3/license.html" target="_blank" rel="noopener">Python documentation site</a>.</li>
<li><strong>Large User Base</strong>: Python has a large, active, and passionate community of users. It is easy to find learning materials and other resources, ask questions, search for jobs, hire additional developers, and meet other Python programmers.</li>
</ul>
<h3 id="disadvantages-of-python">Disadvantages of Python</h3>
<p>Despite its many advantages, Python also has a few notable disadvantages. Here are some of the drawbacks of Python.</p>
<ul>
<li><strong>Not Very Fast</strong>: Python is much slower than more efficient languages like C and Java. Python is interpreted and dynamically-typed, so the run-time compiler has a lot of work to do. It must constantly validate the type of each variable. This means Python is not the best choice for scenarios where speed is critical.</li>
<li><strong>Memory Intensive</strong>: Python is not optimized to reduce memory. It can use ten times the RAM as a program written in a more frugal language. However, this is partly a tradeoff in return for flexibility and ease of use. In addition, the Python garbage collector cannot gather all discarded resources immediately, which reduces the amount of available memory. Python is not a good choice for memory-constrained environments.</li>
<li><strong>Harder to Avoid Runtime Errors</strong>: Python is not compiled until runtime and is dynamically typed. Therefore, many problems that would otherwise be caught by the compiler do not appear until the program runs. This might include something as simple as a syntax error, but it can include problems like trying to add an integer and a string together.</li>
<li><strong>Not Much Traction in Mobile or Desktop Applications</strong>: Because it is somewhat slow and uses a lot of memory, Python has not made gains in the mobile space. There are some Python development tools for mobile apps, but they are more limited than frameworks for other languages. The situation is a bit better in client desktops, but Python is still not too popular for front-end applications.</li>
<li><strong>Not Optimized for Database Access</strong>: It is more difficult to work with databases in Python than in some other applications. Python lacks a powerful, high quality, easy-to-use interface like the Java Database Connectivity (JDBC). It can still be used if the database reads and writes are relatively straightforward. But it is not the best choice for applications that have complex interactions with a large corporate database.</li>
<li><strong>No Multithreading Support</strong>: Due to its architecture, Python does not support multi-threading. Instead, it uses multiprocessing, where each &ldquo;thread&rdquo; runs in a separate Python process. This relies on the oversight of the operating system to schedule and balance the processes, and might not deliver equally good results.</li>
<li><strong>Prone to Overuse or Misuse</strong>: Python&rsquo;s simplicity is one of its strengths, but this can be a surprising weakness in some situations. Because it is so easy to use, it is often misused for tasks where it is not one of the best alternatives. Python is great for rapid development and prototypes, but this might tempt organizations to overlook proper software development principles.</li>
</ul>
<h2 id="should-you-learn-python">Should You Learn Python?</h2>
<p>After reading about the pros and cons of Python, you might still be uncertain whether it is worth learning. On one hand, there are always benefits to learning a new language. But there are at least a dozen other popular languages, so there are also opportunity costs.</p>
<p>Nonetheless, there are some situations where Python is the right choice. There are benefits to learning Python if any of the following statements apply.</p>
<p><img src="data:image/png;base64,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" alt="8 Key Advantages of Python For Web App Development in 2023"></p>
<p><img src="data:image/jpeg;base64,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" alt="Python Advantages and Disadvantages - Step in the right direction -  TechVidvan"></p>
<p>&nbsp;</p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (16, 27, N'<header class="mb-05">
<h1 class="article-content__title">Intro to Deep Learning</h1>
</header>
<div class="d-md-flex align-items-top justify-content-between">
<div class="tags d-flex flex-wrap align-items-center" data-v-4365a2a0="">&nbsp;</div>
<div class="post__menu">
<div class="el-dropdown">&nbsp;</div>
</div>
</div>
<div class="article-content__body my-2 flex-fill">
<div class="md-contents">
<h3 id="_what-is-deep-learning-0">What is Deep Learning?</h3>
<blockquote>
<p>&ldquo;Deep learning is a particular kind of machine learning that achieves great power and flexibility by learning to represent the world as nested hierarchy of concepts, with each concept defined in relation to simpler concepts, and more abstract representations computed in terms of less abstract ones.&rdquo;</p>
</blockquote>
<p>Deep Learning is a subfield of machine learning which its algorithms inspired by the structure and function of the human brain. This Algorithm takes raw data as an input and process the data through some layers of the nonlinear transformation of the input data to compute the output. The layers are made of nodes. A node is just a place where computation happens, loosely patterned on a neuron in the human brain, which fires when it encounters sufficient stimuli. A node combines input from the data with a set of coefficients, or weights, that either amplify or dampen that input, thereby assigning significance to inputs for the task the algorithm is trying to learn.</p>
<p>Here''s a few key trends in deep learning history:</p>
<ul>
<li>Deep learning has had a long and rich history, but has gone by many names,reﬂecting diﬀerent philosophical viewpoints, and has waxed and waned inpopularity.</li>
<li>Deep learning has become more useful as the amount of available trainingdata has increased.</li>
<li>Deep learning models have grown in size over time as computer infrastructure(both hardware and software) for deep learning has improved.</li>
<li>Deep learning has solved increasingly complicated applications with increasingaccuracy over time.</li>
</ul>
<p>&nbsp;</p>
<p>These are examples of deep application: voice recognition, machine translation, , automatic text generation.etc.</p>
<h3 id="_where-can-we-apply-deep-learning-1">Where can we apply deep learning?</h3>
<p>There are so monay domain where we can apply our deep learning application such as:</p>
<ul>
<li>Computer Vision: for applications like vehicle number plate identification and&nbsp;<a href="https://viblo.asia/p/facial-recognition-system-face-recognition-Ljy5Vr6j5ra" target="_blank" rel="noopener">facial recognition</a>.</li>
<li>Information Retrieval: for applications like search engines, both text search, and image search.</li>
<li>Marketing: for applications like automated email marketing, target identification</li>
<li>Medical Diagnosis: for applications like cancer identification, anomaly detection</li>
<li>Natural Language Processing: for applications like sentiment analysis, photo tagging</li>
<li>Online Advertising, etc</li>
</ul>
<h3 id="_deep-learning-techniques-2">Deep Learning Techniques</h3>
<p>These are the popular deep learning techniques:</p>
<h5>Multilayer Perceptron (MLP)</h5>
<p>A multilayer perceptron (MLP) is a class of feedforward artificial neural network and it consists of three or more layers (an input and an output layer with one or more hidden layers) of nonlinearly-activating nodes.</p>
<h5>Convolutional Neural Networks (CNNs)</h5>
<p>CNNs are neural networks that employ the convolution operation (instead of a fully connected layer) as one of its layers. CNNs are often used to recognize objects and scenes, and perform object detection and segmentation. They learn directly from image data, eliminating the need for manual feature extraction.</p>
<p>&nbsp;</p>
<h5>Recurrent Neural Networks (RNNs)</h5>
<p>RNNs, are a type of artificial neural network that add additional weights to the network to create cycles in the network which is basically using information from a previous forward pass over the neural network. RNNs are often applied to problems wherein the input data on which the predictions are to be made is in the form of a sequence .</p>
<h5>Long Short-Term Memory (LSTMs)</h5>
<p>LSTMs are a special kind of RNN, capable of learning long-term dependencies in sequence prediction problems. It often used in complex problem domains like machine translation, speech recognition, and more.</p>
<h3 id="_deep-learning-vs-other-machine-learning-algorithms-3">Deep Learning Vs Other Machine Learning Algorithms</h3>
<p>Deep learning also has same basic definition as machine learning which:</p>
<blockquote>
<p>input data<code>X</code>&nbsp;into trained function&nbsp;<code>F(x)</code>&nbsp;and return result&nbsp;<code>y</code>. However, there are few points that we will compare these two techniques:</p>
</blockquote>
<h5>Data dependencies:</h5>
<p>the most important difference between deep learning and other traditional machine learning is the amount of training data. When data is small, deep learning not learn well because it need large amount of data in order understant it perfectly. However, traditional machine learning needs little amount data to train on because its algorithm can perform well or not is based on a human expert who tuning the algorithm parameters.</p>
<h5>Hardware dependencies:</h5>
<p>Because deep learning need to train on large amount of data which mean lot of calculation, it needs to use high performance hardware for the operation. On the other hand, other machine learning algorithm can work on low performance hardware since it use little data.</p>
<h5>Execution time:</h5>
<p>More data mean more time as well.</p>
<h5>Feature engineering:</h5>
<p>In Machine learning, most of the applied features need to be identified by an expert and then hand-coded as per the domain and data type.</p>
<p>Deep learning algorithms try to learn high-level features from data by it self.</p>
</div>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (17, 28, N'<h1 class="post-title">B&agrave;i 35: Lược sử Deep Learning</h1>
<p><span class="post-date">Jun 22, 2018</span><br><br></p>
<div>
<p><em>T&ocirc;i xin tạm dừng c&aacute;c b&agrave;i viết về Decision Tree để chuyển sang Deep Learning. T&ocirc;i sẽ quay lại với c&aacute;c thuật to&aacute;n Machine Learning cổ điển khi c&oacute; dịp</em></p>
<p>Trong trang n&agrave;y:</p>
<ul>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#gioi-thieu">Giới thiệu</a></li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#nhung-dau-moc-quan-trong-cua-deep-learning">Những dấu mốc quan trọng của deep learning</a>
<ul>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#perceptron-s">Perceptron (60s)</a></li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#mlp-va-backpropagation-ra-doi-s">MLP v&agrave; Backpropagation ra đời (80s)</a></li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#mua-dong-ai-thu-hai-s---dau-s">M&ugrave;a đ&ocirc;ng AI thứ hai (90s - đầu 2000s)</a></li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#cai-ten-duoc-lam-moi----deep-learning-">C&aacute;i t&ecirc;n được l&agrave;m mới &ndash; Deep Learning (2006)</a></li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#dot-pha-">Đột ph&aacute; (2012)</a></li>
</ul>
</li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#dieu-gi-mang-den-su-thanh-cong-cua-deep-learning">Điều g&igrave; mang đến sự th&agrave;nh c&ocirc;ng của deep learning?</a></li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#ket-luan">Kết luận</a></li>
<li><a href="https://machinelearningcoban.com/2018/06/22/deeplearning/#tai-lieu-tham-khao">T&agrave;i liệu tham khảo</a></li>
</ul>
<p><a name="gioi-thieu"></a></p>
<h2 id="giới-thiệu">Giới thiệu</h2>
<p>Như đ&atilde; một lần nhắc đến trong&nbsp;<a href="https://machinelearningcoban.com/2016/12/26/introduce/">b&agrave;i đầu ti&ecirc;n của blog</a>, tr&iacute; tuệ nh&acirc;n tạo đang len lỏi v&agrave;o trong cuộc sống v&agrave; ảnh hưởng s&acirc;u rộng tới mỗi ch&uacute;ng ta. Kể từ khi t&ocirc;i viết b&agrave;i đầu ti&ecirc;n, tần suất ch&uacute;ng ta nghe thấy c&aacute;c cụm từ &lsquo;artificial intelligence&rsquo;, &lsquo;machine learning&rsquo;, &lsquo;deep learning&rsquo; cũng ng&agrave;y một tăng l&ecirc;n. Nguy&ecirc;n nh&acirc;n ch&iacute;nh dẫn đến việc n&agrave;y (v&agrave; việc ra đời blog n&agrave;y) l&agrave; sự xuất hiện của deep learning trong 5-6 năm gần đ&acirc;y.</p>
<p>Một lần nữa xin được d&ugrave;ng lại h&igrave;nh vẽ m&ocirc; tả mối quan hệ giữa artificial intelligence, machine learning, v&agrave; deep learning:</p>
<hr>
<div class="imgcap">
<div>&nbsp;</div>
<div class="thecap">Mối quan hệ giữa AI, Machine Learning v&agrave; Deep Learning.<br>(Nguồn:&nbsp;<a href="https://blogs.nvidia.com/blog/2016/07/29/whats-difference-artificial-intelligence-machine-learning-deep-learning-ai/">What&rsquo;s the Difference Between Artificial Intelligence, Machine Learning, and Deep Learning?</a>)</div>
</div>
<hr>
<p>Trong b&agrave;i viết n&agrave;y, t&ocirc;i sẽ tr&igrave;nh b&agrave;y sơ lược về lịch sử deep learning. Trong c&aacute;c b&agrave;i tiếp theo, t&ocirc;i c&oacute; tham vọng viết thật kỹ về c&aacute;c th&agrave;nh phần cơ bản của c&aacute;c hệ thống deep learning. Xa hơn nữa, blog sẽ c&oacute; th&ecirc;m c&aacute;c b&agrave;i hướng dẫn cho nhiều b&agrave;i to&aacute;n thực tế.</p>
<p><strong>Blog lu&ocirc;n đ&oacute;n nhận những đ&oacute;ng g&oacute;p để chất lượng c&aacute;c b&agrave;i viết được tốt hơn. Nếu bạn c&oacute; đ&oacute;ng g&oacute;p n&agrave;o, vui l&ograve;ng để lại trong phần comment, t&ocirc;i sẽ cập nhật b&agrave;i viết cho ph&ugrave; hợp. Cảm ơn bạn.</strong></p>
<p><a name="nhung-dau-moc-quan-trong-cua-deep-learning"></a></p>
<h2 id="những-dấu-mốc-quan-trọng-của-deep-learning">Những dấu mốc quan trọng của deep learning</h2>
<p>Deep learning được nhắc đến nhiều trong những năm gần đ&acirc;y, nhưng những nền tảng cơ bản đ&atilde; xuất hiện từ rất l&acirc;u &hellip;</p>
<p>Ch&uacute;ng ta c&ugrave;ng quan s&aacute;t h&igrave;nh dưới đ&acirc;y:</p>
<hr>
<div class="imgcap">
<div>&nbsp;</div>
<div class="thecap">Lịch sử deep learning (Nguồn: H&igrave;nh được lấy từ&nbsp;<a href="https://beamandrew.github.io/deeplearning/2017/02/23/deep_learning_101_part1.html">Deep Learning 101 - Part 1: History and Background&nbsp;</a>. T&aacute;c giả b&agrave;i viết kh&ocirc;ng biết ch&iacute;nh x&aacute;c nguồn gốc của h&igrave;nh.)</div>
</div>
<hr>
<p><a name="perceptron-s"></a></p>
<h3 id="perceptron-60s">Perceptron (60s)</h3>
<p>Một trong những nền m&oacute;ng đầu ti&ecirc;n của neural network v&agrave; deep learning l&agrave;&nbsp;<a href="https://machinelearningcoban.com/2017/01/21/perceptron/">perceptron learning algorithm</a>&nbsp;(hoặc gọn l&agrave; perceptron). Perceptron l&agrave; một thuật to&aacute;n supervised learning gi&uacute;p giải quyết b&agrave;i to&aacute;n ph&acirc;n lớp nhị ph&acirc;n, được khởi nguồn bởi&nbsp;<a href="https://en.wikipedia.org/wiki/Frank_Rosenblatt">Frank Rosenblatt</a>&nbsp;năm 1957 trong một nghi&ecirc;n cứu được t&agrave;i trợ bởi Văn ph&ograve;ng nghi&ecirc;n cứu hải qu&acirc;n Hoa Kỳ (U.S Office of Naval Research &ndash;&nbsp;<em>từ một cơ quan li&ecirc;n quan đến qu&acirc;n sự</em>). Thuật to&aacute;n perceptron được chứng minh l&agrave; hội tụ nếu hai lớp dữ liệu l&agrave;&nbsp;<em>linearly separable</em>. Với th&agrave;nh c&ocirc;ng n&agrave;y, năm 1958, trong một hội thảo, Rosenblatt đ&atilde; c&oacute; một ph&aacute;t biểu g&acirc;y tranh c&atilde;i. Từ ph&aacute;t biểu n&agrave;y, tờ New York Times đ&atilde; c&oacute; một b&agrave;i b&aacute;o cho rằng perceptron được Hải qu&acirc;n Hoa Kỳ mong đợi &ldquo;c&oacute; thể đi, n&oacute;i chuyện, nh&igrave;n, viết, tự sinh sản, v&agrave; tự nhận thức được sự tồn tại của m&igrave;nh&rdquo;. (<em>Ch&uacute;ng ta biết rằng cho tới giờ c&aacute;c hệ thống n&acirc;ng cao hơn perceptron nhiều lần vẫn chưa thể</em>).</p>
<p>Mặc d&ugrave; thuật to&aacute;n n&agrave;y mang lại nhiều kỳ vọng, n&oacute; nhanh ch&oacute;ng được chứng minh kh&ocirc;ng thể giải quyết những b&agrave;i to&aacute;n đơn giản. Năm 1969,&nbsp;<a href="https://en.wikipedia.org/wiki/Marvin_Minsky">Marvin Minsky</a>&nbsp;v&agrave;&nbsp;<a href="https://en.wikipedia.org/wiki/Seymour_Papert">Seymour Papert</a>&nbsp;trong cuốn s&aacute;ch nổi tiếng&nbsp;<a href="https://en.wikipedia.org/wiki/Perceptrons_(book)">Perceptrons</a>&nbsp;đ&atilde; chứng minh rằng&nbsp;<a href="https://machinelearningcoban.com/2017-02-24-mlp.markdown#-bieu-dien-ham-xor-voi-neural-network">kh&ocirc;ng thể &lsquo;học&rsquo; được h&agrave;m số XOR</a>&nbsp;khi sử dụng perceptron. Ph&aacute;t hiện n&agrave;y l&agrave;m cho&aacute;ng v&aacute;ng giới khoa học thời gian đ&oacute; (<em>b&acirc;y giờ ch&uacute;ng ta thấy việc n&agrave;y kh&aacute; hiển nhi&ecirc;n</em>). Perceptron được chứng minh rằng chỉ hoạt động nếu dữ liệu l&agrave;&nbsp;<em>linearly separable</em>.</p>
<p><em>Ph&aacute;t hiện n&agrave;y khiến cho c&aacute;c nghi&ecirc;n cứu về perceptron bị gi&aacute;n đoạn gần 20 năm. Thời kỳ n&agrave;y c&ograve;n được gọi l&agrave;&nbsp;<strong>M&ugrave;a đ&ocirc;ng AI thứ nhất (The First AI winter)</strong>.</em></p>
<p>Cho tới khi&hellip;</p>
<p><a name="mlp-va-backpropagation-ra-doi-s"></a></p>
<h3 id="mlp-v&agrave;-backpropagation-ra-đời-80s">MLP v&agrave; Backpropagation ra đời (80s)</h3>
<p><a href="https://en.wikipedia.org/wiki/Geoffrey_Hinton">Geoffrey Hinton</a>&nbsp;tốt nghiệp PhD ng&agrave;nh neural networks năm 1978. Năm 1986, &ocirc;ng c&ugrave;ng với hai t&aacute;c giả kh&aacute;c xuất bản một b&agrave;i b&aacute;o khoa học tr&ecirc;n Nature với tựa đề&nbsp;<a href="http://www.nature.com/nature/journal/v323/n6088/abs/323533a0.html">&ldquo;Learning representations by back-propagating errors&rdquo;</a>. Trong b&agrave;i b&aacute;o n&agrave;y, nh&oacute;m của &ocirc;ng chứng minh rằng neural nets với nhiều hidden layer (được gọi l&agrave; multi-layer perceptron hoặc MLP) c&oacute; thể được huấn luyện một c&aacute;ch hiệu quả dựa tr&ecirc;n một quy tr&igrave;nh đơn giản được gọi l&agrave;&nbsp;<a href="https://machinelearningcoban.com/2017/02/24/mlp/#-backpropagation"><strong>backpropagation</strong></a>&nbsp;(<em>backpropagation l&agrave; t&ecirc;n gọi mỹ miều của quy tắc chuỗi &ndash; chain rule &ndash; trong t&iacute;nh đạo h&agrave;m. Việc t&iacute;nh được đạo h&agrave;m của h&agrave;m số phức tạp m&ocirc; tả quan hệ giữa đầu v&agrave;o v&agrave; đầu ra của một neural net l&agrave; rất quan trọng v&igrave; hầu hết c&aacute;c thuật to&aacute;n tối ưu đều được thực hiện th&ocirc;ng qua việc t&iacute;nh đạo h&agrave;m,&nbsp;<a href="https://machinelearningcoban.com/2017/01/12/gradientdescent/">gradient descent</a>&nbsp;l&agrave; một v&iacute; dụ</em>). Việc n&agrave;y gi&uacute;p neural nets&nbsp;<em>tho&aacute;t</em>&nbsp;được những hạn chế của perceptron về việc chỉ biểu diễn được c&aacute;c quan hệ tuyến t&iacute;nh. Để biểu diễn c&aacute;c quan hệ phi tuyến, ph&iacute;a sau mỗi layer l&agrave; một h&agrave;m k&iacute;ch hoạt phi tuyến, v&iacute; dụ h&agrave;m sigmoid hoặc tanh. (ReLU ra đời năm 2012). Với hidden layers, neural nets được chứng minh rằng c&oacute; khả năng xấp xỉ hầu hết bất kỳ h&agrave;m số n&agrave;o qua một định l&yacute; được gọi l&agrave;&nbsp;<a href="https://en.wikipedia.org/wiki/Universal_approximation_theorem">universal approximation theorem</a>.&nbsp;<em>Neurel nets quay trở lại cuộc chơi</em>.</p>
<p>Thuật to&aacute;n n&agrave;y mang lại một v&agrave;i th&agrave;nh c&ocirc;ng ban đầu, nổi trội l&agrave;&nbsp;<strong>convolutional neural nets</strong>&nbsp;(convnets hay CNN) (c&ograve;n được gọi l&agrave;&nbsp;<a href="http://yann.lecun.com/exdb/lenet/">LeNet</a>) cho b&agrave;i to&aacute;n nhận dạng chữ số viết tay được khởi nguồn bởi Yann LeCun tại AT&amp;T Bell Labs (Yann LeCun l&agrave; sinh vi&ecirc;n sau cao học của Hinton tại đại học Toronto năm 1987-1988). Dưới đ&acirc;y l&agrave; bản demo được lấy từ trang web của LeNet, network l&agrave; một CNN với 5 layer, c&ograve;n được gọi l&agrave; LeNet-5 (1998).</p>
<hr>
<div class="imgcap">
<div>&nbsp;</div>
<div class="thecap">LeNet-5 cho b&agrave;i to&aacute;n nhận diện chữ số viết tay. (Nguồn:&nbsp;<a href="http://yann.lecun.com/">http://yann.lecun.com</a>)</div>
</div>
<hr>
<p>M&ocirc; h&igrave;nh n&agrave;y được sử dụng rộng r&atilde;i trong c&aacute;c hệ thống đọc số viết tay tr&ecirc;n c&aacute;c check (s&eacute;c ng&acirc;n h&agrave;ng) v&agrave; m&atilde; v&ugrave;ng bưu điện của nước Mỹ.</p>
<p>LeNet l&agrave; thuật to&aacute;n tốt nhất thời gian đ&oacute; cho b&agrave;i to&aacute;n nhận dạng ảnh chữ số viết tay. N&oacute; tốt hơn MLP th&ocirc;ng thường (với fully connected layer) v&igrave; n&oacute; c&oacute; khả năng tr&iacute;ch xuất được đặc trưng trong kh&ocirc;ng gian hai chiều của ảnh th&ocirc;ng qua c&aacute;c filters (bộ lọc) hai chiều. Hơn nữa, c&aacute;c filter n&agrave;y nhỏ n&ecirc;n việc lưu trữ v&agrave; t&iacute;nh to&aacute;n cũng tốt hơn so với MLP th&ocirc;ng thường. (<em>Yan LeCun c&oacute; xuất ph&aacute;t từ Electrical Engineering n&ecirc;n rất quen thuộc với c&aacute;c bộ lọc.</em>)</p>
<p><a name="mua-dong-ai-thu-hai-s---dau-s"></a></p>
<h3 id="m&ugrave;a-đ&ocirc;ng-ai-thứ-hai-90s---đầu-2000s">M&ugrave;a đ&ocirc;ng AI thứ hai (90s - đầu 2000s)</h3>
<p>C&aacute;c m&ocirc; h&igrave;nh tương tự được kỳ vọng sẽ giải quyết nhiều b&agrave;i to&aacute;n image classification kh&aacute;c. Tuy nhi&ecirc;n, kh&ocirc;ng như c&aacute;c chữ số, c&aacute;c loại ảnh kh&aacute;c lại rất hạn chế v&igrave; m&aacute;y ảnh số chưa phổ biến tại thời điểm đ&oacute;. Ảnh được g&aacute;n nh&atilde;n lại c&agrave;ng hiếm. Trong khi để c&oacute; thể huấn luyện được m&ocirc; h&igrave;nh convnets, ta cần rất nhiều dữ liệu huấn luyện. Ngay cả khi dữ liệu c&oacute; đủ, một vấn đề nan giải kh&aacute;c l&agrave; khả năng t&iacute;nh to&aacute;n của c&aacute;c m&aacute;y t&iacute;nh thời đ&oacute; c&ograve;n rất hạn chế.</p>
<p>Một hạn chế kh&aacute;c của c&aacute;c kiến tr&uacute;c MLP n&oacute;i chung l&agrave; h&agrave;m mất m&aacute;t kh&ocirc;ng phải l&agrave; một&nbsp;<a href="https://machinelearningcoban.com/2017/03/12/convexity/#-convex-functions">h&agrave;m lồi</a>. Việc n&agrave;y khiến cho việc t&igrave;m nghiệm tối ưu to&agrave;n cục cho b&agrave;i to&aacute;n tối ưu h&agrave;m mất m&aacute;t trở n&ecirc;n rất kh&oacute; khăn. Một vấn đề kh&aacute;c li&ecirc;n quan đến giới hạn t&iacute;nh to&aacute;n của m&aacute;y t&iacute;nh cũng khiến cho việc huấn luyện MLP kh&ocirc;ng hiệu quả khi số lượng hidden layers lớn l&ecirc;n. Vấn đề n&agrave;y c&oacute; t&ecirc;n l&agrave;&nbsp;<strong>vanishing gradient</strong>.</p>
<p>Nhắc lại rằng h&agrave;m k&iacute;ch hoạt được sử dụng thời gian đ&oacute; l&agrave; sigmoid hoặc tanh &ndash; l&agrave; c&aacute;c h&agrave;m bị chặn trong khoảng (0, 1) hoặc (-1, 1) (Nhắc lại&nbsp;<a href="https://machinelearningcoban.com/2017/01/27/logisticregression/#sigmoid-function">đạo h&agrave;m của h&agrave;m sigmoid</a>&nbsp;<span id="MathJax-Element-1-Frame" class="mjx-chtml MathJax_CHTML" style="box-sizing: border-box; display: inline-block; line-height: 0; text-indent: 0px; text-align: left; text-transform: none; font-style: normal; font-weight: normal; font-size: 18.72px; letter-spacing: normal; overflow-wrap: normal; word-spacing: normal; white-space: nowrap; float: none; direction: ltr; max-width: none; max-height: none; min-width: 0px; min-height: 0px; border: 0px; margin: 0px; padding: 1px 0px; position: relative;" tabindex="0" role="presentation" data-mathml="&lt;math xmlns=&quot;http://www.w3.org/1998/Math/MathML&quot;&gt;&lt;mi&gt;&amp;#x03C3;&lt;/mi&gt;&lt;mo stretchy=&quot;false&quot;&gt;(&lt;/mo&gt;&lt;mi&gt;z&lt;/mi&gt;&lt;mo stretchy=&quot;false&quot;&gt;)&lt;/mo&gt;&lt;/math&gt;"><span id="MJXc-Node-1" class="mjx-math" aria-hidden="true"><span id="MJXc-Node-2" class="mjx-mrow"><span id="MJXc-Node-3" class="mjx-mi"><span class="mjx-char MJXc-TeX-math-I">&sigma;</span></span><span id="MJXc-Node-4" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">(</span></span><span id="MJXc-Node-5" class="mjx-mi"><span class="mjx-char MJXc-TeX-math-I">z</span></span><span id="MJXc-Node-6" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">)</span></span></span></span><span class="MJX_Assistive_MathML" role="presentation"> ( )</span></span>&nbsp;l&agrave;&nbsp;<span id="MathJax-Element-2-Frame" class="mjx-chtml MathJax_CHTML" style="box-sizing: border-box; display: inline-block; line-height: 0; text-indent: 0px; text-align: left; text-transform: none; font-style: normal; font-weight: normal; font-size: 18.72px; letter-spacing: normal; overflow-wrap: normal; word-spacing: normal; white-space: nowrap; float: none; direction: ltr; max-width: none; max-height: none; min-width: 0px; min-height: 0px; border: 0px; margin: 0px; padding: 1px 0px; position: relative;" tabindex="0" role="presentation" data-mathml="&lt;math xmlns=&quot;http://www.w3.org/1998/Math/MathML&quot;&gt;&lt;mi&gt;&amp;#x03C3;&lt;/mi&gt;&lt;mo stretchy=&quot;false&quot;&gt;(&lt;/mo&gt;&lt;mi&gt;z&lt;/mi&gt;&lt;mo stretchy=&quot;false&quot;&gt;)&lt;/mo&gt;&lt;mo stretchy=&quot;false&quot;&gt;(&lt;/mo&gt;&lt;mn&gt;1&lt;/mn&gt;&lt;mo&gt;&amp;#x2212;&lt;/mo&gt;&lt;mi&gt;&amp;#x03C3;&lt;/mi&gt;&lt;mo stretchy=&quot;false&quot;&gt;(&lt;/mo&gt;&lt;mi&gt;z&lt;/mi&gt;&lt;mo stretchy=&quot;false&quot;&gt;)&lt;/mo&gt;&lt;mo stretchy=&quot;false&quot;&gt;)&lt;/mo&gt;&lt;/math&gt;"><span id="MJXc-Node-7" class="mjx-math" aria-hidden="true"><span id="MJXc-Node-8" class="mjx-mrow"><span id="MJXc-Node-9" class="mjx-mi"><span class="mjx-char MJXc-TeX-math-I">&sigma;</span></span><span id="MJXc-Node-10" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">(</span></span><span id="MJXc-Node-11" class="mjx-mi"><span class="mjx-char MJXc-TeX-math-I">z</span></span><span id="MJXc-Node-12" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">)</span></span><span id="MJXc-Node-13" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">(</span></span><span id="MJXc-Node-14" class="mjx-mn"><span class="mjx-char MJXc-TeX-main-R">1</span></span><span id="MJXc-Node-15" class="mjx-mo MJXc-space2"><span class="mjx-char MJXc-TeX-main-R">&minus;</span></span><span id="MJXc-Node-16" class="mjx-mi MJXc-space2"><span class="mjx-char MJXc-TeX-math-I">&sigma;</span></span><span id="MJXc-Node-17" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">(</span></span><span id="MJXc-Node-18" class="mjx-mi"><span class="mjx-char MJXc-TeX-math-I">z</span></span><span id="MJXc-Node-19" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">)</span></span><span id="MJXc-Node-20" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">)</span></span></span></span><span class="MJX_Assistive_MathML" role="presentation"> ( )(1&minus; ( ))</span></span>&nbsp;l&agrave; t&iacute;ch của hai số nhỏ hơn 1). Khi sử dụng backpropagation để t&iacute;nh đạo h&agrave;m cho c&aacute;c ma trận hệ số ở c&aacute;c lớp đầu ti&ecirc;n, ta cần phải nh&acirc;n rất nhiều c&aacute;c gi&aacute; trị nhỏ hơn 1 với nhau. Việc n&agrave;y khiến cho nhiều đạo h&agrave;m th&agrave;nh phần bằng 0 do xấp xỉ t&iacute;nh to&aacute;n. Khi đạo h&agrave;m của một th&agrave;nh phần bằng 0, n&oacute; sẽ kh&ocirc;ng được cập nhật th&ocirc;ng qua gradient descent!</p>
<p>Những hạn chế n&agrave;y khiến cho neural nets một lần nữa rơi v&agrave;o thời kỳ&nbsp;<em>băng gi&aacute;</em>. V&agrave;o thời điểm những năm 1990 v&agrave; đầu những năm 2000, neural nets dần được thay thế bởi&nbsp;<a href="https://machinelearningcoban.com/2017/04/09/smv/">support vector machines &ndash;SVM</a>. SVMs c&oacute; ưu điểm l&agrave; b&agrave;i to&aacute;n tối ưu để t&igrave;m c&aacute;c tham số của n&oacute; l&agrave; một b&agrave;i to&aacute;n lồi &ndash; c&oacute; nhiều c&aacute;c thuật to&aacute;n tối ưu hiệu quả gi&uacute;p t&igrave;m nghiệm của n&oacute;. C&aacute;c&nbsp;<a href="https://machinelearningcoban.com/2017/04/22/kernelsmv/">kỹ thuật về kernel</a>&nbsp;cũng ph&aacute;t triển gi&uacute;p SVMs giải quyết được cả c&aacute;c vấn đề về việc dữ liệu kh&ocirc;ng ph&acirc;n biệt tuyến t&iacute;nh.</p>
<p>Nhiều nh&agrave; khoa học l&agrave;m machine learning chuyển sang nghi&ecirc;n cứu SVM trong thời gian đ&oacute;, trừ một v&agrave;i nh&agrave; khoa học cứng đầu&hellip;</p>
<p><a name="cai-ten-duoc-lam-moi----deep-learning-"></a></p>
<h3 id="c&aacute;i-t&ecirc;n-được-l&agrave;m-mới--deep-learning-2006">C&aacute;i t&ecirc;n được l&agrave;m mới &ndash; Deep Learning (2006)</h3>
<p>Năm 2006, Hinton một lần nữa cho rằng &ocirc;ng biết&nbsp;<a href="https://www.youtube.com/watch?v=mlXzufEk-2E">bộ n&atilde;o hoạt động như thế n&agrave;o</a>, v&agrave; giới thiệu &yacute; tưởng của&nbsp;<em>tiền huấn luyện kh&ocirc;ng gi&aacute;m s&aacute;t</em>&nbsp;(<a href="https://metacademy.org/graphs/concepts/unsupervised_pre_training"><em>unsupervised pretraining</em></a>) th&ocirc;ng qua&nbsp;<a href="https://en.wikipedia.org/wiki/Deep_belief_network">deep belief nets (DBN)</a>. DBN c&oacute; thể được xem như sự xếp chồng c&aacute;c unsupervised networks đơn giản như&nbsp;<a href="https://en.wikipedia.org/wiki/Restricted_Boltzmann_machine">restricted Boltzman machine</a>&nbsp;hay&nbsp;<a href="http://ufldl.stanford.edu/tutorial/unsupervised/Autoencoders/">autoencoders</a>.</p>
<p>Lấy v&iacute; dụ với autoencoder. Mỗi autoencoder l&agrave; một neural net với một hidden layer. Số hidden&nbsp;<a href="https://machinelearningcoban.com/2017/02/24/mlp/#-units">unit</a>&nbsp;&iacute;t hơn số input unit, v&agrave; số output unit bằng với số input unit. Network n&agrave;y đơn giản được huấn luyện để kết quả ở output layer giống với kết quả ở input layer (v&agrave; v&igrave; vậy được gọi l&agrave; autoencoder). Qu&aacute; tr&igrave;nh dữ liệu đi từ input layer tới hidden layer c&oacute; thể coi l&agrave;&nbsp;<em>m&atilde; ho&aacute;</em>, qu&aacute; tr&igrave;nh dữ liệu đi từ hidden layer ra output layer c&oacute; thể được coi l&agrave;&nbsp;<em>giải m&atilde;</em>. Khi output giống với input, ta c&oacute; thể thấy rằng hidden layer với &iacute;t unit hơn c&oacute; để m&atilde; ho&aacute; input kh&aacute; th&agrave;nh c&ocirc;ng, v&agrave; c&oacute; thể được coi mang những t&iacute;nh chất của input. Nếu ta bỏ output layer,&nbsp;<em>cố định</em>&nbsp;(<em>freeze</em>) kết nối giữa input v&agrave; hidden layer, coi đầu ra của hidden layer l&agrave; một input mới, sau đ&oacute; huấn luyện một autoencoder kh&aacute;c, ta được th&ecirc;m một hidden layer nữa. Qu&aacute; tr&igrave;nh n&agrave;y tiếp tục k&eacute;o d&agrave;i ta sẽ được một network đủ&nbsp;<em>s&acirc;u</em>&nbsp;m&agrave; output của network lớn n&agrave;y (ch&iacute;nh l&agrave; hidden layer của autoencoder cuối c&ugrave;ng) mang th&ocirc;ng tin của input ban đầu. Sau đ&oacute; ta c&oacute; thể th&ecirc;m c&aacute;c layer kh&aacute;c tuỳ thuộc v&agrave;o b&agrave;i to&aacute;n (chẳng hạn th&ecirc;m softmax layer ở cuối cho b&agrave;i to&aacute;n classification). Cả network được huấn luyện th&ecirc;m một v&agrave;i epoch nữa. Qu&aacute; tr&igrave;nh n&agrave;y được gọi l&agrave;&nbsp;<em>tinh chỉnh</em>&nbsp;(<em>fine tuning</em>).</p>
<p>Tại sao qu&aacute; tr&igrave;nh huấn luyện như tr&ecirc;n mang lại nhiều lợi &iacute;ch?</p>
<p>Một trong những hạn chế đ&atilde; đề cập của MLP l&agrave; vấn đề&nbsp;<em>vanishing gradient</em>. Những ma trận trọng số ứng với c&aacute;c layer đầu của network rất kh&oacute; được huấn luyện v&igrave; đạo h&agrave;m của h&agrave;m mất m&aacute;t theo c&aacute;c ma trận n&agrave;y nhỏ. Với &yacute; tưởng của DBN, c&aacute;c ma trận trọng số ở những hidden layer đầu ti&ecirc;n được&nbsp;<em>tiền huấn luyện</em>&nbsp;(<em>pretrained</em>). C&aacute;c trọng số được tiền huấn luyện n&agrave;y c&oacute; thể coi l&agrave; gi&aacute; trị khởi tạo tốt cho c&aacute;c hidden layer ph&iacute;a đầu. Việc n&agrave;y gi&uacute;p phần n&agrave;o tr&aacute;nh được sự phiền h&agrave; của&nbsp;<em>vanishing gradient</em>.</p>
<p>Kể từ đ&acirc;y, neural networks với nhiều hidden layer được đổi t&ecirc;n th&agrave;nh&nbsp;<strong>deep learning</strong>.</p>
<p>Vấn đề&nbsp;<em>vanishing gradient</em>&nbsp;được giải quyết phần n&agrave;o (vẫn chưa thực sự triệt để), nhưng vẫn c&ograve;n những vấn đề kh&aacute;c của deep learning: dữ liệu huấn luyện qu&aacute; &iacute;t, v&agrave; khả năng t&iacute;nh to&aacute;n của CPU c&ograve;n rất hạn chế trong việc huấn luyện c&aacute;c deep networks.</p>
<p>Năm 2010, gi&aacute;o sư Fei-Fei Li, một gi&aacute;o sư ng&agrave;nh computer vision đầu ng&agrave;nh tại Stanford, c&ugrave;ng với nh&oacute;m của b&agrave; tạo ra một cơ sở dữ liệu c&oacute; t&ecirc;n&nbsp;<a href="http://www.image-net.org/">ImageNet</a>&nbsp;với h&agrave;ng triệu bức ảnh thuộc 1000 lớp dữ liệu kh&aacute;c nhau đ&atilde; được g&aacute;n nh&atilde;n. Dự &aacute;n n&agrave;y được thực hiện nhờ v&agrave;o sự b&ugrave;ng nổ của internet những năm 2000 v&agrave; lượng ảnh khổng lồ được upload l&ecirc;n internet thời gian đ&oacute;. C&aacute;c bức ảnh n&agrave;y được g&aacute;n nh&atilde;n bởi rất nhiều người (được trả c&ocirc;ng).</p>
<p>Xem th&ecirc;m&nbsp;<a href="https://www.youtube.com/watch?v=40riCqvRoMs">How we teach computers to understand pictures. Fei-Fei Li</a></p>
<p>Bộ cơ sở dữ liệu n&agrave;y được cập nhật h&agrave;ng năm, v&agrave; kể từ năm 2010, n&oacute; được d&ugrave;ng trong một cuộc thi thường ni&ecirc;n c&oacute; t&ecirc;n&nbsp;<a href="http://www.image-net.org/challenges/LSVRC/">ImageNet Large Scale Visual Recognition Challenge (ILSVRC)</a>. Trong cuộc thi n&agrave;y, dữ liệu huấn luyện được giao cho c&aacute;c đội tham gia. Mỗi đội cần sử dụng dữ liệu n&agrave;y để huấn luyện c&aacute;c m&ocirc; h&igrave;nh ph&acirc;n lớp, c&aacute;c m&ocirc; h&igrave;nh n&agrave;y sẽ được &aacute;p dụng để dự đo&aacute;n nh&atilde;n của dữ liệu mới (được giữ bởi ban tổ chức). Trong hai năm 2010 v&agrave; 2011, c&oacute; rất nhiều đội tham gia. C&aacute;c m&ocirc; h&igrave;nh trong hai năm n&agrave;y chủ yếu l&agrave; sự kết hợp của SVM với c&aacute;c feature được x&acirc;y dựng bởi c&aacute;c bộ&nbsp;<em>hand-crafted descriptors</em>&nbsp;(SIFT, HoG, v.v.). M&ocirc; h&igrave;nh gi&agrave;nh chiến thắng c&oacute; top-5 error rate l&agrave; 28% (c&agrave;ng nhỏ c&agrave;ng tốt). M&ocirc; h&igrave;nh gi&agrave;nh chiến thắng năm 2011 c&oacute; top-5 error rate l&agrave; 26%. Cải thiện kh&ocirc;ng nhiều!</p>
<p><em>Ngo&agrave;i lề: top-5 error rate được t&iacute;nh như sau. Mỗi m&ocirc; h&igrave;nh dự đo&aacute;n 5 nh&atilde;n của một bức ảnh. Nếu nh&atilde;n thật của bức ảnh nằm trong 5 nh&atilde;n đ&oacute;, ta c&oacute; một điểm được ph&acirc;n lớp ch&iacute;nh x&aacute;c. Ngo&agrave;i ra, bức ảnh đ&oacute; được coi l&agrave; một error. Top-5 error rate l&agrave; tỉ lệ số bức ảnh error trong to&agrave;n bộ số ảnh kiểm thử với error được t&iacute;nh theo c&aacute;ch n&agrave;y. Top-1 error cộng với classification accuracy (phần trăm) ch&iacute;nh bằng 100 phần trăm.</em></p>
<p><a name="dot-pha-"></a></p>
<h3 id="đột-ph&aacute;-2012">Đột ph&aacute; (2012)</h3>
<p>Năm 2012, cũng tại ILSVRC, Alex Krizhevsky, Ilya Sutskever, v&agrave; Geoffrey Hinton (lại l&agrave; &ocirc;ng) tham gia v&agrave; đạt kết quả top-5 error rate 16%. Kết quả n&agrave;y l&agrave;m sững sờ giới nghi&ecirc;n cứu thời gian đ&oacute;. M&ocirc; h&igrave;nh l&agrave; một Deep Convolutional Neural Network, sau n&agrave;y được gọi l&agrave;&nbsp;<a href="https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf">AlexNet</a>.</p>
<p>Trong b&agrave;i b&aacute;o n&agrave;y, rất nhiều c&aacute;c kỹ thuật mới được giới thiệu. Trong đ&oacute; hai đ&oacute;ng g&oacute;p nổi bật nhất l&agrave;&nbsp;<a href="https://machinelearningcoban.com/2017/02/24/mlp/#-relu">h&agrave;m ReLU</a>&nbsp;v&agrave; dropout. H&agrave;m ReLU (<span id="MathJax-Element-3-Frame" class="mjx-chtml MathJax_CHTML" style="box-sizing: border-box; display: inline-block; line-height: 0; text-indent: 0px; text-align: left; text-transform: none; font-style: normal; font-weight: normal; font-size: 18.72px; letter-spacing: normal; overflow-wrap: normal; word-spacing: normal; white-space: nowrap; float: none; direction: ltr; max-width: none; max-height: none; min-width: 0px; min-height: 0px; border: 0px; margin: 0px; padding: 1px 0px; position: relative;" tabindex="0" role="presentation" data-mathml="&lt;math xmlns=&quot;http://www.w3.org/1998/Math/MathML&quot;&gt;&lt;mtext&gt;ReLU&lt;/mtext&gt;&lt;mo stretchy=&quot;false&quot;&gt;(&lt;/mo&gt;&lt;mi&gt;x&lt;/mi&gt;&lt;mo stretchy=&quot;false&quot;&gt;)&lt;/mo&gt;&lt;mo&gt;=&lt;/mo&gt;&lt;mo movablelimits=&quot;true&quot; form=&quot;prefix&quot;&gt;max&lt;/mo&gt;&lt;mo stretchy=&quot;false&quot;&gt;(&lt;/mo&gt;&lt;mi&gt;x&lt;/mi&gt;&lt;mo&gt;,&lt;/mo&gt;&lt;mn&gt;0&lt;/mn&gt;&lt;mo stretchy=&quot;false&quot;&gt;)&lt;/mo&gt;&lt;/math&gt;"><span id="MJXc-Node-21" class="mjx-math" aria-hidden="true"><span id="MJXc-Node-22" class="mjx-mrow"><span id="MJXc-Node-23" class="mjx-mtext"><span class="mjx-char MJXc-TeX-main-R">ReLU</span></span><span id="MJXc-Node-24" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">(</span></span><span id="MJXc-Node-25" class="mjx-mi"><span class="mjx-char MJXc-TeX-math-I">x</span></span><span id="MJXc-Node-26" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">)</span></span><span id="MJXc-Node-27" class="mjx-mo MJXc-space3"><span class="mjx-char MJXc-TeX-main-R">=</span></span><span id="MJXc-Node-28" class="mjx-mo MJXc-space3"><span class="mjx-char MJXc-TeX-main-R">max</span></span><span id="MJXc-Node-29" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">(</span></span><span id="MJXc-Node-30" class="mjx-mi"><span class="mjx-char MJXc-TeX-math-I">x</span></span><span id="MJXc-Node-31" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">,</span></span><span id="MJXc-Node-32" class="mjx-mn MJXc-space1"><span class="mjx-char MJXc-TeX-main-R">0</span></span><span id="MJXc-Node-33" class="mjx-mo"><span class="mjx-char MJXc-TeX-main-R">)</span></span></span></span><span class="MJX_Assistive_MathML" role="presentation">ReLU( )=max( ,0)</span></span>) với c&aacute;ch t&iacute;nh v&agrave; đạo h&agrave;m đơn giản (bằng 1 khi đầu v&agrave;o kh&ocirc;ng &acirc;m, bằng 0 khi ngược lại) gi&uacute;p tốc độ huấn luyện tăng l&ecirc;n đ&aacute;ng kể. Ngo&agrave;i ra, việc ReLU kh&ocirc;ng bị chặn tr&ecirc;n bởi 1 (như softmax hay tanh) khiến cho vấn đề vanishing gradient cũng được giải quyết phần n&agrave;o. Dropout cũng l&agrave; một kỹ thuật đơn giản v&agrave; cực kỳ hiệu quả. Trong qu&aacute; tr&igrave;nh training, nhiều hidden unit bị&nbsp;<em>tắt</em>&nbsp;ngẫu nhi&ecirc;n v&agrave; m&ocirc; h&igrave;nh được huấn luyện tr&ecirc;n c&aacute;c bộ tham số c&ograve;n lại. Trong qu&aacute; tr&igrave;nh test, to&agrave;n bộ c&aacute;c unit sẽ được sử dụng. C&aacute;ch l&agrave;m n&agrave;y kh&aacute; l&agrave; c&oacute; l&yacute; khi đối chiếu với con người. Nếu chỉ d&ugrave;ng một phần năng lực đ&atilde; đem lại hiệu quả th&igrave; d&ugrave;ng to&agrave;n bộ năng lực sẽ mang lại hiệu quả cao hơn. Việc n&agrave;y cũng gi&uacute;p cho m&ocirc; h&igrave;nh tr&aacute;nh được&nbsp;<a href="https://machinelearningcoban.com/2017/03/04/overfitting/">overfitting</a>&nbsp;v&agrave; cũng được coi giống với kỹ thuật&nbsp;<a href="https://en.wikipedia.org/wiki/Ensemble_learning"><em>ensemble</em></a>&nbsp;trong c&aacute;c hệ thống machine learning kh&aacute;c. Với mỗi c&aacute;ch&nbsp;<em>tắt</em>&nbsp;c&aacute;c unit, ta c&oacute; một m&ocirc; h&igrave;nh kh&aacute;c nhau. Với nhiều tổ hợp unit bị tắt kh&aacute;c nhau, ta thu được nhiều m&ocirc; h&igrave;nh. Việc kết hợp ở cuối c&ugrave;ng được coi như sự kết hợp của nhiều m&ocirc; h&igrave;nh (v&agrave; v&igrave; vậy, n&oacute; giống với&nbsp;<em>ensemble learning</em>).</p>
<p>Một trong những yếu tố quan trọng nhất gi&uacute;p AlexNet th&agrave;nh c&ocirc;ng l&agrave; việc sử dụng GPU (card đồ hoạ) để huấn luyện m&ocirc; h&igrave;nh. GPU được tạo ra cho game thủ, với khả năng chạy song song nhiều l&otilde;i, đ&atilde; trở th&agrave;nh một c&ocirc;ng cụ cực kỳ ph&ugrave; hợp với c&aacute;c thuật to&aacute;n deep learning, gi&uacute;p tăng tốc thuật to&aacute;n l&ecirc;n nhiều lần so với CPU.</p>
<p>Sau AlexNet, tất cả c&aacute;c m&ocirc; h&igrave;nh gi&agrave;nh giải cao trong c&aacute;c năm tiếp theo đều l&agrave; c&aacute;c deep networks (ZFNet 2013, GoogLeNet 2014, VGG 2014, ResNet 2015). T&ocirc;i sẽ gi&agrave;nh một b&agrave;i của blog để viết về c&aacute;c kiến tr&uacute;c quan trọng n&agrave;y. Xu thế chung c&oacute; thể thấy l&agrave; c&aacute;c m&ocirc; h&igrave;nh c&agrave;ng ng&agrave;y c&agrave;ng&nbsp;<em>deep</em>. Xem h&igrave;nh dưới đ&acirc;y.</p>
<hr>
<div class="imgcap">
<div>&nbsp;</div>
<div class="thecap">Kết quả ILSVRC qua c&aacute;c năm. (Nguồn:&nbsp;<a href="https://medium.com/@siddharthdas_32104/cnns-architectures-lenet-alexnet-vgg-googlenet-resnet-and-more-666091488df5">CNN Architectures: LeNet, AlexNet, VGG, GoogLeNet, ResNet and more ...</a>)</div>
</div>
<hr>
<p>Những c&ocirc;ng ty c&ocirc;ng nghệ lớn cũng để &yacute; tới việc ph&aacute;t triển c&aacute;c ph&ograve;ng nghi&ecirc;n cứu deep learning trong thời gian n&agrave;y. Rất nhiều c&aacute;c ứng dụng c&ocirc;ng nghệ đột ph&aacute; đ&atilde; được &aacute;p dụng v&agrave;o cuộc sống h&agrave;ng ng&agrave;y. Cũng kể từ năm 2012, số lượng c&aacute;c b&agrave;i b&aacute;o khoa học về deep learning tăng l&ecirc;n theo h&agrave;m số mũ. C&aacute;c blog về deep learning cũng tăng l&ecirc;n từng ng&agrave;y.</p>
<p><a name="dieu-gi-mang-den-su-thanh-cong-cua-deep-learning"></a></p>
<h2 id="điều-g&igrave;-mang-đến-sự-th&agrave;nh-c&ocirc;ng-của-deep-learning">Điều g&igrave; mang đến sự th&agrave;nh c&ocirc;ng của deep learning?</h2>
<p>Rất nhiều những &yacute; tưởng cơ bản của deep learning được đặt nền m&oacute;ng từ những năm 80-90 của thế kỷ trước, tuy nhi&ecirc;n deep learning chỉ đột ph&aacute; trong khoảng 5-6 năm nay. V&igrave; sao?</p>
<p>C&oacute; nhiều nh&acirc;n tố dẫn đến sự b&ugrave;ng nổ n&agrave;y:</p>
<ul>
<li>
<p>Sự ra đời của c&aacute;c bộ dữ liệu lớn được g&aacute;n nh&atilde;n.</p>
</li>
<li>
<p>Khả năng t&iacute;nh to&aacute;n song song tốc độ cao của GPU.</p>
</li>
<li>
<p>Sự ra đời của ReLU v&agrave; c&aacute;c h&agrave;m k&iacute;ch hoạt li&ecirc;n quan l&agrave;m hạn chế vấn đề vanishing gradient.</p>
</li>
<li>
<p>Sự cải tiến của c&aacute;c kiến tr&uacute;c: GoogLeNet, VGG, ResNet, &hellip; v&agrave; c&aacute;c kỹ thuật transfer learning, fine tuning.</p>
</li>
<li>
<p>Nhiều kỹ thuật regularization mới: dropout, batch normalization, data augmentation.</p>
</li>
<li>
<p>Nhiều thư viện mới hỗ trợ việc huấn luyện deep network với GPU: theano, caffe, mxnet, tensorflow, pytorch, keras, &hellip;</p>
</li>
<li>
<p>Nhiều kỹ thuật tối ưu mới: Adagrad, RMSProp, Adam, &hellip;</p>
</li>
</ul>
<p><a name="ket-luan"></a></p>
<h2 id="kết-luận">Kết luận</h2>
<p>Rất nhiều bạn đọc c&oacute; y&ecirc;u cầu t&ocirc;i viết về deep learning từ l&acirc;u. Tuy nhi&ecirc;n, trước đ&oacute; t&ocirc;i tự nhận rằng m&igrave;nh chưa đủ kiến thức về lĩnh vực n&agrave;y để viết cho độc giả. Chỉ khi c&oacute; những b&agrave;i cơ bản về machine learning v&agrave; bản th&acirc;n đ&atilde; t&iacute;ch luỹ được một lượng kiến thức nhất định t&ocirc;i mới quyết định bắt đầu v&agrave;o chủ đề được nhiều bạn quan t&acirc;m n&agrave;y.</p>
<p>C&aacute;c thuật to&aacute;n machine learning cổ điển kh&aacute;c vẫn c&oacute; thể xuất hiện trong c&aacute;c b&agrave;i sau của blog.</p>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (18, 29, N'<h1 class="article-content__title">Lecture 1: Introduction to NLP and Deep Learning</h1>
<p>B&agrave;i viết đầu ti&ecirc;n gồm những nội dụng ch&iacute;nh sau:</p>
<ol>
<li>Xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n l&agrave; g&igrave;? Bản chất của ng&ocirc;n ngữ con người.</li>
<li>Deep Learning l&agrave; g&igrave;?</li>
<li>Tại sao xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n l&agrave; một nhiệm vụ kh&oacute;?</li>
<li>Ứng dụng của Deep Learning cho NLP.</li>
</ol>
<h2 id="_xu-ly-ngon-ngu-tu-nhiennlp-la-gi-0">Xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n(NLP) l&agrave; g&igrave;?</h2>
<p>Xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n l&agrave; một lĩnh vực đặc biệt, l&agrave; sự kết hợp giữa c&aacute;c ng&agrave;nh khoa học m&aacute;y t&iacute;nh, tr&iacute; tuệ nh&acirc;n tạo v&agrave; ng&ocirc;n ngữ học.</p>
<p>Mục ti&ecirc;u của việc xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n l&agrave; để cho m&aacute;y t&iacute;nh xử l&yacute; v&agrave; hiểu được ng&ocirc;n ngữ tự nhi&ecirc;n của con người, gi&uacute;p m&aacute;y t&iacute;nh c&oacute; thể thực hiện được một số nhiệm vụ hữu &iacute;ch thay cho con người như đặt lịch hẹn, mua b&aacute;n h&agrave;ng h&oacute;a, dịch từ ng&ocirc;n ngữ n&agrave;y sang ng&ocirc;n ngữ kh&aacute;c, c&aacute;c hệ tư vấn, hệ hỏi đ&aacute;p(V&iacute; dụ: Siri, Google Assistant, Facebook M, Cortana,...).</p>
<p>Để m&aacute;y t&iacute;nh c&oacute; thể hiểu được đầy đủ v&agrave; thể hiện được đ&uacute;ng &yacute; nghĩa của ng&ocirc;n ngữ l&agrave; một nhiệm vụ cực k&igrave; kh&oacute;.</p>
<p>Một v&agrave;i b&agrave;i to&aacute;n của xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n như:</p>
<ul>
<li>Spell checking: ph&aacute;t hiện v&agrave; sửa lỗi ch&iacute;nh tả</li>
<li>Finding synonyms: T&igrave;m từ c&oacute; nghĩa tương đồng</li>
<li>Extracting information: Tr&iacute;ch r&uacute;t th&ocirc;ng tin từ websites như gi&aacute; sản phẩm, ng&agrave;y th&aacute;ng, địa điểm, t&ecirc;n người v&agrave; t&ecirc;n c&ocirc;ng ty</li>
<li>Classifying: Ph&acirc;n loại quan điểm(T&iacute;ch cực/ Ti&ecirc;u cực) của một văn bản d&agrave;i, ph&acirc;n loại tin tức,...</li>
<li>Machine translation: Dịch từ ng&ocirc;n ngữ nguồn sang ng&ocirc;n ngữ đ&iacute;ch</li>
<li>Spoken dialog systems: C&aacute;c hệ thống hội thoại giữa người v&agrave; m&aacute;y(Tư vấn kh&aacute;ch h&agrave;ng tự động, điều khiển thiết bị, đặt h&agrave;ng,...)</li>
<li>Question Answering: C&aacute;c hệ hỏi đ&aacute;p</li>
<li>Speech recognition: Nhận dạng giọng n&oacute;i</li>
</ul>
<p>Trong đ&oacute;, đầu v&agrave;o thường l&agrave; hai dạng ch&iacute;nh của ng&ocirc;n ngữ gồm lời n&oacute;i(speech) v&agrave; văn bản(text). Sau khi ph&acirc;n t&iacute;ch ngữ &acirc;m(đối với dạng speech) hoặc OCR/Tokenization văn bản, ch&uacute;ng ta sẽ trải qua c&aacute;c bước xử l&yacute; ng&ocirc;n ngữ theo c&aacute;c cấp độ:</p>
<ul>
<li>Morphological analysis: ph&acirc;n t&iacute;ch h&igrave;nh th&aacute;i của ng&ocirc;n ngữ, bao gồm c&aacute;c kh&acirc;u xử l&yacute;:
<ul>
<li>Ph&acirc;n đoạn từ vựng (word segmentation): ph&acirc;n giải c&acirc;u văn được nhập v&agrave;o th&agrave;nh c&aacute;c từ c&oacute; thứ tự.</li>
<li>Ph&acirc;n loại từ (part-of-speech tagging): quyết định từ loại của từ vựng</li>
<li>Phục hồi thể nguy&ecirc;n dạng của từ (lemmatization)(đối với tiếng anh): l&agrave;m trở lại nguy&ecirc;n dạng ban đầu c&aacute;c từ vựng bị biến đổi thể ( inflection) hoặc được kết hợp (conjugatetion).</li>
</ul>
</li>
<li>Syntactic analysis: ph&acirc;n t&iacute;ch c&uacute; ph&aacute;p, t&igrave;m hiểu cấu tr&uacute;c của c&acirc;u(chủ ngữ, động từ ch&iacute;nh,...)</li>
<li>Semantic interpretaion: diễn dịch ngữ nghĩa, &yacute; nghĩa của c&acirc;u dựa v&agrave;o c&aacute;c từ tạo n&ecirc;n c&acirc;u</li>
<li>Discourse processing: ph&acirc;n t&iacute;ch ngữ nghĩa dựa tr&ecirc;n bối cảnh của c&acirc;u.</li>
</ul>
<h2 id="_nhung-dieu-dac-biet-ve-ngon-ngu-cua-con-nguoi-1">Những điều đặc biệt về ng&ocirc;n ngữ của con người.</h2>
<p>Ng&ocirc;n ngữ của con người l&agrave; một hệ thống c&aacute;c t&iacute;n hiệu/k&yacute; hiệu được x&acirc;y dựng một c&aacute;ch đặc biệt để truyền đạt được th&ocirc;ng tin c&oacute; chủ đ&iacute;ch của người viết/người n&oacute;i. C&aacute;c t&iacute;n hiệu/k&yacute; hiệu n&agrave;y được con người sử dụng để giao tiếp với nhau theo nhiều c&aacute;ch:</p>
<ul>
<li>&Acirc;m thanh</li>
<li>Cử chỉ</li>
<li>Chữ viết</li>
<li>H&igrave;nh ảnh/Tranh vẽ</li>
</ul>
<p>Mỗi người sẽ c&oacute; c&aacute;ch m&atilde; h&oacute;a c&aacute;c t&iacute;n hiệu/ k&yacute; hiệu n&agrave;y kh&aacute;c nhau(giọng n&oacute;i kh&aacute;c nhau, chữ viết kh&aacute;c nhau, n&eacute;t vẽ kh&aacute;c nhau). Tuy nhi&ecirc;n, ngữ nghĩa l&agrave; bất biến v&agrave; thống nhất kh&ocirc;ng phụ thuộc v&agrave;o đối tượng thể hiện.</p>
<h2 id="_deep-learning-la-gi-2">Deep Learning l&agrave; g&igrave;?</h2>
<p>Deep Learning l&agrave; một lĩnh vực con của học m&aacute;y(Machine learning).</p>
<p>C&aacute;c phương ph&aacute;p học m&aacute;y truyền thống(decision tree, logistic regression, naive bayes, support vector machine,...) l&agrave;m việc tốt nhờ c&oacute; sự thiết kế c&aacute;c đặc trưng, c&aacute;c thuộc t&iacute;nh đầu v&agrave;o của con người(Feature extraction). Machine learning sẽ tối ưu c&aacute;c trọng số của thuật to&aacute;n để được kết quả dự đo&aacute;n cuối c&ugrave;ng tốt nhất.</p>
<p>C&aacute;c phương ph&aacute;p học m&aacute;y cơ bản được triển khai dựa tr&ecirc;n sự m&ocirc; tả dữ liệu của bạn bằng c&aacute;c thuộc t&iacute;nh m&agrave; m&aacute;y t&iacute;nh c&oacute; thể hiểu được(Điều n&agrave;y đ&ograve;i hỏi người thiết kế phải c&oacute; sự hiểu biết nhất định trong lĩnh vực của b&agrave;i to&aacute;n đ&oacute;), sau đ&oacute; c&aacute;c thuộc t&iacute;nh được đưa qua thuật to&aacute;n học nhằm tối ưu c&aacute;c trọng số của m&ocirc; h&igrave;nh.</p>
<p>Tr&aacute;i ngược với c&aacute;c phương ph&aacute;p học m&aacute;y truyền thống, Deep learning lỗ lực học c&aacute;c biểu diễn tốt nhất, t&igrave;m ra những đặc trưng tốt nhất của dữ liệu một c&aacute;ch tự động.</p>
<p>Ở đ&acirc;y c&oacute; thể hiều, đầu v&agrave;o cho c&aacute;c thuật to&aacute;n Deep Learning c&oacute; thể l&agrave; dữ liệu th&ocirc;(V&iacute; dụ: sound, pixels, k&yacute; tự hoặc từ ngữ,...)</p>
<p>L&yacute; do để Deep Learning trở l&ecirc;n vượt trội so với c&aacute;c phương ph&aacute;p truyền thống:</p>
<ul>
<li>C&aacute;c thuộc t&iacute;nh được tr&iacute;ch chọn một c&aacute;ch thủ c&ocirc;ng thường được x&aacute;c định 1 c&aacute;ch r&otilde; r&agrave;ng, tuy nhi&ecirc;n, c&oacute; thể thiếu hoặc thừa th&ocirc;ng tin, tốn nhiều thời gian thiết kế v&agrave; x&aacute;c thực t&iacute;nh ch&iacute;nh x&aacute;c.</li>
<li>Việc học ra c&aacute;c thuộc t&iacute;nh được thực hiện dễ d&agrave;ng v&agrave; nhanh ch&oacute;ng hơn, linh hoạt hơn trong việc t&igrave;m biểu diễn cho th&ocirc;ng tin của ng&ocirc;n ngữ</li>
<li>Deep Learning c&oacute; thể học kh&ocirc;ng gi&aacute;m s&aacute;t(kh&ocirc;ng cần dữ liệu c&oacute; nh&atilde;n sẵn, từ ch&iacute;nh dữ liệu th&ocirc;) hoặc học c&oacute; gi&aacute;m s&aacute;t(Với c&aacute;c nh&atilde;n đặc biệt như positive/negative).</li>
</ul>
<p>Trong những năm gần đ&acirc;y, sự ph&aacute;t triển của hệ thống phần cứng(CPU/GPU/TPU) cũng như việc dữ liệu training được cung cấp ng&agrave;y c&agrave;ng nhiều tr&ecirc;n internet đ&atilde; khiến cho Deep learning ng&agrave;y c&agrave;ng ph&aacute;t triển mạnh mẽ. Bắt đầu với sự ph&aacute;t triển trong xử l&yacute; tiếng n&oacute;i v&agrave; h&igrave;nh ảnh, v&agrave; giờ l&agrave; xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n(NLP).</p>
<h2 id="_tai-sao-xu-ly-ngon-ngu-tu-nhien-la-mot-nhiem-vu-kho-3">Tại sao xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n l&agrave; một nhiệm vụ kh&oacute;?</h2>
<ul>
<li>
<p>Sự phức tạp trong việc biểu diễn, học v&agrave; sử dụng ng&ocirc;n ngữ</p>
</li>
<li>
<p>Th&ocirc;ng tin được truyền đạt bởi ng&ocirc;n ngữ kh&ocirc;ng chỉ phụ thuộc v&agrave; bản th&acirc;n n&oacute; m&agrave; c&ograve;n phụ thuộc v&agrave;o t&iacute;nh huống, ngữ cảnh hoặc kiến thức hiểu biết sẵn c&oacute; của con người</p>
</li>
<li>
<p>Ng&ocirc;n ngữ của con người l&agrave; kh&ocirc;ng r&otilde; r&agrave;ng (kh&ocirc;ng giống như ng&ocirc;n ngữ lập tr&igrave;nh)</p>
<p>V&iacute; dụ:</p>
<ul>
<li>"Hổ mang b&ograve; l&ecirc;n n&uacute;i."</li>
<li>"&Ocirc;ng l&atilde;o đi nhanh qu&aacute;."</li>
<li>"Nữ sinh tặng hoa Tổng thống Donald Trump thi Hoa hậu Việt Nam."</li>
</ul>
</li>
</ul>
<h2 id="_ung-dung-cua-deep-learning-cho-nlp-deep-nlp-4">Ứng dụng của Deep Learning cho NLP: Deep NLP</h2>
<p>Kết hợp c&aacute;c &yacute; tưởng v&agrave; muc ti&ecirc;u của xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n với việc sử dụng c&aacute;c biểu diễn đặc trưng của ng&ocirc;n ngữ thống qua c&aacute;c thuật to&aacute;n Deep Learning.</p>
<p>Một số cải tiến lớn trong những nằm gần đ&acirc;y trong xử l&yacute; ng&ocirc;n ngữ tự nhi&ecirc;n:</p>
<ul>
<li>Cấp độ ng&ocirc;n ngữ:&nbsp;<a href="https://ieeexplore.ieee.org/abstract/document/8384456" target="_blank" rel="noopener">Speech recognition(Viettel team)</a>, Text to Speech(Viettel, VBee), word2vec,...</li>
<li>Cấp độ xử l&yacute; core: parts-of-speech,entities,parsing,...</li>
<li>Cấp độ ứng dụng ho&agrave;n chỉnh: Sentiment Analysis, Question Answering, dialogue agents, machine translation,...</li>
</ul>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (19, 32, N'<header class="mb-05">
<h1 class="article-content__title">Tổng quan Tr&iacute; tuệ nh&acirc;n tạo. Ph&acirc;n biệt AI - Machine Learning - Deep Learning</h1>
</header>
<div class="d-md-flex align-items-top justify-content-between">
<div class="tags d-flex flex-wrap align-items-center" data-v-4365a2a0="">&nbsp;</div>
<div class="post__menu">
<div class="el-dropdown">&nbsp;</div>
</div>
</div>
<div class="article-content__body my-2 flex-fill">
<div class="md-contents">
<h2 id="_1-su-khac-nhau-giua-ai---machine-learning---deep-learning-0">1. Sự kh&aacute;c nhau giữa AI - Machine Learning - Deep Learning</h2>
<p>Ở thời đại c&ocirc;ng nghệ 4.0 hiện nay, chắc hẳn ai cũng đều đ&atilde; từng nghe qua kh&aacute;i niệm Tr&iacute; tuệ nh&acirc;n tạo hay AI, Machine Learning, Deep Learning rồi phải kh&ocirc;ng n&agrave;o. Những kh&aacute;i niệm tưởng chừng đơn giản nhưng lại kh&aacute; nhập nhằng v&agrave; dễ khiến người ta nhầm lẫn<strong>AI - Tr&iacute; tuệ nh&acirc;n tạo</strong>&nbsp;được coi l&agrave; tr&iacute; tuệ của con người được m&ocirc; phỏng v&agrave; sử dụng bởi m&aacute;y m&oacute;c.</p>
<ul>
<li>Trong khi đ&oacute;&nbsp;<strong>Machine Learning</strong>&nbsp;l&agrave; một phương ph&aacute;p để chinh phục AI, gi&uacute;p m&aacute;y c&oacute; thể m&ocirc; phỏng được tr&iacute; tuệ đ&oacute;.</li>
<li>Cuối c&ugrave;ng,&nbsp;<strong>Deep Learning</strong>&nbsp;l&agrave; một kỹ thuật để hiện thực h&oacute;a Machine Learning</li>
</ul>
<p>C&oacute; thể giải th&iacute;ch mối li&ecirc;n hệ giữa 3 kh&aacute;i niệm n&agrave;y bằng c&aacute;ch tưởng tượng ch&uacute;ng như những v&ograve;ng tr&ograve;n, trong đ&oacute; AI - &yacute; tưởng xuất hiện sớm nhất - l&agrave; v&ograve;ng tr&ograve;n lớn nhất, tiếp đến l&agrave; machine learning - kh&aacute;i niệm xuất hiện sau, v&agrave; cuối c&ugrave;ng l&agrave; deep learning - thứ đang th&uacute;c đẩy sự b&ugrave;ng ph&aacute;t của AI hiện nay - l&agrave; v&ograve;ng tr&ograve;n nhỏ nhất.</p>
<h2 id="_2-ai---tri-tue-nhan-tao-1">2. AI - Tr&iacute; tuệ nh&acirc;n tạo</h2>
<h3 id="_khai-niem-2">Kh&aacute;i niệm</h3>
<ul>
<li>AI l&agrave; sự m&ocirc; phỏng qu&aacute; tr&igrave;nh tr&iacute; tuệ của con người bằng m&aacute;y m&oacute;c, đặc biệt l&agrave; c&aacute;c hệ thống hệ m&aacute;y t&iacute;nh.</li>
<li>AI gi&uacute;p m&aacute;y m&oacute;c c&oacute; thể học hỏi kinh nghiệm, điều chỉnh c&aacute;c đầu v&agrave;o mới v&agrave; thực hiện c&aacute;c nhiệm vụ giống con người.</li>
<li>AI l&agrave; một lĩnh vực của khoa khọc m&aacute;y t&iacute;nh, nhấn mạnh việc tạo ra c&aacute;c m&aacute;y m&oacute;c th&ocirc;ng minh, hoạt động v&agrave; phản ứng như con người.</li>
<li>C&aacute;c ứng dụng cụ thể của AI bao gồm xử l&yacute; c&aacute;c ng&ocirc;n ngữ tự nhi&ecirc;n, nhận dạng giọng n&oacute;i v&agrave; thị gi&aacute;c, quản l&yacute; hệ thống, &hellip;</li>
</ul>
<h3 id="_ung-dung-3">Ứng dụng</h3>
<h4>Trong chăm s&oacute;c sức khỏe</h4>
<ul>
<li>Gi&uacute;p cải thiện kết quả của bệnh nh&acirc;n v&agrave; giảm chi ph&iacute;. C&aacute;c c&ocirc;ng ty đang &aacute;p dụng m&aacute;y học để chẩn đo&aacute;n tốt hơn v&agrave; nhanh hơn con người. Một trong những c&ocirc;ng nghệ chăm s&oacute;c sức khỏe nổi tiếng nhất l&agrave; IBM Watson. N&oacute; hiểu ng&ocirc;n ngữ tự nhi&ecirc;n v&agrave; c&oacute; thể trả lời c&aacute;c c&acirc;u hỏi. Hệ thống khai th&aacute;c dữ liệu bệnh nh&acirc;n v&agrave; c&aacute;c nguồn dữ liệu c&oacute; sẵn kh&aacute;c để tạo th&agrave;nh một giả thuyết, sau đ&oacute; n&oacute; đưa ra một lược đồ chấm điểm tin cậy.</li>
<li>C&aacute;c ứng dụng AI kh&aacute;c bao gồm chatbot, một chương tr&igrave;nh m&aacute;y t&iacute;nh được sử dụng trực tuyến để trả lời c&aacute;c c&acirc;u hỏi v&agrave; hỗ trợ kh&aacute;ch h&agrave;ng, để gi&uacute;p sắp xếp c&aacute;c cuộc hẹn theo d&otilde;i hoặc hỗ trợ bệnh nh&acirc;n th&ocirc;ng qua quy tr&igrave;nh thanh to&aacute;n v&agrave; trợ l&yacute; sức khỏe ảo cung cấp phản hồi y tế cơ bản.</li>
</ul>
<h4>Trong kinh doanh</h4>
<ul>
<li>Tự động h&oacute;a qu&aacute; tr&igrave;nh robot đang được &aacute;p dụng cho c&aacute;c nhiệm vụ lặp đi lặp lại thường được thực hiện bởi con người. C&aacute;c thuật to&aacute;n m&aacute;y học đang được t&iacute;ch hợp v&agrave;o c&aacute;c nền tảng ph&acirc;n t&iacute;ch v&agrave; kh&aacute;m ph&aacute; th&ocirc;ng tin về c&aacute;ch phục vụ kh&aacute;ch h&agrave;ng tốt hơn. Chatbots đ&atilde; được kết hợp v&agrave;o c&aacute;c trang web để cung cấp dịch vụ ngay lập tức cho kh&aacute;ch h&agrave;ng.</li>
<li>Đối với hoạt động kinh doanh, c&aacute;c qu&aacute; tr&igrave;nh tự động h&oacute;a bằng robot đang dần được &aacute;p dụng rộng r&atilde;i. N&oacute; thay thế cho c&aacute;c nhiệm vụ lặp đi lặp lại thường được thực hiện bằng con người trước đ&acirc;y.</li>
<li>C&aacute;c thuật to&aacute;n học m&aacute;y trong tr&iacute; tuệ nh&acirc;n tạo được t&iacute;ch hợp v&agrave;o c&aacute;c nền tảng ph&acirc;n t&iacute;ch v&agrave; CRM (Customer relationship management &ndash; Quản l&yacute; quan hệ kh&aacute;ch h&agrave;ng) để kh&aacute;m ph&aacute; th&ocirc;ng tin về c&aacute;ch phục vụ kh&aacute;ch h&agrave;ng tốt hơn. Chatbot đ&atilde; được kết hợp v&agrave;o c&aacute;c trang web để cung cấp dịch vụ ngay lập tức cho kh&aacute;ch h&agrave;ng. Giảm thiểu thời gian chờ v&agrave; n&acirc;ng cao mức độ h&agrave;i l&ograve;ng.</li>
</ul>
<h4>Trong t&agrave;i ch&iacute;nh &ndash; ng&acirc;n h&agrave;ng</h4>
<ul>
<li>AI trong c&aacute;c ứng dụng t&agrave;i ch&iacute;nh c&aacute; nh&acirc;n, như Intuit&rsquo;s Mint hoặc TurboTax, đang ph&aacute; vỡ c&aacute;c tổ chức t&agrave;i ch&iacute;nh. C&aacute;c ứng dụng như thu thập dữ liệu c&aacute; nh&acirc;n v&agrave; cung cấp tư vấn t&agrave;i ch&iacute;nh. C&aacute;c chương tr&igrave;nh kh&aacute;c, như IBM Watson, đ&atilde; được &aacute;p dụng cho qu&aacute; tr&igrave;nh mua nh&agrave;. Ng&agrave;y nay, phần mềm tr&iacute; tuệ nh&acirc;n tạo thực hiện phần lớn giao dịch tr&ecirc;n Phố Wall.</li>
<li>C&aacute;c ng&acirc;n h&agrave;ng đ&atilde; t&igrave;m thấy kết quả tốt trong việc sử dụng chatbot để l&agrave;m cho kh&aacute;ch h&agrave;ng của họ biết về c&aacute;c dịch vụ v&agrave; dịch vụ bổ sung. Họ cũng đang sử dụng AI để cải thiện việc ra quyết định cho vay, đặt giới hạn t&iacute;n dụng v&agrave; x&aacute;c định cơ hội đầu tư.</li>
<li>Chatbot l&agrave; ứng dụng đầu ti&ecirc;n cho thấy sức ảnh hưởng của tr&iacute; tuệ nh&acirc;n tạo trong lĩnh vực ng&acirc;n h&agrave;ng. Với ứng dụng n&agrave;y, kh&aacute;ch h&agrave;ng sẽ kh&ocirc;ng cần phải đến ng&acirc;n h&agrave;ng để truy vấn th&ocirc;ng tin. Họ ho&agrave;n to&agrave;n c&oacute; thể th&ocirc;ng qua Chatbot để t&igrave;m hiểu c&aacute;c dịch vụ v&agrave; c&aacute;c dịch vụ bổ sung kh&aacute;c ngay tại nh&agrave; hay bất cứ nơi n&agrave;o m&agrave; họ muốn.</li>
<li>Ngo&agrave;i ra, tr&iacute; tuệ nh&acirc;n tại c&ograve;n được &aacute;p dụng để đưa ra c&aacute;c quyết định cho vay, đặt giới hạn t&iacute;n dụng v&agrave; x&aacute;c định cơ hội đầu tư. Bằng c&aacute;ch t&iacute;ch hợp th&ecirc;m c&aacute;c c&ocirc;ng nghệ như nhận dạng giọng n&oacute;i (voice recognition) v&agrave; nhận dạng khu&ocirc;n mặt (face recognition) v&agrave;o ứng dụng điện thoại. Từ đ&acirc;y c&aacute;c ng&acirc;n h&agrave;ng c&oacute; thể cung cấp c&aacute;c trải nghiệm c&aacute; nh&acirc;n h&oacute;a tốt hơn cho kh&aacute;ch h&agrave;ng của m&igrave;nh.</li>
<li>V&igrave; vậy, ngo&agrave;i việc ứng dụng hệ thống AI r&agrave; so&aacute;t thị trường để th&ocirc;ng b&aacute;o cho c&aacute;c hệ thống giao dịch. C&aacute;c ng&acirc;n h&agrave;ng c&ograve;n th&ocirc;ng qua c&aacute;c ứng dụng th&ocirc;ng minh n&agrave;y để thể thu thập h&agrave;nh vi của kh&aacute;ch h&agrave;ng v&agrave; từ đ&oacute; đưa ra c&aacute;c lời khuy&ecirc;n về t&agrave;i ch&iacute;nh. Gi&uacute;p kh&aacute;ch h&agrave;ng quản l&yacute; d&ograve;ng tiền của m&igrave;nh một c&aacute;ch tốt hơn.</li>
</ul>
<h4>Trong gi&aacute;o dục</h4>
<ul>
<li>Đối với ng&agrave;nh gi&aacute;o dục, tr&iacute; tuệ nh&acirc;n tạo cũng ng&agrave;y c&agrave;ng thể hiện r&otilde; tầm quan trọng cũng như những lợi &iacute;ch vượt trội của m&igrave;nh. AI c&oacute; thể tự động h&oacute;a việc chấm điểm nhanh ch&oacute;ng v&agrave; ch&iacute;nh x&aacute;c. Gi&uacute;p tiết kiệm một khoảng thời gian lớn m&agrave; c&aacute;c nh&agrave; gi&aacute;o dục phải bỏ ra cho hoạt động n&agrave;y. Gia sư AI c&oacute; thể cung cấp hỗ trợ bổ sung cho sinh vi&ecirc;n, đảm bảo họ lu&ocirc;n đi đ&uacute;ng hướng. V&agrave; n&oacute; c&oacute; thể thay đổi nơi học sinh học v&agrave; thậm ch&iacute; thay thế một số gi&aacute;o vi&ecirc;n.</li>
<li>Ngo&agrave;i ra, n&oacute; c&ograve;n c&oacute; thể đ&aacute;nh gi&aacute; tr&igrave;nh độ của người học. Qua đ&oacute; tự điều chỉnh cấp độ ph&ugrave; hợp, cung cấp hỗ trợ bổ sung, đảm bảo người học theo kịp tốc độ v&agrave; lu&ocirc;n đi đ&uacute;ng hướng.</li>
</ul>
<h4>Trong ph&aacute;p luật</h4>
<ul>
<li>T&iacute;nh cho tới thời điểm hiện tại, AI được &aacute;p dụng phổ biến trong qu&aacute; tr&igrave;nh nghi&ecirc;n cứu ph&aacute;p luật, t&igrave;m kiếm v&agrave; s&agrave;ng lọc th&ocirc;ng tin qua c&aacute;c t&agrave;i liệu. Từ đ&oacute;, dự đo&aacute;n vi phạm ph&aacute;p luật v&agrave; hỗ trợ cho c&aacute;c luật sư c&ugrave;ng thẩm ph&aacute;n trong việc xử l&yacute; th&ocirc;ng tin một c&aacute;ch nhanh ch&oacute;ng. C&aacute;c c&ocirc;ng ty khởi nghiệp cũng đang x&acirc;y dựng c&aacute;c trợ l&yacute; m&aacute;y t&iacute;nh hỏi v&agrave; trả lời c&oacute; thể s&agrave;ng lọc c&aacute;c c&acirc;u hỏi được lập tr&igrave;nh để trả lời bằng c&aacute;ch kiểm tra ph&acirc;n loại v&agrave; bản thể học li&ecirc;n quan đến cơ sở dữ liệu.</li>
<li>Nhiều nh&agrave; khoa học tin rằng, trong một tương lai kh&ocirc;ng xa, tr&iacute; tuệ nh&acirc;n tạo c&oacute; thể được sử dụng để x&eacute;t xử trực tuyến c&aacute;c tranh chấp, thậm ch&iacute; l&agrave; cả những vụ &aacute;n h&igrave;nh sự.</li>
</ul>
<h4>Trong sản xuất</h4>
<p>C&oacute; thể n&oacute;i, sản xuất l&agrave; lĩnh vực đi đầu trong việc kết hợp robot v&agrave;o quy tr&igrave;nh l&agrave;m việc. C&aacute;c robot c&ocirc;ng nghiệp được tạo ra v&agrave; sử dụng để thực hiện c&aacute;c nhiệm vụ chuy&ecirc;n biệt m&agrave; trước đ&acirc;y do con người thực hiện. N&oacute; gi&uacute;p thực hiện c&aacute;c kỹ năng đ&ograve;i hỏi sự ch&iacute;nh x&aacute;c tuyệt đối, cải thiện hiệu quả l&agrave;m việc, hay việc quản l&yacute; h&agrave;ng tồn kho, tự gi&aacute;m s&aacute;t v&agrave; kiểm tra lẫn nhau.</p>
<h2 id="_3-machine-learning-4">3. Machine Learning</h2>
<h2>Kh&aacute;i niệm</h2>
<ul>
<li>L&agrave; một lĩnh vực con của AI sử dụng c&aacute;c thuật to&aacute;n cho ph&eacute;p m&aacute;y t&iacute;nh c&oacute; thể học từ dữ liệu để thực hiện c&aacute;c c&ocirc;ng việc thay v&igrave; được lập tr&igrave;nh một c&aacute;ch r&otilde; r&agrave;ng.</li>
<li>N&oacute; c&oacute; khả năng tự học hỏi dựa tr&ecirc;n dữ liệu đưa v&agrave;o m&agrave; kh&ocirc;ng cần phải được lập tr&igrave;nh cụ thể.</li>
</ul>
<h3 id="_cach-su-dung-6">C&aacute;ch sử dụng</h3>
<p>Một cỗ m&aacute;y thực hiện chơi cờ(nhiệm vụ T), c&oacute; thể học từ dữ liệu c&aacute;c v&aacute;n cờ trước đ&oacute; hoặc chơi với một chuy&ecirc;n gia(kinh nghiệm E). Khả năng chơi của cỗ m&aacute;y l&agrave; tỉ lệ số v&aacute;n m&agrave; n&oacute; chiến thắng khi chơi với con người(hiệu suất P).Mức độ bảo mật th&ocirc;ng tin cao, an to&agrave;n th&ocirc;ng tin cho kh&aacute;ch h&agrave;ng</p>
<p>V&iacute; dụ:</p>
<ul>
<li>
<p><strong>VD1:</strong>&nbsp;Một hệ thống nhận v&agrave;o một h&igrave;nh ảnh, n&oacute; phải x&aacute;c định xem trong đ&oacute; c&oacute; khu&ocirc;n mặt của Ngọc Trinh hay kh&ocirc;ng. Điều n&agrave;y thấy r&otilde; nhất ở chức năng tự động gắn thẻ khu&ocirc;n mặt của Facebook.</p>
</li>
<li>
<p><strong>VD2:</strong>&nbsp;Hệ thống nhận v&agrave;o c&aacute;c reviews về một sản phẩm đồ ăn. cần x&aacute;c định c&aacute;c reviews đ&oacute; c&oacute; nội dung t&iacute;ch cực hay ti&ecirc;u cực.</p>
</li>
<li>
<p><strong>VD3:</strong>&nbsp;Một hệ thống nhận v&agrave;o h&igrave;nh ảnh/ th&ocirc;ng tin của một người. Đ&aacute;nh gi&aacute; số điểm đo khả năng người đ&oacute; sẽ trả một khoản vay t&iacute;n dụng.</p>
</li>
<li>
<p><strong>Trong VD1</strong>, nhiệm vụ ph&aacute;t hiện khu&ocirc;n mặt của người mẫu Ngọc Trinh trong một bức ảnh. Kinh nghiệm c&oacute; thể l&agrave; một tập hợp c&aacute;c ảnh c&oacute; khu&ocirc;n mặc Ngọc Trinh v&agrave; một tập ảnh kh&aacute;c kh&ocirc;ng c&oacute;. Hiệu suất sẽ được t&iacute;nh bằng tỉ lệ đo&aacute;n ch&iacute;nh x&aacute;c tr&ecirc;n một tập ảnh mới.</p>
</li>
<li>
<p><strong>Trong VD2</strong>, nhiệm vụ của b&agrave;i to&aacute;n l&agrave; l&agrave; g&aacute;n nh&atilde;n cho mỗi review. Kinh nghiệm ở đ&acirc;y c&oacute; thể l&agrave; tập hợp c&aacute;c review v&agrave; nh&atilde;n tương ứng của n&oacute;. Hiệu suất được đo bằng tỉ lệ dự đo&aacute;n nh&atilde;n ch&iacute;nh x&aacute;c tr&ecirc;n c&aacute;c review mới.</p>
</li>
<li>
<p><strong>Trong VD3,</strong>&nbsp;b&agrave;i to&aacute;n cần giải quyết l&agrave; đ&aacute;nh gi&aacute; điểm tin cậy của người d&ugrave;ng để thực hiện cho vay t&iacute;n dụng. Kinh nghiệm c&oacute; thể học được từ c&aacute;c tập h&igrave;nh ảnh/ th&ocirc;ng tin của những người vay t&iacute;n dụng trước đi k&egrave;m th&ocirc;ng tin họ c&oacute; chi trả khoản vay t&iacute;n dụng đ&oacute; kh&ocirc;ng. Hiệu suất của m&ocirc; h&igrave;nh sẽ được đo bằng tỉ lệ dự đo&aacute;n đ&uacute;ng tr&ecirc;n tập kh&aacute;ch h&agrave;ng mới.</p>
</li>
</ul>
<p>L&agrave;m sao thuật to&aacute;n c&oacute; thể thể đưa ra đầu ra mong muốn từ tập dữ liệu đầu v&agrave;o? Bạn cần một qu&aacute; tr&igrave;nh huấn luyện sử dụng c&aacute;c dữ liệu huấn luyện. N&oacute; ch&iacute;nh l&agrave; kinh nghiệm E ở định nghĩa tr&ecirc;n.</p>
<h3 id="_huan-luyen-mo-hinh-7">Huấn luyện m&ocirc; h&igrave;nh</h3>
<p>C&aacute;c v&iacute; dụ trong tập huấn luyện thường c&oacute; một tập thuộc t&iacute;nh/ đặc trưng cố định. Đ&oacute; l&agrave; những thể hiện để m&ocirc; tả về đối tượng đ&oacute;. Như trong VD1, đặc trưng c&oacute; thể l&agrave; tần suất c&aacute;c m&agrave;u của mỗi bức ảnh. Trong VD2, c&aacute;c đặc trưng một review sẽ l&agrave; c&aacute;c từ tạo n&ecirc;n review đ&oacute;. C&ograve;n VD3, c&aacute;c đặc trưng c&oacute; thể l&agrave; tuổi t&aacute;c, c&ocirc;ng việc, mức lương của mỗi người,&hellip;</p>
<p>Lựa chọn c&aacute;c đặc trưng th&iacute;ch hợp l&agrave; một nhiệm vụ quan trọng trong Machine learning. Ch&uacute;ng ta sẽ tiếp tục l&agrave;m r&otilde; điều n&agrave;y ở phần ph&iacute;a sau mục n&agrave;y.</p>
<ul>
<li>Đầu ti&ecirc;n, bạn cung cấp cho AI một tập hợp c&aacute;c đặc điểm của lo&agrave;i m&egrave;o để m&aacute;y nhận dạng, v&iacute; dụ như m&agrave;u sắc l&ocirc;ng, h&igrave;nh d&aacute;ng cơ thể, k&iacute;ch thước&hellip;</li>
<li>Tiếp theo, bạn cung cấp một số h&igrave;nh ảnh cho AI, trong đ&oacute; một số hoặc tất cả c&aacute;c h&igrave;nh ảnh c&oacute; thể được d&aacute;n nh&atilde;n "m&egrave;o" để m&aacute;y c&oacute; thể chọn hiệu quả hơn c&aacute;c chi tiết, đặc điểm c&oacute; li&ecirc;n quan đến m&egrave;o.</li>
<li>Sau khi m&aacute;y đ&atilde; nhận được đủ dữ liệu cần thiết về m&egrave;o, n&oacute; phải biết c&aacute;ch t&igrave;m một con m&egrave;o trong một bức tranh - &ldquo;Nếu trong h&igrave;nh ảnh c&oacute; chứa c&aacute;c chi tiết X, Y, hoặc Z n&agrave;o đ&oacute;, th&igrave; 95% khả năng đ&oacute; l&agrave; một con m&egrave;o&rdquo;.</li>
</ul>
<h2 id="_4-deep-learning-8">4. Deep Learning</h2>
<h3 id="_khai-niem-9">Kh&aacute;i niệm</h3>
<ul>
<li>L&agrave; một phương ph&aacute;p của Machine learning</li>
<li>Cho ph&eacute;p ch&uacute;ng ta huấn luyện một AI c&oacute; thể dự đo&aacute;n được c&aacute;c đầu ra dựa v&agrave;o một tập c&aacute;c đầu v&agrave;o.</li>
<li>Gi&uacute;p m&aacute;y t&iacute;nh giải quyết một loạt c&aacute;c vấn đề phức tạp kh&ocirc;ng thể giải quyết được.</li>
<li>N&oacute; như l&agrave; một &ldquo;mạng thần kinh &ndash; neural networks&rdquo; c&oacute; thể xử l&yacute; dữ liệu tương tự như một bộ n&atilde;o con người c&oacute; thể thực hiện m&agrave; trong đ&oacute; m&aacute;y tự đ&agrave;o tạo ch&iacute;nh n&oacute;.</li>
<li>Đ&ograve;i hỏi rất nhiều dữ liệu đầu v&agrave;o v&agrave; sức mạnh t&iacute;nh to&aacute;n.</li>
</ul>
<h3 id="_tai-sao-can-deep-learning-10">Tại sao cần Deep learning?</h3>
<ul>
<li>Một v&iacute; dụ về một nhiệm vụ Machine Learning đơn giản, n&ocirc;ng cạn c&oacute; thể dự đo&aacute;n doanh số b&aacute;n kem sẽ thay đổi như thế n&agrave;o dựa tr&ecirc;n nhiệt độ ngo&agrave;i trời. Việc đưa ra dự đo&aacute;n chỉ sử dụng một v&agrave;i t&iacute;nh năng dữ liệu theo c&aacute;ch n&agrave;y l&agrave; tương đối đơn giản v&agrave; c&oacute; thể được thực hiện bằng c&aacute;ch sử dụng một kỹ thuật Machine Learning gọi l&agrave; hồi quy tuyến t&iacute;nh với độ dốc giảm dần.</li>
<li>Vấn đề l&agrave; h&agrave;ng loạt vấn đề trong thế giới thực kh&ocirc;ng ph&ugrave; hợp với những m&ocirc; h&igrave;nh đơn giản như vậy. Một v&iacute; dụ về một trong những vấn đề thực tế phức tạp n&agrave;y l&agrave; nhận ra c&aacute;c số viết tay.</li>
<li>Để giải quyết vấn đề n&agrave;y, m&aacute;y t&iacute;nh cần phải c&oacute; khả năng đối ph&oacute; với sự đa dạng lớn trong c&aacute;ch thức tr&igrave;nh b&agrave;y dữ liệu. Mỗi chữ số từ 0 đến 9 c&oacute; thể được viết theo v&ocirc; số c&aacute;ch: k&iacute;ch thước v&agrave; h&igrave;nh dạng ch&iacute;nh x&aacute;c của mỗi chữ số viết tay c&oacute; thể rất kh&aacute;c nhau t&ugrave;y thuộc v&agrave;o người viết v&agrave; trong ho&agrave;n cảnh n&agrave;o.</li>
<li>Đối ph&oacute; với sự biến đổi của c&aacute;c t&iacute;nh năng n&agrave;y v&agrave; sự lộn xộn tương t&aacute;c lớn hơn giữa ch&uacute;ng, l&agrave; nơi học tập s&acirc;u v&agrave; mạng lưới thần kinh s&acirc;u (neural networks) trở n&ecirc;n hữu &iacute;ch.</li>
<li>Như đ&atilde; đề cập, độ s&acirc;u đề cập đến số lượng c&aacute;c lớp ẩn, thường l&agrave; hơn ba, được sử dụng trong c&aacute;c mạng lưới thần kinh s&acirc;u.</li>
</ul>
<p>Quay lại v&iacute; dụ con m&egrave;o, Điểm kh&aacute;c biệt ch&iacute;nh ở đ&acirc;y l&agrave; con người kh&ocirc;ng sẽ phải dạy một chương tr&igrave;nh deep learning biết một con m&egrave;o tr&ocirc;ng như thế n&agrave;o, m&agrave; chỉ cần cung cấp cho n&oacute; đủ h&igrave;nh ảnh cần thiết về lo&agrave;i m&egrave;o, v&agrave; n&oacute; sẽ tự m&igrave;nh h&igrave;nh dung, tự học. C&aacute;c bước cần l&agrave;m như sau:</p>
<ul>
<li>Cung cấp cho m&aacute;y rất nhiều ảnh về m&egrave;o.</li>
<li>Thuật to&aacute;n sẽ kiểm tra ảnh để xem c&aacute;c đặc điểm, chi tiết chung giữa c&aacute;c bức ảnh.</li>
<li>Mỗi bức ảnh sẽ được giải m&atilde; chi tiết dưới nhiều cấp độ, từ c&aacute;c h&igrave;nh dạng lớn, chung đến c&aacute;c &ocirc; nhỏ v&agrave; nhỏ hơn nữa. Nếu một h&igrave;nh dạng hoặc c&aacute;c đường được lặp lại nhiều lần, thuật to&aacute;n sẽ gắn nh&atilde;n n&oacute; như l&agrave; một đặc t&iacute;nh quan trọng.</li>
<li>Sau khi ph&acirc;n t&iacute;ch đủ h&igrave;nh ảnh cần thiết, thuật to&aacute;n giờ đ&acirc;y sẽ biết được c&aacute;c mẫu n&agrave;o cung cấp bằng chứng r&otilde; r&agrave;ng nhất về m&egrave;o v&agrave; tất cả những g&igrave; con người phải l&agrave;m chỉ l&agrave; cung cấp c&aacute;c dữ liệu th&ocirc;.</li>
</ul>
<h3 id="_neural-networks-11">Neural Networks</h3>
<ul>
<li>Lấy cảm hứng từ sự hiểu biết về sinh học của bộ n&atilde;o lo&agrave;i người &ndash; sự li&ecirc;n kết giữa c&aacute;c nơ-ron. L&agrave; c&aacute;c m&ocirc; h&igrave;nh to&aacute;n học c&oacute; cấu tr&uacute;c được lấy cảm hứng lỏng lẻo từ bộ n&atilde;o.</li>
<li>Mỗi nơ-ron trong mạng nơ-ron l&agrave; một h&agrave;m to&aacute;n học lấy dữ liệu th&ocirc;ng qua đầu v&agrave;o, biến đổi dữ liệu đ&oacute; th&agrave;nh dạng dễ điều chỉnh hơn v&agrave; sau đ&oacute; phun ra th&ocirc;ng qua đầu ra.</li>
<li>C&aacute;c mạng thần kinh nh&acirc;n tạo n&agrave;y c&oacute; c&aacute;c lớp rời rạc, c&aacute;c kết nối, v&agrave; c&aacute;c hướng truyền dữ liệu.</li>
</ul>
<p><strong>V&iacute; dụ minh họa</strong>&nbsp;Ch&uacute;ng ta muốn dự đo&aacute;n gi&aacute; v&eacute; dựa v&agrave;o c&aacute;c đầu v&agrave;o như sau:</p>
<ul>
<li>S&acirc;n bay khởi h&agrave;nh</li>
<li>S&acirc;n bay đến</li>
<li>Ng&agrave;y bay</li>
<li>H&atilde;ng h&agrave;ng kh&ocirc;ng</li>
</ul>
<p>=&gt;</p>
<ul>
<li>Input layer nhận c&aacute;c dữ liệu đầu v&agrave;o. Trong trường hợp của ch&uacute;ng ta, ta c&oacute; 4 nơ r on trong input layer: s&acirc;n bay khởi h&agrave;nh, s&acirc;n bay đến, ng&agrave;y bay, h&atilde;ng bay. Input layer sẽ đưa c&aacute;c đầu v&agrave;o n&agrave;y v&agrave;o hidden layer thứ nhất.</li>
<li>C&aacute;c hidden layer thực hiện c&aacute;c ph&eacute;p t&iacute;nh to&aacute;n cho c&aacute;c đầu v&agrave;o. Thử th&aacute;ch lớn nhất trong việc tạo mạng nơ ron l&agrave; quyết định số lượng c&aacute;c hidden layer n&agrave;y, cũng như số c&aacute;c nơ ron cho mỗi layer.</li>
<li>Output layer trả về dữ liệu đầu ra, trường hợp của ta sẽ l&agrave; đưa ra dự đo&aacute;n về gi&aacute; v&eacute;.</li>
<li>Mối li&ecirc;n kết giữa nơ ron được kết hợp với một trọng số, n&oacute; chỉ ra được tầm quan trọng của gi&aacute; trị đầu v&agrave;o.</li>
<li>Khi dự đo&aacute;n gi&aacute; v&eacute;, ng&agrave;y khởi h&agrave;nh l&agrave; nguy&ecirc;n tố quan trọng nhất. V&igrave; vậy, mạng nơ ron li&ecirc;n kết của ng&agrave;y khởi h&agrave;nh sẽ c&oacute; một trọng số lớn.</li>
<li>Mỗi nơ-ron trong mạng nơ-ron l&agrave; một h&agrave;m to&aacute;n học lấy dữ liệu th&ocirc;ng qua đầu v&agrave;o, biến đổi dữ liệu đ&oacute; th&agrave;nh dạng dễ điều chỉnh hơn v&agrave; sau đ&oacute; phun ra th&ocirc;ng qua đầu ra</li>
</ul>
<h3 id="_ung-dung-cua-deep-learning-12">Ứng dụng của Deep Learning</h3>
<ul>
<li>Nhờ Deep Learning, AI đ&atilde; c&oacute; một tương lai tươi s&aacute;ng hơn</li>
<li>Deep Learning đ&atilde; cho ph&eacute;p ứng dụng nhiếu vấn đề thực tế của m&aacute;y học v&agrave; bằng c&aacute;ch mở rộng lĩnh vực tổng thể của AI. Deep learning ph&aacute; vỡ c&aacute;c c&aacute;ch thức con người l&agrave;m việc bằng c&aacute;ch l&agrave;m cho tất cả c&aacute;c loại m&aacute;y m&oacute;c trợ gi&uacute;p c&oacute; thể thực hiện được, gần hoặc giống hệt con người.</li>
<li>&Ocirc; t&ocirc; kh&ocirc;ng người l&agrave;i, chăm s&oacute;c sức khoẻ tốt hơn, thậm ch&iacute; cả đề xuất về bộ phim tốt hơn, tất cả đều hiện thực trong thời đại ng&agrave;y nay. AI l&agrave; hiện tại v&agrave; tương lai. Với sự trợ gi&uacute;p của Deep Learning, AI c&oacute; thể hiện thức h&oacute;a ước mơ khoa học giả tưởng m&agrave; ch&uacute;ng ta đ&atilde; tưởng tượng từ rất l&acirc;u. Bạn c&oacute; một C-3PO, t&ocirc;i sẽ lấy n&oacute;. Bạn c&oacute; thể giữ Terminator của bạn.</li>
</ul>
</div>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (20, 33, N'<h1 id="firstHeading" class="firstHeading mw-first-heading"><span class="mw-page-title-main">Tr&iacute; tuệ nh&acirc;n tạo</span></h1>
<p>Trong&nbsp;<a title="Khoa học m&aacute;y t&iacute;nh" href="https://vi.wikipedia.org/wiki/Khoa_h%E1%BB%8Dc_m%C3%A1y_t%C3%ADnh">khoa học m&aacute;y t&iacute;nh</a>,&nbsp;<strong>tr&iacute; tuệ nh&acirc;n tạo</strong>&nbsp;hay&nbsp;<strong>AI</strong>&nbsp;(<a title="Tiếng Anh" href="https://vi.wikipedia.org/wiki/Ti%E1%BA%BFng_Anh">tiếng Anh</a>:&nbsp;<em><span lang="en">artificial intelligence</span></em>), đ&ocirc;i khi được gọi l&agrave;&nbsp;<strong>tr&iacute; th&ocirc;ng minh nh&acirc;n tạo</strong>, l&agrave;&nbsp;<a title="Tr&iacute; th&ocirc;ng minh" href="https://vi.wikipedia.org/wiki/Tr%C3%AD_th%C3%B4ng_minh">tr&iacute; th&ocirc;ng minh</a>&nbsp;được thể hiện bằng&nbsp;<a title="M&aacute;y m&oacute;c" href="https://vi.wikipedia.org/wiki/M%C3%A1y_m%C3%B3c">m&aacute;y m&oacute;c</a>, tr&aacute;i ngược với&nbsp;<strong>tr&iacute; th&ocirc;ng minh tự nhi&ecirc;n</strong>&nbsp;của con người. Th&ocirc;ng thường, thuật ngữ "tr&iacute; tuệ nh&acirc;n tạo" thường được sử dụng để m&ocirc; tả c&aacute;c m&aacute;y chủ m&oacute;c (hoặc m&aacute;y t&iacute;nh) c&oacute; khả năng bắt chước c&aacute;c chức năng "nhận thức" m&agrave; con người thường phải li&ecirc;n kết với&nbsp;<a title="T&acirc;m tr&iacute;" href="https://vi.wikipedia.org/wiki/T%C3%A2m_tr%C3%AD">t&acirc;m tr&iacute;</a>, như "học tập" v&agrave; "giải quyết vấn đề".<sup id="cite_ref-FOOTNOTERussellNorvig2009_1-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-FOOTNOTERussellNorvig2009-1">[1]</a></sup><sup id="cite_ref-2" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-2">[2]</a></sup><sup id="cite_ref-3" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-3">[3]</a></sup></p>
<p>Khi m&aacute;y m&oacute;c ng&agrave;y c&agrave;ng tăng khả năng, c&aacute;c nhiệm vụ được coi l&agrave; cần "tr&iacute; th&ocirc;ng minh" thường bị loại bỏ khỏi định nghĩa về AI, một hiện tượng được gọi l&agrave;&nbsp;<a class="new" title="Hiệu ứng AI (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Hi%E1%BB%87u_%E1%BB%A9ng_AI&amp;action=edit&amp;redlink=1">hiệu ứng AI</a>.<sup id="cite_ref-4" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-4">[4]</a></sup>&nbsp;Một c&acirc;u ch&acirc;m ng&ocirc;n trong Định l&yacute; của Tesler n&oacute;i rằng "AI l&agrave; bất cứ điều g&igrave; chưa được thực hiện."<sup id="cite_ref-5" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-5">[5]</a></sup>&nbsp;V&iacute; dụ,&nbsp;<a title="Nhận dạng k&yacute; tự quang học" href="https://vi.wikipedia.org/wiki/Nh%E1%BA%ADn_d%E1%BA%A1ng_k%C3%BD_t%E1%BB%B1_quang_h%E1%BB%8Dc">nhận dạng k&yacute; tự quang học</a>&nbsp;thường bị loại trừ khỏi những thứ được coi l&agrave; AI, đ&atilde; trở th&agrave;nh một c&ocirc;ng nghệ th&ocirc;ng thường.<sup id="cite_ref-6" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-6">[6]</a></sup>&nbsp;khả năng m&aacute;y hiện đại thường được ph&acirc;n loại như AI bao gồm th&agrave;nh c&ocirc;ng hiểu lời n&oacute;i của con người,<sup id="cite_ref-FOOTNOTERussellNorvig2009_1-1" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-FOOTNOTERussellNorvig2009-1">[1]</a></sup>&nbsp;cạnh tranh ở mức cao nhất trong&nbsp;<a title="Tr&ograve; chơi chiến lược" href="https://vi.wikipedia.org/wiki/Tr%C3%B2_ch%C6%A1i_chi%E1%BA%BFn_l%C6%B0%E1%BB%A3c">tr&ograve; chơi chiến lược</a>&nbsp;(chẳng hạn như&nbsp;<a title="Cờ vua" href="https://vi.wikipedia.org/wiki/C%E1%BB%9D_vua">cờ vua</a>&nbsp;v&agrave;&nbsp;<a title="Cờ v&acirc;y" href="https://vi.wikipedia.org/wiki/C%E1%BB%9D_v%C3%A2y">Go</a>),<sup id="cite_ref-bbc-alphago_7-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-bbc-alphago-7">[7]</a></sup>&nbsp;xe hoạt động độc lập, định tuyến th&ocirc;ng minh trong mạng ph&acirc;n phối nội dung, v&agrave; m&ocirc; phỏng qu&acirc;n sự.</p>
<p>Tr&iacute; tuệ nh&acirc;n tạo c&oacute; thể được ph&acirc;n th&agrave;nh ba loại hệ thống kh&aacute;c nhau: tr&iacute; tuệ nh&acirc;n tạo ph&acirc;n t&iacute;ch, lấy cảm hứng từ con người v&agrave; nh&acirc;n tạo.<sup id="cite_ref-8" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-8">[8]</a></sup>&nbsp;AI ph&acirc;n t&iacute;ch chỉ c&oacute; c&aacute;c đặc điểm ph&ugrave; hợp với&nbsp;<a title="Nhận thức" href="https://vi.wikipedia.org/wiki/Nh%E1%BA%ADn_th%E1%BB%A9c">tr&iacute; tuệ nhận thức</a>; tạo ra một đại diện nhận thức về thế giới v&agrave; sử dụng học tập dựa tr&ecirc;n kinh nghiệm trong qu&aacute; khứ để th&ocirc;ng b&aacute;o c&aacute;c quyết định trong tương lai. AI lấy cảm hứng từ con người c&oacute; c&aacute;c yếu tố từ&nbsp;<a title="Tr&iacute; tuệ x&uacute;c cảm" href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_x%C3%BAc_c%E1%BA%A3m">tr&iacute; tuệ</a>&nbsp;nhận thức v&agrave;&nbsp;<a title="Tr&iacute; tuệ x&uacute;c cảm" href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_x%C3%BAc_c%E1%BA%A3m">cảm x&uacute;c</a>; hiểu cảm x&uacute;c của con người, ngo&agrave;i c&aacute;c yếu tố nhận thức v&agrave; xem x&eacute;t ch&uacute;ng trong việc&nbsp;<a class="new" title="Ra quyết định (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Ra_quy%E1%BA%BFt_%C4%91%E1%BB%8Bnh&amp;action=edit&amp;redlink=1">ra quyết định</a>. AI nh&acirc;n c&aacute;ch h&oacute;a cho thấy c&aacute;c đặc điểm của tất cả c&aacute;c loại năng lực (nghĩa l&agrave; tr&iacute; tuệ nhận thức, cảm x&uacute;c v&agrave; x&atilde; hội), c&oacute; khả năng tự &yacute; thức v&agrave; tự nhận thức được trong c&aacute;c tương t&aacute;c.</p>
<p>Tr&iacute; tuệ nh&acirc;n tạo được th&agrave;nh lập như một m&ocirc;n học thuật v&agrave;o năm 1956, v&agrave; trong những năm sau đ&oacute; đ&atilde; trải qua nhiều l&agrave;n s&oacute;ng lạc quan,<sup id="cite_ref-Optimism_of_early_AI_9-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Optimism_of_early_AI-9">[9]</a></sup><sup id="cite_ref-AI_in_the_80s_10-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-AI_in_the_80s-10">[10]</a></sup>&nbsp;sau đ&oacute; l&agrave; sự thất vọng v&agrave; mất kinh ph&iacute; (được gọi l&agrave; " m&ugrave;a đ&ocirc;ng AI "),<sup id="cite_ref-First_AI_winter_11-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-First_AI_winter-11">[11]</a></sup><sup id="cite_ref-Second_AI_winter_12-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Second_AI_winter-12">[12]</a></sup>&nbsp;tiếp theo l&agrave; c&aacute;ch tiếp cận mới, th&agrave;nh c&ocirc;ng v&agrave; t&agrave;i trợ mới.<sup id="cite_ref-AI_in_the_80s_10-1" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-AI_in_the_80s-10">[10]</a></sup><sup id="cite_ref-AI_in_2000s_13-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-AI_in_2000s-13">[13]</a></sup>&nbsp;Trong phần lớn lịch sử của m&igrave;nh, nghi&ecirc;n cứu AI đ&atilde; được chia th&agrave;nh c&aacute;c trường con thường kh&ocirc;ng li&ecirc;n lạc được với nhau.<sup id="cite_ref-Fragmentation_of_AI_14-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Fragmentation_of_AI-14">[14]</a></sup>&nbsp;C&aacute;c trường con n&agrave;y dựa tr&ecirc;n c&aacute;c c&acirc;n nhắc kỹ thuật, chẳng hạn như c&aacute;c mục ti&ecirc;u cụ thể (v&iacute; dụ: "&nbsp;<a title="Robot học" href="https://vi.wikipedia.org/wiki/Robot_h%E1%BB%8Dc">robot học</a>&nbsp;" hoặc "học m&aacute;y"),<sup id="cite_ref-Problems_of_AI_15-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Problems_of_AI-15">[15]</a></sup>&nbsp;việc sử dụng c&aacute;c c&ocirc;ng cụ cụ thể ("logic" hoặc&nbsp;<a class="mw-redirect" title="Mạng nơ-ron nh&acirc;n tạo" href="https://vi.wikipedia.org/wiki/M%E1%BA%A1ng_n%C6%A1-ron_nh%C3%A2n_t%E1%BA%A1o">mạng lưới thần kinh nh&acirc;n tạo</a>) hoặc sự kh&aacute;c biệt triết học s&acirc;u sắc.<sup id="cite_ref-Biological_intelligence_vs._intelligence_in_general_16-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Biological_intelligence_vs._intelligence_in_general-16">[16]</a></sup><sup id="cite_ref-Neats_vs._scruffies_17-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Neats_vs._scruffies-17">[17]</a></sup><sup id="cite_ref-Symbolic_vs._sub-symbolic_18-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Symbolic_vs._sub-symbolic-18">[18]</a></sup>&nbsp;C&aacute;c ng&agrave;nh con cũng được dựa tr&ecirc;n c&aacute;c yếu tố x&atilde; hội (c&aacute;c tổ chức cụ thể hoặc c&ocirc;ng việc của c&aacute;c nh&agrave; nghi&ecirc;n cứu cụ thể).<sup id="cite_ref-Fragmentation_of_AI_14-1" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Fragmentation_of_AI-14">[14]</a></sup></p>
<p>Lĩnh vực n&agrave;y được th&agrave;nh lập dựa tr&ecirc;n tuy&ecirc;n bố rằng&nbsp;<a title="Tr&iacute; th&ocirc;ng minh của con người" href="https://vi.wikipedia.org/wiki/Tr%C3%AD_th%C3%B4ng_minh_c%E1%BB%A7a_con_ng%C6%B0%E1%BB%9Di">tr&iacute; th&ocirc;ng minh của con người</a>&nbsp;"c&oacute; thể được m&ocirc; tả ch&iacute;nh x&aacute;c đến mức một cỗ m&aacute;y c&oacute; thể được chế tạo để m&ocirc; phỏng n&oacute;".<sup id="cite_ref-19" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-19">[19]</a></sup>&nbsp;Điều n&agrave;y l&agrave;m dấy l&ecirc;n những tranh luận triết học về bản chất của&nbsp;<a title="T&acirc;m tr&iacute;" href="https://vi.wikipedia.org/wiki/T%C3%A2m_tr%C3%AD">t&acirc;m tr&iacute;</a>&nbsp;v&agrave; đạo đức khi tạo ra những sinh vật nh&acirc;n tạo c&oacute; tr&iacute; th&ocirc;ng minh giống con người, đ&oacute; l&agrave; những vấn đề đ&atilde; được&nbsp;<a title="Lịch sử ng&agrave;nh tr&iacute; tuệ nh&acirc;n tạo" href="https://vi.wikipedia.org/wiki/L%E1%BB%8Bch_s%E1%BB%AD_ng%C3%A0nh_tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o">thần thoại</a>, viễn tưởng v&agrave;&nbsp;<a title="Triết học về tr&iacute; tuệ nh&acirc;n tạo" href="https://vi.wikipedia.org/wiki/Tri%E1%BA%BFt_h%E1%BB%8Dc_v%E1%BB%81_tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o">triết học</a>&nbsp;từ&nbsp;<a title="Thời kỳ cổ đại" href="https://vi.wikipedia.org/wiki/Th%E1%BB%9Di_k%E1%BB%B3_c%E1%BB%95_%C4%91%E1%BA%A1i">thời cổ đại</a>&nbsp;đề cập tới.<sup id="cite_ref-McCorduck''s_thesis_20-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-McCorduck''s_thesis-20">[20]</a></sup>&nbsp;Một số người cũng coi AI l&agrave;&nbsp;<a title="Điểm kỳ dị c&ocirc;ng nghệ" href="https://vi.wikipedia.org/wiki/%C4%90i%E1%BB%83m_k%E1%BB%B3_d%E1%BB%8B_c%C3%B4ng_ngh%E1%BB%87">mối nguy hiểm cho nh&acirc;n loại</a>&nbsp;nếu tiến triển của n&oacute; kh&ocirc;ng suy giảm.<sup id="cite_ref-21" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-21">[21]</a></sup>&nbsp;Những người kh&aacute;c tin rằng AI, kh&ocirc;ng giống như c&aacute;c cuộc c&aacute;ch mạng c&ocirc;ng nghệ trước đ&acirc;y, sẽ tạo ra&nbsp;<a class="new" title="Thất nghiệp c&ocirc;ng nghệ (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Th%E1%BA%A5t_nghi%E1%BB%87p_c%C3%B4ng_ngh%E1%BB%87&amp;action=edit&amp;redlink=1">nguy cơ thất nghiệp h&agrave;ng loạt</a>.<sup id="cite_ref-guardian_jobs_debate_22-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-guardian_jobs_debate-22">[22]</a></sup></p>
<p>Trong thế kỷ 21, c&aacute;c kỹ thuật AI đ&atilde; trải qua sự hồi sinh sau những tiến bộ đồng thời về sức mạnh m&aacute;y t&iacute;nh,&nbsp;<a title="Dữ liệu lớn" href="https://vi.wikipedia.org/wiki/D%E1%BB%AF_li%E1%BB%87u_l%E1%BB%9Bn">dữ liệu lớn</a>&nbsp;v&agrave; hiểu biết l&yacute; thuyết; v&agrave; kỹ thuật AI đ&atilde; trở th&agrave;nh một phần thiết yếu của&nbsp;<a class="new" title="C&ocirc;ng nghiệp c&ocirc;ng nghệ (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=C%C3%B4ng_nghi%E1%BB%87p_c%C3%B4ng_ngh%E1%BB%87&amp;action=edit&amp;redlink=1">ng&agrave;nh c&ocirc;ng nghệ</a>, gi&uacute;p giải quyết nhiều vấn đề th&aacute;ch thức trong học m&aacute;y,&nbsp;<a title="C&ocirc;ng nghệ phần mềm" href="https://vi.wikipedia.org/wiki/C%C3%B4ng_ngh%E1%BB%87_ph%E1%BA%A7n_m%E1%BB%81m">c&ocirc;ng nghệ phần mềm</a>&nbsp;v&agrave;&nbsp;<a title="Vận tr&ugrave; học" href="https://vi.wikipedia.org/wiki/V%E1%BA%ADn_tr%C3%B9_h%E1%BB%8Dc">nghi&ecirc;n cứu vận h&agrave;nh</a>.<sup id="cite_ref-AI_in_2000s_13-1" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-AI_in_2000s-13">[13]</a></sup></p>
<h2><span id="L.E1.BB.8Bch_s.E1.BB.AD"></span><span id="Lịch_sử" class="mw-headline">Lịch sử</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a class="mw-editsection-visualeditor" title="Sửa đổi phần &ldquo;Lịch sử&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;veaction=edit&amp;section=1">sửa</a><span class="mw-editsection-divider">&nbsp;|&nbsp;</span><a title="Sửa đổi phần &ldquo;Lịch sử&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;section=1">sửa m&atilde; nguồn</a><span class="mw-editsection-bracket">]</span></span></h2>
<div class="hatnote navigation-not-searchable" role="note">B&agrave;i chi tiết:&nbsp;<a title="Lịch sử ng&agrave;nh tr&iacute; tuệ nh&acirc;n tạo" href="https://vi.wikipedia.org/wiki/L%E1%BB%8Bch_s%E1%BB%AD_ng%C3%A0nh_tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o">Lịch sử ng&agrave;nh tr&iacute; tuệ nh&acirc;n tạo</a></div>
<p>Tư tưởng c&oacute; khả năng sinh vật nh&acirc;n tạo xuất hiện như c&aacute;c thiết bị kể chuyện thời cổ đại,<sup id="cite_ref-AI_in_myth_23-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-AI_in_myth-23">[23]</a></sup>&nbsp;v&agrave; đ&atilde; được phổ biến trong tiểu thuyết, như trong&nbsp;<em><a title="Frankenstein" href="https://vi.wikipedia.org/wiki/Frankenstein">Frankenstein</a></em>&nbsp;của&nbsp;<a title="Mary Shelley" href="https://vi.wikipedia.org/wiki/Mary_Shelley">Mary Shelley</a>&nbsp;hay&nbsp;<em>RUR (m&aacute;y to&agrave;n năng Rossum)</em>&nbsp;của&nbsp;<a title="Karel Čapek" href="https://vi.wikipedia.org/wiki/Karel_%C4%8Capek">Karel Capek</a>.<sup id="cite_ref-AI_in_early_science_fiction_24-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-AI_in_early_science_fiction-24">[24]</a></sup>&nbsp;Những nh&acirc;n vật n&agrave;y v&agrave; số phận của họ n&ecirc;u ra nhiều vấn đề tương tự hiện đang được thảo luận trong&nbsp;<a class="new" title="Đạo đức của tr&iacute; tuệ nh&acirc;n tạo (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=%C4%90%E1%BA%A1o_%C4%91%E1%BB%A9c_c%E1%BB%A7a_tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;redlink=1">đạo đức của tr&iacute; tuệ nh&acirc;n tạo</a>.<sup id="cite_ref-McCorduck''s_thesis_20-1" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-McCorduck''s_thesis-20">[20]</a></sup></p>
<p>Nghi&ecirc;n cứu về&nbsp;<a title="L&yacute; tr&iacute;" href="https://vi.wikipedia.org/wiki/L%C3%BD_tr%C3%AD">l&yacute; tr&iacute;</a>&nbsp;cơ học hoặc&nbsp;<a title="L&yacute; tr&iacute;" href="https://vi.wikipedia.org/wiki/L%C3%BD_tr%C3%AD">"ch&iacute;nh thức"</a>&nbsp;bắt đầu với c&aacute;c&nbsp;<a title="Nh&agrave; triết học" href="https://vi.wikipedia.org/wiki/Nh%C3%A0_tri%E1%BA%BFt_h%E1%BB%8Dc">nh&agrave; triết học</a>&nbsp;v&agrave; to&aacute;n học thời cổ đại. Nghi&ecirc;n cứu về logic to&aacute;n học đ&atilde; dẫn trực tiếp đến&nbsp;<a title="L&yacute; thuyết t&iacute;nh to&aacute;n" href="https://vi.wikipedia.org/wiki/L%C3%BD_thuy%E1%BA%BFt_t%C3%ADnh_to%C3%A1n">l&yacute; thuyết t&iacute;nh to&aacute;n</a>&nbsp;của&nbsp;<a title="Alan Turing" href="https://vi.wikipedia.org/wiki/Alan_Turing">Alan Turing</a>, người cho rằng một cỗ m&aacute;y, bằng c&aacute;ch x&aacute;o trộn c&aacute;c k&yacute; hiệu đơn giản như "0" v&agrave; "1", c&oacute; thể m&ocirc; phỏng bất kỳ h&agrave;nh động suy luận to&aacute;n học n&agrave;o c&oacute; thể hiểu được. Tầm nh&igrave;n s&acirc;u sắc n&agrave;y, cho thấy m&aacute;y t&iacute;nh kỹ thuật số c&oacute; thể m&ocirc; phỏng bất kỳ qu&aacute; tr&igrave;nh suy luận h&igrave;nh thức n&agrave;o, đ&atilde; được gọi l&agrave; luận &aacute;n Church-Turing.<sup id="cite_ref-Formal_reasoning_25-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Formal_reasoning-25">[25]</a></sup>&nbsp;C&ugrave;ng với những kh&aacute;m ph&aacute; đồng thời về&nbsp;<a title="Khoa học thần kinh" href="https://vi.wikipedia.org/wiki/Khoa_h%E1%BB%8Dc_th%E1%BA%A7n_kinh">sinh học thần kinh</a>,&nbsp;<a title="L&yacute; thuyết th&ocirc;ng tin" href="https://vi.wikipedia.org/wiki/L%C3%BD_thuy%E1%BA%BFt_th%C3%B4ng_tin">l&yacute; thuyết th&ocirc;ng tin</a>&nbsp;v&agrave;&nbsp;<a title="Điều khiển học" href="https://vi.wikipedia.org/wiki/%C4%90i%E1%BB%81u_khi%E1%BB%83n_h%E1%BB%8Dc">điều khiển học</a>, điều n&agrave;y khiến c&aacute;c nh&agrave; nghi&ecirc;n cứu c&acirc;n nhắc khả năng x&acirc;y dựng bộ n&atilde;o điện tử. Turing đ&atilde; đề xuất rằng "nếu một con người kh&ocirc;ng thể ph&acirc;n biệt giữa c&aacute;c phản hồi từ một m&aacute;y v&agrave; một con người, m&aacute;y t&iacute;nh c&oacute; thể được coi l&agrave; ''th&ocirc;ng minh''.<sup id="cite_ref-26" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-26">[26]</a></sup>&nbsp;C&ocirc;ng việc đầu ti&ecirc;n m&agrave; b&acirc;y giờ được c&ocirc;ng nhận l&agrave; tr&iacute; tuệ nh&acirc;n tạo l&agrave; thiết kế h&igrave;nh thức "tế b&agrave;o thần kinh nh&acirc;n tạo" do McCullouch v&agrave; Pitts đưa ra năm 3500.<sup id="cite_ref-FOOTNOTERussellNorvig2009_1-2" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-FOOTNOTERussellNorvig2009-1">[1]</a></sup></p>
<h2><span id="M.E1.BB.A5c_ti.C3.AAu"></span><span id="Mục_ti&ecirc;u" class="mw-headline">Mục ti&ecirc;u</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a class="mw-editsection-visualeditor" title="Sửa đổi phần &ldquo;Mục ti&ecirc;u&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;veaction=edit&amp;section=2">sửa</a><span class="mw-editsection-divider">&nbsp;|&nbsp;</span><a title="Sửa đổi phần &ldquo;Mục ti&ecirc;u&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;section=2">sửa m&atilde; nguồn</a><span class="mw-editsection-bracket">]</span></span></h2>
<h3><span id="L.C3.BD_lu.E1.BA.ADn.2C_gi.E1.BA.A3i_quy.E1.BA.BFt_v.E1.BA.A5n_.C4.91.E1.BB.81"></span><span id="L&yacute;_luận,_giải_quyết_vấn_đề" class="mw-headline">L&yacute; luận, giải quyết vấn đề</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a class="mw-editsection-visualeditor" title="Sửa đổi phần &ldquo;L&yacute; luận, giải quyết vấn đề&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;veaction=edit&amp;section=3">sửa</a><span class="mw-editsection-divider">&nbsp;|&nbsp;</span><a title="Sửa đổi phần &ldquo;L&yacute; luận, giải quyết vấn đề&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;section=3">sửa m&atilde; nguồn</a><span class="mw-editsection-bracket">]</span></span></h3>
<p>C&aacute;c nh&agrave; nghi&ecirc;n cứu đầu ti&ecirc;n đ&atilde; ph&aacute;t triển c&aacute;c thuật to&aacute;n bắt chước theo l&yacute; luận từng bước m&agrave; con người sử dụng khi giải quyết c&aacute;c c&acirc;u đố hoặc đưa ra c&aacute;c phương ph&aacute;p loại trừ logic.<sup id="cite_ref-Reasoning_27-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Reasoning-27">[27]</a></sup>&nbsp;V&agrave;o cuối những năm 1980 v&agrave; 1990, nghi&ecirc;n cứu về AI đ&atilde; ph&aacute;t triển c&aacute;c phương ph&aacute;p xử l&yacute; th&ocirc;ng tin kh&ocirc;ng chắc chắn hoặc kh&ocirc;ng đầy đủ, sử dụng c&aacute;c kh&aacute;i niệm từ&nbsp;<a title="X&aacute;c suất" href="https://vi.wikipedia.org/wiki/X%C3%A1c_su%E1%BA%A5t">x&aacute;c suất</a>&nbsp;v&agrave;&nbsp;<a title="Kinh tế" href="https://vi.wikipedia.org/wiki/Kinh_t%E1%BA%BF">kinh tế</a>.<sup id="cite_ref-Uncertain_reasoning_28-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Uncertain_reasoning-28">[28]</a></sup></p>
<p>Đối với những vấn đề kh&oacute;, c&aacute;c thuật to&aacute;n bắt buộc phải c&oacute; phần cứng đủ mạnh để thực hiện ph&eacute;p t&iacute;nh to&aacute;n khổng lồ - để trải qua "vụ nổ tổ hợp": lượng bộ nhớ v&agrave; thời gian t&iacute;nh to&aacute;n c&oacute; thể trở n&ecirc;n v&ocirc; tận nếu giải quyết một vấn đề kh&oacute;. Mức độ ưu ti&ecirc;n cao nhất l&agrave; t&igrave;m kiếm c&aacute;c thuật to&aacute;n giải quyết vấn đề.<sup id="cite_ref-Intractability_29-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Intractability-29">[29]</a></sup></p>
<p>Con người thường sử dụng c&aacute;c ph&aacute;n đo&aacute;n nhanh v&agrave; trực quan chứ kh&ocirc;ng phải l&agrave; ph&eacute;p khấu trừ từng bước m&agrave; c&aacute;c nghi&ecirc;n cứu AI ban đầu c&oacute; thể m&ocirc; phỏng.<sup id="cite_ref-Psychological_evidence_of_sub-symbolic_reasoning_30-0" class="reference"><a href="https://vi.wikipedia.org/wiki/Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o#cite_note-Psychological_evidence_of_sub-symbolic_reasoning-30">[30]</a></sup>&nbsp;AI đ&atilde; tiến triển bằng c&aacute;ch sử dụng c&aacute;ch giải quyết vấn đề "biểu tượng phụ": c&aacute;ch tiếp cận t&aacute;c nh&acirc;n được thể hiện nhấn mạnh tầm quan trọng của c&aacute;c kỹ năng cảm biến động đến l&yacute; luận cao hơn; nghi&ecirc;n cứu mạng thần kinh cố gắng để m&ocirc; phỏng c&aacute;c cấu tr&uacute;c b&ecirc;n trong n&atilde;o l&agrave;m ph&aacute;t sinh kỹ năng n&agrave;y. C&aacute;c phương ph&aacute;p tiếp cận thống k&ecirc; đối với AI bắt chước khả năng của con người.</p>
<h2><span id="C.C3.A1c_tr.C6.B0.E1.BB.9Dng_ph.C3.A1i_tr.C3.AD_tu.E1.BB.87_nh.C3.A2n_t.E1.BA.A1o"></span><span id="C&aacute;c_trường_ph&aacute;i_tr&iacute;_tuệ_nh&acirc;n_tạo" class="mw-headline">C&aacute;c trường ph&aacute;i tr&iacute; tuệ nh&acirc;n tạo</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a class="mw-editsection-visualeditor" title="Sửa đổi phần &ldquo;C&aacute;c trường ph&aacute;i tr&iacute; tuệ nh&acirc;n tạo&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;veaction=edit&amp;section=4">sửa</a><span class="mw-editsection-divider">&nbsp;|&nbsp;</span><a title="Sửa đổi phần &ldquo;C&aacute;c trường ph&aacute;i tr&iacute; tuệ nh&acirc;n tạo&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;section=4">sửa m&atilde; nguồn</a><span class="mw-editsection-bracket">]</span></span></h2>
<figure class="mw-halign-right">
<figcaption><a title="Robot" href="https://vi.wikipedia.org/wiki/Robot">Robot</a>&nbsp;<a title="ASIMO" href="https://vi.wikipedia.org/wiki/ASIMO">ASIMO</a>&nbsp;(<a title="Honda" href="https://vi.wikipedia.org/wiki/Honda">Honda</a>&nbsp;- Nhật Bản)</figcaption>
</figure>
<p>Tr&iacute; tuệ nh&acirc;n tạo (AI) chia th&agrave;nh hai trường ph&aacute;i tư duy: Tr&iacute; tu&ecirc; nh&acirc;n tạo truyền thống v&agrave;&nbsp;<a class="new" title="Tr&iacute; tuệ t&iacute;nh to&aacute;n (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_t%C3%ADnh_to%C3%A1n&amp;action=edit&amp;redlink=1">tr&iacute; tuệ t&iacute;nh to&aacute;n</a>.</p>
<p>Tr&iacute; tu&ecirc; nh&acirc;n tạo truyền thống hầu như bao gồm c&aacute;c phương ph&aacute;p hiện được ph&acirc;n loại l&agrave; c&aacute;c phương ph&aacute;p&nbsp;<a title="Học m&aacute;y" href="https://vi.wikipedia.org/wiki/H%E1%BB%8Dc_m%C3%A1y">học m&aacute;y</a>&nbsp;(<em>machine learning</em>), đặc trưng bởi&nbsp;<a class="new" title="Hệ h&igrave;nh thức (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=H%E1%BB%87_h%C3%ACnh_th%E1%BB%A9c&amp;action=edit&amp;redlink=1">hệ h&igrave;nh thức</a>&nbsp;(<em>formalism</em>) v&agrave;&nbsp;<a class="mw-redirect" title="Khoa học Thống k&ecirc;" href="https://vi.wikipedia.org/wiki/Khoa_h%E1%BB%8Dc_Th%E1%BB%91ng_k%C3%AA">ph&acirc;n t&iacute;ch thống k&ecirc;</a>. N&oacute; c&ograve;n được biết với c&aacute;c t&ecirc;n Tr&iacute; tu&ecirc; nh&acirc;n tạo&nbsp;<a title="Biểu tượng" href="https://vi.wikipedia.org/wiki/Bi%E1%BB%83u_t%C6%B0%E1%BB%A3ng">biểu tượng</a>, Tr&iacute; tu&ecirc; nh&acirc;n tạo&nbsp;<a title="Logic" href="https://vi.wikipedia.org/wiki/Logic">logic</a>,&nbsp;<a class="new" title="TTNT ngăn nắp (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=TTNT_ng%C4%83n_n%E1%BA%AFp&amp;action=edit&amp;redlink=1">Tr&iacute; tu&ecirc; nh&acirc;n tạo ngăn nắp</a>&nbsp;(<em>neat AI</em>) v&agrave;&nbsp;<a class="new" title="TTNT cổ điển (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=TTNT_c%E1%BB%95_%C4%91i%E1%BB%83n&amp;action=edit&amp;redlink=1">Tr&iacute; tu&ecirc; nh&acirc;n tạo cổ điển</a>&nbsp;(<em>Goodness Old Fashioned Artificial Intelligence</em>). (Xem th&ecirc;m&nbsp;<a title="Ngữ nghĩa học" href="https://vi.wikipedia.org/wiki/Ng%E1%BB%AF_ngh%C4%A9a_h%E1%BB%8Dc">ngữ nghĩa học</a>.) C&aacute;c phương ph&aacute;p gồm c&oacute;:</p>
<ul>
<li><a title="Hệ chuy&ecirc;n gia" href="https://vi.wikipedia.org/wiki/H%E1%BB%87_chuy%C3%AAn_gia">Hệ chuy&ecirc;n gia</a>: &aacute;p dụng c&aacute;c khả năng suy luận để đạt tới một kết luận. Một hệ chuy&ecirc;n gia c&oacute; thể xử l&yacute; c&aacute;c lượng lớn th&ocirc;ng tin đ&atilde; biết v&agrave; đưa ra c&aacute;c kết luận dựa tr&ecirc;n c&aacute;c th&ocirc;ng tin đ&oacute;.&nbsp;<a class="new" title="Clippy (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Clippy&amp;action=edit&amp;redlink=1">Clippy</a>&nbsp;chương tr&igrave;nh trợ gi&uacute;p c&oacute; h&igrave;nh c&aacute;i kẹp giấy của&nbsp;<a title="Microsoft Office" href="https://vi.wikipedia.org/wiki/Microsoft_Office">Microsoft Office</a>&nbsp;l&agrave; một v&iacute; dụ. Khi người d&ugrave;ng g&otilde; ph&iacute;m, Clippy nhận ra c&aacute;c xu hướng nhất định v&agrave; đưa ra c&aacute;c gợi &yacute;.</li>
<li><a title="Lập luận theo t&igrave;nh huống" href="https://vi.wikipedia.org/wiki/L%E1%BA%ADp_lu%E1%BA%ADn_theo_t%C3%ACnh_hu%E1%BB%91ng">Lập luận theo t&igrave;nh huống</a>.</li>
<li><a title="Mạng Bayes" href="https://vi.wikipedia.org/wiki/M%E1%BA%A1ng_Bayes">Mạng Bayes</a>.</li>
</ul>
<p>Tr&iacute; tuệ t&iacute;nh to&aacute;n nghi&ecirc;n cứu việc học hoặc ph&aacute;t triển lặp (v&iacute; dụ: tinh chỉnh tham số trong hệ thống, chẳng hạn hệ thống&nbsp;<a class="new" title="Connectionist (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Connectionist&amp;action=edit&amp;redlink=1">connectionist</a>). Việc học dựa tr&ecirc;n dữ liệu kinh nghiệm v&agrave; c&oacute; quan hệ với Tr&iacute; tuệ nh&acirc;n tạo phi k&yacute; hiệu,&nbsp;<a class="new" title="TTNT lộn xộn (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=TTNT_l%E1%BB%99n_x%E1%BB%99n&amp;action=edit&amp;redlink=1">Tr&iacute; tu&ecirc; nh&acirc;n tạo lộn xộn</a>&nbsp;(<em>scruffy AI</em>) v&agrave;&nbsp;<a class="new" title="T&iacute;nh to&aacute;n mềm (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=T%C3%ADnh_to%C3%A1n_m%E1%BB%81m&amp;action=edit&amp;redlink=1">t&iacute;nh to&aacute;n mềm</a>&nbsp;(<em>soft computing</em>). C&aacute;c phương ph&aacute;p ch&iacute;nh gồm c&oacute;:</p>
<ul>
<li><a class="mw-redirect" title="Mạng nơ-ron" href="https://vi.wikipedia.org/wiki/M%E1%BA%A1ng_n%C6%A1-ron">Mạng neural</a>: c&aacute;c hệ thống mạnh về&nbsp;<a title="Nhận dạng mẫu" href="https://vi.wikipedia.org/wiki/Nh%E1%BA%ADn_d%E1%BA%A1ng_m%E1%BA%ABu">nhận dạng mẫu</a>&nbsp;(<em>pattern recognition</em>).</li>
<li><a class="new" title="Hệ mờ (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=H%E1%BB%87_m%E1%BB%9D&amp;action=edit&amp;redlink=1">Hệ mờ</a>&nbsp;(<em>Fuzzy system</em>): c&aacute;c kỹ thuật&nbsp;<a class="new" title="Suy luận kh&ocirc;ng chắc chắn (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Suy_lu%E1%BA%ADn_kh%C3%B4ng_ch%E1%BA%AFc_ch%E1%BA%AFn&amp;action=edit&amp;redlink=1">suy luận kh&ocirc;ng chắc chắn</a>, đ&atilde; được sử dụng rộng r&atilde;i trong c&aacute;c hệ thống c&ocirc;ng nghiệp hiện đại v&agrave; c&aacute;c hệ thống quản l&yacute; sản phẩm ti&ecirc;u d&ugrave;ng.</li>
<li><a class="new" title="T&iacute;nh to&aacute;n tiến h&oacute;a (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=T%C3%ADnh_to%C3%A1n_ti%E1%BA%BFn_h%C3%B3a&amp;action=edit&amp;redlink=1">T&iacute;nh to&aacute;n tiến h&oacute;a</a>&nbsp;(<em>Evolutionary computation</em>): ứng dụng c&aacute;c kh&aacute;i niệm biology như&nbsp;<a class="mw-disambig" title="Quần thể" href="https://vi.wikipedia.org/wiki/Qu%E1%BA%A7n_th%E1%BB%83">quần thể</a>,&nbsp;<a title="Biến dị sinh học" href="https://vi.wikipedia.org/wiki/Bi%E1%BA%BFn_d%E1%BB%8B_sinh_h%E1%BB%8Dc">biến dị</a>&nbsp;v&agrave;&nbsp;<a title="Đấu tranh sinh tồn" href="https://vi.wikipedia.org/wiki/%C4%90%E1%BA%A5u_tranh_sinh_t%E1%BB%93n">đấu tranh sinh tồn</a>&nbsp;để sinh c&aacute;c lời giải ng&agrave;y c&agrave;ng tốt hơn cho b&agrave;i to&aacute;n. C&aacute;c phương ph&aacute;p n&agrave;y thường được chia th&agrave;nh c&aacute;c&nbsp;<a class="new" title="Thuật to&aacute;n tiến h&oacute;a (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Thu%E1%BA%ADt_to%C3%A1n_ti%E1%BA%BFn_h%C3%B3a&amp;action=edit&amp;redlink=1">thuật to&aacute;n tiến h&oacute;a</a>&nbsp;(v&iacute; dụ&nbsp;<a title="Giải thuật di truyền" href="https://vi.wikipedia.org/wiki/Gi%E1%BA%A3i_thu%E1%BA%ADt_di_truy%E1%BB%81n">thuật to&aacute;n gene</a>) v&agrave;&nbsp;<a class="new" title="Tr&iacute; tuệ bầy đ&agrave;n (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_b%E1%BA%A7y_%C4%91%C3%A0n&amp;action=edit&amp;redlink=1">tr&iacute; tuệ bầy đ&agrave;n</a>&nbsp;(<em>swarm intelligence</em>) (chẳng hạn&nbsp;<a class="new" title="Hệ kiến (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=H%E1%BB%87_ki%E1%BA%BFn&amp;action=edit&amp;redlink=1">hệ kiến</a>).</li>
<li><a class="new" title="TTNT dựa h&agrave;nh vi (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=TTNT_d%E1%BB%B1a_h%C3%A0nh_vi&amp;action=edit&amp;redlink=1">Tr&iacute; tu&ecirc; nh&acirc;n tạo dựa h&agrave;nh vi</a>&nbsp;(<em>Behavior based AI</em>): một phương ph&aacute;p module để x&acirc;y dựng c&aacute;c hệ thống Tr&iacute; tu&ecirc; nh&acirc;n tạo bằng tay.</li>
</ul>
<p>Người ta đ&atilde; nghi&ecirc;n cứu c&aacute;c&nbsp;<a title="Hệ thống th&ocirc;ng minh lai" href="https://vi.wikipedia.org/wiki/H%E1%BB%87_th%E1%BB%91ng_th%C3%B4ng_minh_lai">hệ thống th&ocirc;ng minh lai</a>&nbsp;(<em>hybrid intelligent system</em>), trong đ&oacute; kết hợp hai trường ph&aacute;i n&agrave;y. C&aacute;c luật suy diễn của hệ chuy&ecirc;n gia c&oacute; thể được sinh bởi mạng neural hoặc c&aacute;c&nbsp;<a class="new" title="Luật dẫn xuất (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Lu%E1%BA%ADt_d%E1%BA%ABn_xu%E1%BA%A5t&amp;action=edit&amp;redlink=1">luật dẫn xuất</a>&nbsp;(<em>production rule</em>) từ việc học theo thống k&ecirc; như trong kiến tr&uacute;c&nbsp;<a class="new" title="ACT-R (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=ACT-R&amp;action=edit&amp;redlink=1">ACT-R</a>.</p>
<p>C&aacute;c phương ph&aacute;p tr&iacute; tuệ nh&acirc;n tạo thường được d&ugrave;ng trong c&aacute;c c&ocirc;ng tr&igrave;nh nghi&ecirc;n cứu&nbsp;<a title="Khoa học nhận thức" href="https://vi.wikipedia.org/wiki/Khoa_h%E1%BB%8Dc_nh%E1%BA%ADn_th%E1%BB%A9c">khoa học nhận thức</a>&nbsp;(<em>cognitive science</em>), một ng&agrave;nh cố gắng tạo ra m&ocirc; h&igrave;nh nhận thức của&nbsp;<a class="mw-redirect" title="Lo&agrave;i người" href="https://vi.wikipedia.org/wiki/Lo%C3%A0i_ng%C6%B0%E1%BB%9Di">con người</a>&nbsp;(việc n&agrave;y kh&aacute;c với c&aacute;c nghi&ecirc;n cứu&nbsp;<em>Tr&iacute; tu&ecirc; nh&acirc;n tạo</em>, v&igrave;&nbsp;<em>Tr&iacute; tu&ecirc; nh&acirc;n tạo</em>&nbsp;chỉ muốn tạo ra m&aacute;y m&oacute;c thực dụng, kh&ocirc;ng phải tạo ra m&ocirc; h&igrave;nh về hoạt động của bộ &oacute;c con người).</p>
<h2><span id="Tri.E1.BA.BFt_l.C3.BD_Tr.C3.AD_tu.E1.BB.87_nh.C3.A2n_t.E1.BA.A1o"></span><span id="Triết_l&yacute;_Tr&iacute;_tuệ_nh&acirc;n_tạo" class="mw-headline">Triết l&yacute; Tr&iacute; tuệ nh&acirc;n tạo</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a class="mw-editsection-visualeditor" title="Sửa đổi phần &ldquo;Triết l&yacute; Tr&iacute; tuệ nh&acirc;n tạo&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;veaction=edit&amp;section=5">sửa</a><span class="mw-editsection-divider">&nbsp;|&nbsp;</span><a title="Sửa đổi phần &ldquo;Triết l&yacute; Tr&iacute; tuệ nh&acirc;n tạo&rdquo;" href="https://vi.wikipedia.org/w/index.php?title=Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;section=5">sửa m&atilde; nguồn</a><span class="mw-editsection-bracket">]</span></span></h2>
<p><em>B&agrave;i ch&iacute;nh&nbsp;<a class="new" title="Triết l&yacute; Tr&iacute; tuệ nh&acirc;n tạo (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Tri%E1%BA%BFt_l%C3%BD_Tr%C3%AD_tu%E1%BB%87_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;redlink=1">Triết l&yacute; Tr&iacute; tuệ nh&acirc;n tạo</a></em></p>
<p><a class="new" title="TTNT mạnh (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=TTNT_m%E1%BA%A1nh&amp;action=edit&amp;redlink=1">Tr&iacute; tuệ nh&acirc;n tạo mạnh</a>&nbsp;hay Tr&iacute; tuệ nh&acirc;n tạo yếu, đ&oacute; vẫn l&agrave; một chủ đề tranh luận n&oacute;ng hổi của c&aacute;c&nbsp;<a class="mw-redirect" title="Triết gia" href="https://vi.wikipedia.org/wiki/Tri%E1%BA%BFt_gia">nh&agrave; triết học</a>&nbsp;Tr&iacute; tuệ nh&acirc;n tạo. N&oacute; li&ecirc;n quan tới&nbsp;<a class="new" title="Philosophy of mind (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Philosophy_of_mind&amp;action=edit&amp;redlink=1">philosophy of mind</a>&nbsp;v&agrave;&nbsp;<a class="new" title="Mind-body problem (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Mind-body_problem&amp;action=edit&amp;redlink=1">mind-body problem</a>. Đ&aacute;ng ch&uacute; &yacute; nhất l&agrave;&nbsp;<a title="Roger Penrose" href="https://vi.wikipedia.org/wiki/Roger_Penrose">Roger Penrose</a>&nbsp;trong t&aacute;c phẩm&nbsp;<em><a class="new" title="The Emperor''s New Mind (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=The_Emperor%27s_New_Mind&amp;action=edit&amp;redlink=1">The Emperor''s New Mind</a></em>&nbsp;v&agrave;&nbsp;<a title="John Searle" href="https://vi.wikipedia.org/wiki/John_Searle">John Searle</a>&nbsp;với&nbsp;<a class="new" title="Th&iacute; nghiệm tư duy (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Th%C3%AD_nghi%E1%BB%87m_t%C6%B0_duy&amp;action=edit&amp;redlink=1">th&iacute; nghiệm tư duy</a>&nbsp;trong cuốn&nbsp;<em><a class="new" title="Chinese room (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Chinese_room&amp;action=edit&amp;redlink=1">Chinese room</a></em>&nbsp;(Căn ph&ograve;ng Trung Hoa) khẳng định rằng c&aacute;c hệ thống&nbsp;<a title="Logic h&igrave;nh thức" href="https://vi.wikipedia.org/wiki/Logic_h%C3%ACnh_th%E1%BB%A9c">logic h&igrave;nh thức</a>&nbsp;kh&ocirc;ng thể đạt được&nbsp;<a title="Nhận thức" href="https://vi.wikipedia.org/wiki/Nh%E1%BA%ADn_th%E1%BB%A9c">nhận thức</a>&nbsp;thực sự, trong khi&nbsp;<a class="new" title="Douglas Hofstadter (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Douglas_Hofstadter&amp;action=edit&amp;redlink=1">Douglas Hofstadter</a>&nbsp;trong&nbsp;<em><a title="G&ouml;del, Escher, Bach" href="https://vi.wikipedia.org/wiki/G%C3%B6del,_Escher,_Bach">G&ouml;del, Escher, Bach</a></em>&nbsp;v&agrave;&nbsp;<a class="new" title="Daniel Dennett (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Daniel_Dennett&amp;action=edit&amp;redlink=1">Daniel Dennett</a>&nbsp;trong&nbsp;<em><a class="new" title="Consciousness Explained (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Consciousness_Explained&amp;action=edit&amp;redlink=1">Consciousness Explained</a></em>&nbsp;ủng hộ&nbsp;<a title="Thuyết chức năng" href="https://vi.wikipedia.org/wiki/Thuy%E1%BA%BFt_ch%E1%BB%A9c_n%C4%83ng">thuyết chức năng</a>. Theo quan điểm của nhiều người ủng hộ Tr&iacute; tuệ nh&acirc;n tạo mạnh,&nbsp;<a class="new" title="Nhận thức nh&acirc;n tạo (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Nh%E1%BA%ADn_th%E1%BB%A9c_nh%C3%A2n_t%E1%BA%A1o&amp;action=edit&amp;redlink=1">nhận thức nh&acirc;n tạo</a>&nbsp;được coi l&agrave; "<a class="new" title="Ch&eacute;n th&aacute;nh (trang kh&ocirc;ng tồn tại)" href="https://vi.wikipedia.org/w/index.php?title=Ch%C3%A9n_th%C3%A1nh&amp;action=edit&amp;redlink=1">ch&eacute;n th&aacute;nh</a> " của Tr&iacute; tuệ nh&acirc;n tạo.</p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (21, 36, N'<p>Learn More About Google AI through this Guide to Google AI.</p>
<p>As a leader in your industry, you know the power of utilizing modern technology to serve customers better and develop superior products.&nbsp;</p>
<p>Google AI is making waves in the marketing world, allowing companies to access powerful insights and tools to make life easier for CEOs and business leaders.&nbsp;</p>
<p>In this comprehensive guide to Google Artificial Intelligence, we&rsquo;ll explore how the company has revolutionized marketing by providing actionable data sets from machine learning models.&nbsp;</p>
<p>We&rsquo;ll discuss why CEOs should consider investing in Google AI technologies when looking for an edge over their competition and go through what this cutting-edge tech can do for them &ndash; now and in the future.</p>
<h2 class="wp-block-heading"><span id="I_Introduction_to_the_comprehensive_guide_on_Google_Artificial_Intelligence">I. Introduction To The Comprehensive Guide On Google Artificial Intelligence</span></h2>
<p>Artificial intelligence is quickly becoming a buzzword in the world of technology. As our world continues to evolve and innovate, so does the concept of AI.&nbsp;</p>
<p>Google is at the forefront of this revolution, and they&rsquo;ve recently released a comprehensive guide to AI. This guide is designed to help individuals navigate the complex world of Google&rsquo;s AI tools.&nbsp;</p>
<p>From machine learning to natural language processing, this guide is a must-read for anyone looking to understand the latest developments in the field. So buckle up because we&rsquo;re about to dive into the exciting world of Google Artificial Intelligence.</p>
<h2 class="wp-block-heading"><span id="A_Definition_and_overview_of_AI">A. Definition And Overview Of AI</span></h2>
<p>&nbsp;</p>
<p>Artificial Intelligence, commonly referred to as AI, is a computer&rsquo;s ability to mimic human intelligence and decision-making. AI relies on complex algorithms and data to learn and adapt to new information and situations.&nbsp;</p>
<p>AI aims to create machines that can perform tasks that typically require human intelligence, such as visual perception, speech recognition, and decision-making. AI can transform numerous industries, including healthcare, finance, and transportation.&nbsp;</p>
<p>With AI, machines can process large amounts of data quickly and with great accuracy, leading to increased efficiency and productivity. AI will undoubtedly become more advanced and integrated into our daily lives as technology evolves.</p>
<h2 class="wp-block-heading"><span id="B_Brief_history_of_AI">B. Brief History Of AI</span></h2>
<p>Artificial Intelligence, or AI for short, has come a long way since its inception in the mid-20th century. The concept was first coined in 1956 at Dartmouth College, where scientists gathered to explore the possibility of creating machines that could mimic human intelligence.&nbsp;</p>
<p>At the time, the dream of creating intelligent machines seemed like a far-off fantasy. However, technological advancements have enabled significant progress in AI in the following decades.&nbsp;</p>
<p>Today, AI powers everything from our virtual assistants, such as Siri and Alexa, to self-driving cars and complex algorithms that can analyze vast amounts of data in seconds.&nbsp;</p>
<p>Looking back at the brief history of AI, it is truly remarkable to see how far we have come and how much further we can go in harnessing the power of intelligent tech.</p>
<h2 class="wp-block-heading"><span id="C_Introduction_to_Google_AI_Overview_history_and_mission">C. Introduction To Google AI: Overview, History And Mission</span></h2>
<p>&nbsp;</p>
<p>Artificial intelligence has made remarkable strides in recent years, and Google has been at the forefront of its development. With its Google Artificial Intelligence program, the company continues to push the boundaries of what is possible with this exciting technology.&nbsp;</p>
<p>The history of Google AI dates back to the early 2000s when the company began exploring the potential of machine learning. Since then, Google AI has grown into a massive operation, with teams of researchers and engineers working to solve some of the most complex problems in the field.&nbsp;</p>
<p>Today, Google Artificial Intelligence&rsquo;s mission is to &ldquo;organize the world&rsquo;s information and make it universally accessible and useful&rdquo; by developing intelligent systems that process vast amounts of data and provide valuable insights. As we continue to explore the potential of AI, Google will undoubtedly remain a key player in the field.</p>
<h2 class="wp-block-heading"><span id="II_Understanding_Artificial_Intelligence">II. Understanding Artificial Intelligence</span></h2>
<p>Artificial Intelligence, or AI, is a rapidly developing technology taking the world by storm. It refers to the ability of machines to perform cognitive tasks that would normally require human intelligence, such as learning, thinking, and problem-solving.&nbsp;</p>
<p>AI has significantly impacted various industries, from healthcare to finance to transportation. While some people worry about the loss of automation jobs, others are excited about the new opportunities that AI can create.&nbsp;</p>
<p>With its ability to analyze vast amounts of data and draw meaningful insights, AI is poised to revolutionize how we live and work.&nbsp;</p>
<p>As we continue to develop and refine this technology, it is important to keep in mind both the incredible benefits it can bring us and the potential challenges we must navigate to ensure that it is used ethically and responsibly.</p>
<h2 class="wp-block-heading"><span id="A_Types_of_AI_Narrow_general_and_superintelligence">A. Types Of AI: Narrow, General, And Superintelligence</span></h2>
<p>Artificial Intelligence has come a long way since its inception.&nbsp;</p>
<p>Different types of AI have emerged as we have progressed in this field. These types are generally categorized into narrow, general, and superintelligence.&nbsp;</p>
<p>Narrow AI has been the most commonly used type of AI and is mainly used to help machines perform specific tasks like image recognition.&nbsp;</p>
<p>General AI, on the other hand, is designed to perform more complex tasks that require reasoning and intelligence, similar to humans.&nbsp;</p>
<p>At the same time, Superintelligence AI is an advanced technology that surpasses human intelligence. So, considering all factors, each type of AI has its own unique set of applications and abilities.</p>
<h2 class="wp-block-heading"><span id="B_Key_concepts_in_AI_Machine_learning_deep_learning_and_neural_networks">B. Key Concepts In AI: Machine Learning, Deep Learning, And Neural Networks</span></h2>
<p>&nbsp;</p>
<p>Artificial intelligence (AI) has become one of the most talked-about subjects in recent years. The field of AI involves creating machines that can perform tasks that typically require human intelligence.&nbsp;</p>
<p>Machine learning, deep learning, and neural networks are the three key concepts that constitute the backbone of AI. Machine learning refers to training a machine to recognize patterns in large data sets.&nbsp;</p>
<p>On the other hand, deep learning involves creating multiple layers of neural networks to process complex data sets. Neural networks are algorithms that aim to mimic how the human brain works, by recognizing patterns through interconnected nodes.&nbsp;</p>
<p>These concepts have revolutionized how machines learn and have contributed to significant advancements in various fields such as healthcare, finance, and technology.</p>
<h2 class="wp-block-heading"><span id="III_Google_Artificial_Intelligence_Technologies">III. Google Artificial Intelligence Technologies</span></h2>
<p>Google AI Technologies represent a revolutionary shift in the field of artificial intelligence, transforming the way we approach problem-solving and data analysis.&nbsp;</p>
<p>With cutting-edge tools like TensorFlow and Cloud AutoML, Google is opening up a whole new world of possibilities for developers and businesses alike, empowering them to harness the immense power of machine learning.&nbsp;</p>
<p>By leveraging natural language processing, neural networks, and other advanced techniques, Google is helping users to streamline their processes and improve their bottom line.&nbsp;</p>
<p>Whether you&rsquo;re looking to automate repetitive tasks, gain insights from big data, or develop innovative new products and services, Google Technologies are at the forefront of the AI revolution, unlocking infinite possibilities for the future.</p>
<h2 class="wp-block-heading"><span id="A_Google_Search_AI">A. Google Search AI</span></h2>
<p>Google&rsquo;s artificial intelligence system for search revolutionizes how we look for information online.&nbsp;</p>
<p>With its advanced natural language processing capabilities, the search AI can understand complex queries, long-tail keywords, and conversational language. Not only does this mean that search results are more accurate and relevant, but it also makes searching feel more like conversing with an intelligent assistant.&nbsp;</p>
<p>The system constantly learns and improves, adapting to new trends and language and user behavior changes. As a result, search is becoming more efficient and personalized for each user.</p>
<p>This exciting technology is just the beginning of what&rsquo;s possible with AI in search and promises to improve our online experiences.</p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (22, 37, N'<h1 class="hero-new__title">Responsible AI practices</h1>
<section class="section main-article-chapter" data-menu-title="What is responsible AI?">
<h3 class="section-title">What is responsible AI?</h3>
<p>Responsible AI is an approach to developing and deploying artificial intelligence (<a href="https://www.techtarget.com/searchenterpriseai/definition/AI-Artificial-Intelligence">AI</a>) from both an ethical and legal point of view. The goal of responsible AI is to employ AI in a safe, trustworthy and ethical fashion. Using AI responsibly should increase transparency and help reduce issues such as&nbsp;<a href="https://www.techtarget.com/searchenterpriseai/definition/machine-learning-bias-algorithm-bias-or-AI-bias">AI bias</a>.</p>
<p>Proponents of responsible AI hope that a widely adopted governance framework of AI best practices makes it easier for organizations around the globe to ensure their AI programming is human-centered, interpretable and explainable. Having a responsible AI system in place ensures fairness, reliability and transparency.</p>
<p>Trustworthy AI standards, however, are currently up to the discretion of the data scientists and software developers who write and deploy an organization''s AI models. This means that the steps required to prevent discrimination and ensure transparency vary from company to company.</p>
<p>Implementation can also differ from company to company. For example, the chief analytics officer or other dedicated AI officers and teams might be responsible for developing, implementing and monitoring the organization''s responsible AI framework. An explanation of the organization''s framework should be documented on the organization''s website, listing how it addresses <a href="https://www.techtarget.com/whatis/definition/accountability">accountability</a>&nbsp;and ensures its use of AI is anti-discriminatory.</p>
</section>
<section class="section main-article-chapter" data-menu-title="Why responsible AI is important">
<h3 class="section-title">Why responsible AI is important</h3>
<p>Responsible AI is a still emerging area of&nbsp;<a href="https://www.techtarget.com/searchenterpriseai/definition/AI-governance">AI governance</a>. The use of the word&nbsp;<em>responsible&nbsp;</em>is an umbrella term that covers both ethics and&nbsp;<a href="https://www.techtarget.com/whatis/definition/AI-democratization">democratization</a>.</p>
<p>Often, the data sets used to train machine learning (ML) models introduce bias into AI. This is caused by either incomplete or faulty data, or by the biases of those training the ML model. When an AI program is biased, it can end up negatively affecting or hurting humans -- such as unjustly declining applications for financial loans or, in healthcare, inaccurately diagnosing a patent.</p>
<p>Now that software programs with AI features are becoming more common, it''s increasingly apparent that there''s a need for standards in AI beyond&nbsp;<a href="https://webhome.auburn.edu/~vestmon/robotics.html" target="_blank" rel="noopener">those established</a>&nbsp;by science fiction writer Isaac Asimov in his "Three Laws of Robotics."</p>
<p>The implementation of responsible AI can help reduce AI bias, create more transparent AI systems and increase end-user trust in those systems.</p>
</section>
<section class="section main-article-chapter" data-menu-title="What are the principles of responsible AI?">
<h3 class="section-title">What are the principles of responsible AI?</h3>
<p>AI and machine learning models should follow a list of principles that might differ from organization to organization.</p>
<p>For example, Microsoft and Google both follow their own list of principles, and the National Institute of Standards and Technology (<a href="https://www.techtarget.com/searchsoftwarequality/definition/NIST">NIST</a>) has published a 1.0 version of an AI Risk Management Framework that follows many of the same principles found in Microsoft and Google''s lists. NIST''s list of seven principles includes the following:</p>
<ul class="default-list">
<li><strong>Accountable and transparent.</strong>&nbsp;Increased transparency is meant to provide increased trust in the AI system, while making it easier to fix problems associated with AI model outputs. This also enables developers more accountability over their AI systems.</li>
<li><strong>Explainable and interpretable.</strong>&nbsp;<a href="https://www.techtarget.com/searchenterpriseai/feature/Interpretability-and-explainability-can-lead-to-more-reliable-ML">Explainability and interpretability</a>&nbsp;are meant to provide more in-depth insights into the functionality and trustworthiness of an AI system.&nbsp;<a href="https://www.techtarget.com/whatis/definition/explainable-AI-XAI">Explainable AI</a>, for example, is meant to provide users with an explanation as to why and how it got to its output.</li>
<li><strong>Fair with harmful bias managed.</strong>&nbsp;Fairness is meant to address issues concerning AI bias and discrimination. This principle focuses on providing equality and equity, which is difficult as values differ per organization and culture.</li>
<li><strong>Privacy-enhanced.</strong>&nbsp;Privacy is meant to enforce practices that help to safeguard end-user autonomy, identity and dignity. Responsible AI systems must be developed and deployed with values such as anonymity, confidentiality and control.</li>
<li><strong>Secure and resilient.</strong>&nbsp;Responsible AI systems should be secure and resilient against potential threats such as&nbsp;<a href="https://www.techtarget.com/searchenterpriseai/definition/adversarial-machine-learning">adversarial attacks</a>. Responsible AI systems should be built to avoid, protect against and respond to attacks, while also being able to recover from an attack.</li>
<li><strong>Valid and reliable.</strong>&nbsp;Responsible AI systems should be able to maintain their performance in different unexpected circumstances without failure.</li>
<li><strong>Safe.&nbsp;</strong>Responsible AI shouldn''t endanger human life, property or the environment.</li>
</ul>
</section>
<section class="section main-article-chapter" data-menu-title="How do you design responsible AI?">
<h3 class="section-title">How do you design responsible AI?</h3>
<p>Ongoing scrutiny is crucial to ensure an organization is committed to providing an unbiased, trustworthy AI. This is why it''s crucial for an organization to have a maturity model to follow while designing and implementing an AI system.</p>
<p>At a base level, responsible AI should be built around development standards that focus on the principles for responsible AI design. As these principles differ per organization, each one should be carefully considered. AI should be built with resources according to a company-wide development standard that mandates the use of the following:</p>
<ul class="default-list">
<li>Shared code repositories.</li>
<li>Approved model architectures.</li>
<li>Sanctioned variables.</li>
<li>Established bias testing methodologies to help determine the validity of tests for AI systems.</li>
<li>Stability standards for active machine learning models to ensure AI programming works as intended.</li>
</ul>
<p>AI models should be built with concrete goals that focus on building a model in a safe, trustworthy and ethical way. For example, an organization could construct responsible AI with the goals and principles noted in Figure 2.</p>
<figure class="main-article-image full-col" data-img-fullsize="https://cdn.ttgtmedia.com/rms/onlineimages/enterprise_ai-responsible_ai-f_mobile.png"></figure>
</section>
<section class="section main-article-chapter" data-menu-title="Implementation and how it works">
<h3 class="section-title">Implementation and how it works</h3>
<p>An organization can implement responsible AI and demonstrate that it has created a responsible AI system in the following ways:</p>
<ul class="default-list">
<li>Ensure data is explainable in a way that a human can interpret.</li>
<li>Document design and decision-making processes to the point where if a mistake occurs, it can be&nbsp;<a href="https://www.techtarget.com/searchsoftwarequality/definition/reverse-engineering">reverse-engineered</a>&nbsp;to determine what transpired.</li>
<li>Build a diverse work culture and promote constructive discussions to help mitigate bias.</li>
<li>Use interpretable features to help create human-understandable data.</li>
<li>Create a rigorous development process that values visibility into each application''s latent features.</li>
<li>Focus on eliminating typical&nbsp;<a href="https://www.techtarget.com/whatis/definition/black-box-AI">black box AI model</a>&nbsp;development methods. Instead, focus on building a white box or explainable AI system, which provides an explanation for each decision the AI makes.</li>
</ul>
</section>
<section class="section main-article-chapter" data-menu-title="Best practices for responsible AI principles">
<h3 class="section-title">Best practices for responsible AI principles</h3>
<p>When designing responsible AI, governance processes need to be systematic and repeatable. Some best practices include the following:</p>
<ul class="default-list">
<li>Implement&nbsp;<a href="https://www.techtarget.com/iotagenda/tip/3-machine-learning-best-practices-to-use-in-IoT-projects">machine learning best practices</a>.</li>
<li>Create a diverse culture of support. This includes creating gender and racially diverse teams that work on creating responsible AI standards. Enable this culture to speak freely on ethical concepts around AI and bias.</li>
<li>Promote transparency to create an explainable AI model so that any decisions made by AI are visible and easily fixable.</li>
<li>Make the work as measurable as possible. Dealing with responsibility is subjective, so ensure there are measurable processes in place such as visibility and explainability and that there are auditable technical frameworks and ethical frameworks.</li>
<li>Use responsible AI tools to inspect AI models. Options such as the TensorFlow toolkit are available.</li>
<li>Identify metrics for training and monitoring to help keep errors, false positives and biases at a minimum.</li>
<li>Perform tests such as bias testing or&nbsp;<a href="https://www.techtarget.com/searcherp/feature/Predictive-maintenance-Definition-benefits-example-strategy">predictive maintenance</a>&nbsp;to help produce verifiable results and increase end-user trust.</li>
<li>Continue to monitor after deployment. This helps ensure the AI model continues to function in a responsible, unbiased way.</li>
<li>Stay mindful and learn from the process. An organization learns more about responsible AI in implementation -- from fairness practices to technical references and materials surrounding technical ethics.</li>
</ul>
</section>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (23, 38, N'<h2 class="phrase">&nbsp;</h2>
<div class="wikiContent">
<p>Educational resources are used in a learning environment to help and assist with people&rsquo;s development and learning. They&rsquo;re designed to reinforce learning and in some cases allow people to put their knowledge to the test. Educational resources are brilliant for teachers and educators to help them deliver the best quality lessons.&nbsp;</p>
</div>
<div class="extraData"><strong>Classic English and Handwriting</strong>&nbsp;- Classic English covers writing and grammar resources for ages 5-11, which are in line with the curriculum aims and topic areas. Twinkl Handwriting is used by EYFS, KS1, KS2 teachers, teaching assistants, home educators, parents and the Pupils themselves. The aim is to help pupils on a journey to progress with their writing resulting in them being able to write fluently, legibly, and with increased speed.
<p>&nbsp;</p>
<ul>
<li><strong>Classic Maths</strong>&nbsp;- Here we have a range of resources that help children with their fluency, reasoning and problem-solving. There&rsquo;s a range of abstract maths activities and games.</li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Classic Topic</strong>&nbsp;- Encompasses core teaching materials covering a wide range of areas that aren&rsquo;t English and Maths. The resources cater for KS1 and KS2 children.</li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Planit&nbsp;- Planit is aimed at KS1 and KS2 teachers. They include resources with great detail and save teachers time researching and creating resources for the lessons, instead, it allows them to focus on how they will deliver the resource to their pupils.</strong></li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Move&nbsp;-&nbsp;Offers primary school teachers in England teaching PE, a scheme that has been written by PE subject leaders which cover all areas of the curriculum.</strong></li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Boost&nbsp;-&nbsp;A range of intervention resources which are created to support and lift learning for SATs, to help children prepare for their Year 2 and Year 6 assessment tests that take place yearly.</strong></li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Inclusion</strong>&nbsp;- Their mission to empower teaching professionals with expert knowledge and materials to help them confidently support any student with individualised needs and create a genuinely inclusive classroom setting.</li>
</ul>
<p><strong>They focus on four different areas:</strong></p>
<ul>
<li>Special Educational Needs &amp; Disabilities</li>
<li>Speech and Language Therapy</li>
<li>English as an Additional Language</li>
<li>Pastoral Support</li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Life and Phonics</strong>&nbsp;- Twinkl life offers a complete, up to date and &lsquo;whole-school&rsquo; tool kit for PSHE, Citizenship and Relationships Education. Phonics is for children at EYFS to KS1 and is targeted for parents, home educators and EYFS Practitioners. Twinkl Phonics enables children to enjoy the journey of reading and writing.</li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Newsroom</strong>&nbsp;- Delivers a trusted feed of the latest headlines, classroom-friendly reports and ready to use National Curriculum resources. They offer balanced, accurate andAge-appropriate content that can safely connect to a class&rsquo; current affairs.</li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>Original and book club</strong>&nbsp;- Aims to enthuse and inspire pupils with engaging stories for EYFS up to KS2. With a variety of characters that are inclusive and representative of the diverse world around us, Twinkl Originals are designed to encourage a love for reading and enhance curriculum wide learning, through the accompanying teacher-made resources.</li>
</ul>
<p>&nbsp;</p>
<ul>
<li><strong>GO!&nbsp;</strong>-&nbsp;Produces interactive games and self-marking resources for all subjects and age ranges from EYFS to KS4. They are designed to be used with a computer or mobile device, meaning they are 100% paperless and can be shared directly over the Internet with children via a simple PIN or creating usernames and passwords.</li>
</ul>
<p>&nbsp;</p>
<p>So why don&rsquo;t you explore one of these products and sample some of our brilliant educational resources to help cut-down on lesson planning and improve engagement levels? Or watch the video below to see further exactly what Twinkl can offer with our range of resources.</p>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (24, 41, N'<header></header>
<p>Many mobile apps need to load resources from a remote URL. You may want to make a POST request to a REST API, or you may need to fetch a chunk of static content from another server.</p>
<h2 id="using-fetch" class="anchor anchorWithStickyNavbar_JmGV">Using Fetch<a class="hash-link" title="Direct link to Using Fetch" href="https://reactnative.dev/docs/network#using-fetch" aria-label="Direct link to Using Fetch">​</a></h2>
<p>React Native provides the&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API" target="_blank" rel="noopener noreferrer">Fetch API</a>&nbsp;for your networking needs. Fetch will seem familiar if you have used&nbsp;<code>XMLHttpRequest</code>&nbsp;or other networking APIs before. You may refer to MDN''s guide on&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch" target="_blank" rel="noopener noreferrer">Using Fetch</a>&nbsp;for additional information.</p>
<h3 id="making-requests" class="anchor anchorWithStickyNavbar_JmGV">Making requests<a class="hash-link" title="Direct link to Making requests" href="https://reactnative.dev/docs/network#making-requests" aria-label="Direct link to Making requests">​</a></h3>
<p>In order to fetch content from an arbitrary URL, you can pass the URL to fetch:</p>
<div class="language-tsx codeBlockContainer_mQmQ theme-code-block">
<div class="codeBlockContent_D5yF">
<pre class="prism-code language-tsx codeBlock_RMoD thin-scrollbar" tabindex="0"><code class="codeBlockLines_AclH"><span class="token-line"><span class="token function">fetch</span><span class="token punctuation">(</span><span class="token string">''https://mywebsite.com/mydata.json''</span><span class="token punctuation">)</span><span class="token punctuation">;</span><br></span></code></pre>
<div class="buttonGroup_aaMX">&nbsp;</div>
</div>
</div>
<p>Fetch also takes an optional second argument that allows you to customize the HTTP request. You may want to specify additional headers, or make a POST request:</p>
<div class="language-tsx codeBlockContainer_mQmQ theme-code-block">
<div class="codeBlockContent_D5yF">
<pre class="prism-code language-tsx codeBlock_RMoD thin-scrollbar" tabindex="0"><code class="codeBlockLines_AclH"><span class="token-line"><span class="token function">fetch</span><span class="token punctuation">(</span><span class="token string">''https://mywebsite.com/endpoint/''</span><span class="token punctuation">,</span> <span class="token punctuation">{</span><br></span><span class="token-line"><span class="token plain">  method</span><span class="token operator">:</span> <span class="token string">''POST''</span><span class="token punctuation">,</span><br></span><span class="token-line"><span class="token plain">  headers</span><span class="token operator">:</span> <span class="token punctuation">{</span><br></span><span class="token-line">    <span class="token maybe-class-name">Accept</span><span class="token operator">:</span> <span class="token string">''application/json''</span><span class="token punctuation">,</span><br></span><span class="token-line">    <span class="token string-property property">''Content-Type''</span><span class="token operator">:</span> <span class="token string">''application/json''</span><span class="token punctuation">,</span><br></span><span class="token-line">  <span class="token punctuation">}</span><span class="token punctuation">,</span><br></span><span class="token-line"><span class="token plain">  body</span><span class="token operator">:</span> <span class="token known-class-name class-name">JSON</span><span class="token punctuation">.</span><span class="token method function property-access">stringify</span><span class="token punctuation">(</span><span class="token punctuation">{</span><br></span><span class="token-line"><span class="token plain">    firstParam</span><span class="token operator">:</span> <span class="token string">''yourValue''</span><span class="token punctuation">,</span><br></span><span class="token-line"><span class="token plain">    secondParam</span><span class="token operator">:</span> <span class="token string">''yourOtherValue''</span><span class="token punctuation">,</span><br></span><span class="token-line">  <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span><br></span><span class="token-line"><span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span><br></span></code></pre>
<div class="buttonGroup_aaMX">&nbsp;</div>
</div>
</div>
<p>Take a look at the&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/API/Request" target="_blank" rel="noopener noreferrer">Fetch Request docs</a>&nbsp;for a full list of properties.</p>
<h3 id="handling-the-response" class="anchor anchorWithStickyNavbar_JmGV">Handling the response<a class="hash-link" title="Direct link to Handling the response" href="https://reactnative.dev/docs/network#handling-the-response" aria-label="Direct link to Handling the response">​</a></h3>
<p>The above examples show how you can make a request. In many cases, you will want to do something with the response.</p>
<p>Networking is an inherently asynchronous operation. Fetch method will return a&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise" target="_blank" rel="noopener noreferrer">Promise</a>&nbsp;that makes it straightforward to write code that works in an asynchronous manner:</p>
<div class="language-tsx codeBlockContainer_mQmQ theme-code-block">
<div class="codeBlockContent_D5yF">
<pre class="prism-code language-tsx codeBlock_RMoD thin-scrollbar" tabindex="0"><code class="codeBlockLines_AclH"><span class="token-line"><span class="token keyword">const</span> <span class="token function-variable function">getMoviesFromApi</span> <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token arrow operator">=&gt;</span> <span class="token punctuation">{</span><br></span><span class="token-line">  <span class="token keyword">return</span> <span class="token function">fetch</span><span class="token punctuation">(</span><span class="token string">''https://reactnative.dev/movies.json''</span><span class="token punctuation">)</span><br></span><span class="token-line">    <span class="token punctuation">.</span><span class="token method function property-access">then</span><span class="token punctuation">(</span><span class="token plain">response </span><span class="token arrow operator">=&gt;</span><span class="token plain"> response</span><span class="token punctuation">.</span><span class="token method function property-access">json</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><br></span><span class="token-line">    <span class="token punctuation">.</span><span class="token method function property-access">then</span><span class="token punctuation">(</span><span class="token plain">json </span><span class="token arrow operator">=&gt;</span> <span class="token punctuation">{</span><br></span><span class="token-line">      <span class="token keyword">return</span><span class="token plain"> json</span><span class="token punctuation">.</span><span class="token property-access">movies</span><span class="token punctuation">;</span><br></span><span class="token-line">    <span class="token punctuation">}</span><span class="token punctuation">)</span><br></span><span class="token-line">    <span class="token punctuation">.</span><span class="token method function property-access">catch</span><span class="token punctuation">(</span><span class="token plain">error </span><span class="token arrow operator">=&gt;</span> <span class="token punctuation">{</span><br></span><span class="token-line">      <span class="token console class-name">console</span><span class="token punctuation">.</span><span class="token method function property-access">error</span><span class="token punctuation">(</span><span class="token plain">error</span><span class="token punctuation">)</span><span class="token punctuation">;</span><br></span><span class="token-line">    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span><br></span><span class="token-line"><span class="token punctuation">}</span><span class="token punctuation">;</span><br></span></code></pre>
<div class="buttonGroup_aaMX">&nbsp;</div>
</div>
</div>
<p>You can also use the&nbsp;<code>async</code>&nbsp;/&nbsp;<code>await</code>&nbsp;syntax in a React Native app:</p>
<div class="language-tsx codeBlockContainer_mQmQ theme-code-block">
<div class="codeBlockContent_D5yF">
<pre class="prism-code language-tsx codeBlock_RMoD thin-scrollbar" tabindex="0"><code class="codeBlockLines_AclH"><span class="token-line"><span class="token keyword">const</span> <span class="token function-variable function">getMoviesFromApiAsync</span> <span class="token operator">=</span> <span class="token keyword">async</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token arrow operator">=&gt;</span> <span class="token punctuation">{</span><br></span><span class="token-line">  <span class="token keyword">try</span> <span class="token punctuation">{</span><br></span><span class="token-line">    <span class="token keyword">const</span><span class="token plain"> response </span><span class="token operator">=</span> <span class="token keyword">await</span> <span class="token function">fetch</span><span class="token punctuation">(</span><br></span><span class="token-line">      <span class="token string">''https://reactnative.dev/movies.json''</span><span class="token punctuation">,</span><br></span><span class="token-line">    <span class="token punctuation">)</span><span class="token punctuation">;</span><br></span><span class="token-line">    <span class="token keyword">const</span><span class="token plain"> json </span><span class="token operator">=</span> <span class="token keyword">await</span><span class="token plain"> response</span><span class="token punctuation">.</span><span class="token method function property-access">json</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span><br></span><span class="token-line">    <span class="token keyword">return</span><span class="token plain"> json</span><span class="token punctuation">.</span><span class="token property-access">movies</span><span class="token punctuation">;</span><br></span><span class="token-line">  <span class="token punctuation">}</span> <span class="token keyword">catch</span> <span class="token punctuation">(</span><span class="token plain">error</span><span class="token punctuation">)</span> <span class="token punctuation">{</span><br></span><span class="token-line">    <span class="token console class-name">console</span><span class="token punctuation">.</span><span class="token method function property-access">error</span><span class="token punctuation">(</span><span class="token plain">error</span><span class="token punctuation">)</span><span class="token punctuation">;</span><br></span><span class="token-line">  <span class="token punctuation">}</span><br></span><span class="token-line"><span class="token punctuation">}</span><span class="token punctuation">;</span></span></code></pre>
</div>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (25, 42, N'<div>
<div class="article-title">
<h1>How to make a Post request from frontend in react-native ?</h1>
</div>
<div class="media"><a href="https://www.geeksforgeeks.org/how-to-make-a-post-request-from-frontend-in-react-native/#article-meta-div">
<div class="badges">
<div>&nbsp;</div>
<div>
<div class="u-name">samiksharanjan</div>
</div>
</div>
</a></div>
</div>
<div class="main_wrapper">
<div id="nav-tab-main"><a class="nav_tab article active">Read</a><a class="nav_tab discuss" data-gfg-action="loadComments">Discuss</a><a id="nav_tab_courses" class="nav_tab courses" data-gfg-action="loadCourses"></a>Courses<a class="nav_tab practice" data-gfg-action="loadPractice">Practice</a></div>
<div class="article-buttons">
<div class="article--viewer_like tooltip">&nbsp;</div>
</div>
</div>
<div class="text">
<p>The POST method is used to send data to the server to create a new resource or modify an existing resource on the server. we cannot make a POST request by using a web browser, as web browsers only directly support GET requests.</p>
<p>But What if we want to develop an application where we need to add some data to the backend or modify existing data whenever the user clicks the button from the UI side? In that case, we have to make a post request from the frontend (For example: On click of a button)</p>
<p>For learning purposes, we generally use tools such as Advanced Rest Client or Postman to Create or add new data.</p>
<p>Generally, whenever an API is triggered from the browser, a GET request is sent and the data is fetched.</p>
<div id="_GFG_ABP_Incontent_728x90"></div>
<p><strong>Prerequisites:</strong></p>
<ul>
<li>Basic knowledge of ReactJS.</li>
<li>Html, CSS, and javascript with ES6 syntax.</li>
<li>Basic knowledge of HTTP methods</li>
<li>NodeJs should be installed in your system.</li>
<li>Jdk and android studio for testing your app on the emulator</li>
</ul>
<p><strong>Approach:</strong>&nbsp;In this article, we will see how to make post requests in react native. We will trigger an API using the fetch method on click of a button and after getting a response from that API, we will show an Alert message. To trigger a Post request from the UI side in react -native, we can send the Request option as a second Parameter.</p>
<p><strong>Creating React Native App:</strong></p>
<p><strong>Step 1:&nbsp;</strong>Create a react-native project :</p>
<pre>npx react-native init DemoProject</pre>
<p><strong>Step 2:&nbsp;</strong>Now install react-native-paper</p>
<pre>npm install react-native-paper</pre>
<p><strong>Step 3:&nbsp;</strong>Start the server</p>
<pre>npx react-native run-android</pre>
<p><strong>Project Structure:&nbsp;</strong>The project should look like this:</p>
<p><img class="aligncenter" src="https://media.geeksforgeeks.org/wp-content/uploads/20220222214841/Capture-144x300.PNG" sizes="100vw" srcset="https://media.geeksforgeeks.org/wp-content/uploads/20220222214841/Capture.PNG," width="144"></p>
<p><strong>Example:</strong>&nbsp;Here, we are sending request options as a second parameter along with the body. This body is handled in API.</p>
<div class="noIdeBtnDiv">
<div class="responsive-tabs-wrapper">
<div class="responsive-tabs responsive-tabs--enabled">
<ul class="responsive-tabs__list" role="tablist">
<li id="tablist1-tab1" class="responsive-tabs__list__item responsive-tabs__list__item--active" tabindex="0" role="tab" aria-controls="tablist1-panel1">PostRequestExample.js</li>
</ul>
<div id="tablist1-panel1" class="tabcontent responsive-tabs__panel responsive-tabs__panel--active" role="tabpanel" aria-hidden="false" aria-labelledby="tablist1-tab1">
<div class="code-block">
<div class="code-gutter">
<div class="editor-buttons-container">
<div class="editor-buttons">
<div class="editor-buttons-div" title="Run and Edit"><em id="copy-code-button" class="gfg-icon gfg-icon_copy code-sidebar-button padding-2px copy-code-button" title="Copy Code"></em>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
</div>
</div>
</div>
<div class="code-container">
<div id="highlighter_787328" class="syntaxhighlighter nogutter night">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="plain">import React, { useState, useEffect } from </code><code class="string">"react"</code><code class="plain">;</code></div>
<div class="line number2 index1 alt1"><code class="plain">import { Text, View, StyleSheet, Alert } from </code><code class="string">''react-native''</code><code class="plain">;</code></div>
<div class="line number3 index2 alt2"><code class="plain">import { Button } from </code><code class="string">"react-native-paper"</code><code class="plain">;</code></div>
<div class="line number4 index3 alt1"><code class="undefined spaces">&nbsp;</code>&nbsp;</div>
<div class="line number5 index4 alt2"><code class="plain">const PostRequestExample = () =&gt; {</code></div>
<div class="line number6 index5 alt1"><code class="undefined spaces">&nbsp;</code>&nbsp;</div>
<div class="line number7 index6 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">const requestOptions = {</code></div>
<div class="line number8 index7 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">method: </code><code class="string">''POST''</code><code class="plain">,</code></div>
<div class="line number9 index8 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">headers: { </code><code class="string">''Content-Type''</code><code class="plain">: </code><code class="string">''application/json''</code> <code class="plain">},</code></div>
<div class="line number10 index9 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">body: JSON.stringify({ postName: </code><code class="string">''React updates ''</code> <code class="plain">})</code></div>
<div class="line number11 index10 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">};</code></div>
<div class="line number12 index11 alt1"><code class="undefined spaces">&nbsp;</code>&nbsp;</div>
<div class="line number13 index12 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">const postExample = async () =&gt; {</code></div>
<div class="line number14 index13 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="keyword">try</code> <code class="plain">{</code></div>
<div class="line number15 index14 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">await fetch(</code></div>
<div class="line number16 index15 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="string">''<a href="https://reqres.in/api/posts">https://reqres.in/api/posts</a>''</code><code class="plain">, requestOptions)</code></div>
<div class="line number17 index16 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">.then(response =&gt; {</code></div>
<div class="line number18 index17 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">response.json()</code></div>
<div class="line number19 index18 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">.then(data =&gt; {</code></div>
<div class="line number20 index19 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">Alert.alert(</code><code class="string">"Post created at : "</code><code class="plain">,&nbsp;</code></div>
<div class="line number21 index20 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">data.createdAt);</code></div>
<div class="line number22 index21 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">});</code></div>
<div class="line number23 index22 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">})</code></div>
<div class="line number24 index23 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">}</code></div>
<div class="line number25 index24 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="keyword">catch</code> <code class="plain">(error) {</code></div>
<div class="line number26 index25 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">console.error(error);</code></div>
<div class="line number27 index26 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">}</code></div>
<div class="line number28 index27 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">}</code></div>
<div class="line number29 index28 alt2"><code class="undefined spaces">&nbsp;</code>&nbsp;</div>
<div class="line number30 index29 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="keyword">return</code> <code class="plain">(</code></div>
<div class="line number31 index30 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">&lt;View style={styles.btn}&gt;</code></div>
<div class="line number32 index31 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">&lt;Button mode=</code><code class="string">"contained"</code> <code class="plain">onPress={postExample} &gt;</code></div>
<div class="line number33 index32 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">Click to make a Post request&lt;/Button&gt;</code></div>
<div class="line number34 index33 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">&lt;/View&gt;</code></div>
<div class="line number35 index34 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">)</code></div>
<div class="line number36 index35 alt1"><code class="undefined spaces">&nbsp;</code>&nbsp;</div>
<div class="line number37 index36 alt2"><code class="plain">}</code></div>
<div class="line number38 index37 alt1"><code class="undefined spaces">&nbsp;</code>&nbsp;</div>
<div class="line number39 index38 alt2"><code class="plain">export </code><code class="keyword">default</code> <code class="plain">PostRequestExample;</code></div>
<div class="line number40 index39 alt1"><code class="undefined spaces">&nbsp;</code>&nbsp;</div>
<div class="line number41 index40 alt2"><code class="plain">const styles = StyleSheet.create({</code></div>
<div class="line number42 index41 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">btn: {</code></div>
<div class="line number43 index42 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">marginTop: 60,</code></div>
<div class="line number44 index43 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">marginLeft: 30,</code></div>
<div class="line number45 index44 alt2"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">marginRight: 30</code></div>
<div class="line number46 index45 alt1"><code class="undefined spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="plain">}</code></div>
<div class="line number47 index46 alt2"><code class="plain">})</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (26, 43, N'<h2 id="setting-up-news-api-account">Setting up a News API account</h2>
<p>To populate our application with news articles, we&rsquo;ll use the&nbsp;<a href="https://newsapi.org/">News API</a>&nbsp;as our backend. The News API provides us with a REST API that we can use to get the latest, breaking news headlines from all around the world.</p>
<p>Before you can begin using the News API, you need to get an API token from the website. Go to the&nbsp;<a href="https://newsapi.org/docs/get-started"><strong>G</strong></a><a href="https://newsapi.org/docs/get-started"><strong>et started</strong></a>&nbsp;page and click on&nbsp;<strong>Get API Key</strong>. Once you click the button, you&rsquo;ll be redirected to the registration page. After filling in your details on the page and registering successfully, you can get your API token. Now,&nbsp;let&rsquo;s take the API for a spin and&nbsp;<a href="https://newsapi.org/docs">test everything it has to offer</a>.</p>
<p>To test the API, we&rsquo;ll use Postman, but you can use the API platform of your choice. Alternately, you can simply use curl in your terminal. You can either use the standalone Postman application on your OS, or simply use the web app, which is what I prefer.</p>
<p>For&nbsp;<code class=" prettyprinted"><span class="typ">Feed</span></code>, we&rsquo;ll use the&nbsp;<a href="https://newsapi.org/docs/endpoints/top-headlines">top headlines endpoint</a>, so let&rsquo;s test it first:</p>
<p><img class="aligncenter wp-image-115618 size-full jetpack-lazy-image jetpack-lazy-image--handled" src="https://blog.logrocket.com/wp-content/uploads/2022/06/top-headlines-endpoint.png" sizes="(max-width: 730px) 100vw, 730px" srcset="https://blog.logrocket.com/wp-content/uploads/2022/06/top-headlines-endpoint.png 730w, https://blog.logrocket.com/wp-content/uploads/2022/06/top-headlines-endpoint.png?resize=300,182 300w" alt="Top Headlines Endpoint" width="730" height="443" loading="eager" data-attachment-id="115618" data-permalink="https://blog.logrocket.com/create-news-feed-react-native/top-headlines-endpoint/" data-orig-file="https://blog.logrocket.com/wp-content/uploads/2022/06/top-headlines-endpoint.png" data-orig-size="730,443" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="top-headlines-endpoint" data-image-description="" data-image-caption="" data-medium-file="https://blog.logrocket.com/wp-content/uploads/2022/06/top-headlines-endpoint.png?w=300" data-large-file="https://blog.logrocket.com/wp-content/uploads/2022/06/top-headlines-endpoint.png?w=730" data-lazy-loaded="1"></p>
<p>We&rsquo;re using the following URL:</p>
<pre class="language-txt prettyprinted"><span class="pln">https</span><span class="pun">:</span><span class="com">//newsapi.org/v2/top-headlines?category=technology&amp;language=en</span></pre>
<p>We are passing two query parameters to the URL:</p>
<ul>
<li><code class=" prettyprinted"><span class="pln">category</span><span class="pun">=</span><span class="pln">technology</span></code>: Gets all the top headlines in the technology category</li>
<li><code class=" prettyprinted"><span class="pln">language</span><span class="pun">=</span><span class="pln">en</span></code>: Ensures we only get news articles written in English</li>
</ul>
<p>Each call to a News API URL must contain an&nbsp;<code class=" prettyprinted"><span class="pln">apiKey</span></code>, which is used to authenticate the user who is sending the request and for analytics purposes.</p>
<p>We can add our API key&nbsp;in an API call in one of two ways. For one, you can directly send it as a query param in the URL itself:</p>
<pre class="prettyprinted hljs cpp"><span class="pln">https</span><span class="pun">:</span><span class="com"><span class="hljs-comment">//newsapi.org/v2/top-headlines?category=technology&amp;language=en&amp;apiKey=&lt;YOUR_API_KEY&gt;</span></span></pre>
<p>However, this method is not secure, and&nbsp;therefore is not recommended. But, you can use it for testing. Alternately, we can try sending&nbsp;<code class=" prettyprinted"><span class="pln">API_KEY</span></code>&nbsp;inside the request header using the&nbsp;<code class=" prettyprinted"><span class="pln">X</span><span class="pun">-</span><span class="typ">Api</span><span class="pun">-</span><span class="pln">key</span></code>. If you&rsquo;re using curl, you could add a request header like the one below:</p>
<pre class="prettyprinted hljs nginx"><span class="pln"> <span class="hljs-attribute">curl</span> https</span><span class="pun">:</span><span class="com">//newsapi.org/v2/top-headlines?category=technology&amp;language=en</span>
   <span class="pun">-</span><span class="pln">H </span><span class="str"><span class="hljs-string">"X-Api-key: &lt;YOUR_API_KEY&gt;"</span></span></pre>
<p>If you&rsquo;re using Postman, then simply go to the&nbsp;<code class=" prettyprinted"><strong><span class="typ">Headers</span></strong></code>&nbsp;tab of&nbsp;<code class=" prettyprinted"><span class="pln">request</span></code>&nbsp;and add a&nbsp;<code class=" prettyprinted"><span class="pln">key</span></code>&nbsp;and&nbsp;<code class=" prettyprinted"><span class="kwd">value</span></code>, like in the screenshot above.</p>
<p>Now that we have a response object from our API, let&rsquo;s analyze it and see what it provides for us.&nbsp;The response has an&nbsp;<code class=" prettyprinted"><span class="pln">articles</span></code>&nbsp;key, which is an array of&nbsp;<code class=" prettyprinted"><span class="pln">objects</span></code>&nbsp;where each object is a news article.</p>
<p>A sample of a&nbsp;<code class=" prettyprinted"><span class="pln">news</span></code>&nbsp;object is given below:</p>
<pre class="prettyprinted hljs json"><span class="pun">{</span>
    <span class="str"><span class="hljs-attr">"source"</span></span><span class="pun">:</span> <span class="pun">{</span>
        <span class="str"><span class="hljs-attr">"id"</span></span><span class="pun">:</span> <span class="kwd"><span class="hljs-literal">null</span></span><span class="pun">,</span>
        <span class="str"><span class="hljs-attr">"name"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"digitalspy.com"</span></span>
    <span class="pun">},</span>
    <span class="str"><span class="hljs-attr">"author"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"Joe Anderton"</span></span><span class="pun">,</span>
    <span class="str"><span class="hljs-attr">"title"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"Walking Dead''s Norman Reedus reveals Death Stranding 2 existence - Digital Spy"</span></span><span class="pun">,</span>
    <span class="str"><span class="hljs-attr">"description"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"The Walking Dead star Norman Reedus reveals Death Stranding 2 existence."</span></span><span class="pun">,</span>
    <span class="str"><span class="hljs-attr">"url"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"https://www.digitalspy.com/tech/a40064850/walking-dead-norman-reedus-death-stranding-2/"</span></span><span class="pun">,</span>
    <span class="str"><span class="hljs-attr">"urlToImage"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"https://hips.hearstapps.com/digitalspyuk.cdnds.net/16/28/1468254183-screen-shot-2016-07-11-at-171152.jpg?crop=1xw:0.8929577464788733xh;center,top&amp;resize=1200:*"</span></span><span class="pun">,</span>
    <span class="str"><span class="hljs-attr">"publishedAt"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"2022-05-21T10:12:41Z"</span></span><span class="pun">,</span>
    <span class="str"><span class="hljs-attr">"content"</span></span><span class="pun">:</span> <span class="str"><span class="hljs-string">"The Walking Dead star Norman Reedus has seemingly revealed the existence of Death Stranding 2.\r\nThe actor played leading character Sam Porter Bridges in the PlayStation and PC game from Metal Gear So&hellip; [+2088 chars]"</span></span>
<span class="pun">}</span></pre>
<p>As you can see, we get a lot of data for a single news article, but we&rsquo;ll use&nbsp;<code class=" prettyprinted"><span class="pln">title</span></code>,&nbsp;<code class=" prettyprinted"><span class="pln">url</span></code>,&nbsp;<code class=" prettyprinted"><span class="pln">urlToImage</span></code>,&nbsp;<code class=" prettyprinted"><span class="pln">publishedAt</span></code>, and&nbsp;<code class=" prettyprinted"><span class="pln">content</span></code>. Now that our backend is all set up, let&rsquo;s start working on the mobile app.</p>
<h2 id="application-preview">Application preview</h2>
<p>Before we actually write the code for our app, let&rsquo;s discuss the features we want to build. First, we&rsquo;ll need a home screen or feed where we&rsquo;ll show all the latest news articles.&nbsp;At the top of the list, there will be a horizontal list of news category tags, which, when selected, will load news for that specific category.</p>
<p>We&rsquo;ll need a search bar at the top of the screen that the user can use to search news using a specific keyword. We&rsquo;ll also implement shared transition navigation. When the user clicks on any news articles, the&nbsp;<code class=" prettyprinted"><span class="typ">NewsDetail</span></code>&nbsp;screen will appear.</p>
<p>We&rsquo;ll use Redux to manage state in our application. We want to persist the data between application lifecycles, so we&rsquo;ll use&nbsp;<a href="https://github.com/rt2zz/redux-persist">Redux Persist</a>.</p>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (27, 46, N'<h1 id="pageTitle">About Objective-C</h1>
<p><a name="//apple_ref/doc/uid/TP40011210-CH1-DontLinkElementID_1"></a></p>
<p>Objective-C is the primary programming language you use when writing software for OS X and iOS. It&rsquo;s a superset of the C programming language and provides object-oriented capabilities and a dynamic runtime. Objective-C inherits the syntax, primitive types, and flow control statements of C and adds syntax for defining classes and methods. It also adds language-level support for object graph management and object literals while providing dynamic typing and binding, deferring many responsibilities until runtime.</p>
<p><a title="At a Glance" name="//apple_ref/doc/uid/TP40011210-CH1-DontLinkElementID_2"></a></p>
<h2 class="jump">At a Glance</h2>
<p>This document introduces the Objective-C language and offers extensive examples of its use. You&rsquo;ll learn how to create your own classes describing custom objects and see how to work with some of the framework classes provided by Cocoa and Cocoa Touch. Although the framework classes are separate from the language, their use is tightly wound into coding with Objective-C and many language-level features rely on behavior offered by these classes.</p>
<section><a title="An App Is Built from a Network of Objects" name="//apple_ref/doc/uid/TP40011210-CH1-SW2"></a>
<h3>An App Is Built from a Network of Objects</h3>
<p>When building apps for OS X or iOS, you&rsquo;ll spend most of your time working with objects. Those objects are instances of Objective-C classes, some of which are provided for you by Cocoa or Cocoa Touch and some of which you&rsquo;ll write yourself.</p>
<p>If you&rsquo;re writing your own class, start by providing a description of the class that details the intended public interface to instances of the class. This interface includes the public properties to encapsulate relevant data, along with a list of methods. Method declarations indicate the messages that an object can receive, and include information about the parameters required whenever the method is called. You&rsquo;ll also provide a class implementation, which includes the executable code for each method declared in the interface.</p>
<div class="notebox">
<aside><a title="Relevant Chapters" name="//apple_ref/doc/uid/TP40011210-CH1-SW3"></a>
<p><strong>Relevant Chapters:</strong>&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/DefiningClasses/DefiningClasses.html#//apple_ref/doc/uid/TP40011210-CH3-SW1" data-renderer-version="1">Defining Classes</a></span>,&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithObjects/WorkingwithObjects.html#//apple_ref/doc/uid/TP40011210-CH4-SW1" data-renderer-version="1">Working with Objects</a></span>,&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/EncapsulatingData/EncapsulatingData.html#//apple_ref/doc/uid/TP40011210-CH5-SW1" data-renderer-version="1">Encapsulating Data</a></span></p>
<p>&nbsp;</p>
</aside>
</div>
</section>
<section><a title="Categories Extend Existing Classes" name="//apple_ref/doc/uid/TP40011210-CH1-SW14"></a>
<h3>Categories Extend Existing Classes</h3>
<p>Rather than creating an entirely new class to provide minor additional capabilities over an existing class, it&rsquo;s possible to define a category to add custom behavior to an existing class. You can use a category to add methods to any class, including classes for which you don&rsquo;t have the original implementation source code, such as framework classes like&nbsp;<code>NSString</code>.</p>
<p>If you do have the original source code for a class, you can use a class extension to add new properties, or modify the attributes of existing properties. Class extensions are commonly used to hide private behavior for use either within a single source code file, or within the private implementation of a custom framework.</p>
<div class="notebox">
<aside><a title="Relevant Chapters" name="//apple_ref/doc/uid/TP40011210-CH1-SW15"></a>
<p><strong>Relevant Chapters:</strong>&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html#//apple_ref/doc/uid/TP40011210-CH6-SW1" data-renderer-version="1">Customizing Existing Classes</a></span></p>
<p>&nbsp;</p>
</aside>
</div>
</section>
<section><a title="Protocols Define Messaging Contracts" name="//apple_ref/doc/uid/TP40011210-CH1-SW4"></a>
<h3>Protocols Define Messaging Contracts</h3>
<p>The majority of work in an Objective-C app occurs as a result of objects sending messages to each other. Often, these messages are defined by the methods declared explicitly in a class interface. Sometimes, however, it is useful to be able to define a set of related methods that aren&rsquo;t tied directly to a specific class.</p>
<p>Objective-C uses protocols to define a group of related methods, such as the methods an object might call on its&nbsp;<span class="pediaLink" data-header="Delegation" data-contents="Delegation is a simple and powerful pattern in which one object in a program acts on behalf of, or in coordination with, another object. "><a target="_self" data-renderer-version="1" data-href="../../../../General/Conceptual/DevPedia-CocoaCore/Delegation.html#//apple_ref/doc/uid/TP40008195-CH14">delegate</a></span>, which are either optional or required. Any class can indicate that it adopts a protocol, which means that it must also provide implementations for all of the required methods in the protocol.</p>
<div class="notebox">
<aside><a title="Relevant Chapters" name="//apple_ref/doc/uid/TP40011210-CH1-SW5"></a>
<p><strong>Relevant Chapters:</strong>&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithProtocols/WorkingwithProtocols.html#//apple_ref/doc/uid/TP40011210-CH11-SW1" data-renderer-version="1">Working with Protocols</a></span></p>
<p>&nbsp;</p>
</aside>
</div>
</section>
<section><a title="Values and Collections Are Often Represented as Objective-C Objects" name="//apple_ref/doc/uid/TP40011210-CH1-SW6"></a>
<h3>Values and Collections Are Often Represented as Objective-C Objects</h3>
<p>It&rsquo;s common in Objective-C to use Cocoa or Cocoa Touch classes to represent values. The&nbsp;<code>NSString</code>&nbsp;class is used for strings of characters, the&nbsp;<code>NSNumber</code>&nbsp;class for different types of numbers such as integer or floating point, and the&nbsp;<code>NSValue</code>&nbsp;class for other values such as C structures. You can also use any of the primitive types defined by the C language, such as&nbsp;<code>int</code>,&nbsp;<code>float</code>&nbsp;or&nbsp;<code>char</code>.</p>
<p>Collections are usually represented as instances of one of the collection classes, such as&nbsp;<code>NSArray</code>,&nbsp;<code>NSSet</code>, or&nbsp;<code>NSDictionary</code>, which are each used to collect other Objective-C objects.</p>
<div class="notebox">
<aside><a title="Relevant Chapters" name="//apple_ref/doc/uid/TP40011210-CH1-SW7"></a>
<p><strong>Relevant Chapters:</strong>&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/FoundationTypesandCollections/FoundationTypesandCollections.html#//apple_ref/doc/uid/TP40011210-CH7-SW1" data-renderer-version="1">Values and Collections</a></span></p>
<p>&nbsp;</p>
</aside>
</div>
</section>
<section><a title="Blocks Simplify Common Tasks" name="//apple_ref/doc/uid/TP40011210-CH1-SW8"></a>
<h3>Blocks Simplify Common Tasks</h3>
<p>Blocks are a language feature introduced to C, Objective-C and C++ to represent a unit of work; they encapsulate a block of code along with captured state, which makes them similar to closures in other programming languages. Blocks are often used to simplify common tasks such as collection enumeration, sorting and testing. They also make it easy to schedule tasks for concurrent or asynchronous execution using technologies like Grand Central Dispatch (GCD).</p>
<div class="notebox">
<aside><a title="Relevant Chapters" name="//apple_ref/doc/uid/TP40011210-CH1-SW9"></a>
<p><strong>Relevant Chapters:</strong>&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html#//apple_ref/doc/uid/TP40011210-CH8-SW1" data-renderer-version="1">Working with Blocks</a></span></p>
<p>&nbsp;</p>
</aside>
</div>
</section>
<section><a title="Error Objects Are Used for Runtime Problems" name="//apple_ref/doc/uid/TP40011210-CH1-SW10"></a>
<h3>Error Objects Are Used for Runtime Problems</h3>
<p>Although Objective-C includes syntax for exception handling, Cocoa and Cocoa Touch use exceptions only for programming errors (such as out of bounds array access), which should be fixed before an app is shipped.</p>
<p>All other errors&mdash;including runtime problems such as running out of disk space or not being able to access a web service&mdash;are represented by instances of the&nbsp;<code>NSError</code>&nbsp;class. Your app should plan for errors and decide how best to handle them in order to present the best possible user experience when something goes wrong.</p>
<div class="notebox">
<aside><a title="Relevant Chapters" name="//apple_ref/doc/uid/TP40011210-CH1-SW11"></a>
<p><strong>Relevant Chapters:</strong>&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/ErrorHandling/ErrorHandling.html#//apple_ref/doc/uid/TP40011210-CH9-SW1" data-renderer-version="1">Dealing with Errors</a></span></p>
<p>&nbsp;</p>
</aside>
</div>
</section>
<section><a title="Objective-C Code Follows Established Conventions" name="//apple_ref/doc/uid/TP40011210-CH1-SW12"></a>
<h3>Objective-C Code Follows Established Conventions</h3>
<p>When writing Objective-C code, you should keep in mind a number of established coding conventions. Method names, for example, start with a lowercase letter and use camel case for multiple words; for example,&nbsp;<code>doSomething</code>&nbsp;or&nbsp;<code>doSomethingElse</code>. It&rsquo;s not just the capitalization that&rsquo;s important, though; you should also make sure that your code is as readable as possible, which means that method names should be expressive, but not too verbose.</p>
<p>In addition, there are a few conventions that are required if you wish to take advantage of language or framework features. Property accessor methods, for example, must follow strict naming conventions in order to work with technologies like&nbsp;<span class="pediaLink" data-header="Key-value coding" data-contents="Key-value coding is a mechanism for indirectly accessing an object&rsquo;s attributes and relationships using string identifiers. "><a target="_self" data-renderer-version="1" data-href="../../../../General/Conceptual/DevPedia-CocoaCore/KeyValueCoding.html#//apple_ref/doc/uid/TP40008195-CH25">Key-Value Coding</a></span>&nbsp;(KVC) or&nbsp;<span class="pediaLink" data-header="Key-value observing" data-contents="Key-value observing is a mechanism that enables an object to be notified directly when a property of another object changes. "><a target="_self" data-renderer-version="1" data-href="../../../../General/Conceptual/DevPedia-CocoaCore/KVO.html#//apple_ref/doc/uid/TP40008195-CH16">Key-Value Observing</a></span>&nbsp;(KVO).</p>
<div class="notebox">
<aside><a title="Relevant Chapters" name="//apple_ref/doc/uid/TP40011210-CH1-SW13"></a>
<p><strong>Relevant Chapters:</strong>&nbsp;<span class="content_text"><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Conventions/Conventions.html#//apple_ref/doc/uid/TP40011210-CH10-SW1" data-renderer-version="1">Conventions</a></span></p>
<p>&nbsp;</p>
</aside>
</div>
</section>
<p><a title="Prerequisites" name="//apple_ref/doc/uid/TP40011210-CH1-DontLinkElementID_4"></a></p>
<h2 class="jump">Prerequisites</h2>
<p>If you are new to OS X or iOS development, you should read through&nbsp;<em><a href="https://developer.apple.com/library/archive/referencelibrary/GettingStarted/RoadMapiOS-Legacy/index.html#//apple_ref/doc/uid/TP40011343" target="_self" data-renderer-version="1">Start Developing iOS Apps Today (Retired)</a></em>&nbsp;or&nbsp;<em><a href="https://developer.apple.com/library/archive/referencelibrary/GettingStarted/RoadMapOSX/index.html#//apple_ref/doc/uid/TP40012262" target="_self" data-renderer-version="1">Start Developing Mac Apps Today</a></em>&nbsp;before reading this document, to get a general overview of the application development process for iOS and OS X. Additionally, you should become familiar with Xcode before trying to follow the exercises at the end of most chapters in this document. Xcode is the IDE used to build apps for iOS and OS X; you&rsquo;ll use it to write your code, design your app''s user interface, test your application, and debug any problems.</p>
<p>Although it&rsquo;s preferable to have some familiarity with C or one of the C-based languages such as Java or C#, this document does include inline examples of basic C language features such as flow control statements. If you have knowledge of another higher-level programming language, such as Ruby or Python, you should be able to follow the content.</p>
<p>Reasonable coverage is given to general object-oriented programming principles, particularly as they apply in the context of Objective-C, but it is assumed that you have at least a minimal familiarity with basic object-oriented concepts. If you&rsquo;re not familiar with these concepts, you should read the relevant chapters in&nbsp;<em><a href="https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010810" target="_self" data-renderer-version="1">Concepts in Objective-C Programming</a></em>.</p>
<div id="introSeeAlsoSection"><a title="See Also" name="//apple_ref/doc/uid/TP40011210-CH1-DontLinkElementID_3"></a>
<h2 class="jump">See Also</h2>
<p>The content in this document applies to Xcode 4.4 or later and assumes you are targeting either OS X v10.7 or later, or iOS 5 or later. For more information about Xcode, see&nbsp;<em><a href="https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/index.html#//apple_ref/doc/uid/TP40010215" target="_self" data-renderer-version="2">Xcode Overview</a></em>. For information on language feature availability, see&nbsp;<em><a href="https://developer.apple.com/library/archive/releasenotes/ObjectiveC/ObjCAvailabilityIndex/index.html#//apple_ref/doc/uid/TP40012243" target="_self" data-renderer-version="2">Objective-C Feature Availability Index</a></em>.</p>
<p>Objective-C apps use reference counting to determine the lifetime of objects. For the most part, the Automatic Reference Counting (ARC) feature of the compiler takes care of this for you. If you are unable to take advantage of ARC, or need to convert or maintain legacy code that manages an object&rsquo;s memory manually, you should read&nbsp;<em><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/MemoryMgmt.html#//apple_ref/doc/uid/10000011i" target="_self" data-renderer-version="1">Advanced Memory Management Programming Guide</a></em>.</p>
<p>In addition to the compiler, the Objective-C language uses a runtime system to enable its dynamic and object-oriented features. Although you don&rsquo;t usually need to worry about how Objective-C &ldquo;works,&rdquo; it&rsquo;s possible to interact directly with this runtime system, as described by&nbsp;<em><a href="https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048" target="_self" data-renderer-version="1">Objective-C Runtime Programming Guide</a></em>&nbsp;and&nbsp;<em><a class="urlLink" href="https://developer.apple.com/documentation/objectivec/objective_c_runtime" target="_self">Objective-C Runtime Reference</a></em>.</p>
</div>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (28, 47, N'<p>Objective-C is an object-oriented programming language.</p>
<p>It is the main programming language used by Apple for the OS X and iOS operating systems and their respective APIs, Cocoa and Cocoa Touch.</p>
<h2 id="Example_Code">Example Code</h2>
<pre>#import &lt;Foundation/Foundation.h&gt;

int main (int argc, <span class="r">const</span> char * argv[])
{
   NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

   NSLog (@<span class="q">"hello world"</span>);
   [pool drain];
   return 0;
}
</pre>
<div><br><br><br><br></div>
<h2 id="Foundation_Framework">Foundation Framework</h2>
<p>The following line in the code above include the foundation framework into our code.</p>
<pre>#import &lt;Foundation/Foundation.h&gt;
</pre>
<p>Foundation Framework has libraries and features we can use.</p>
<p>It includes a list of extended datatypes like NSArray, NSDictionary, NSSet and so on.</p>
<p>Foundation Framework has a set of functions we can use to manipulate files, strings, etc.</p>
<p>We can also use Foundation Framework to do URL handling, date formatting, data handling, error handling, etc.</p>
<h2 id="File_name_extension">File name extension</h2>
<p>Objective-C source files use&nbsp;<code>.m</code>&nbsp;as extension.</p>
<p>The following table lists other commonly used filename extensions.</p>
<table class="table table-bordered">
<tbody>
<tr>
<th>Extension</th>
<th>Meaning</th>
</tr>
<tr>
<td>.c</td>
<td>C language source file</td>
</tr>
<tr>
<td>.cc, .cpp</td>
<td>C++ language source file</td>
</tr>
<tr>
<td>.h</td>
<td>Header file</td>
</tr>
<tr>
<td>.m</td>
<td>Objective-C source file</td>
</tr>
<tr>
<td>.mm</td>
<td>Objective-C++ source file</td>
</tr>
<tr>
<td>.o</td>
<td>Object (compiled) file</td>
</tr>
</tbody>
</table>')
GO
INSERT [dbo].[Docs] ([id], [lessons], [content])
VALUES (29, 48, N'<h2 id="1-swift-va-objective-c" class="ftwp-heading">1. Swift and Objective C</h2>
<p>Swift and Objective-C are two languages in iOS programming.</p>
<p>Objective-C was born before Swift and has a history of development with many applications.</p>
<p>Swift was later developed to replace Objective-C. Swift also comes with visual programming tools. Therefore, wherever you go, you will always see it, which will help a lot for programmers, saving debugging effort.</p>
<p>However, Swift has not been able to immediately replace Objective C.</p>
<h2 id="2-cac-uu-diem-cua-swift-so-voi-objective-c" class="ftwp-heading">2. Advantages of Swift over Objective C</h2>
<ul>
<li>Swift runs faster, equivalent to C++<br>Swift is easier to read and learn than Objective-C (brand new syntax, much more concise)<br>Files in Swift unified neenvieecj simpler code maintenance.<br>Swift''s compiler is better than Objective''s<br>Swift not using pointers makes code safer, and helps programmers get rid of the tricky concept of pointers.<br>Swift better memory management<br>Swift is open source: Programmers can view the source code, edit it, and patch it.</li>
</ul>
<h2 id="3-nhuoc-diem-cua-swift-so-voi-objective-c" class="ftwp-heading">3. Disadvantages of Swift compared to OLD Objective</h2>
<ul>
<li>
<p>Many APIs don''t work with Swift<br>Many rules for initialization, optional type selection<br>A large number of previous projects and software were written in Objective C, so Objective C.</p>
<p>In short, although there are some disadvantages, Swift is completely superior to Objective C. In the case of old and small projects, you can completely combine these two languages.</p>
<p>If you''ve programmed with both C and Python, you''ll find Objective C is like C and Swift is like Python. Swift omits a lot of complicated and confusing syntax.</p>
</li>
</ul>')
GO
SET IDENTITY_INSERT [dbo].[Docs] OFF
GO
SET IDENTITY_INSERT [dbo].[File] ON
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (1, 5, N'/SWP391_Group3/images/lesson/1687800487553_JavaScrip.pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (2, 9, N'/SWP391_Group3/images/lesson/1687800511230_C#.pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (3, 14, N'/SWP391_Group3/images/lesson/1687800437079_C .pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (4, 19, N'/SWP391_Group3/images/lesson/1687800450624_C++.pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (5, 24, N'/SWP391_Group3/images/lesson/1687800462727_Python .pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (7, 30, N'/SWP391_Group3/images/lesson/1687963582169_6S191_MIT_DeepLearning_L7.pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (8, 34, N'/SWP391_Group3/images/lesson/1687964158687_AI-4-Everyone.pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (9, 39, N'/SWP391_Group3/images/lesson/1687964610220_Google AI education.pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (10, 44, N'/SWP391_Group3/images/lesson/1687965238980_react native.pdf')
GO
INSERT [dbo].[File] ([id], [lessons], [file_name])
VALUES (11, 49, N'/SWP391_Group3/images/lesson/1687965663672_ObjC.pdf')
GO
SET IDENTITY_INSERT [dbo].[File] OFF
GO
GO
INSERT INTO SWP_V1.dbo.enrollments (user_id, course_id, price, enrolled_at)
VALUES (1, 1, 1000000, N'2023-07-11'),
       (1, 2, 500000, N'2023-07-11'),
       (1, 3, 1000000, N'2023-06-11'),
       (1, 4, 500000, N'2023-06-11'),
       (1, 5, 500000, N'2023-07-11'),
       (2, 1, 1000000, N'2023-05-11'),
       (2, 2, 500000, N'2023-05-11'),
       (3, 2, 500000, N'2023-04-11'),
       (3, 3, 500000, N'2023-03-11'),
       (4, 2, 500000, N'2023-02-11')
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
       (4, 1, 3, 'The course had some good information but there were a lot of technical difficulties.'),
       (5, 1, 3, 'The course had some good information but there were a lot of technical difficulties.'),
       (6, 1, 3, 'The course had some good information but there were a lot of technical difficulties.'),
       (4, 2, 4, 'I found this course very helpful for my job.'),
       (5, 3, 2, 'This course was a waste of money. I did not learn anything new.');
