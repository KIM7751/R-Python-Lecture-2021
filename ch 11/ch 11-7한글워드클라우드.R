# Wiki'빅 데이터' 검색 결과 워드클라우드 만들기
library(RCurl)
library(XML)
library(SnowballC)
library(tm)
library(wordcloud)

enc <- URLencode(iconv('빅 데이터', 'CP949', 'UTF-8')) # 빅 데이터 euckr -> urf8로 바꿔라
enc
url <- paste0('https://ko.wikipedia.org/wiki/', enc)
url
html <- readLines(url)
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p', xmlValue)

length(doc)
doc[1]

# 전처리 수행
# 한글과 space만 남기고 다른 모든 글자를 지운다

hdoc <- gsub('[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣 ]', '',doc) # 한글이 아닌것 이라는 뜻
hdoc[1]

# DTM / 한글에서는 잘 안된다.

corpus <- Corpus(VectorSource(hdoc))
inspect(corpus)
dtm <- DocumentTermMatrix(corpus)
inspect(dtm) # 한글은 형태소 분석을 꼭 해줘야함


# 한글 처리 후 작업을 해야함.
library(wordcloud2)
library(KoNLP)
useSejongDic()
nouns <- extractNoun(hdoc) # 리스트로 되어 있음
noun_freq <- table(unlist(nouns))
noun_freq[1:10]
v <- sort(noun_freq, decreasing = T)
v100 <- v[1:100]
wordcloud2(v100)

##################################################
# 한글 불용어 처리
#  - 반복해서 stop_words에 단어를 추가하면서 진행
##################################################

noun_vec <- unlist(nouns)
stop_words <- c('한', '등', '수', '적', '년', '이', '것', '들', '있', '성', '해', '형')

l <- list()
for (word in unlist(nouns)) {
    if(!word %in% stop_words) {
        l <- append(l, word)
    }
}
noun_freq <- table(unlist(l))    
v <- sort(noun_freq, decreasing = T)
v100 <- v[1:100]
v100
wordcloud2(v100)

