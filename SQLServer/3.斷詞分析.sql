DECLARE @sql NVARCHAR(MAX)=N'SELECT [News] FROM [News] WHERE [NewsId]=5'
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

for ww in remainderWords:
	print(ww)
'
	,@input_data_1=@sql
GO
