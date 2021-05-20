# IMDB 영화평 감성분석
install.packages('text2vec')
library(text2vec)
library(caret)
library(tm)
 
# 소문자, 불용어, 구둣점, 숫자, 태그, 중복/null에 대한 전처리를 미리 고려

str(movie_review)

# 8:2 비율로 훈련/테스트 데이터셋 분할

set.seed(2021)
train_list <- createDataPartition(y = movie_review$sentiment,
                                  p = 0.8, list = F)
mtrain <- movie_review[train_list,]
mtest <- movie_review[-train_list,]

# 트레인 데이터 -> DTM -> 훈련 // 테스트 데이터 -> 트레인 데이터의 DTM을 적용시킨다
# 훈련 데이터셋에 대해 DTM 구축
# 테스트 데이터셋에 대해서도 동일하게 적용해야함

doc <- Corpus(VectorSource(mtrain$review))
doc <- tm_map(doc, content_transformer(tolower))
doc <- tm_map(doc, removeNumbers)
stop_words <- c(stopwords('en'), '<br />')
doc <- tm_map(doc, removeWords, stop_words)
doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, stripWhitespace)

dtm <- DocumentTermMatrix(doc,
                          control = list(weighting=weightTf))

dim(dtm)
inspect(dtm) # movie 와 film 빈도수가 많은 것을 확인

dtm_tfidf <- DocumentTermMatrix(doc,
             control = list(weighting=weightTfIdf))
 
inspect(dtm_tfidf) # movie 와 film의 확률을 낮춤

# 모델링이 가능한 형태로 DTM을 변환

dtm_sm <- removeSparseTerms(dtm, 0.9)
dim(dtm_sm)

#sentiment(y)와 DTM을 묶어서 데이터 프레임을 생성

X <- as.matrix(dtm_sm)
dataTrain <- as.data.frame(cbind(mtrain$sentiment, X))
head(dataTrain)
colnames(dataTrain)[1] <- "y"
dataTrain$y <- as.factor(dataTrain$y)

# Decision Tree로 학습

library(rpart)
dt <- rpart(y ~ ., dataTrain)

# 테스트 데이터셋으로 모델 성능 평가

docTest <- Corpus(VectorSource(mtest$review))
docTest <- tm_map(docTest, content_transformer(tolower))
docTest <- tm_map(docTest, removeNumbers)
docTest <- tm_map(docTest, removeWords, stop_words)
docTest <- tm_map(docTest, removePunctuation)
docTest <- tm_map(docTest, stripWhitespace)

dtmTest <- DocumentTermMatrix(docTest,
                              control = list(dictionary=dtm_sm$dimnames$Terms))
dim(dtmTest)
inspect(dtmTest)

# sentiment(y)와 DTM_TEST 를 묶어서 데이터프레임을 생성

X <- as.matrix(dtmTest)
dataTest <- as.data.frame(cbind(mtest$sentiment, X))
colnames(dataTest)[1] <- 'y'
dataTest$y <- as.factor(dataTest$y)

# 학습했던 모델로 예측

dt_pred <- predict(dt, dataTest, type = 'class')
table(dt_pred, dataTest$y)

##################
# SVM 으로 훈련
##################
library(e1071)
svc <- svm(y ~ ., dataTrain)
sv_pred <- predict(svc, dataTest, type='class')
table(sv_pred, dataTest$y)

####################
# Tf-Idf로 변환
####################
dtm_tfidf <- DocumentTermMatrix(doc,
                                control=list(weighting=weightTfIdf))
inspect(dtm_tfidf)

# 모델링이 가능한 형태로 DTM을 변환
dtm_small_tfidf <- removeSparseTerms(dtm_tfidf, 0.9)
dim(dtm_small_tfidf)

# Sentiment(y)와 DTM을 묶어서 데이터프레임을 생성
X <- as.matrix(dtm_small_tfidf)
dataTrain <- as.data.frame(cbind(mtrain$sentiment, X))
head(dataTrain)
colnames(dataTrain)[1] <- 'y'
dataTrain$y <- as.factor(dataTrain$y)

# Decision Tree로 학습
dt_tfidf <- rpart(y ~ ., dataTrain)

# Test dataset
# dtmTest_tfidf <- DocumentTermMatrix(docTest,
#                     control=list(dictionary=dtm_small_tfidf$dimnames$Terms,
#                                  weighting=weightTfIdf))
dtmTest_tfidf <- DocumentTermMatrix(docTest,
                                    control=list(dictionary=dtm_small_tfidf$dimnames$Terms))
X <- as.matrix(dtmTest_tfidf)
dataTest <- as.data.frame(cbind(mtest$sentiment, X))
colnames(dataTest)[1] <- 'y'
dataTest$y <- as.factor(dataTest$y)

# 예측
dt_pred_tfidf <- predict(dt_tfidf, dataTest, type='class')
table(dt_pred_tfidf, dataTest$y)

# SVM
# svc_tfidf <- svm(y ~ ., dataTrain)
# sv_pred_tfidf <- predict(svc_tfidf, dataTest, type='class')
# table(sv_pred_tfidf, dataTest$y)