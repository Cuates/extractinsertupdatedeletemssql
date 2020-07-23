USE [DatabaseName]
GO

-- Set ansi nulls
SET ANSI_NULLS ON
GO

-- Set quoted identifier
SET QUOTED_IDENTIFIER ON
GO

-- ==========================
--        File: TableEntries
--     Created: 07/22/2020
--     Updated: 07/22/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Table entries
-- ==========================
CREATE TABLE [dbo].[TableEntries](
  [teID] [int] identity (1, 1) not null,
  [created_date] [datetime2](7) not null,
  [modified_date] [datetime2](7) not null,
  [userIdentifier] [int] not null,
  [columnOne] [nvarchar](255) not null,
  [columnTwo] [nvarchar](255) not null,
CONSTRAINT [PK_TableEntries] PRIMARY KEY CLUSTERED
(
  [columnOne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TableEntries] ADD  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dbo].[TableEntries] ADD  DEFAULT (getdate()) FOR [modified_date]
GO