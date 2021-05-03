# Random Forest 결정트리의 낮은 성능을 보완하기 위함.
# 앙상블 -> 1) 서로 다른 분류기 - 로지스틱 회귀(0), 결정트리(1), SVM(0) -> (0,1,0) Voting이라고함 / 결과값이 다를것  
#           2) 동일한 분류기    - Random forest(Decision tree) -> 결과값이 같아 의미가 업어 데이터를 다르게함 (복원추출) 

library(caret)
install.packages("randomForest")
library(randomForest)

set.seed(2021)
train_index  <- createDataPartition(iris$Species, p=0.8, list = F)
iris_train <- iris[train_index,]
iris_test <- iris[-train_index,]


# 모델링/학습
rf <- randomForest(Species ~ ., iris_train)
rf

# 예측
pred <- predict(rf, iris_test, type='class')
pred

# 평가
confusionMatrix(pred, iris_test$Species)

# 시각화
plot(rf)

# 하이퍼 파라메터
small_forest <- randomForest(Species ~., iris_train,
                             ntree=100, nodsize=4)  # 엔트리와 노드사이즈를 바꿔주며 높은 정확도를 찾아줌.
s_pred <- predict(small_forest, iris_test, type = 'class')
confusionMatrix(s_pred, iris_test$Species)
plot(small_forest)
