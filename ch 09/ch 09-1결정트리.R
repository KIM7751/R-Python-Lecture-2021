# 분류
# 결정 트리(decision tree)
library(rpart)

head(iris)
dtc <- rpart(Species~., iris) # iris 데이터를 결정 트리로 학습
summary(dtc) # Variable importance 품종을 가리는데 중요도
dtc

# 결정 트리 시각화
par(mfrow=c(1,1), xpd=NA)
plot(dtc)
text(dtc, use.n=T)

# 예측
pred <- predict(dtc, iris, type = 'class')
table(pred, iris$Species)


# 평가 
install.packages('caret')
library(caret)
confusionMatrix(pred, iris$Species) #accuracy 정확도 0.96 만점 1

# 시각화
install.packages('rpart.plot')
library(rpart.plot)
rpart.plot(dtc)
rpart.plot(dtc, type = 4)


#훈련/테스트 셋으로 분리하여 시행
set.seed(2021)
sample(1:10, 4)

set.seed(2021)   # 샘플 값을 꾸준하게 일정한 값을 뽑고 싶다
iris_index <- sample(1:nrow(iris), 0.8*nrow(iris))
iris_train <- iris[iris_index,]
iris_test <- iris[setdiff(1:nrow(iris), iris_index),]
iris_test <- iris[-iris_index,]                       # 테스트셋 뽑는 두가지 방법
dim(iris_train)
dim(iris_test)

# 모델링 
dtc <- rpart(Species~., iris_train)

# 예측 
pred <- predict(dtc, iris_test, type = "class")

# 평가 
confusionMatrix(pred, iris_test$Species)

table(iris$Species)

# 비율대로 훈련 / 테스트 데이터셋 만들기

train_index <- createDataPartition(iris$Species, p=0.8, list=F)
iris_train <- iris[train_index,]
iris_test <- iris[- train_index,]
table(iris_train$Species)
table(iris_test$Species)

# 학습
dtc <- rpart(Species~., iris_train)

# 예측
pred <- predict(dtc, iris_test, type = 'class')

# 평가
confusionMatrix(pred, iris_test$Species)

# 시각화
rpart.plot(dtc)

#장점 예측이 빠름 , 결측값 처리 가능
#단점 성능이 낮음
