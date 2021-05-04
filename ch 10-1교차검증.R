# K-Fold교차 검증
library(caret)

# iris 데이터를 섞는다
set.seed(2021)
data <- iris[sample(nrow(iris)),]
head(data)
tail(data)

# K-Fold CV, K=5

k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)
acc <- 0

for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- train(Species~., data_train, method='rf')
    pred <- predict(rf, data_test)
    t <- table(pred, data_test$Species)
    acc <- acc + (t[1,1] + t[2,2] + t[3,3])/nrow(data_test)
    }

average_accuracy <- acc / k
average_accuracy

######################################
# caret 라이브러리를 이용한 코드 (간단화)
######################################
control <- trainControl(method = 'cv', number = 5)
new_rf <- train(Species~., data = iris, method = 'rf',
                metric = 'Accuracy', trControl = control)
confusionMatrix(new_rf)

######################################
# 4개 모델에 적용 / 번외 꿀팁 (변수,함수는 소문자로 시작) (대문자는 객체,class)
######################################
control <- trainControl(method = 'cv', number = 5)
dt <-  train(Species~., data = iris, method = 'rpart',
             metric = 'Accuracy', trControl = control)

rf <-  train(Species~., data = iris, method = 'rf',
             metric = 'Accuracy', trControl = control)

sv <-  train(Species~., data = iris, method = 'svmRadial',
            metric = 'Accuracy', trControl = control)

kn <-  train(Species~., data = iris, method = 'knn',
             metric = 'Accuracy', trControl = control)

resamp <- resamples(list(결정트리=dt, 랜덤포레스트=rf,
                             SVM=sv, KNN=kn))

summary(resamp)
sort(resamp, decreasing = T) #sort(resamp,) 객체/특성/method/()
                             # a <- class
                             # a.sort     객체를 만들어 사용하는 방법
dotplot(resamp)
