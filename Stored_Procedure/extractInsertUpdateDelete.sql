use [DatabaseName]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- =========================================
--        File: extractInsertUpdateDelete
--     Created: 07/25/2020
--     Updated: 07/29/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Extract insert update delete
-- =========================================
create procedure [dbo].[extractInsertUpdateDelete]
  -- Parameters
  @optionMode nvarchar(255),
  @userIdentifierString as nvarchar(255) = null,
  @columnOneString nvarchar(255) = null,
  @columnTwoString nvarchar(255) = null,
  @columnTwoStringNew nvarchar(255) = null
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Declare variables
  declare @attempts as smallint
  declare @userIdentifier as int

  -- Set variables
  set @attempts = 1

  -- Omit characters
  set @optionMode = dbo.OmitCharacters(@optionMode, '65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')

  -- Check if empty string
  if @optionMode = ''
    begin
      -- Set parameter to null if empty string
      set @optionMode = nullif(@optionMode, '')
    end

  -- Omit characters
  set @userIdentifierString = dbo.OmitCharacters(@userIdentifierString, '48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')

  -- Check if empty string
  if @userIdentifierString = ''
    begin
      -- Set parameter to null if empty string
      set @userIdentifierString = nullif(@userIdentifierString, '')
    end

  -- Omit characters
  set @columnOneString = dbo.OmitCharacters(@columnOneString, '45,48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')

  -- Check if empty string
  if @columnOneString = ''
    begin
      -- Set parameter to null if empty string
      set @columnOneString = nullif(@columnOneString, '')
    end

  -- Omit characters
  set @columnTwoString = dbo.OmitCharacters(@columnTwoString, '45,48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')

  -- Check if empty string
  if @columnTwoString = ''
    begin
      -- Set parameter to null if empty string
      set @columnTwoString = nullif(@columnTwoString, '')
    end

  -- Omit characters
  set @columnTwoStringNew = dbo.OmitCharacters(@columnTwoStringNew, '45,48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')

  -- Check if empty string
  if @columnTwoStringNew = ''
    begin
      -- Set parameter to null if empty string
      set @columnTwoStringNew = nullif(@columnTwoStringNew, '')
    end

  -- Check if option mode is extract entries by column one
  if @optionMode = 'extractEntriesColumnOne'
    begin
      -- Select record
      select
      ltrim(rtrim(te.columnOne)) as [Column One],
      ltrim(rtrim(te.columnTwo)) as [Column Two]
      from dbo.TableEntries te
      where
      te.columnOne = @columnOneString
    end

  -- Else check if option mode is extract table entries report
  else if @optionMode = 'extractTableEntriesReport'
    begin
      -- Select record
      select
      ltrim(rtrim(te.columnOne)) as [Column One],
      ltrim(rtrim(te.columnTwo)) as [Column Two]
      from dbo.TableEntries te
      group by te.columnOne, te.columnTwo
      order by ltrim(rtrim(te.columnOne)) asc
    end

  -- Else check if option mode is insert column one and column two entry
  else if @optionMode = 'insertColumnOneColumnTwoEntry'
    begin
      -- Check if parameters are null
      if @userIdentifierString is null or @columnOneString is null or @columnTwoString is null
        begin
          -- Select message
          select
          'Error~insertColumnOneColumnTwoEntry: Process halted, user identifier string, column one string, and or column two string were not provided' as [Status]
        end
      else
        begin
          -- Try casting value to integer
          if try_cast(@userIdentifierString as integer) is not null
            begin
              -- Select and set variable
              select
              @userIdentifier = ut.utID
              from dbo.UserTable ut
              where
              ut.userNumber = @userIdentifierString
            end
          else
            begin
              -- Select and set variable
              select
              top 1
              @userIdentifier = ut.ID
              from dbo.UserTable ut
              where
              ut.userID = @userIdentifierString
              order by ut.utID desc
            end

          -- Check if the user identifier is not null
          if @userIdentifier is null
            begin
              -- Select message
              select
              'Error~insertColumnOneColumnTwoEntry: Process halted, user identifier was not retrieved' as [Status]
            end
          else
            begin
              -- Set variables
              set @columnOneString = upper(@columnOneString)
              set @columnTwoString = upper(@columnTwoString)

              -- Check if a record already exists
              if not exists
              (
                -- Select record
                select
                te.teID as [teID]
                from dbo.TableEntries te
                where
                te.columnOne = @columnOneString
              )
                begin
                  -- Loop until condition is met
                  while @attempts <= 5
                    begin
                      -- Begin the tranaction
                      begin tran
                        -- Begin the try block
                        begin try
                          -- Insert record
                          insert into dbo.TableEntries (userIdentifier, columnOne, columnTwo, created_date, modified_date) values (@userIdentifier, @columnOneString, @columnTwoString, getdate(), getdate())

                          -- Select message
                          select
                          'Success~Insert entry recorded' as [Status]

                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Commit transactional statement
                              commit tran
                            end

                          -- Break out of the loop
                          break
                        end try
                        -- End try block
                        -- Begin catch block
                        begin catch
                          -- Only display an error message if it is on the final attempt of the execution
                          if @attempts = 5
                            begin
                              -- Select error number, line, and message
                              select
                              'Error~insertColumnOneColumnTwoEntry: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
                            end

                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Rollback to the previous state before the transaction was called
                              rollback
                            end

                          -- Increments the loop control for attempts
                          set @attempts = @attempts + 1

                          -- Wait for delay for x amount of time
                          waitfor delay '00:00:04'

                          -- Continue the loop
                          continue
                        end catch
                        -- End catch block
                    end
                end
              else
                begin
                  -- Select message
                  select
                  'Success~Process halted, Entry already exists' as [Status]
                end
            end
        end
    end

  -- Else check if option mode is update column two
  else if @optionMode = 'updateColumnTwo'
    begin
      -- Check if parameters are null
      if @userIdentifierString is null or @columnOneString is null or @columnTwoString is null or @columnTwoStringNew is null
        begin
          -- Select message
          select
          'Error~updateColumnTwo: Process halted, user identifier string, column one string, column two string, and or column two string new were not provided' as [Status]
        end
      else
        begin
          -- Try casting value to integer
          if try_cast(@userIdentifierString as integer) is not null
            begin
              -- Select and set variable
              select
              @userIdentifier = ut.utID
              from dbo.UsertTable ut
              where
              ut.userNumber = @userIdentifierString
            end
          else
            begin
              -- Select and set variable
              select
              top 1
              @userIdentifier = ut.utID
              from dbo.UserTable ut
              where
              ut.userID = @userIdentifierString
              order by ut.utID desc
            end

          -- Check if the user identifier is not null
          if @userIdentifier is null
            begin
              -- Select message
              select
              'Error~updateColumnTwo: Process halted, user identifier was not retrieved' as [Status]
            end
          else
            begin
              -- Set variables
              set @columnOneString = upper(@columnOneString)
              set @columnTwoString = upper(@columnTwoString)
              set @columnTwoStringNew = upper(@columnTwoStringNew)

              -- Check if a record already exists
              if exists
              (
                -- Select record
                select
                te.teID as [teID]
                from dbo.TableEntries te
                where
                te.columnOne = @columnOneString and
                te.columnTwo = @columnTwoString
              )
                begin
                  -- Check if the new record does not already exist
                  if not exists
                  (
                    -- Select record
                    select
                    te.teID as [teID]
                    from dbo.TableEntries te
                    where
                    ltrim(rtrim(te.columnOne)) = @columnOneString and
                    ltrim(rtrim(te.columnTwo)) = @columnTwoStringNew
                  )
                    begin
                      -- Loop until condition is met
                      while @attempts <= 5
                        begin
                          -- Begin the tranaction
                          begin tran
                            -- Begin the try block
                            begin try
                              -- Update record
                              update dbo.TableEntries
                              set
                              userIdentifier = @userIdentifier,
                              columnTwo = @columnTwoStringNew,
                              modified_date = getdate()
                              where
                              columnOne = @columnOneString and
                              columnTwo = @columnTwoString

                              -- Select message
                              select
                              'Success~Column two updated' as [Status]

                              -- Check if there is trans count
                              if @@trancount > 0
                                begin
                                  -- Commit transactional statement
                                  commit tran
                                end

                              -- Break out of the loop
                              break
                            end try
                            -- End try block
                            -- Begin catch block
                            begin catch
                              -- Only display an error message if it is on the final attempt of the execution
                              if @attempts = 5
                                begin
                                  -- Select error number, line, and message
                                  select
                                  'Error~updateColumnTwo: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_ling() as nvarchar) + ' Error Message: ' + error_message() as [Status]
                                end

                              -- Check if there is trans count
                              if @@trancount > 0
                                begin
                                  -- Rollback to the previous state before the transaction was called
                                  rollback
                                end

                              -- Increments the loop control for attempts
                              set @attempts = @attempts + 1

                              -- Wait for delay for x amount of time
                              waitfor delay '00:00:04'

                              -- Continue the loop
                              continue
                            end catch
                            -- End catch block
                        end
                    end
                  else
                    begin
                      -- Select message
                      select
                      'Success~Column one already associated' as [Status]
                    end
                end
              else
                begin
                  -- Select message
                  select
                  'Error~updateColumnTwo: Entry not found to update' as [Status]
                end
            end
        end
    end

  -- Else check if option mode is delete column one entry
  else if @optionMode = 'deleteColumnOneEntry'
    begin
      -- Check if parameter is null
      if @columnOneString is null
        begin
          -- Select message
          select
          'Error~deleteColumnOneEntry: Process halted, column one string was not provided' as [Status]
        end
      else
        begin
          -- Set variables
          set @columnOneString = upper(@columnOneString)

          -- Check if a record already exists
          if exists
          (
            -- Select record
            select
            te.teID as [teID]
            from dbo.TableEntries te
            where
            te.columnOne = @columnOneString
          )
            begin
              -- Loop until condition is met
              while @attempts <= 5
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Delete record
                      delete from dbo.TableEntries
                      where
                      columnOne = @columnOneString

                      -- Select message
                      select
                      'Success~Record deleted' as [Status]

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Break out of the loop
                      break
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Only display an error message if it is on the final attempt of the execution
                      if @attempts = 5
                        begin
                          -- Select error number, line, and message
                          select
                          'Error~deleteColumnOneEntry: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
                        end

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Increments the loop control for attempts
                      set @attempts = @attempts + 1

                      -- Wait for delay for x amount of time
                      waitfor delay '00:00:04'

                      -- Continue the loop
                      continue
                    end catch
                    -- End catch block
                end
            end
          else
            begin
              -- Select message
              select
              'Success~Process halted, entry does not exist' as [Status]
            end
        end
    end

  -- Else option mode was not found
  else
    begin
      -- Select message
      select
      'Error~OptionMode provided has no handle' as [Status]
    end
end