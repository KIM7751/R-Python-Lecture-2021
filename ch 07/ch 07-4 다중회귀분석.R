# 다중회귀분석

state.x77
head(state.x77)
states <- as.data.frame(state.x77[,c('Murder','Population','Illiteracy','Income','Frost')])

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)

summary(fit) # 문맹률과 인구에서 연관성을 파악
par(mfrow=c(2,2))
plot(fit)
par(mfrow=c(1,1))

# 다중공선성: 독립변수간 강한 상관관계가 나타나는 문제
# Correlation (0.9 이상이면 다중공선성 의심)

states.cor <- cor(states[2:5])
states.cor # 다중공선성으로 보이는 부분이 없다

#VIF(Variation Inflation Factor) 계산 (10이상이면 다중공선성 의심)
install.packages("car")
library(car)
vif(fit)

fit1 <- lm(Murder ~ ., data = states) # . 변수를 다 집어 넣어
summary(fit1)

fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
summary(fit2)

# AIC (다중선형모델중 뭐가 더 좋은 모델인지)
AIC(fit1, fit2) # 값이 적을수록 좋은 모델

# Backward stepwise regression(변수를 하나씩 지워가며) / Forward stepwise regression(변수를 하나씩 추가해보며 데이터 비교)
step(fit1, direction =  'backward')

fit3 <- lm(Murder ~ 1, data = states) # 1  절편만 놓고서 시작
step(fit3, direction = 'forward',
     scope = ~ Population + Illiteracy + Income + Frost, data=states )
step(fit3, direction = 'forward', scope = list(upper = fit1, lower))



install.packages("leaps")
library(leaps)
subsets <- regsubsets(Murder~., data=states, 
                      method='seqrep', nbest=4)
subsets <- regsubsets(Murder~., data=states, 
                      method='exhaustive', nbest=4)
summary(subsets)
plot(subsets)