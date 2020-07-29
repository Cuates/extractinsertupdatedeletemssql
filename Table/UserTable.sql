use [DatabaseName]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- =======================
--        File: UserTable
--     Created: 07/22/2020
--     Updated: 07/29/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: User table
-- =======================
create table [dbo].[UserTable](
  [utID] [bigint] identity (1, 1) not null,
  [userID] [nvarchar](100) not null,
  [userNumber] [int] not null,
  [created_date] [datetime2](7) null,
  [modified_date] [datetime2](7) null,
  constraint [UK_UserTable_userID] unique nonclustered
  (
    [userID] asc
  )with (pad_index = off, statistics_norecompute = off, ignore_dup_key = off, allow_row_locks = on, allow_page_locks = on) on [primary],
  constraint [UK_UserTable_userNumber] unique nonclustered
  (
    [userNumber] asc
  )with (pad_index = off, statistics_norecompute = off, ignore_dup_key = off, allow_row_locks = on, allow_page_locks = on) on [primary]
) on [primary]
go

alter table [dbo].[UserTable] add  default (getdate()) for [created_date]
go

alter table [dbo].[UserTable] add  default (getdate()) for [modified_date]
go