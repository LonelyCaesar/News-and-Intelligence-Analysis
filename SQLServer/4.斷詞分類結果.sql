CREATE TABLE #TT
(
	[KeyWords] NVARCHAR(10)
)

DECLARE @sql NVARCHAR(MAX)=N'SELECT [News] FROM [News] WHERE [NewsId]=6'

INSERT INTO #TT
EXEC sp_execute_external_script  
	@language = N'Python'  
	, @script = N'
import pandas as pd
import jieba

#Ū�J���ε�
stopWords=[]
with open("C:\\DD\\MyStopWords.txt", "r", encoding="UTF-8") as file:
    for data in file.readlines():
        data = data.strip()
        stopWords.append(data)

#Ū�J�Τ�۩w�q��
jieba.load_userdict("C:\\DD\\MyKeyWords.txt")

df=pd.DataFrame(InputDataSet)
sentence=df.iloc[0,0]
words = jieba.cut(sentence, cut_all=False)

#�簣���ݭn�����ε�
remainderWords=[]
remainderWords = list(filter(lambda a: a not in stopWords and a != "\n", words))

OutputDataSet=pd.DataFrame(remainderWords)
'
	,@input_data_1=@sql
GO

DELETE FROM #TT WHERE UNICODE(SUBSTRING([KeyWords],1,1))=13
DELETE FROM #TT WHERE LEN([KeyWords])<2

SELECT * FROM #TT