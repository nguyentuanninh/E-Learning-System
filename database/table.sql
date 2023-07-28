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
    created_date date default getdate() not null,
	modified_date date,
	approve_date date ,
    [image]        varchar(100),
    Parent_id    int,
	Created_By int references admin_account(id),
	Modified_By int references admin_account(id),
    NewsGroup   int references NewsGroup (id)
)