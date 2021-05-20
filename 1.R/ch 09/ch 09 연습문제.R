
### ucla
###################################################### ucla 결정트리
library(rpart)
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit = factor(ucla$admit)
dtc <- rpart(admit~.,ucla)
summary(dtc)

## ucla 결정트리 시각화
par(mfrow=c(1,1), xpd=NA)
plot(dtc)
text(dtc, use.n=T)

# ucla 예측
pred_d <-predict(dtc, ucla, type = 'class')
table(pred_d, ucla$admit)

# ucla 평가
library(caret)
confusionMatrix(pred_d, ucla$admit) #Accuracy : 0.7575 

# 시각화
library(rpart.plot)
rpart.plot(dtc)

## 훈련/테스트 셋으로 분리하여 시행
set.seed(2021)
ucla_index <- sample(1:nrow(ucla), 0.8*nrow(ucla))
ucla_train <- ucla[ucla_index,]
ucla_test <- ucla[-ucla_index,]
dim(ucla_train)
dim(ucla_test)

# 모델링
dtc2 <- rpart(admit~., ucla_train)

# 예측
pred_d2 <- predict(dtc2, ucla_test, type = "class")

# 평가
confusionMatrix(pred_d2, ucla_test$admit) # Accuracy : 0.6375

table(ucla$admit)

## 비율대로 훈련 / 테스트 데이터셋 만들기

train_index2 <- createDataPartition(ucla$admit, p=0.8, list = F)
ucla_train2 <- ucla[train_index2,]
ucla_test2  <- ucla[-train_index2,]
table(ucla_train2$admit)
table(ucla_test2$admit)

# 모델링
dtc3 <- rpart(admit~.,ucla_train2)

# 예측
pred_d3 <- predict(dtc3, ucla_test2, type = 'class')

# 평가
confusionMatrix(pred_d3, ucla_test2$admit) # Accuracy : 0.6835

# 시각화
rpart.plot(dtc3)

###################################################### ucla 랜덤포레스트

library(caret)
library(randomForest)

set.seed(2021)
train_index2 <- createDataPartition(ucla$admit, p=0.8, list = F)
ucla_train2 <- ucla[train_index2,]
ucla_test2  <- ucla[-train_index2,]

# 모델링
rf <- randomForest(admit~.,ucla_train2)
rf

# 예측
pred_r <- predict(rf, ucla_test2, type = 'class')
pred_r

# 평가
confusionMatrix(pred_r, ucla_test2$admit) # Accuracy : 0.7342

# 시각화
plot(rf)

###################################################### ucla SVM

library(e1071)
library(caret)

set.seed(2021)
train_index2 <- createDataPartition(ucla$admit, p=0.8, list = F)
ucla_train2  <- ucla[train_index2,]
ucla_test2   <- ucla[-train_index2,]

# 모델링
svc <- svm(admit~., ucla_test2)

# 예측
pred_s <- predict(svc, ucla_test2, type = 'class')

# 평가
confusionMatrix(pred_s, ucla_test2$admit) # Accuracy : 0.7215   

###################################################### ucla KNN

summary(ucla_test2)

k <- knn(ucla_train2[,1:4],ucla_test2[,1:4],
         ucla_train2$admit, k=3)
k

table(k)
confusionMatrix(k,ucla_test2$admit) #Accuracy : 0.9367

### wine

library(dplyr)
wine <- read.table('data/wine.data.txt', sep= ",")
columns <- readLines('data/wine.name.txt')
names(wine)
names(wine)[2:14] <- columns
names(wine)
names(wine)[2:14] <- substr(columns, 4, nchar(columns))
names(wine)[1] <- 'Y'
names(wine)
wine$Y = factor(wine$Y)
###################################################### wine 결정트리
set.seed(2021)
wine_index <- createDataPartition(wine$Y, p=0.8, list = F)
wine_train  <- wine[wine_index,]
wine_test   <- wine[-wine_index,]

# 모델링
dtc_w <- rpart(Y ~ ., wine_train)

# 예측
pre_wd <- predict(dtc_w, wine_test, type = 'class')

# 평가
confusionMatrix(pre_wd, wine_test$Y) #Accuracy : 0.9118 


###################################################### wine 랜덤 포레스트
set.seed(2021)
wine_index <- createDataPartition(wine$Y, p=0.8, list = F)
wine_train  <- wine[wine_index,]
wine_test   <- wine[-wine_index,]

# 모델링
rf_w <- randomForest(Y ~ . , wine_train)

# 예측
pre_wr <- predict(rf_w, wine_test, type = 'class')

# 평가
confusionMatrix(pre_wr, wine_test$Y) #Accuracy : 0.9706

###################################################### wine SVM

library(e1071)
library(caret)

set.seed(2021)
wine_index <- createDataPartition(wine$Y, p=0.8, list = F)
wine_train  <- wine[wine_index,]
wine_test   <- wine[-wine_index,]

# 모델링
svc_w <- svm(Y ~ . , wine_train)

# 예측
pre_ws <- predict(svc_w, wine_test , type = 'class')

# 평가
confusionMatrix(pre_ws, wine_test$Y) # Accuracy : 1  

###################################################### wine KNN
library(class)

kw <- knn(wine_train[,1:14],wine_test[,1:14],
         wine_train$Y, k=3)
kw
table(kw)
confusionMatrix(kw, wine_test$Y) #Accuracy : 0.9367
