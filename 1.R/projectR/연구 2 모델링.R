library(dplyr)
library(caret)
library(e1071)
library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)

mvp <- read.csv("https://raw.githubusercontent.com/DONGRYEOLLEE1/R.LECTURE-2021/main/data/MVP.csv")
mvp_1 <- mvp %>% na.omit() %>% filter(Year <= 2010) %>% 
    select(G, MP, PT, TRB, AST, STL, FG., X3P., FT.,MVP) %>% as.data.frame()
mvp_2 <- mvp %>% na.omit() %>% filter(Year >= 2011) %>% 
    select(G, MP, PT, TRB, AST, STL, FG., X3P., FT.,MVP) %>% as.data.frame()

mvp_1$MVP <- as.factor(mvp_1$MVP)
mvp_2$MVP <- as.factor(mvp_2$MVP)
str(mvp_1)
# mvp가 아닌 행들만 추출, y값 MVP 열은 범주화.

stat <- read.csv("data/projectData/Seasons_Stats_Last.csv")
stat <- stat %>% filter(Year >= 2000) %>% na.omit() %>% 
    select(G, MP, PT, TRB, AST, STL, FG., X3P., FT.,MVP)
stat$MVP <- as.factor(stat$MVP)
stat_not_mvp <- stat %>% filter(MVP == 0)
length(is.na(stat_not_mvp)) # na가 없음을 증명

# mvp가 아닌 행들 중 랜덤으로 행을 추출. (mvp데이터의 10배수.)

set.seed(5000)
a <- stat_not_mvp[sample(nrow(stat_not_mvp), 310), ]
b <- stat_not_mvp[sample(nrow(stat_not_mvp), 100), ]

train_1 <- rbind(a, mvp_1)
test_1 <- rbind(b, mvp_2)



# dtc

dtc <- rpart(MVP ~ . , train_1)
pred <- predict(dtc, test_1, type = 'class')

table(pred, test_1$MVP)
confusionMatrix(pred, test_1$MVP)

rpart.plot(dtc, type=4)


# 예측에 사용될 데이터 셋 
st_2021 <- read.csv("data/projectData/2021Player.csv") %>% na.omit()
st_2021 <- as.data.frame(st_2021)

# 디시젼트리로 2021 MVP 예측.
pred_dt_2021 <- predict(dtc, st_2021, type = 'class')
summary(pred_dt_2021)

############################################################################################
# 랜덤 포레스트
# 랜덤포레스트 모델 만들어 테스트(TEST, TRAIN 셋 활용.)

rf <- randomForest(MVP ~ ., train_1, ntree = 300)
pred_rf <- predict(rf, test_1, type = 'class')
confusionMatrix(pred_rf, test_1$MVP)
plot(rf)                                               # 평균적으로 ntree 값 5~60부터 안정적 값이 나오는 것을 확인 가능.
importance(rf)                                         # 변수 중요도의 경우 sample에 따라 차이를 보임.

# 랜덤포레스트 모델로 2021 mvp 예측

pred_rf_2021 <- predict(rf, st_2021, type = 'class')
summary(pred_rf_2021)

target_rf = pred_rf_2021[pred_rf_2021 == 1] %>% names()
target_rf
st_2021 %>% filter(rownames(st_2021) %in% target_rf) %>% select(Player)

###########################################################################################
# 서포트 벡터 머신
# SVM 모델 만들고 테스트
sv <- svm(MVP ~ ., train_1)
pred_sv <- predict(sv, test_1, type = 'class')
confusionMatrix(pred_sv, test_1$MVP)

# SVM 모델로 2021 mvp 예측
pred_sv_2021 <- predict(sv, st_2021, type = 'class')
summary(pred_sv_2021)

# SVM 모델이 예측한 선수 이름 출력.
target_sv <- pred_sv_2021[pred_sv_2021 == 1] %>% names()
st_2021 %>% filter(rownames(st_2021) %in% target_sv) %>% select(Player)


##################################################변수선택과정##################################################################

mvp <- read.csv("C:/projectR/rawdata/MVP.csv")
mvp_1 <- mvp %>% na.omit() %>% filter(Year <= 2010) %>% select(G, MP, PT, TRB, AST, STL, FG., X3P., FT.,MVP) %>% as.data.frame()
mvp_2 <- mvp %>% na.omit() %>% filter(Year >= 2011) %>% select(G, MP, PT, TRB, AST, STL, FG., X3P., FT.,MVP) %>% as.data.frame()
mvp_1$MVP <- as.factor(mvp_1$MVP)
mvp_2$MVP <- as.factor(mvp_2$MVP)


stat <- read.csv("C:/projectR/rawdata/Seasons_Stats_Last.csv")
stat <- stat %>% filter(Year >= 2000) %>% na.omit() %>% select(G, MP, PT, TRB, AST, STL, FG., X3P., FT., MVP)
stat$MVP <- as.factor(stat$MVP)
stat_not_mvp <- stat %>% filter(MVP == 0)

a <- stat_not_mvp[sample(nrow(stat_not_mvp), 310), ]
b <- stat_not_mvp[sample(nrow(stat_not_mvp), 100), ]

train_1 <- rbind(a, mvp_1)
test_1 <- rbind(b, mvp_2)

dtc <- rpart(MVP ~ . , train_1)
dtc
summary(dtc)

# 로지스틱회귀
str(train_1)
lr <- glm(MVP~ ., train_1, family = binomial)
summary(lr)

# 변수선택
step(lr, direction = "backward")

# 디시젼트리 
dtc <- rpart(MVP ~ . , train_1)
pred <- predict(dtc, test_1, type = 'class')
summary(dtc)                                    # Variable importance 값 및 영향 독립변수가 sample seed 값에 따라서 끊임없이 변하므로 사용할 수 없었다. 