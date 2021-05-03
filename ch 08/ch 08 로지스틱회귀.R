# 일반화 선형 모델
#로지스틱 회귀 - UCLA admission data

ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
library(ggplot2)
library(dplyr)
str(ucla)

lr <- glm(admit ~ ., data = ucla, family = binomial) # 총 데이터의 훈련셋을 넣고
coef(lr)                                             # 검증셋으로 테스트를 해봄

test <- data.frame(gre=c(376), gpa=c(3.6), rank=c(3))

predict(lr,test, type = 'response') # predict(모델, 예측할 새로운 데이터) 
                                    # 데이터의 테스트셋을 넣는다
                                    # 테스트 셋을 넣어 모델을 평가함.

# ucla 데이터 셋 train/test data set 분할

train_index <- sample(1:nrow(ucla), 0.8*nrow(ucla)) #80%를 트레인 셋으로 놓겠다다
test_index <- setdiff(1:nrow(ucla), train_index)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[test_index,]

dim(ucla_train)
dim(ucla_test)

# 분할비율은 적절한가?
table(ucla$admit)        # 127/400 -> 0.3175
table(ucla_train$admit)  # 101/320 -> 0.3156

# 훈련 데이터셋으로 학습, 테스트 데이터셋으로 예측/평가

lr  <- glm(admit~., ucla_train, family = binomial)
pre <- predict(lr, ucla_test, type = 'response')
pre
ucla_test$admit
