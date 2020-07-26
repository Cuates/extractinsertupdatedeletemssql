USE [DatabaseName]
GO

-- Set ansi nulls
SET ANSI_NULLS ON
GO

-- Set quoted identifier
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
--        File: UserTable
--     Created: 07/22/2020
--     Updated: 07/26/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: User table
-- =============================================
CREATE TABLE [dbo].[UserTable](
  [utID] [int] identity (1, 1) not null,
  [userID] [nvarchar](100) not null,
  [userNumber] [int] not null,
  [created_date] [datetime2](7) null,
  [modified_date] [datetime2](7) null,
  CONSTRAINT [UK_userID] UNIQUE NONCLUSTERED
  (
    [userID] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
  CONSTRAINT [UK_userNumber] UNIQUE NONCLUSTERED
  (
    [userNumber] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserTable] ADD  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dbo].[UserTable] ADD  DEFAULT (getdate()) FOR [modified_date]
GO