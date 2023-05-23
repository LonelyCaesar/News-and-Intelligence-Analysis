SELECT * from [News]

SELECT [KeyWords] FROM [News] WHERE [NewsId]=10;

CREATE FUNCTION GetKeyWords(@id INT) 
RETURNS @tt TABLE
(
	[KeyWords] NVARCHAR(10),  
    [Cnts] INT
)
AS
  BEGIN
	DECLARE @json NVARCHAR(MAX)	
	SELECT @json=[KeyWords] FROM [News] WHERE [NewsId]=@id;
	INSERT INTO @tt
	SELECT * FROM OPENJSON(@json)
	WITH(
		[KeyWords] NVARCHAR(10) '$.KeyWords',
		[Cnt] INT '$.Cnt'
	)
	RETURN;
  END
GO

SELECT * FROM News
SELECT * FROM GetKeyWords(10)