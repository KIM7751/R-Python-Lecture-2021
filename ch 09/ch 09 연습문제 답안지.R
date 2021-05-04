# 과제
library(caret)
library(rpart)
library(randomForest)
library(e1071)

# 1) ucla 데이터
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)

# 훈련/테스트 데이터셋 만들기
set.seed(2021)
train_index <- createDataPartition(ucla$admit, p=0.8, list=F)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[-train_index,]

# 결정 트리
dt <- rpart(admit~., ucla_train)
dt_pred <- predict(dt, ucla_test, type='class')
t <- table(dt_pred, ucla_test$admit)
dt_acc <- (t[1,1] + t[2,2]) / nrow(ucla_test)
dt_acc

# 랜덤 포레스트
rf <- randomForest(admit~., ucla_train)
rf_pred <- predict(rf, ucla_test, type='class')
t <- table(rf_pred, ucla_test$admit)
rf_acc <- (t[1,1] + t[2,2]) / nrow(ucla_test)
rf_acc

# 서포트 벡터 머신
sv <- svm(admit~., ucla_train)
sv_pred <- predict(sv, ucla_test, type='class')
t <- table(sv_pred, ucla_test$admit)
sv_acc <- (t[1,1] + t[2,2]) / nrow(ucla_test)
sv_acc

# K-NN
library(class)
kn_pred <- knn(ucla_train[, 2:4], ucla_test[, 2:4], 
               ucla_train$admit, k=5)
t <- table(kn_pred, ucla_test$admit)
kn_acc <- (t[1,1] + t[2,2]) / nrow(ucla_test)
kn_acc

# 로지스틱 회귀
lr <- glm(admit~., ucla_train, family=binomial)
lr_pred <- predict(lr, ucla_test, type='response')
lr_pred <- ifelse(lr_pred > 0.5, 1, 0)
t <- table(lr_pred, ucla_test$admit)
lr_acc <- (t[1,1] + t[2,2]) / nrow(ucla_test)
lr_acc

print(paste(dt_acc, rf_acc, sv_acc, kn_acc, lr_acc))


# 2) wine data
wine <- read.table('data/wine.data.txt', sep=',')
head(wine)
columns <- readLines('data/wine.name2.txt')
columns
names(wine)[2:14] <- substr(columns, 4, nchar(columns))
names(wine)[1] <- 'Y'
head(wine)
str(wine)
wine$Y <- factor(wine$Y)

# 훈련/테스트 데이터셋 만들기
set.seed(2021)
train_index <- createDataPartition(wine$Y, p=0.8, list=F)
wine_train <- wine[train_index,]
wine_test <- wine[-train_index,]
table(wine$Y)
table(wine_train$Y)

# 결정 트리
dt <- rpart(Y~., wine_train)
dt_pred <- predict(dt, wine_test, type='class')
t <- table(dt_pred, wine_test$Y)
dt_acc <- (t[1,1] + t[2,2] + t[3,3]) / nrow(wine_test)
dt_acc

# 랜덤 포레스트
rf <- randomForest(Y~., wine_train)
rf_pred <- predict(rf, wine_test, type='class')
t <- table(rf_pred, wine_test$Y)
rf_acc <- (t[1,1] + t[2,2] + t[3,3]) / nrow(wine_test)
rf_acc

# 서포트 벡터 머신
sv <- svm(Y~., wine_train)
sv_pred <- predict(sv, wine_test, type='class')
t <- table(sv_pred, wine_test$Y)
sv_acc <- (t[1,1] + t[2,2] + t[3,3]) / nrow(wine_test)
sv_acc

# K-NN
kn_pred <- knn(wine_train[, 2:14], wine_test[, 2:14], 
               wine_train$Y, k=5)
t <- table(kn_pred, wine_test$Y)
kn_acc <- (t[1,1] + t[2,2] + t[3,3]) / nrow(wine_test)
kn_acc

print(paste(dt_acc, rf_acc, sv_acc, kn_acc))