/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     5/10/2026 5:14:31 AM                         */
/*==============================================================*/
-- create database MediaProduction  - run this first to create the database firstly
-- use MediaProduction              - then run this to use the database
if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROFESSIONAL') and o.name = 'FK_PROFESSI_HAVE_A_SKILLS')
alter table PROFESSIONAL
   drop constraint FK_PROFESSI_HAVE_A_SKILLS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SESSION') and o.name = 'FK_SESSION_HAS_PROJECT')
alter table SESSION
   drop constraint FK_SESSION_HAS_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SESSION') and o.name = 'FK_SESSION_HAVE_STUDIO')
alter table SESSION
   drop constraint FK_SESSION_HAVE_STUDIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SESSION_EQUIP') and o.name = 'FK_SESSION__SESSION_E_EQUIPMEN')
alter table SESSION_EQUIP
   drop constraint FK_SESSION__SESSION_E_EQUIPMEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SESSION_EQUIP') and o.name = 'FK_SESSION__SESSION_E_SESSION')
alter table SESSION_EQUIP
   drop constraint FK_SESSION__SESSION_E_SESSION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SESSION_EQUIP') and o.name = 'FK_SESSION__SESSION_E_PROFESSI')
alter table SESSION_EQUIP
   drop constraint FK_SESSION__SESSION_E_PROFESSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WORK_ON') and o.name = 'FK_WORK_ON_WORK_ON_SESSION')
alter table WORK_ON
   drop constraint FK_WORK_ON_WORK_ON_SESSION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WORK_ON') and o.name = 'FK_WORK_ON_WORK_ON2_PROFESSI')
alter table WORK_ON
   drop constraint FK_WORK_ON_WORK_ON2_PROFESSI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EQUIPMENT')
            and   type = 'U')
   drop table EQUIPMENT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROFESSIONAL')
            and   name  = 'HAVE_A_FK'
            and   indid > 0
            and   indid < 255)
   drop index PROFESSIONAL.HAVE_A_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROFESSIONAL')
            and   type = 'U')
   drop table PROFESSIONAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT')
            and   type = 'U')
   drop table PROJECT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SESSION')
            and   name  = 'HAVE_FK'
            and   indid > 0
            and   indid < 255)
   drop index SESSION.HAVE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SESSION')
            and   name  = 'HAS_FK'
            and   indid > 0
            and   indid < 255)
   drop index SESSION.HAS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SESSION')
            and   type = 'U')
   drop table SESSION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SESSION_EQUIP')
            and   name  = 'SESSION_EQUIP3_FK'
            and   indid > 0
            and   indid < 255)
   drop index SESSION_EQUIP.SESSION_EQUIP3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SESSION_EQUIP')
            and   name  = 'SESSION_EQUIP2_FK'
            and   indid > 0
            and   indid < 255)
   drop index SESSION_EQUIP.SESSION_EQUIP2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SESSION_EQUIP')
            and   name  = 'SESSION_EQUIP_FK'
            and   indid > 0
            and   indid < 255)
   drop index SESSION_EQUIP.SESSION_EQUIP_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SESSION_EQUIP')
            and   type = 'U')
   drop table SESSION_EQUIP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SKILLS')
            and   type = 'U')
   drop table SKILLS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('STUDIO')
            and   type = 'U')
   drop table STUDIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('WORK_ON')
            and   name  = 'WORK_ON2_FK'
            and   indid > 0
            and   indid < 255)
   drop index WORK_ON.WORK_ON2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('WORK_ON')
            and   name  = 'WORK_ON_FK'
            and   indid > 0
            and   indid < 255)
   drop index WORK_ON.WORK_ON_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WORK_ON')
            and   type = 'U')
   drop table WORK_ON
go

/*==============================================================*/
/* Table: EQUIPMENT                                             */
/*==============================================================*/
create table EQUIPMENT (
   EQ_ID                int                  not null,
   SERIAL_NUM           varchar(50)          not null,
   EQ_TYPE              varchar(50)          not null,
   STATUS               varchar(50)          not null,
   constraint PK_EQUIPMENT primary key (EQ_ID)
)
go

/*==============================================================*/
/* Table: PROFESSIONAL                                          */
/*==============================================================*/
create table PROFESSIONAL (
   PROFESSIONAL_ID      int                  not null,
   SKILL_ID             int                  not null,
   PRO_NAME             varchar(50)          not null,
   ROLE                 varchar(50)          not null,
   constraint PK_PROFESSIONAL primary key (PROFESSIONAL_ID)
)
go

/*==============================================================*/
/* Index: HAVE_A_FK                                             */
/*==============================================================*/




