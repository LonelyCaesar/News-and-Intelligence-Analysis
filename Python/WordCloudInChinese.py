#程式
%matplotlib inline
import matplotlib.pyplot as plt
from wordcloud import WordCloud
from PIL import Image
import jieba
import numpy as np
# 如果檔案內有一些編碼錯誤，使用 errors='ignore' 來忽略錯誤
with open("107.csv", encoding="big5", errors='ignore') as f:
    text = f.read()

# 設定使用 big5 斷詞
jieba.set_dictionary('./dict.txt.big')
wordlist = jieba.cut(text)
words = " ".join(wordlist)
#文字雲造型圖片
mask = np.array(Image.open('picture.png')) #文字雲形狀
# 從 Google 下載的中文字型
font = 'SourceHanSansTW-Regular.otf'
#背景顏色預設黑色，改為白色、使用指定圖形、使用指定字體
my_wordcloud = WordCloud(background_color='white',mask=mask,font_path=font).generate(words)

plt.imshow(my_wordcloud)
plt.axis("off")
plt.show()
#存檔
my_wordcloud.to_file('word_cloud.png')