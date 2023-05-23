WITH T1
AS
(
	SELECT [NewsId] FROM [News]
	WHERE SUBSTRING([Label],1,1)='1'
)
,T2
AS
(
	SELECT A.[NewsId],B.KeyWords,B.Cnts
	FROM T1 AS A CROSS APPLY dbo.GetKeyWords(A.[NewsId]) AS B
)

SELECT [KeyWords],SUM(Cnts) AS [Cnts]
FROM T2
GROUP BY [KeyWords]
ORDER BY [Cnts] DESC;