create nonclustered index HAVE_A_FK on PROFESSIONAL (SKILL_ID ASC)
go

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   ID                   int                  not null,
   TITLE                varchar(50)          not null,
   BUDGET               float(50)            not null,
   DEADLINE             datetime             not null,
   constraint PK_PROJECT primary key (ID)
)
go

/*==============================================================*/
/* Table: SESSION                                               */
/*==============================================================*/
create table SESSION (
   SESS_ID              int                  not null,
   ID                   int                  not null,
   ID_STUDIO            int                  not null,
   SESS_DATE            datetime             null,
   constraint PK_SESSION primary key (SESS_ID)
)
go

/*==============================================================*/
/* Index: HAS_FK                                                */
/*==============================================================*/




create nonclustered index HAS_FK on SESSION (ID ASC)
go

/*==============================================================*/
/* Index: HAVE_FK                                               */
/*==============================================================*/




create nonclustered index HAVE_FK on SESSION (ID_STUDIO ASC)
go

/*==============================================================*/
/* Table: SESSION_EQUIP                                         */
/*==============================================================*/
create table SESSION_EQUIP (
   EQ_ID                int                  not null,
   SESS_ID              int                  not null,
   PROFESSIONAL_ID      int                  not null,
   RETURN_CONDITION     varchar(50)          null,
   constraint PK_SESSION_EQUIP primary key (EQ_ID, SESS_ID, PROFESSIONAL_ID)
)
go

/*==============================================================*/
/* Index: SESSION_EQUIP_FK                                      */
/*==============================================================*/




create nonclustered index SESSION_EQUIP_FK on SESSION_EQUIP (EQ_ID ASC)
go

/*==============================================================*/
/* Index: SESSION_EQUIP2_FK                                     */
/*==============================================================*/




create nonclustered index SESSION_EQUIP2_FK on SESSION_EQUIP (SESS_ID ASC)
go

/*==============================================================*/
/* Index: SESSION_EQUIP3_FK                                     */
/*==============================================================*/




create nonclustered index SESSION_EQUIP3_FK on SESSION_EQUIP (PROFESSIONAL_ID ASC)
go

/*==============================================================*/
/* Table: SKILLS                                                */
/*==============================================================*/
create table SKILLS (
   SKILL_ID             int                  not null,
   TECH_SKILL           varchar(50)          null,
   constraint PK_SKILLS primary key (SKILL_ID)
)
go

/*==============================================================*/
/* Table: STUDIO                                                */
/*==============================================================*/
create table STUDIO (
   ID_STUDIO            int                  not null,
   NAME                 varchar(50)          not null,
   TYPE                 varchar(50)          not null,
   WING                 varchar(50)          null,
   AVAILABILITY         smallint             not null,
   constraint PK_STUDIO primary key (ID_STUDIO)
)
go

/*==============================================================*/
/* Table: WORK_ON                                               */
/*==============================================================*/
create table WORK_ON (
   SESS_ID              int                  not null,
   PROFESSIONAL_ID      int                  not null,
   constraint PK_WORK_ON primary key (SESS_ID, PROFESSIONAL_ID)
)
go

/*==============================================================*/
/* Index: WORK_ON_FK                                            */
/*==============================================================*/




create nonclustered index WORK_ON_FK on WORK_ON (SESS_ID ASC)
go

/*==============================================================*/
/* Index: WORK_ON2_FK                                           */
/*==============================================================*/




create nonclustered index WORK_ON2_FK on WORK_ON (PROFESSIONAL_ID ASC)
go

alter table PROFESSIONAL
   add constraint FK_PROFESSI_HAVE_A_SKILLS foreign key (SKILL_ID)
      references SKILLS (SKILL_ID)
go

alter table SESSION
   add constraint FK_SESSION_HAS_PROJECT foreign key (ID)
      references PROJECT (ID)
go

alter table SESSION
   add constraint FK_SESSION_HAVE_STUDIO foreign key (ID_STUDIO)
      references STUDIO (ID_STUDIO)
go

alter table SESSION_EQUIP
   add constraint FK_SESSION__SESSION_E_EQUIPMEN foreign key (EQ_ID)
      references EQUIPMENT (EQ_ID)
go

alter table SESSION_EQUIP
   add constraint FK_SESSION__SESSION_E_SESSION foreign key (SESS_ID)
      references SESSION (SESS_ID)
go

alter table SESSION_EQUIP
   add constraint FK_SESSION__SESSION_E_PROFESSI foreign key (PROFESSIONAL_ID)
      references PROFESSIONAL (PROFESSIONAL_ID)
