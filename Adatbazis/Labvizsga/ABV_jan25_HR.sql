USE [master]
GO

IF NOT EXISTS (
    SELECT [name]
FROM sys.databases
WHERE [name] = N'HR'
)
CREATE DATABASE HR
GO
USE [HR]
GO
IF OBJECT_ID('[dbo].[AlkalmazottMunkakorok]', 'U') IS NOT NULL
DROP TABLE [dbo].[AlkalmazottMunkakorok]
GO
IF OBJECT_ID('[dbo].[Reszlegek]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Reszlegek]
GO
IF OBJECT_ID('[dbo].[Alkalmazottak]', 'U') IS NOT NULL
DROP TABLE [dbo].[Alkalmazottak]
GO
IF OBJECT_ID('[dbo].[Vegzettsegek]', 'U') IS NOT NULL
DROP TABLE [dbo].[Vegzettsegek]
GO
IF OBJECT_ID('[dbo].[Irodak]', 'U') IS NOT NULL
DROP TABLE [dbo].[Irodak]
GO
IF OBJECT_ID('[dbo].[Munkakorok]', 'U') IS NOT NULL
DROP TABLE [dbo].[Munkakorok]
GO
IF OBJECT_ID('[dbo].[Varosok]', 'U') IS NOT NULL
DROP TABLE [dbo].[Varosok]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alkalmazottak]
(
    [AlkalmazottID] [varchar](10) NOT NULL,
    [Nev] [nvarchar](50) NOT NULL,
    [Email] [varchar](50) NULL,
    [AlkamazasKezdete] [date] NULL,
    [VegzettsegID] [int] NULL,
    [VarosID] [int] NULL,
    PRIMARY KEY CLUSTERED 
(
	[AlkalmazottID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlkalmazottMunkakorok]
(
	[AMID] INT NOT NULL IDENTITY,
    [AlkalmazottID] [varchar](10) NOT NULL,
    [MunkakorID] [int] NOT NULL,
    [KezdetiDatum] [date] NOT NULL,
    [VegsoDatum] [date] NOT NULL,
    [Fizetes] [int] NULL,
    [SzabadnapokSzama] [int] DEFAULT 22,
    [MenedzserID] [varchar](10) NULL,
    [IrodaID] [int] NULL,
    [ReszlegID] [int] NULL,
    CONSTRAINT [PK_AlkalmazottMunkakorok] PRIMARY KEY CLUSTERED 
(
	[AMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Irodak]
(
    [IrodaID] [int] IDENTITY(1,1) NOT NULL,
    [Nev] [nvarchar](50) NOT NULL,
    [Cim] [nvarchar](50) NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[IrodaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Munkakorok]
(
    [MunkakorID] [int] IDENTITY(1,1) NOT NULL,
    [Nev] [nvarchar](50) NOT NULL,
    MunkakorLeiras nvarchar(100) DEFAULT 'Leiras',
    PRIMARY KEY CLUSTERED 
(
	[MunkakorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reszlegek]
(
    [ReszlegID] [int] IDENTITY(1,1) NOT NULL,
    [Nev] [varchar](50) NULL,
    PRIMARY KEY CLUSTERED 
(
	[ReszlegID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Varosok]
(
    [VarosID] [int] IDENTITY(1,1) NOT NULL,
    [VarosNev] [nvarchar](50) NOT NULL,
    [AllamKod] [varchar](2) NULL,
    PRIMARY KEY CLUSTERED 
(
	[VarosID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vegzettsegek]
(
    [VegzettsegID] [int] IDENTITY(1,1) NOT NULL,
    [VegzettsegiSzint] [nvarchar](50) NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[VegzettsegID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'C10033', N'Nagy Janos', N'Janos.Nagy@TechCorp.com', CAST(N'2013-02-17' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E10033', N'Jermaine Massey', N'Jermaine.Massey@TechCorp.com', CAST(N'2016-03-07' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E10407', N'Darshan Rathod', N'Darshan.Rathod@TechCorp.com', CAST(N'2018-10-08' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E11678', N'Colleen Alma', N'Colleen.Alma@TechCorp.com', CAST(N'2001-12-26' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E11920', N'Sharon Gillies', N'Sharon.Gillies@TechCorp.com', CAST(N'2006-06-19' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E12397', N'Daniel Matkovic', N'Daniel.Matkovic@TechCorp.com', CAST(N'2013-11-17' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E12562', N'Keith Ingram', N'Keith.Ingram@TechCorp.com', CAST(N'1996-04-14' AS Date), 7, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E12890', N'Robert Brown', N'Robert.Brown@TechCorp.com', CAST(N'2010-06-06' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E13085', N'Susan Cole ', N'Susan.Cole @TechCorp.com', CAST(N'2017-05-01' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E13160', N'Eric  Baxter', N'Eric .Baxter@TechCorp.com', CAST(N'2008-10-06' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E13596', N'Kenneth Dewitt', N'Kenneth.Dewitt@TechCorp.com', CAST(N'2012-04-09' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E14737', N'Juan Cosme', N'Juan.Cosme@TechCorp.com', CAST(N'2012-07-22' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E14913', N'Aaron Gordon ', N'Aaron.Gordon @TechCorp.com', CAST(N'1998-07-15' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E15267', N'Shanteel Jackson', N'Shanteel.Jackson@TechCorp.com', CAST(N'1998-02-22' AS Date), 6, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E15292', N'Melinda Fisher', N'Melinda.Fisher@TechCorp.com', CAST(N'2011-02-06' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E16276', N'Analyn Braza', N'Analyn.Braza@TechCorp.com', CAST(N'1996-03-07' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E16346', N'Jill Fram', N'Jill.Fram@TechCorp.com', CAST(N'2007-12-16' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E16678', N'Abby Lockhart', N'Abby.Lockhart@TechCorp.com', CAST(N'2005-11-25' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E16995', N'Wilson Martinez', N'Wilson.Martinez@TechCorp.com', CAST(N'2001-02-28' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E17054', N'Tyrone Hutchison', N'Tyrone.Hutchison@TechCorp.com', CAST(N'2006-09-07' AS Date), 5, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E17372', N'Greg Pratt', N'Greg.Pratt@TechCorp.com', CAST(N'2009-06-08' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E17469', N'Haifa Hajiri', N'Haifa.Hajiri@TechCorp.com', CAST(N'2003-12-17' AS Date), 6, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E18659', N'Arnold Hanson', N'Arnold.Hanson@TechCorp.com', CAST(N'2008-01-27' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E18697', N'Anita Deluise', N'Anita.Deluise@TechCorp.com', CAST(N'1995-06-01' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E20101', N'Zoey Bulter', N'Zoey.Bulter@TechCorp.com', CAST(N'2012-12-03' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E20848', N'Edward Eslser', N'Edward.Eslser@TechCorp.com', CAST(N'2006-07-26' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E21348', N'Nital Thaker', N'Nital.Thaker@TechCorp.com', CAST(N'2016-09-28' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E21696', N'Mallory Russo', N'Mallory.Russo@TechCorp.com', CAST(N'1997-12-06' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E22197', N'Oliver Jia', N'Oliver.Jia@TechCorp.com', CAST(N'2013-09-22' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E22680', N'Cassidy Bancroft', N'Cassidy.Bancroft@TechCorp.com', CAST(N'2013-10-26' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E22785', N'Tami Smith', N'Tami.Smith@TechCorp.com', CAST(N'1997-12-08' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E23295', N'Lori Scatchard', N'Lori.Scatchard@TechCorp.com', CAST(N'2004-05-08' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E23429', N'Andrew Yoon', N'Andrew.Yoon@TechCorp.com', CAST(N'2018-11-14' AS Date), 1, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E23590', N'Dennis Wooten', N'Dennis.Wooten@TechCorp.com', CAST(N'2013-04-06' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E23669', N'Karen Brown', N'Karen.Brown@TechCorp.com', CAST(N'2017-04-23' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E24100', N'Zondra Peck', N'Zondra.Peck@TechCorp.com', CAST(N'1997-03-06' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E24539', N'Grace Messinger', N'Grace.Messinger@TechCorp.com', CAST(N'2004-12-12' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E25144', N'Chandi Bhandari', N'Chandi.Bhandari@TechCorp.com', CAST(N'2007-10-25' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E25640', N'Joseph Donohue', N'Joseph.Donohue@TechCorp.com', CAST(N'2007-12-27' AS Date), 6, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E25662', N'Doug Tomson', N'Doug.Tomson@TechCorp.com', CAST(N'1995-06-22' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E25710', N'Brent Robinson', N'Brent.Robinson@TechCorp.com', CAST(N'2005-08-14' AS Date), 4, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E26322', N'Raisa Paulson', N'Raisa.Paulson@TechCorp.com', CAST(N'2010-10-20' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E26874', N'Tiffany Harrington', N'Tiffany.Harrington@TechCorp.com', CAST(N'2015-06-27' AS Date), 4, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E27267', N'Preston Lilly', N'Preston.Lilly@TechCorp.com', CAST(N'2010-08-29' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E27498', N'Toni Lembeck', N'Toni.Lembeck@TechCorp.com', CAST(N'2001-07-18' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E27621', N'Wendell Mobley', N'Wendell.Mobley@TechCorp.com', CAST(N'2013-11-27' AS Date), 7, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E27909', N'Michael Sperduti', N'Michael.Sperduti@TechCorp.com', CAST(N'2014-06-20' AS Date), 1, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E28092', N'Tuan Yang', N'Tuan.Yang@TechCorp.com', CAST(N'2008-11-01' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E28638', N'Marie Dumadara', N'Marie.Dumadara@TechCorp.com', CAST(N'2004-06-02' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E29129', N'Belinda Van Loon', N'Belinda.Van Loon@TechCorp.com', CAST(N'2007-12-03' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E29652', N'Jennifer Westin', N'Jennifer.Westin@TechCorp.com', CAST(N'2007-06-14' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E30058', N'Bertin Dakouo', N'Bertin.Dakouo@TechCorp.com', CAST(N'2013-09-24' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E30317', N'Siena Spitzer', N'Siena.Spitzer@TechCorp.com', CAST(N'2019-01-03' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E30678', N'Jody Hopkins', N'Jody.Hopkins@TechCorp.com', CAST(N'2020-05-02' AS Date), 4, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E31241', N'Laura House', N'Laura.House@TechCorp.com', CAST(N'2014-05-10' AS Date), 1, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E31931', N'Leo Manhanga', N'Leo.Manhanga@TechCorp.com', CAST(N'2013-09-26' AS Date), 7, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E32058', N'Curtis Gibson', N'Curtis.Gibson@TechCorp.com', CAST(N'2009-01-19' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E32359', N'Jen  Frangias', N'Jen .Frangias@TechCorp.com', CAST(N'2019-03-24' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E33486', N'Stephen Colluci', N'Stephen.Colluci@TechCorp.com', CAST(N'2000-08-02' AS Date), 3, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E34496', N'Tony Hughes', N'Tony.Hughes@TechCorp.com', CAST(N'2009-01-27' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E34500', N'Kathy Fedder', N'Kathy.Fedder@TechCorp.com', CAST(N'1997-01-17' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E34748', N'Holly Smith', N'Holly.Smith@TechCorp.com', CAST(N'2011-04-28' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E34816', N'Roseann Martineeti', N'Roseann.Martineeti@TechCorp.com', CAST(N'2000-08-01' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E35053', N'Ashley Bergman', N'Ashley.Bergman@TechCorp.com', CAST(N'2009-03-01' AS Date), 6, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E35075', N'John Certa', N'John.Certa@TechCorp.com', CAST(N'2007-08-29' AS Date), 7, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E35856', N'Beth Sepkowski', N'Beth.Sepkowski@TechCorp.com', CAST(N'2017-05-03' AS Date), 4, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E35860', N'Vivian Kovach', N'Vivian.Kovach@TechCorp.com', CAST(N'1999-08-18' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E36346', N'Tyrone Curtis', N'Tyrone.Curtis@TechCorp.com', CAST(N'1999-06-22' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E36960', N'Ken Beer', N'Ken.Beer@TechCorp.com', CAST(N'2008-04-26' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E36988', N'Michelle Zietz', N'Michelle.Zietz@TechCorp.com', CAST(N'2015-10-31' AS Date), 1, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E37246', N'Paulius Mikalainis', N'Paulius.Mikalainis@TechCorp.com', CAST(N'2013-10-23' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E37389', N'Becky Weaver', N'Becky.Weaver@TechCorp.com', CAST(N'1996-12-08' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E37523', N'Alan Mecklet', N'Alan.Mecklet@TechCorp.com', CAST(N'2017-12-02' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E38634', N'Zach Bratkovich', N'Zach.Bratkovich@TechCorp.com', CAST(N'2014-11-22' AS Date), 3, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E38677', N'Michael Scilla', N'Michael.Scilla@TechCorp.com', CAST(N'2014-04-17' AS Date), 3, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E38959', N'Ludovic Bocken', N'Ludovic.Bocken@TechCorp.com', CAST(N'2006-09-16' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E38997', N'Roseann Clemente', N'Roseann.Clemente@TechCorp.com', CAST(N'2007-09-21' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E39652', N'Kyle Guilmartin', N'Kyle.Guilmartin@TechCorp.com', CAST(N'2012-08-11' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E40432', N'April Briggs', N'April.Briggs@TechCorp.com', CAST(N'2010-01-30' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E41635', N'James Aryeetey', N'James.Aryeetey@TechCorp.com', CAST(N'2005-03-26' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E41712', N'Elaine Podwika', N'Elaine.Podwika@TechCorp.com', CAST(N'2012-01-06' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E42061', N'Diana Teppen', N'Diana.Teppen@TechCorp.com', CAST(N'2013-11-04' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E42522', N'Fiona Morris', N'Fiona.Morris@TechCorp.com', CAST(N'2007-05-26' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E42681', N'James Henderson', N'James.Henderson@TechCorp.com', CAST(N'1996-04-09' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E43694', N'Benyam Gizaw', N'Benyam.Gizaw@TechCorp.com', CAST(N'2016-10-28' AS Date), 3, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E44136', N'Erica Siegal', N'Erica.Siegal@TechCorp.com', CAST(N'2002-01-09' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E44426', N'Jacob Lauber', N'Jacob.Lauber@TechCorp.com', CAST(N'2007-05-02' AS Date), 5, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E45236', N'Patti Hoeg', N'Patti.Hoeg@TechCorp.com', CAST(N'2008-05-29' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E45405', N'Prashant Sharma', N'Prashant.Sharma@TechCorp.com', CAST(N'2000-09-06' AS Date), 6, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E45736', N'John Perez', N'John.Perez@TechCorp.com', CAST(N'2015-04-04' AS Date), 3, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E45758', N'Walter Waddler', N'Walter.Waddler@TechCorp.com', CAST(N'2017-12-19' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E45824', N'Raj Prudvi', N'Raj.Prudvi@TechCorp.com', CAST(N'2017-10-03' AS Date), 1, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E46366', N'Johnathan Wayman', N'Johnathan.Wayman@TechCorp.com', CAST(N'2004-10-16' AS Date), 1, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E47655', N'Cody Holland', N'Cody.Holland@TechCorp.com', CAST(N'1997-11-27' AS Date), 3, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E47926', N'Janice Canterbury', N'Janice.Canterbury@TechCorp.com', CAST(N'2008-05-31' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E48148', N'Alexis Fitzpatrick', N'Alexis.Fitzpatrick@TechCorp.com', CAST(N'2013-02-19' AS Date), 6, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E48637', N'Joey Fulkerson', N'Joey.Fulkerson@TechCorp.com', CAST(N'1999-09-26' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E48884', N'Stacey Lewis', N'Stacey.Lewis@TechCorp.com', CAST(N'2008-06-01' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E49025', N'Mark Fiore', N'Mark.Fiore@TechCorp.com', CAST(N'2005-06-09' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E49459', N'Courtney Newman', N'Courtney.Newman@TechCorp.com', CAST(N'2020-03-28' AS Date), 7, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E49798', N'Greg Stirton', N'Greg.Stirton@TechCorp.com', CAST(N'1998-01-09' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E50012', N'Ann Roberto', N'Ann.Roberto@TechCorp.com', CAST(N'2009-10-01' AS Date), 6, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E51619', N'Tom Meola', N'Tom.Meola@TechCorp.com', CAST(N'2011-10-05' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E51723', N'Carlos Lopez', N'Carlos.Lopez@TechCorp.com', CAST(N'2014-05-23' AS Date), 6, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E52461', N'Lena Thorton', N'Lena.Thorton@TechCorp.com', CAST(N'2014-11-11' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E52489', N'Kelly Price', N'Kelly.Price@TechCorp.com', CAST(N'2002-12-05' AS Date), 1, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E53406', N'Janice Mayzlik', N'Janice.Mayzlik@TechCorp.com', CAST(N'2001-10-25' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E53895', N'Kumar Durairaj', N'Kumar.Durairaj@TechCorp.com', CAST(N'2014-10-27' AS Date), 6, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E54196', N'Phil  Wisneski', N'Phil .Wisneski@TechCorp.com', CAST(N'2004-12-18' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E55855', N'Parker Williams', N'Parker.Williams@TechCorp.com', CAST(N'2018-05-20' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E55880', N'Alex Warring', N'Alex.Warring@TechCorp.com', CAST(N'1995-07-18' AS Date), 7, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E56144', N'Cassidy Clayton', N'Cassidy.Clayton@TechCorp.com', CAST(N'2013-01-28' AS Date), 3, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E56444', N'Curtis Steward', N'Curtis.Steward@TechCorp.com', CAST(N'1999-06-10' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E56459', N'Raven Landis', N'Raven.Landis@TechCorp.com', CAST(N'2016-04-21' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E57502', N'Frank Debanco', N'Frank.Debanco@TechCorp.com', CAST(N'2016-07-21' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E57987', N'Nicole Lee', N'Nicole.Lee@TechCorp.com', CAST(N'2016-05-15' AS Date), 6, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E59688', N'Jason Wingard', N'Jason.Wingard@TechCorp.com', CAST(N'2006-01-11' AS Date), 7, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E60752', N'Michael Tholstrup', N'Michael.Tholstrup@TechCorp.com', CAST(N'2010-02-27' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E60901', N'Samantha Kramer', N'Samantha.Kramer@TechCorp.com', CAST(N'2010-01-10' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E60929', N'Tanya Maheshwari', N'Tanya.Maheshwari@TechCorp.com', CAST(N'2013-07-03' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E61614', N'Elliot Foley', N'Elliot.Foley@TechCorp.com', CAST(N'1996-07-21' AS Date), 4, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E61947', N'Charles Wirry', N'Charles.Wirry@TechCorp.com', CAST(N'2010-03-04' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E62100', N'Victoria Pruitt', N'Victoria.Pruitt@TechCorp.com', CAST(N'2000-02-15' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E62527', N'Barry Walsh', N'Barry.Walsh@TechCorp.com', CAST(N'2006-06-15' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E62634', N'Karen Lafler', N'Karen.Lafler@TechCorp.com', CAST(N'2014-08-19' AS Date), 1, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E63041', N'Allison Gentle', N'Allison.Gentle@TechCorp.com', CAST(N'1995-08-22' AS Date), 5, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E63930', N'Sonali Baidya', N'Sonali.Baidya@TechCorp.com', CAST(N'2009-02-25' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E63937', N'Rachael Anderson', N'Rachael.Anderson@TechCorp.com', CAST(N'2014-07-15' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E64494', N'Patricia DuBois', N'Patricia.DuBois@TechCorp.com', CAST(N'2007-05-11' AS Date), 3, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E64920', N'Mary Wesson', N'Mary.Wesson@TechCorp.com', CAST(N'2019-05-11' AS Date), 3, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E65052', N'Leobrian Mason', N'Leobrian.Mason@TechCorp.com', CAST(N'1995-09-15' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E66477', N'Dakeem Coleman', N'Dakeem.Coleman@TechCorp.com', CAST(N'2018-05-08' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E67190', N'Nathan Hile ', N'Nathan.Hile @TechCorp.com', CAST(N'2007-07-24' AS Date), 4, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E67793', N'Fausto Recalde', N'Fausto.Recalde@TechCorp.com', CAST(N'2018-06-07' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E68807', N'Wes Tappan', N'Wes.Tappan@TechCorp.com', CAST(N'2010-11-10' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E69297', N'Nilden Tutalar', N'Nilden.Tutalar@TechCorp.com', CAST(N'2013-03-21' AS Date), 1, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E70374', N'Norman Guerrero', N'Norman.Guerrero@TechCorp.com', CAST(N'2007-08-19' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E70603', N'Soek Sohn', N'Soek.Sohn@TechCorp.com', CAST(N'2006-07-06' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E71128', N'Stan Frank', N'Stan.Frank@TechCorp.com', CAST(N'1998-01-28' AS Date), 6, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E71792', N'Jesse Curiel', N'Jesse.Curiel@TechCorp.com', CAST(N'2014-03-30' AS Date), 3, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E72436', N'Eileen Chuss', N'Eileen.Chuss@TechCorp.com', CAST(N'2013-05-11' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E73518', N'Cheryl Pike', N'Cheryl.Pike@TechCorp.com', CAST(N'2001-03-24' AS Date), 6, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E74296', N'Krishna Burli', N'Krishna.Burli@TechCorp.com', CAST(N'2016-12-19' AS Date), 7, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E74490', N'Alejandro Scannapieco', N'Alejandro.Scannapieco@TechCorp.com', CAST(N'1999-05-22' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E75081', N'Dennis Fredrich', N'Dennis.Fredrich@TechCorp.com', CAST(N'2008-10-08' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E75344', N'Michael Kapper', N'Michael.Kapper@TechCorp.com', CAST(N'2009-03-20' AS Date), 5, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E76053', N'Darryl Reamer', N'Darryl.Reamer@TechCorp.com', CAST(N'1998-08-23' AS Date), 3, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E76443', N'Thanuja Polani', N'Thanuja.Polani@TechCorp.com', CAST(N'2020-02-16' AS Date), 4, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E77317', N'Kathy Abiskaroon', N'Kathy.Abiskaroon@TechCorp.com', CAST(N'2015-05-20' AS Date), 1, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E77658', N'Hitesh Bhatt', N'Hitesh.Bhatt@TechCorp.com', CAST(N'2012-03-15' AS Date), 4, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E77884', N'Conner Kinch', N'Conner.Kinch@TechCorp.com', CAST(N'2002-12-09' AS Date), 5, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E78732', N'Randy Myers', N'Randy.Myers@TechCorp.com', CAST(N'2020-01-24' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E79464', N'Anu Patel', N'Anu.Patel@TechCorp.com', CAST(N'1999-05-01' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E79552', N'Angela Masdary', N'Angela.Masdary@TechCorp.com', CAST(N'2008-02-05' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E80744', N'Ginger Logan', N'Ginger.Logan@TechCorp.com', CAST(N'2020-01-09' AS Date), 4, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E81369', N'Kevin Soltis', N'Kevin.Soltis@TechCorp.com', CAST(N'2019-05-29' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E81502', N'Danny Laxton', N'Danny.Laxton@TechCorp.com', CAST(N'1999-10-24' AS Date), 7, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E82137', N'Arup Das', N'Arup.Das@TechCorp.com', CAST(N'2006-10-04' AS Date), 5, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E83512', N'Tim Lawler', N'Tim.Lawler@TechCorp.com', CAST(N'1996-10-22' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E83558', N'Laura McKenna', N'Laura.McKenna@TechCorp.com', CAST(N'1997-10-15' AS Date), 1, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E84122', N'Congkhanh Nguyen', N'Congkhanh.Nguyen@TechCorp.com', CAST(N'2017-10-28' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E85476', N'Shawn Reynolds', N'Shawn.Reynolds@TechCorp.com', CAST(N'2003-07-22' AS Date), 3, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E85640', N'Tara Madison', N'Tara.Madison@TechCorp.com', CAST(N'2001-02-03' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E86238', N'Raymond Dorset', N'Raymond.Dorset@TechCorp.com', CAST(N'2012-04-21' AS Date), 7, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E86828', N'Philip Barnett', N'Philip.Barnett@TechCorp.com', CAST(N'2011-09-29' AS Date), 4, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E87073', N'Yuesef Hosni', N'Yuesef.Hosni@TechCorp.com', CAST(N'2007-01-02' AS Date), 1, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E87210', N'Gary Boyd', N'Gary.Boyd@TechCorp.com', CAST(N'2014-04-18' AS Date), 3, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E87219', N'Jorge Moscoso', N'Jorge.Moscoso@TechCorp.com', CAST(N'2017-09-20' AS Date), 6, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E87230', N'Sara Erwin', N'Sara.Erwin@TechCorp.com', CAST(N'2014-11-10' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E87370', N'Misha Tsidulko', N'Misha.Tsidulko@TechCorp.com', CAST(N'2013-11-18' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E87822', N'Anil Padala', N'Anil.Padala@TechCorp.com', CAST(N'2014-04-02' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E88667', N'Jennifer De La Garza', N'Jennifer.De La Garza@TechCorp.com', CAST(N'1995-12-21' AS Date), 4, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E88864', N'Susan Woodruff', N'Susan.Woodruff@TechCorp.com', CAST(N'2008-11-15' AS Date), 2, 5)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E89540', N'Amit Hardiya', N'Amit.Hardiya@TechCorp.com', CAST(N'2017-06-01' AS Date), 6, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E90222', N'Yawer Ali', N'Yawer.Ali@TechCorp.com', CAST(N'2016-11-01' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E90407', N'Danny Godiksen', N'Danny.Godiksen@TechCorp.com', CAST(N'2010-12-15' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E90435', N'Russell Morales', N'Russell.Morales@TechCorp.com', CAST(N'2017-02-20' AS Date), 1, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E90439', N'Janice McQueen', N'Janice.McQueen@TechCorp.com', CAST(N'2000-07-23' AS Date), 2, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E90990', N'Tammy Tieman', N'Tammy.Tieman@TechCorp.com', CAST(N'2014-11-16' AS Date), 4, 2)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E91075', N'Micah Vass', N'Micah.Vass@TechCorp.com', CAST(N'2019-12-15' AS Date), 1, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E91182', N'Nick Gowen', N'Nick.Gowen@TechCorp.com', CAST(N'2013-05-18' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E91791', N'Aaron Richman', N'Aaron.Richman@TechCorp.com', CAST(N'2017-06-02' AS Date), 1, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E93629', N'Tracy Emerson', N'Tracy.Emerson@TechCorp.com', CAST(N'2013-07-22' AS Date), 3, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E93715', N'Charles Barker', N'Charles.Barker@TechCorp.com', CAST(N'1998-04-29' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E93734', N'Melissa DeMaio', N'Melissa.DeMaio@TechCorp.com', CAST(N'2005-06-21' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E93871', N'Travis Black', N'Travis.Black@TechCorp.com', CAST(N'2002-04-30' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E94358', N'Muhammed Rubel', N'Muhammed.Rubel@TechCorp.com', CAST(N'2007-07-08' AS Date), 1, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E94387', N'Erica Davis', N'Erica.Davis@TechCorp.com', CAST(N'2003-07-25' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E94552', N'Geraldine Staler', N'Geraldine.Staler@TechCorp.com', CAST(N'2013-10-31' AS Date), 4, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E95190', N'Christina Roth', N'Christina.Roth@TechCorp.com', CAST(N'2016-04-26' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E95199', N'Carlos Fernandes', N'Carlos.Fernandes@TechCorp.com', CAST(N'2017-01-09' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E95214', N'Faheem Ahmed', N'Faheem.Ahmed@TechCorp.com', CAST(N'2019-09-22' AS Date), 3, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E96856', N'Tom Wilson', N'Tom.Wilson@TechCorp.com', CAST(N'2017-11-27' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E96966', N'Lu Huang', N'Lu.Huang@TechCorp.com', CAST(N'2014-12-19' AS Date), 2, 3)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E97018', N'Jamie Foskett', N'Jamie.Foskett@TechCorp.com', CAST(N'2000-09-08' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E97273', N'Justin Hayes', N'Justin.Hayes@TechCorp.com', CAST(N'2004-06-05' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E98270', N'Jeff Barnhill', N'Jeff.Barnhill@TechCorp.com', CAST(N'1997-12-24' AS Date), 2, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E98559', N'Max Yish', N'Max.Yish@TechCorp.com', CAST(N'2006-11-11' AS Date), 2, 4)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E98891', N'Doris Venama', N'Doris.Venama@TechCorp.com', CAST(N'2017-09-30' AS Date), 4, 1)
GO
INSERT [dbo].[Alkalmazottak]
    ([AlkalmazottID], [Nev], [Email], [AlkamazasKezdete], [VegzettsegID], [VarosID])
VALUES
    (N'E99949', N'William Graf', N'William.Graf@TechCorp.com', CAST(N'2005-05-26' AS Date), 2, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E10033', 10, CAST(N'2016-03-07' AS Date), CAST(N'2100-07-08' AS Date), 111681, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E10407', 8, CAST(N'2018-10-08' AS Date), CAST(N'2100-04-05' AS Date), 180692, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E11678', 6, CAST(N'2001-12-26' AS Date), CAST(N'2100-03-27' AS Date), 76913, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E11920', 8, CAST(N'2006-06-19' AS Date), CAST(N'2100-05-04' AS Date), 115719, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E12397', 6, CAST(N'2013-11-17' AS Date), CAST(N'2100-03-28' AS Date), 71846, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E12562', 1, CAST(N'1996-04-14' AS Date), CAST(N'2100-01-19' AS Date), 48910, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E12890', 10, CAST(N'2010-06-06' AS Date), CAST(N'2100-07-09' AS Date), 136384, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E13085', 9, CAST(N'2017-05-01' AS Date), CAST(N'2100-06-06' AS Date), 27811, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E13160', 2, CAST(N'2008-10-06' AS Date), CAST(N'2100-01-31' AS Date), 102614, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E13160', 6, CAST(N'2004-07-06' AS Date), CAST(N'2008-10-05' AS Date), 76345, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E13596', 8, CAST(N'2012-04-09' AS Date), CAST(N'2100-04-06' AS Date), 180913, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E14737', 9, CAST(N'2012-07-22' AS Date), CAST(N'2100-06-07' AS Date), 26050, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E14913', 6, CAST(N'1998-07-15' AS Date), CAST(N'2100-03-29' AS Date), 103166, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E15267', 9, CAST(N'1998-02-22' AS Date), CAST(N'2100-06-08' AS Date), 40806, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E15292', 9, CAST(N'2007-02-22' AS Date), CAST(N'2011-02-06' AS Date), 32933, N'E63041', 2, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E15292', 10, CAST(N'2011-02-06' AS Date), CAST(N'2100-06-21' AS Date), 117958, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E16276', 8, CAST(N'1996-03-07' AS Date), CAST(N'2100-05-05' AS Date), 208554, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E16346', 1, CAST(N'2007-12-16' AS Date), CAST(N'2100-01-20' AS Date), 50462, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E16678', 2, CAST(N'2005-11-25' AS Date), CAST(N'2100-02-01' AS Date), 84297, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E16678', 6, CAST(N'1999-02-16' AS Date), CAST(N'2005-11-25' AS Date), 65778, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E16995', 8, CAST(N'2001-02-28' AS Date), CAST(N'2100-04-07' AS Date), 130161, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E17054', 7, CAST(N'2006-09-07' AS Date), CAST(N'2100-04-04' AS Date), 540000, NULL, 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E17372', 8, CAST(N'2009-06-08' AS Date), CAST(N'2100-05-06' AS Date), 170741, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E17469', 1, CAST(N'2003-12-17' AS Date), CAST(N'2100-01-01' AS Date), 47418, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E18659', 10, CAST(N'2008-01-27' AS Date), CAST(N'2100-07-10' AS Date), 124699, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E18697', 1, CAST(N'1995-06-01' AS Date), CAST(N'2100-01-07' AS Date), 45325, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E20101', 8, CAST(N'2012-12-03' AS Date), CAST(N'2100-05-07' AS Date), 157172, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E20848', 9, CAST(N'2002-04-16' AS Date), CAST(N'2006-07-26' AS Date), 41407, N'E63041', 2, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E20848', 10, CAST(N'2006-07-26' AS Date), CAST(N'2100-06-22' AS Date), 83732, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E21348', 10, CAST(N'2016-09-28' AS Date), CAST(N'2100-07-11' AS Date), 148313, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E21696', 4, CAST(N'1997-12-06' AS Date), CAST(N'2100-03-04' AS Date), 167887, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E22197', 6, CAST(N'2013-09-22' AS Date), CAST(N'2100-03-14' AS Date), 89618, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E22680', 8, CAST(N'2013-10-26' AS Date), CAST(N'2100-04-08' AS Date), 196637, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E22785', 8, CAST(N'1997-12-08' AS Date), CAST(N'2100-05-08' AS Date), 83535, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E23295', 8, CAST(N'2003-04-08' AS Date), CAST(N'2004-05-08' AS Date), 57887, N'E88667', 3, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E23295', 10, CAST(N'2004-05-08' AS Date), CAST(N'2100-06-23' AS Date), 118941, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E23429', 8, CAST(N'2018-11-14' AS Date), CAST(N'2100-04-09' AS Date), 114616, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E23590', 10, CAST(N'2013-04-06' AS Date), CAST(N'2100-06-24' AS Date), 101850, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E23669', 6, CAST(N'2017-04-23' AS Date), CAST(N'2100-03-30' AS Date), 77370, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E24100', 6, CAST(N'1997-03-06' AS Date), CAST(N'2100-03-15' AS Date), 98994, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E24539', 8, CAST(N'2004-12-12' AS Date), CAST(N'2100-05-09' AS Date), 173443, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E25144', 10, CAST(N'2007-10-25' AS Date), CAST(N'2100-07-12' AS Date), 148005, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E25640', 1, CAST(N'2007-12-27' AS Date), CAST(N'2100-01-08' AS Date), 40647, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E25662', 8, CAST(N'1995-06-22' AS Date), CAST(N'2100-04-10' AS Date), 188080, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E25710', 3, CAST(N'2005-08-14' AS Date), CAST(N'2100-02-12' AS Date), 77155, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E26322', 10, CAST(N'2010-10-20' AS Date), CAST(N'2100-07-13' AS Date), 136509, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E26874', 6, CAST(N'2015-06-27' AS Date), CAST(N'2100-03-16' AS Date), 45412, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E27267', 8, CAST(N'2010-08-29' AS Date), CAST(N'2100-05-10' AS Date), 206383, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E27498', 2, CAST(N'2001-07-18' AS Date), CAST(N'2100-02-02' AS Date), 78206, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E27498', 6, CAST(N'1995-03-12' AS Date), CAST(N'2001-07-18' AS Date), 72341, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E27621', 1, CAST(N'2013-11-27' AS Date), CAST(N'2100-01-02' AS Date), 28969, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E27909', 1, CAST(N'2014-06-20' AS Date), CAST(N'2100-01-03' AS Date), 43778, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E28092', 8, CAST(N'2008-11-01' AS Date), CAST(N'2100-04-11' AS Date), 174651, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E28638', 8, CAST(N'2004-06-02' AS Date), CAST(N'2100-04-12' AS Date), 123909, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E29129', 8, CAST(N'2007-12-03' AS Date), CAST(N'2100-05-11' AS Date), 118753, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E29652', 10, CAST(N'2007-06-14' AS Date), CAST(N'2100-07-14' AS Date), 115791, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E30058', 8, CAST(N'2013-09-24' AS Date), CAST(N'2100-04-13' AS Date), 81047, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E30317', 6, CAST(N'2019-01-03' AS Date), CAST(N'2100-03-31' AS Date), 66952, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E30678', 8, CAST(N'2020-05-02' AS Date), CAST(N'2100-04-14' AS Date), 91389, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E31241', 8, CAST(N'2014-05-10' AS Date), CAST(N'2100-04-15' AS Date), 157102, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E31931', 9, CAST(N'2013-09-26' AS Date), CAST(N'2100-06-09' AS Date), 38206, N'E63041', 3, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E32058', 8, CAST(N'2009-01-19' AS Date), CAST(N'2100-04-16' AS Date), 140534, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E32359', 8, CAST(N'2019-03-24' AS Date), CAST(N'2100-05-12' AS Date), 102779, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E33486', 4, CAST(N'2000-08-02' AS Date), CAST(N'2100-02-23' AS Date), 153296, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E34496', 1, CAST(N'2009-01-27' AS Date), CAST(N'2100-01-28' AS Date), 31405, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E34500', 3, CAST(N'1997-01-17' AS Date), CAST(N'2100-02-08' AS Date), 113744, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E34748', 6, CAST(N'2011-04-28' AS Date), CAST(N'2100-03-17' AS Date), 71942, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E34816', 8, CAST(N'2000-08-01' AS Date), CAST(N'2100-04-17' AS Date), 82192, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E35053', 1, CAST(N'2009-03-01' AS Date), CAST(N'2100-01-04' AS Date), 41090, N'E63041', 3, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E35075', 1, CAST(N'2007-08-29' AS Date), CAST(N'2100-01-09' AS Date), 51633, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E35856', 10, CAST(N'2017-05-03' AS Date), CAST(N'2100-06-25' AS Date), 99864, N'E44426', 5, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E35860', 8, CAST(N'1999-08-18' AS Date), CAST(N'2100-04-18' AS Date), 125831, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E36346', 8, CAST(N'1999-06-22' AS Date), CAST(N'2100-05-13' AS Date), 100092, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E36960', 6, CAST(N'2008-04-26' AS Date), CAST(N'2100-03-18' AS Date), 101294, N'E44426', 5, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E36988', 9, CAST(N'2015-10-31' AS Date), CAST(N'2100-06-10' AS Date), 48680, N'E63041', 3, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E37246', 2, CAST(N'2013-10-23' AS Date), CAST(N'2100-02-03' AS Date), 103370, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E37389', 8, CAST(N'1996-12-08' AS Date), CAST(N'2100-05-14' AS Date), 172479, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E37523', 1, CAST(N'2017-12-02' AS Date), CAST(N'2100-01-21' AS Date), 35638, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E38634', 4, CAST(N'2014-11-22' AS Date), CAST(N'2100-02-24' AS Date), 144638, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E38677', 4, CAST(N'2014-04-17' AS Date), CAST(N'2100-02-20' AS Date), 201404, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E38959', 10, CAST(N'2006-09-16' AS Date), CAST(N'2100-07-15' AS Date), 83327, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E38997', 8, CAST(N'2007-09-21' AS Date), CAST(N'2100-05-15' AS Date), 173887, N'E88667', 2, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E39652', 8, CAST(N'2012-08-11' AS Date), CAST(N'2100-04-19' AS Date), 71867, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E40432', 10, CAST(N'2010-01-30' AS Date), CAST(N'2100-06-26' AS Date), 130129, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E41635', 3, CAST(N'2005-03-26' AS Date), CAST(N'2100-02-09' AS Date), 134237, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E41712', 3, CAST(N'2012-01-06' AS Date), CAST(N'2100-02-13' AS Date), 87465, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E42061', 8, CAST(N'2013-11-04' AS Date), CAST(N'2100-05-16' AS Date), 212551, N'E88667', 5, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E42522', 3, CAST(N'2007-05-26' AS Date), CAST(N'2100-02-14' AS Date), 79694, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E42681', 8, CAST(N'1996-04-09' AS Date), CAST(N'2100-04-20' AS Date), 101469, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E43694', 4, CAST(N'2016-10-28' AS Date), CAST(N'2100-03-07' AS Date), 159035, N'E88667', 5, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E44136', 8, CAST(N'2002-01-09' AS Date), CAST(N'2100-05-17' AS Date), 70148, N'E88667', 5, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E44426', 5, CAST(N'2007-05-02' AS Date), CAST(N'2100-03-11' AS Date), 205000, N'E17054', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E45236', 8, CAST(N'2008-05-29' AS Date), CAST(N'2100-05-18' AS Date), 123476, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E45405', 9, CAST(N'2000-09-06' AS Date), CAST(N'2100-06-11' AS Date), 40083, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E45736', 4, CAST(N'2015-04-04' AS Date), CAST(N'2100-02-21' AS Date), 156298, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E45758', 3, CAST(N'2017-12-19' AS Date), CAST(N'2100-02-15' AS Date), 144623, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E45824', 1, CAST(N'2017-10-03' AS Date), CAST(N'2100-01-13' AS Date), 51052, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E46366', 8, CAST(N'2004-10-16' AS Date), CAST(N'2100-04-21' AS Date), 133564, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E47655', 4, CAST(N'1997-11-27' AS Date), CAST(N'2100-03-01' AS Date), 207651, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E47926', 6, CAST(N'2008-05-31' AS Date), CAST(N'2100-04-01' AS Date), 85880, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E48148', 1, CAST(N'2013-02-19' AS Date), CAST(N'2100-01-14' AS Date), 39450, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E48637', 3, CAST(N'1999-09-26' AS Date), CAST(N'2100-02-16' AS Date), 140231, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E48884', 6, CAST(N'2008-06-01' AS Date), CAST(N'2100-03-19' AS Date), 103714, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E49025', 2, CAST(N'2005-06-09' AS Date), CAST(N'2100-02-04' AS Date), 111308, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E49459', 9, CAST(N'2020-03-28' AS Date), CAST(N'2100-06-12' AS Date), 42145, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E49798', 8, CAST(N'1998-01-09' AS Date), CAST(N'2100-04-22' AS Date), 79408, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E50012', 1, CAST(N'2009-10-01' AS Date), CAST(N'2100-01-15' AS Date), 37136, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E51619', 3, CAST(N'2011-10-05' AS Date), CAST(N'2100-02-10' AS Date), 122334, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E51723', 1, CAST(N'2014-05-23' AS Date), CAST(N'2100-01-05' AS Date), 35825, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E52461', 8, CAST(N'2014-11-11' AS Date), CAST(N'2100-05-19' AS Date), 196705, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E52489', 9, CAST(N'2002-12-05' AS Date), CAST(N'2100-06-13' AS Date), 27045, N'E63041', 1, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E53406', 4, CAST(N'2001-10-25' AS Date), CAST(N'2100-02-25' AS Date), 81812, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E53895', 9, CAST(N'2014-10-27' AS Date), CAST(N'2100-06-14' AS Date), 28700, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E54196', 8, CAST(N'2004-12-18' AS Date), CAST(N'2100-04-23' AS Date), 156344, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E55855', 8, CAST(N'2018-05-20' AS Date), CAST(N'2100-05-20' AS Date), 175296, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E55880', 9, CAST(N'1995-07-18' AS Date), CAST(N'2100-06-15' AS Date), 43410, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E56144', 4, CAST(N'2013-01-28' AS Date), CAST(N'2100-02-22' AS Date), 169184, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E56444', 8, CAST(N'1999-06-10' AS Date), CAST(N'2100-05-21' AS Date), 87817, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E56459', 1, CAST(N'2016-04-21' AS Date), CAST(N'2100-01-10' AS Date), 42313, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E57502', 8, CAST(N'2016-07-21' AS Date), CAST(N'2100-04-24' AS Date), 162790, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E57987', 1, CAST(N'2016-05-15' AS Date), CAST(N'2100-01-22' AS Date), 49786, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E59688', 1, CAST(N'2006-01-11' AS Date), CAST(N'2100-01-06' AS Date), 34809, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E60752', 3, CAST(N'2010-02-27' AS Date), CAST(N'2100-02-17' AS Date), 138695, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E60901', 8, CAST(N'2010-01-10' AS Date), CAST(N'2100-05-22' AS Date), 87887, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E60929', 4, CAST(N'2013-07-03' AS Date), CAST(N'2100-03-05' AS Date), 195992, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E61614', 8, CAST(N'1996-07-21' AS Date), CAST(N'2100-05-23' AS Date), 174060, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E61947', 8, CAST(N'2010-03-04' AS Date), CAST(N'2100-05-24' AS Date), 212353, N'E88667', 3, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E62100', 10, CAST(N'2000-02-15' AS Date), CAST(N'2100-07-16' AS Date), 122810, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E62527', 6, CAST(N'2006-06-15' AS Date), CAST(N'2100-03-20' AS Date), 49816, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E62634', 6, CAST(N'2014-08-19' AS Date), CAST(N'2100-03-21' AS Date), 65515, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E63041', 5, CAST(N'1995-08-22' AS Date), CAST(N'2100-03-10' AS Date), 176000, N'E17054', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E63930', 8, CAST(N'2009-02-25' AS Date), CAST(N'2100-04-25' AS Date), 125439, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E63937', 10, CAST(N'2014-07-15' AS Date), CAST(N'2100-07-17' AS Date), 84143, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E64494', 10, CAST(N'2007-05-11' AS Date), CAST(N'2100-06-27' AS Date), 140024, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E64920', 10, CAST(N'2019-05-11' AS Date), CAST(N'2100-06-28' AS Date), 153717, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E65052', 8, CAST(N'1995-09-15' AS Date), CAST(N'2100-05-25' AS Date), 103346, N'E88667', 3, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E66477', 6, CAST(N'2018-05-08' AS Date), CAST(N'2100-04-02' AS Date), 86055, N'E77884', 3, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E67190', 8, CAST(N'2007-07-24' AS Date), CAST(N'2100-04-26' AS Date), 86624, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E67793', 6, CAST(N'2018-06-07' AS Date), CAST(N'2100-03-22' AS Date), 52924, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E68807', 8, CAST(N'2010-11-10' AS Date), CAST(N'2100-05-26' AS Date), 175879, N'E88667', 3, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E69297', 9, CAST(N'2013-03-21' AS Date), CAST(N'2100-06-16' AS Date), 31349, N'E63041', 5, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E70374', 8, CAST(N'2007-08-19' AS Date), CAST(N'2100-05-27' AS Date), 123946, N'E88667', 3, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E70603', 8, CAST(N'2006-07-06' AS Date), CAST(N'2100-05-28' AS Date), 89696, N'E88667', 3, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E71128', 9, CAST(N'1998-01-28' AS Date), CAST(N'2100-06-17' AS Date), 48749, N'E63041', 4, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E71792', 4, CAST(N'2014-03-30' AS Date), CAST(N'2100-03-08' AS Date), 123496, N'E88667', 3, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E72436', 8, CAST(N'2013-05-11' AS Date), CAST(N'2100-05-29' AS Date), 134130, N'E88667', 4, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E73518', 1, CAST(N'2001-03-24' AS Date), CAST(N'2100-01-23' AS Date), 51207, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E74296', 1, CAST(N'2016-12-19' AS Date), CAST(N'2100-01-24' AS Date), 47909, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E74490', 8, CAST(N'1999-05-22' AS Date), CAST(N'2100-05-30' AS Date), 196226, N'E88667', 4, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E75081', 4, CAST(N'2008-10-08' AS Date), CAST(N'2100-02-26' AS Date), 132436, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E75344', 10, CAST(N'2009-03-20' AS Date), CAST(N'2100-06-29' AS Date), 135656, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E76053', 4, CAST(N'1998-08-23' AS Date), CAST(N'2100-03-06' AS Date), 83548, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E76443', 2, CAST(N'2020-02-16' AS Date), CAST(N'2100-02-05' AS Date), 114582, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E77317', 1, CAST(N'2015-05-20' AS Date), CAST(N'2100-01-25' AS Date), 34693, N'E77884', 4, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E77658', 3, CAST(N'2012-03-15' AS Date), CAST(N'2100-02-18' AS Date), 113702, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E77884', 5, CAST(N'2002-12-09' AS Date), CAST(N'2100-03-12' AS Date), 187000, N'E17054', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E78732', 1, CAST(N'2020-01-24' AS Date), CAST(N'2100-01-11' AS Date), 34084, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E79464', 4, CAST(N'1999-05-01' AS Date), CAST(N'2100-02-27' AS Date), 177673, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E79552', 6, CAST(N'2008-02-05' AS Date), CAST(N'2100-03-23' AS Date), 84625, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E80744', 6, CAST(N'2020-01-09' AS Date), CAST(N'2100-04-03' AS Date), 96416, N'E77884', 5, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E81369', 6, CAST(N'2019-05-29' AS Date), CAST(N'2100-03-24' AS Date), 93362, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E81502', 1, CAST(N'1999-10-24' AS Date), CAST(N'2100-01-16' AS Date), 34677, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E82137', 10, CAST(N'2006-10-04' AS Date), CAST(N'2100-06-30' AS Date), 97040, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E83512', 6, CAST(N'1996-10-22' AS Date), CAST(N'2100-03-25' AS Date), 103110, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E83558', 1, CAST(N'1997-10-15' AS Date), CAST(N'2100-01-17' AS Date), 45210, N'E44426', 1, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E84122', 10, CAST(N'2017-10-28' AS Date), CAST(N'2100-07-01' AS Date), 78751, N'E44426', 5, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E85476', 3, CAST(N'2003-07-22' AS Date), CAST(N'2100-02-19' AS Date), 71982, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E85640', 10, CAST(N'2001-02-03' AS Date), CAST(N'2100-07-02' AS Date), 126529, N'E44426', 5, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E86238', 9, CAST(N'2012-04-21' AS Date), CAST(N'2100-06-18' AS Date), 30081, N'E63041', 4, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E86828', 2, CAST(N'2011-09-29' AS Date), CAST(N'2100-02-06' AS Date), 116831, N'E44426', 5, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E87073', 8, CAST(N'2007-01-02' AS Date), CAST(N'2100-04-27' AS Date), 146429, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E87210', 4, CAST(N'2014-04-18' AS Date), CAST(N'2100-03-02' AS Date), 176207, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E87219', 1, CAST(N'2017-09-20' AS Date), CAST(N'2100-01-29' AS Date), 34826, N'E88667', 4, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E87230', 8, CAST(N'2014-11-10' AS Date), CAST(N'2100-05-31' AS Date), 144637, N'E88667', 4, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E87370', 8, CAST(N'2013-11-18' AS Date), CAST(N'2100-06-01' AS Date), 105960, N'E88667', 5, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E87822', 10, CAST(N'2014-04-02' AS Date), CAST(N'2100-07-18' AS Date), 90884, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E88667', 5, CAST(N'1995-12-21' AS Date), CAST(N'2100-03-13' AS Date), 210000, N'E17054', 5, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E88864', 8, CAST(N'2008-11-15' AS Date), CAST(N'2100-06-02' AS Date), 209418, N'E88667', 5, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E89540', 1, CAST(N'2017-06-01' AS Date), CAST(N'2100-01-30' AS Date), 38176, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E90222', 8, CAST(N'2016-11-01' AS Date), CAST(N'2100-06-03' AS Date), 158549, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E90407', 1, CAST(N'2010-12-15' AS Date), CAST(N'2100-01-12' AS Date), 28373, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E90435', 9, CAST(N'2017-02-20' AS Date), CAST(N'2100-06-19' AS Date), 52933, N'E63041', 4, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E90439', 10, CAST(N'2000-07-23' AS Date), CAST(N'2100-07-03' AS Date), 92788, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E90990', 10, CAST(N'2014-11-16' AS Date), CAST(N'2100-07-04' AS Date), 118125, N'E44426', 3, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E91075', 6, CAST(N'2019-12-15' AS Date), CAST(N'2100-03-26' AS Date), 68127, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E91182', 8, CAST(N'2013-05-18' AS Date), CAST(N'2100-04-28' AS Date), 96015, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E91791', 1, CAST(N'2017-06-02' AS Date), CAST(N'2100-01-26' AS Date), 29593, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E93629', 4, CAST(N'2013-07-22' AS Date), CAST(N'2100-03-09' AS Date), 183807, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E93715', 8, CAST(N'1998-04-29' AS Date), CAST(N'2100-06-04' AS Date), 196650, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E93734', 8, CAST(N'2005-06-21' AS Date), CAST(N'2100-04-29' AS Date), 111114, N'E77884', 1, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E93871', 8, CAST(N'2002-04-30' AS Date), CAST(N'2100-04-30' AS Date), 88910, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E94358', 1, CAST(N'2007-07-08' AS Date), CAST(N'2100-01-27' AS Date), 48239, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E94387', 8, CAST(N'2003-07-25' AS Date), CAST(N'2100-05-01' AS Date), 191995, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E94552', 10, CAST(N'2013-10-31' AS Date), CAST(N'2100-07-05' AS Date), 153362, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E95190', 9, CAST(N'2016-04-26' AS Date), CAST(N'2100-06-20' AS Date), 51407, N'E63041', 4, 1)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E95199', 8, CAST(N'2017-01-09' AS Date), CAST(N'2100-05-02' AS Date), 153889, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E95214', 4, CAST(N'2019-09-22' AS Date), CAST(N'2100-03-03' AS Date), 93400, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E96856', 4, CAST(N'2017-11-27' AS Date), CAST(N'2100-02-28' AS Date), 127669, N'E17054', 2, 2)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E96966', 10, CAST(N'2014-12-19' AS Date), CAST(N'2100-07-06' AS Date), 134250, N'E44426', 4, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E97018', 10, CAST(N'2000-09-08' AS Date), CAST(N'2100-07-07' AS Date), 151379, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E97273', 8, CAST(N'2004-06-05' AS Date), CAST(N'2100-05-03' AS Date), 137555, N'E77884', 2, 4)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E98270', 3, CAST(N'1997-12-24' AS Date), CAST(N'2100-02-11' AS Date), 99218, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E98559', 8, CAST(N'2006-11-11' AS Date), CAST(N'2100-06-05' AS Date), 101957, N'E88667', 1, 5)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E98891', 2, CAST(N'2017-09-30' AS Date), CAST(N'2100-02-07' AS Date), 110704, N'E44426', 2, 3)
GO
INSERT [dbo].[AlkalmazottMunkakorok]
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E99949', 1, CAST(N'2005-05-26' AS Date), CAST(N'2100-01-18' AS Date), 50043, N'E44426', 2, 3)
GO
SET IDENTITY_INSERT [dbo].[Irodak] ON 
GO
INSERT [dbo].[Irodak]
    ([IrodaID], [Nev], [Cim])
VALUES
    (1, N'East Coast', N'165 Broadway')
GO
INSERT [dbo].[Irodak]
    ([IrodaID], [Nev], [Cim])
VALUES
    (2, N'HQ', N'1 Tech ABC Corp Way')
GO
INSERT [dbo].[Irodak]
    ([IrodaID], [Nev], [Cim])
VALUES
    (3, N'Midwest', N'1300 Nicollet Mall')
GO
INSERT [dbo].[Irodak]
    ([IrodaID], [Nev], [Cim])
VALUES
    (4, N'South', N'422 Broadway')
GO
INSERT [dbo].[Irodak]
    ([IrodaID], [Nev], [Cim])
VALUES
    (5, N'West Coast', N'705 James Way')
GO
SET IDENTITY_INSERT [dbo].[Irodak] OFF
GO
SET IDENTITY_INSERT [dbo].[Munkakorok] ON 
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (1, N'Administrative Assistant')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (2, N'Database Administrator')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (3, N'Design Engineer')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (4, N'Legal Counsel')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (5, N'Manager')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (6, N'Network Engineer')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (7, N'President')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (8, N'Sales Rep')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (9, N'Shipping and Receiving')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (10, N'Software Engineer')
GO
INSERT [dbo].[Munkakorok]
    ([MunkakorID], [Nev])
VALUES
    (11, N'Data Scientist')
GO
SET IDENTITY_INSERT [dbo].[Munkakorok] OFF
GO
SET IDENTITY_INSERT [dbo].[Reszlegek] ON 
GO
INSERT [dbo].[Reszlegek]
    ([ReszlegID], [Nev])
VALUES
    (1, N'Distribution')
GO
INSERT [dbo].[Reszlegek]
    ([ReszlegID], [Nev])
VALUES
    (2, N'HQ')
GO
INSERT [dbo].[Reszlegek]
    ([ReszlegID], [Nev])
VALUES
    (3, N'IT')
GO
INSERT [dbo].[Reszlegek]
    ([ReszlegID], [Nev])
VALUES
    (4, N'Product Development')
GO
INSERT [dbo].[Reszlegek]
    ([ReszlegID], [Nev])
VALUES
    (5, N'Sales')
GO
SET IDENTITY_INSERT [dbo].[Reszlegek] OFF
GO
SET IDENTITY_INSERT [dbo].[Varosok] ON 
GO
INSERT [dbo].[Varosok]
    ([VarosID], [VarosNev], [AllamKod])
VALUES
    (1, N'Dallas', N'TX')
GO
INSERT [dbo].[Varosok]
    ([VarosID], [VarosNev], [AllamKod])
VALUES
    (2, N'Minnapolis', N'MN')
GO
INSERT [dbo].[Varosok]
    ([VarosID], [VarosNev], [AllamKod])
VALUES
    (3, N'Nashville', N'TN')
GO
INSERT [dbo].[Varosok]
    ([VarosID], [VarosNev], [AllamKod])
VALUES
    (4, N'New York City', N'NY')
GO
INSERT [dbo].[Varosok]
    ([VarosID], [VarosNev], [AllamKod])
VALUES
    (5, N'San Francisco', N'CA')
GO
INSERT [dbo].[Varosok]
    ([VarosID], [VarosNev], [AllamKod])
VALUES
    (6, N'Hollywood', N'CA')
GO
SET IDENTITY_INSERT [dbo].[Varosok] OFF
GO
SET IDENTITY_INSERT [dbo].[Vegzettsegek] ON 
GO
INSERT [dbo].[Vegzettsegek]
    ([VegzettsegID], [VegzettsegiSzint])
VALUES
    (1, N'Associates Degree')
GO
INSERT [dbo].[Vegzettsegek]
    ([VegzettsegID], [VegzettsegiSzint])
VALUES
    (2, N'Bachelors Degree')
GO
INSERT [dbo].[Vegzettsegek]
    ([VegzettsegID], [VegzettsegiSzint])
VALUES
    (3, N'Doctorate')
GO
INSERT [dbo].[Vegzettsegek]
    ([VegzettsegID], [VegzettsegiSzint])
VALUES
    (4, N'Masters Degree')
GO
INSERT [dbo].[Vegzettsegek]
    ([VegzettsegID], [VegzettsegiSzint])
VALUES
    (5, N'Masters of Business Administration')
GO
INSERT [dbo].[Vegzettsegek]
    ([VegzettsegID], [VegzettsegiSzint])
VALUES
    (6, N'No College')
GO
INSERT [dbo].[Vegzettsegek]
    ([VegzettsegID], [VegzettsegiSzint])
VALUES
    (7, N'Some College')
GO
SET IDENTITY_INSERT [dbo].[Vegzettsegek] OFF
GO
ALTER TABLE [dbo].[Alkalmazottak] ADD  DEFAULT ('UNKNOWN') FOR [Email]
GO
ALTER TABLE [dbo].[Alkalmazottak] ADD  DEFAULT ('1900-01-01') FOR [AlkamazasKezdete]
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok] ADD  DEFAULT ((0)) FOR [Fizetes]
GO
ALTER TABLE [dbo].[Reszlegek] ADD  DEFAULT ('UNKNOWN') FOR [Nev]
GO
ALTER TABLE [dbo].[Varosok] ADD  DEFAULT ('HU') FOR [AllamKod]
GO
ALTER TABLE [dbo].[Alkalmazottak]  WITH CHECK ADD FOREIGN KEY([VarosID])
REFERENCES [dbo].[Varosok] ([VarosID])
GO
ALTER TABLE [dbo].[Alkalmazottak]  WITH CHECK ADD FOREIGN KEY([VegzettsegID])
REFERENCES [dbo].[Vegzettsegek] ([VegzettsegID])
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok]  WITH CHECK ADD FOREIGN KEY([IrodaID])
REFERENCES [dbo].[Irodak] ([IrodaID])
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok]  WITH CHECK ADD FOREIGN KEY([ReszlegID])
REFERENCES [dbo].[Reszlegek] ([ReszlegID])
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok]  WITH CHECK ADD  CONSTRAINT [FK_AlkalmazottMunkakorok_AlkalmazottID] FOREIGN KEY([AlkalmazottID])
REFERENCES [dbo].[Alkalmazottak] ([AlkalmazottID])
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok] CHECK CONSTRAINT [FK_AlkalmazottMunkakorok_AlkalmazottID]
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok]  WITH CHECK ADD  CONSTRAINT [FK_AlkalmazottMunkakorok_MenedzserID] FOREIGN KEY([MenedzserID])
REFERENCES [dbo].[Alkalmazottak] ([AlkalmazottID])
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok] CHECK CONSTRAINT [FK_AlkalmazottMunkakorok_MenedzserID]
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok]   ADD CONSTRAINT [FK_AlkalmazottMunkakorok_MunkakorID] FOREIGN KEY([MunkakorID])
REFERENCES [dbo].[Munkakorok] ([MunkakorID])
GO
ALTER TABLE [dbo].[AlkalmazottMunkakorok] CHECK CONSTRAINT [FK_AlkalmazottMunkakorok_MunkakorID]
GO
USE [master]
GO
ALTER DATABASE [HR] SET  READ_WRITE 
GO
USE HR

