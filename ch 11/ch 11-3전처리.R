#wikipedia "data science"
install.packages('RCurl')
install.packages('XML')
library(RCurl)
library(XML)
library(stringr)

html <- readLines('https://en.wikipedia.org/wiki/Data_science')
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p', xmlValue)
length(doc) # 홈페이지에 //p 으로 시작하는 녀석들
doc[1]
doc[2]
doc[3]
corpus <- doc[2:3]

# 모두 소문자로 변경

corpus <- tolower(corpus)
corpus[1]

# 숫자 제거 
# 숫자 표현하는 정규식: '\\d', '[[:digit:]]
corpus <- gsub('\\d', '', corpus)
corpus[1]

# 구둣점 제거

corpus <- gsub('[[:punct:]]', '', corpus)
corpus[1]

corpus <- gsub('\n', ' ',corpus)


# 끝에 있는 공백 제거 

corpus <- gsub('\n', ' ',corpus)
corpus <- str_trim(corpus, side='right')

# 불용어 제거 (빈도수가 높으니 많이 연습할 것)

stopwords <- c('a', 'the', 'and', 'in', 'of', 'to', 'but')
gsub('a', '', corpus) # 데이터가 부자연스러워짐 data ->dt
words <- str_split(corpus, ' ') # 단어들로 구분을 먼저 함 / 결과가 리스트로 나옴
unlist(words) # 여러개의 리스트 엘리먼트를 하나의 벡터로 만듦

l <- list() # 빈 리스트 생성
for (word in unlist(words)) {
    if (!word %in% stopwords) {
        l <- append(l, word)
    }
}
corpus <- paste(l, collapse = ' ')
corpus

`%notin%` <- Negate(`%in%`) # 위 %in%에 대체해 사용할 수 있게끔 만듦 `` back quote

l <- list() # 빈 리스트 생성
for (word in unlist(words)) {
    if (!word %notin% stopwords) {
        l <- append(l, word)
    }
}
corpus <- paste(l, collapse = ' ')
corpus