go

alter table WORK_ON
   add constraint FK_WORK_ON_WORK_ON_SESSION foreign key (SESS_ID)
      references SESSION (SESS_ID)
go

alter table WORK_ON
   add constraint FK_WORK_ON_WORK_ON2_PROFESSI foreign key (PROFESSIONAL_ID)
      references PROFESSIONAL (PROFESSIONAL_ID)
go

-- ==============================================================
-- INSERT DATA FOR SKILLS
-- ==============================================================
INSERT INTO SKILLS (SKILL_ID, TECH_SKILL) VALUES
(1, 'Audio Mixing'),
(2, 'Mastering'),
(3, 'Vocal Recording'),
(4, 'Instrument Recording'),
(5, 'MIDI Programming'),
(6, 'Sound Design'),
(7, 'Live Sound Engineering'),
(8, 'Post-Production'),
(9, 'Foley Artistry'),
(10, 'Noise Reduction');

-- ==============================================================
-- INSERT DATA FOR PROFESSIONAL
-- ==============================================================
INSERT INTO PROFESSIONAL (PROFESSIONAL_ID, SKILL_ID, PRO_NAME, ROLE) VALUES
(1, 1, 'John Smith', 'Audio Engineer'),
(2, 2, 'Sarah Johnson', 'Mastering Engineer'),
(3, 3, 'Michael Brown', 'Vocal Producer'),
(4, 4, 'Emily Davis', 'Session Musician'),
(5, 5, 'David Wilson', 'MIDI Programmer'),
(6, 6, 'Lisa Anderson', 'Sound Designer'),
(7, 7, 'Robert Martinez', 'Live Sound Engineer'),
(8, 8, 'Jennifer Taylor', 'Post-Production Specialist'),
(9, 9, 'William Thomas', 'Foley Artist'),
(10, 10, 'Patricia Garcia', 'Audio Restoration Specialist');

-- ==============================================================
-- INSERT DATA FOR STUDIO
-- ==============================================================
INSERT INTO STUDIO (ID_STUDIO, NAME, TYPE, WING, AVAILABILITY) VALUES
(1, 'Studio A', 'Recording', 'North Wing', 8),
(2, 'Studio B', 'Mixing', 'North Wing', 6),
(3, 'Studio C', 'Mastering', 'South Wing', 4),
(4, 'Studio D', 'Rehearsal', 'East Wing', 10),
(5, 'Studio E', 'Voice Over', 'West Wing', 5),
(6, 'Studio F', 'Live Room', 'North Wing', 3),
(7, 'Studio G', 'Post-Production', 'South Wing', 7),
(8, 'Studio H', 'Dubbing', 'East Wing', 4),
(9, 'Studio I', 'Orchestral', 'West Wing', 2),
(10, 'Studio J', 'Podcast', 'North Wing', 9);

-- ==============================================================
-- INSERT DATA FOR PROJECT
-- ==============================================================
INSERT INTO PROJECT (ID, TITLE, BUDGET, DEADLINE) VALUES
(1, 'Rock Album 2026', 25000.00, '2026-08-15 23:59:59'),
(2, 'Jazz Fusion EP', 15000.00, '2026-07-30 18:00:00'),
(3, 'Film Documentary Score', 45000.00, '2026-09-10 23:59:59'),
(4, 'Commercial Jingle', 8000.00, '2026-06-01 17:00:00'),
(5, 'Pop Single Release', 12000.00, '2026-05-25 20:00:00'),
(6, 'Electronic Dance Album', 30000.00, '2026-10-01 23:59:59'),
(7, 'Audiobook Recording', 5000.00, '2026-05-15 16:00:00'),
(8, 'Live Concert Recording', 35000.00, '2026-08-30 22:00:00'),
(9, 'Video Game Soundtrack', 28000.00, '2026-11-15 23:59:59'),
(10, 'Podcast Series', 10000.00, '2026-07-20 12:00:00');

-- ==============================================================
-- INSERT DATA FOR SESSION
-- ==============================================================
INSERT INTO SESSION (SESS_ID, ID, ID_STUDIO, SESS_DATE) VALUES
(1, 1, 1, '2026-05-15 10:00:00'),
(2, 1, 1, '2026-05-16 14:00:00'),
(3, 2, 2, '2026-05-18 11:00:00'),
(4, 3, 9, '2026-05-20 09:00:00'),
(5, 4, 5, '2026-05-22 13:00:00'),
(6, 5, 3, '2026-05-25 15:00:00'),
(7, 6, 1, '2026-05-28 10:30:00'),
(8, 7, 5, '2026-06-01 14:00:00'),
(9, 8, 6, '2026-06-05 19:00:00'),
(10, 9, 7, '2026-06-10 10:00:00'),
(11, 10, 10, '2026-06-12 11:00:00'),
(12, 2, 2, '2026-06-15 13:00:00'),
(13, 3, 9, '2026-06-18 09:30:00'),
(14, 5, 1, '2026-06-20 16:00:00'),
(15, 6, 6, '2026-06-22 12:00:00');

