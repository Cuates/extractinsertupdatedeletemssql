use [DatabaseName]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- ==========================
--        File: TableEntries
--     Created: 07/22/2020
--     Updated: 07/29/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Table entries
-- ==========================
create table [dbo].[TableEntries](
  [teID] [bigint] identity (1, 1) not null,
  [created_date] [datetime2](7) not null,
  [modified_date] [datetime2](7) not null,
  [userIdentifier] [int] not null,
  [columnOne] [nvarchar](255) not null,
  [columnTwo] [nvarchar](255) not null,
  constraint [PK_TableEntries] primary key clustered
  (
    [columnOne] asc
  )with (pad_index = off, statistics_norecompute = off, ignore_dup_key = off, allow_row_locks = on, allow_page_locks = on, fillfactor = 90) on [primary]
) on [primary]
go

alter table [dbo].[TableEntries] add  default (getdate()) for [created_date]
go

alter table [dbo].[TableEntries] add  default (getdate()) for [modified_date]
go