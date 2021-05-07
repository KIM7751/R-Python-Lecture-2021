library(KoNLP)
useSejongDic() # 사전 종류: SystemDic, NIADic

s <- '너에게 묻는다. 연탄재 함부로 발로 차지 마라. 너는 누구에게 한번이라도 뜨거운 사람이었느냐?'

# 명사 추출

extractNoun(s)

# 형태소 분석 

SimplePos09(s)
SimplePos22(s)

nouns <- extractNoun(s)
nouns

ss <- c('너에게 묻는다.', '연탄재 함부로 발로 차지 마라.', '너는 누구에게 한번이라도 뜨거운 사람이었느냐?')
nouns <- extractNoun(ss)
nouns <- unlist(nouns)
nouns
