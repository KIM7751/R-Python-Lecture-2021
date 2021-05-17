library(dplyr)

# mvp데이터는 2000~2020 데이터까지 뽑았음.
# stat데이터는 2000~2017데이터까지 뽑았음.
# 모델을 만들기 위해서 mvp데이터에 맞춰 컬럼을 select함.


mvp <- read.csv("data/projectData/MVP.csv")
mvp_1 <- mvp %>% filter(Season >=2000)
mvp_2 <- mvp_1 %>% select(G, MP, PT, TRB, AST, STL, FG., X3P., FT.,MVP)


stat <- read.csv("data/projectData/Seasons_Stats_NEW1+mvp.csv")
stat <- stat %>% filter(Year >= 2000)
stat_raw <- na.omit(stat)

head(stat)
stat_a <- stat_raw %>% select(G, MP, PT, TRB, AST, STL, FG., X3P., FT., MVP)
stat_not_mvp <- stat_a %>% filter(MVP == 0)

View(stat_a)

library(caret)
library(randomForest)
class(stat_not_mvp)

mvp_3<- as.data.frame(mvp_2)
class(mvp_3)

a <- stat_not_mvp[sample(nrow(stat_not_mvp), 60), ]
b <- mvp_3[sample(nrow(mvp_3), 15), ]
c <- stat_not_mvp[sample(nrow(stat_not_mvp), 20), ]
d <- mvp_3[sample(nrow(mvp_3), 5), ]


train_1 <- rbind(a, b)
View(train_1)
test_1 <- rbind(c, d)



?randomForest
rf <- randomForest(MVP ~ ., train_1)
rf

pred <- predict(rf, test_1, type = 'class')
pred

pred_big <- predict(rf, stat_a, type = 'class')
pred_big

confusionMatrix(pred, test_1$MVP)


md.fit = randomForest(MVP~.,train_1, ntee = 100)
md.fit

md.pred = predict(md.fit, test_1)
md.pred

confusionMatrix(md.pred,  stat_a$MVP)