-- ==============================================================
-- INSERT DATA FOR EQUIPMENT
-- ==============================================================
INSERT INTO EQUIPMENT (EQ_ID, SERIAL_NUM, EQ_TYPE, STATUS) VALUES
(1, 'SN-MIC-001', 'Microphone', 'Available'),
(2, 'SN-MIC-002', 'Microphone', 'In Use'),
(3, 'SN-MIC-003', 'Microphone', 'Under Maintenance'),
(4, 'SN-CNSL-001', 'Console', 'Available'),
(5, 'SN-CNSL-002', 'Console', 'In Use'),
(6, 'SN-MNTR-001', 'Monitor', 'Available'),
(7, 'SN-MNTR-002', 'Monitor', 'Available'),
(8, 'SN-AMP-001', 'Amplifier', 'In Use'),
(9, 'SN-AMP-002', 'Amplifier', 'Available'),
(10, 'SN-INTF-001', 'Audio Interface', 'Available'),
(11, 'SN-INTF-002', 'Audio Interface', 'In Use'),
(12, 'SN-COMP-001', 'Compressor', 'Available'),
(13, 'SN-COMP-002', 'Compressor', 'Under Maintenance'),
(14, 'SN-EQ-001', 'Equalizer', 'Available'),
(15, 'SN-EQ-002', 'Equalizer', 'In Use'),
(16, 'SN-MIDI-001', 'MIDI Controller', 'Available'),
(17, 'SN-MIDI-002', 'MIDI Controller', 'In Use'),
(18, 'SN-SYNTH-001', 'Synthesizer', 'Available'),
(19, 'SN-SYNTH-002', 'Synthesizer', 'Available'),
(20, 'SN-DAW-001', 'DAW Controller', 'In Use');

-- ==============================================================
-- INSERT DATA FOR SESSION_EQUIP
-- ==============================================================
INSERT INTO SESSION_EQUIP (EQ_ID, SESS_ID, PROFESSIONAL_ID, RETURN_CONDITION) VALUES
(1, 1, 1, 'Good'),
(4, 1, 1, 'Good'),
(6, 1, 1, 'Excellent'),
(2, 2, 1, 'Good'),
(5, 2, 1, 'Needs Calibration'),
(11, 2, 3, 'Good'),
(3, 3, 2, NULL),
(7, 3, 2, 'Good'),
(14, 3, 2, 'Excellent'),
(8, 4, 4, 'Good'),
(16, 4, 5, 'Good'),
(10, 5, 6, 'Excellent'),
(18, 5, 6, 'Good'),
(12, 6, 7, 'Good'),
(15, 6, 7, 'Good'),
(1, 7, 1, 'Good'),
(19, 7, 8, 'Excellent'),
(20, 8, 9, 'Good'),
(5, 9, 10, 'Needs Repair'),
(11, 9, 10, 'Good'),
(2, 10, 1, 'Good'),
(13, 10, 2, 'Damaged'),
(4, 11, 6, 'Good'),
(17, 11, 5, 'Excellent'),
(9, 12, 7, 'Good'),
(14, 12, 7, 'Good'),
(6, 13, 4, 'Excellent'),
(15, 13, 4, 'Good'),
(3, 14, 1, NULL),
(12, 14, 1, 'Good'),
(8, 15, 8, 'Good'),
(20, 15, 8, 'Good');

-- ==============================================================
-- INSERT DATA FOR WORK_ON
-- ==============================================================
INSERT INTO WORK_ON (SESS_ID, PROFESSIONAL_ID) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 3),
(2, 5),
(3, 2),
(3, 4),
(4, 4),
(4, 8),
(4, 9),
(5, 6),
(5, 10),
(6, 7),
(6, 1),
(7, 1),
(7, 8),
(7, 6),
(8, 9),
(8, 10),
(9, 10),
(9, 7),
(10, 1),
(10, 2),
(10, 3),
(11, 6),
(11, 5),
(12, 7),
(12, 2),
(13, 4),
(13, 8),
(14, 1),
(14, 3),
(14, 5),
(15, 8),
(15, 9),
(15, 10);

