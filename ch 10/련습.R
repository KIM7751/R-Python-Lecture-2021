1-1 Random Forest # K-Fold CV, K=5
```{r}
library(randomForest)
library(caret)
library(e1071)
library(rpart)
library(class)
library(survival)
library(dplyr)
colon <- na.omit(colon)
colon$status <- factor(colon$status)
set.seed(2021)
data <- colon[sample(nrow(colon)),]
options(digits = 4)

k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)


accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- randomForest(status ~., data_train)
    pred <- predict(rf, data_test, type='class')
    t5 <- table(pred, data_test$status)
    
    accuracy <- accuracy + (t5[1,1]+t5[2,2])/nrow(data_test)
    precision <- precision + t5[2,2]/(t5[2,1]+t5[2,2])
    recall <- recall + t5[2,2]/(t5[1,2]+t5[2,2])
}
rf_avg_acc5 <- accuracy / k
rf_avg_prec5 <- precision / k
rf_avg_rec5 <- recall / k

sprintf('랜덤 포레스트 K=5: 정확도=%f, 정밀도=%f, 재현율=%f',
        rf_avg_acc5, rf_avg_prec5, rf_avg_rec5)
t5
```

1-2 Random Forest # K-Fold CV, K=10
```{r}
set.seed(2021)
data <- colon[sample(nrow(colon)),]
options(digits = 4)
k <- 10
q <- nrow(data) / k
l <- 1:nrow(data)


accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- randomForest(status ~., data_train)
    pred <- predict(rf, data_test, type='class')
    t10 <- table(pred, data_test$status)
    
    accuracy <- accuracy + (t10[1,1]+t10[2,2])/nrow(data_test)
    precision <- precision + t10[2,2]/(t10[2,1]+t10[2,2])
    recall <- recall + t10[2,2]/(t10[1,2]+t10[2,2])
}
rf_avg_acc10 <- accuracy / k
rf_avg_prec10 <- precision / k
rf_avg_rec10 <- recall / k

sprintf('랜덤 포레스트 K=10: 정확도=%f, 정밀도=%f, 재현율=%f',
        rf_avg_acc10, rf_avg_prec10, rf_avg_rec10)
t10
```

1-3 Random Forest # K-Fold CV, K=15
```{r}
set.seed(2021)
data <- colon[sample(nrow(colon)),]
options(digits = 4)
k <- 15
q <- nrow(data) / k
l <- 1:nrow(data)


accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- randomForest(status ~., data_train)
    pred <- predict(rf, data_test, type='class')
    t15 <- table(pred, data_test$status)
    
    accuracy <- accuracy + (t15[1,1]+t15[2,2])/nrow(data_test)
    precision <- precision + t15[2,2]/(t15[2,1]+t15[2,2])
    recall <- recall + t15[2,2]/(t15[1,2]+t15[2,2])
}
rf_avg_acc15 <- accuracy / k
rf_avg_prec15 <- precision / k
rf_avg_rec15 <- recall / k

sprintf('랜덤 포레스트 K=15: 정확도=%f, 정밀도=%f, 재현율=%f',
        rf_avg_acc15, rf_avg_prec15, rf_avg_rec15)
```

1-4 Random Forest # K-Fold CV, K=15
```{r}
set.seed(2021)
data <- colon[sample(nrow(colon)),]
options(digits = 4)
k <- 20
q <- nrow(data) / k
l <- 1:nrow(data)


accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- randomForest(status ~., data_train)
    pred <- predict(rf, data_test, type='class')
    t20 <- table(pred, data_test$status)
    
    accuracy <- accuracy + (t20[1,1]+t20[2,2])/nrow(data_test)
    precision <- precision + t20[2,2]/(t20[2,1]+t20[2,2])
    recall <- recall + t20[2,2]/(t20[1,2]+t20[2,2])
}
rf_avg_acc20 <- accuracy / k
rf_avg_prec20 <- precision / k
rf_avg_rec20 <- recall / k

sprintf('랜덤 포레스트 K=20: 정확도=%f, 정밀도=%f, 재현율=%f',
        rf_avg_acc20, rf_avg_prec20, rf_avg_rec20)
t20
```

2.UCLA
```{r}
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla <- na.omit(colon)
ucla$admit <- factor(ucla$admit)

ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla <- na.omit(colon)
ucla <- ucla[c(T,F),]
ucla$admit <- factor(ucla$admit)

control <- trainControl(method = 'cv', number = 10)
formular <- admit~.
L <- train(formular, data = ucla, method = 'svmLinear', metric = 'Accuracy', trControl = control)
LW <- train(formular, data = ucla, method = 'svmLinearWeights', metric = 'Accuracy', trControl = control)
P <- train(formular, data = ucla, method = 'svmPoly', metric = 'Accuracy', trControl = control)
R <- train(formular, data = ucla, method = 'svmRadial', metric = 'Accuracy', trControl = control)