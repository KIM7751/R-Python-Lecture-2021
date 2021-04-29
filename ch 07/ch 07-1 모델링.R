# 단순 선형 회귀의 적용
# cars 데이터

str(cars)

plot(cars)

cars_model <- lm(dist ~ speed, data=cars)
coef(cars_model)

# 회귀식: dist = 3.9234 * speed - 17.5791 

abline(cars_model, col = 'red')

summary(cars_model) # 별이 많이 붙을 수록 좋은 것(관련성이 높다)  ctrl + shift + c 블록 단추키
par(mfrow=c(2,2))
plot(cars_model)
par(mfrow=c(1,1))
