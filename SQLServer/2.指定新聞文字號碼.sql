SELECT * FROM [News]
----------------------------------------------
DECLARE @sql NVARCHAR(MAX)=N'SELECT [News] FROM [News] WHERE [NewsId]=99'--數字可以改
EXEC sp_execute_external_script  
	@language = N'Python'  
	, @script = N'
import pandas as pd
import jieba

df=pd.DataFrame(InputDataSet)
sentence=df.iloc[0,0]
words = jieba.cut(sentence, cut_all=False)
for ww in words:
	print(ww)
'
	,@input_data_1=@sql
GO