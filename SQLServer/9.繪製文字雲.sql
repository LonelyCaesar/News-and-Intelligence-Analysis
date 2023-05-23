WITH Temp
AS
(
	SELECT [NewsId] FROM [News] WHERE SUBSTRING([Label],1,1)='1'
)
,Temp2
AS
(
	SELECT A.[NewsId],B.KeyWords,B.Cnts
	FROM [Temp] AS A CROSS APPLY(SELECT * FROM dbo.GetKeyWords(A.NewsId)) AS B
)
SELECT TOP(300) [KeyWords],SUM([Cnts]) AS Cnts
FROM Temp2
GROUP BY [KeyWords]
ORDER BY [Cnts] DESC

--------------------------------------------

EXEC sp_execute_external_script  
	@language = N'Python'  
	, @script = N'
import matplotlib.pyplot as plt
from wordcloud import WordCloud
import pandas as pd

input_data = InputDataSet
df=pd.DataFrame(input_data)
nn = list(df.KeyWords)
vv = list(df.Cnts)
my_dict=dict(zip(nn,vv))

#設定中文字體
font_path = "C:\Windows\Fonts\kaiu.ttf"  

wc = WordCloud(font_path = font_path,width = 800, height = 800,background_color ="white",stopwords=None,min_font_size = 10)
wc.generate_from_frequencies(my_dict)
wc.to_file("C:\\DD\\p3.png")
'
, @input_data_1 = N'
WITH Temp
AS
(
	SELECT [NewsId] FROM [News] WHERE SUBSTRING([Label],1,1)=''1''
)
,Temp2
AS
(
	SELECT A.[NewsId],B.KeyWords,B.Cnts
	FROM [Temp] AS A CROSS APPLY(SELECT * FROM dbo.GetKeyWords(A.NewsId)) AS B
)
SELECT TOP(300) [KeyWords],SUM([Cnts]) AS Cnts
FROM Temp2
GROUP BY [KeyWords]
ORDER BY [Cnts] DESC
'