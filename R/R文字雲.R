library(jiebaR)
library(wordcloud) # 第一代文字雲
library(wordcloud2) # 第二代文字雲
library( RColorBrewer)

ch_news = c("請在txt內複製貼上新聞") # 匯入新聞

new_terms = c("鄉鎮縣市", "民意代表", "店家", "買賣交屋")
writeLines(new_terms, '/Users/hello/Documents/R/ch_terms.txt') # 自訂字典,請輸入自己的路徑

stopwords = c( "在","的","上", "下","是", "個","來","為","亦","或", "之", "與", "於", "用", "都", "等", "日", "月", "年", "週", "嗎", "以", "就", "但", "及", "也", "了", "要", "不", "會", "和", "對", "著", "後", "她", "他")
writeLines(stopwords, '/Users/hello/Documents/R/ch_stopwords.txt') # 自訂停用詞,請輸入自己的路徑

cutter = worker(user='/Users/hello/Documents/R/ch_terms.txt', stop_word = '/Users/hello/Documents/R/ch_stopwords.txt') # 引用字典和停用詞,請輸入自己的路徑

ch_news <- gsub("[0-9a-zA-Z]+?", "", ch_news) # 刪除數字和字母

ch_news <- cutter[ch_news] # 斷詞

freq_ch <- sort(table(ch_news), T)
freq_ch = as.data.frame(freq_ch)
colnames(freq_ch) <- c("Words", "Freq") # 字頻表


head(freq_ch) # 查看前10筆資料


par(family=("NotoSansCJKtc-Medium")) # 設定字體 Mac

customed_colors = c("#000080", "#ffff00", "#6495ed", "#00bfff", "#87cefa", "#db7093", "#ba55d3", "#b22222", "#008080", "#ff8c00", "#6b8e23") # 顏色

ch_wordcloud = wordcloud(freq_ch$Words, freq_ch$Freq, min.freq = 2, random.order = F, ordered.colors = F, colors = customed_colors); ch_wordcloud # 第一代文字雲

ch_wordcloud2 = wordcloud2(freq_ch, size = 1.3, color = customed_colors, backgroundColor="white"); ch_wordcloud2
# 第二代文字雲

letterCloud(freq_ch,'OK',size = 0.50)
letterCloud(freq_ch,'R',size = 0.50)

