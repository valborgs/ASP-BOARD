CREATE TABLE [tblS45340ms_usertbl] (
	[idx] [int] IDENTITY (1, 1) NOT NULL,
	[u_id] [nvarchar](64) NULL,
	[u_pw] [nvarchar](128) NULL,
	[u_grade] [nvarchar](4) NULL,
	Constraint [PK_tblS45340ms_usertbl] Primary Key Clustered
	(	[idx]	) On [Primary]
) On [Primary]


CREATE TABLE [tblS45340ms_board] (
	[idx] [int] IDENTITY (1, 1) NOT NULL,
	[b_title] [nvarchar](64) NULL,
	[b_content] [ntext] NULL,
	[b_author] [nvarchar](64) NULL,
	[b_pw] [nvarchar](128) NULL,
	[b_cdate] [nvarchar](128) NULL,
	[b_mdate] [nvarchar](128) NULL,
	[b_grade] [nvarchar](4) NULL,
	[b_secret] [nvarchar](4) NULL,
	[b_removed] [nvarchar](4) NULL,
	Constraint [PK_tblS45340ms_board] Primary Key Clustered
	(	[idx]	) On [Primary]
) On [Primary]


CREATE TABLE [tblS45340ms_reply] (
	[idx] [int] IDENTITY (1, 1) NOT NULL,
	[r_content] [ntext] NULL,
	[r_author] [nvarchar](64) NULL,
	[r_uid] [nvarchar](64) NULL,
	[r_cdate] [nvarchar](128) NULL,
	[r_mdate] [nvarchar](128) NULL,
	[r_bidx] [int] NULL,
	[r_removed] [nvarchar](4) NULL,
	Constraint [PK_tblS45340ms_reply] Primary Key Clustered
	(	[idx]	) On [Primary]
) On [Primary]


CREATE TABLE [tblS45340ms_userlog] (
	[idx] [int] IDENTITY (1, 1) NOT NULL,
	[l_uid] [nvarchar](64) NULL,
	[l_action] [nvarchar](128) NULL,
	[l_time] [nvarchar](128) NULL,
	Constraint [PK_tblS45340ms_userlog] Primary Key Clustered
	(	[idx]	) On [Primary]
) On [Primary]


CREATE TABLE [tblS45340ms_loginsession] (
	[idx] [int] IDENTITY (1, 1) NOT NULL,
	[s_uid] [nvarchar](64) NULL,
	[s_sid] [nvarchar](64) NULL,
	[s_time] [nvarchar](128) NULL,
	Constraint [PK_tblS45340ms_loginsession] Primary Key Clustered
	(	[idx]	) On [Primary]
) On [Primary]
