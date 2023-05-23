SELECT * from [News]
select [News] from [News]
select [News] from [News] where [NewsID]=10

ALTER TABLE [News] ADD [KeyWords] NVARCHAR(MAX);


DECLARE @aa INT=1;
DECLARE @rr NVARCHAR(MAX);
WHILE @aa<=535
  BEGIN
	EXEC [News_to_JsonKeyWord] @aa,@rr OUTPUT;
	UPDATE [News]
	SET [KeyWords]=@rr
	WHERE [NewsId]=@aa;
	SET @aa=@aa+1;
  END