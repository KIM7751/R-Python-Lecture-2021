# 현실 세계의 모델링
X = c(3, 6, 9, 12.)
Y = c(3, 4, 5.5, 6.5)
plot(X, Y)

# model 1: y=0.5x+1.0
Y1 = 0.5*X + 1.0
Y1
# 평균 제곱 오차: Mean Squared Error
(Y - Y1)**2
sum((Y - Y1)**2)
mse <- sum((Y - Y1)**2) / length(Y)
mse

# model 2: y=5/12x + 7/4
Y2 = 5 * X / 12 + 7/4
Y2
mse2 <- sum((Y - Y2)**2) / length(Y)
mse2

# R의 단순 선형회귀 모델 lm (오차가 제일 적은 최적의 모델을 찾아줌)
model <- lm(Y ~ X)
model  # Y = 0.4X + 1.75

plot(X, Y)
abline(model, col='red') #abline() 플롯으로 그린 그래프 위 함수에 맞는 선을 그려줌
fitted(model)            #fitted() 는 Y = 0.4X + 1.75식의 훈련집합 샘플에 예측을 적용
mse_model <- sum((Y - fitted(model))**2) / length(Y) # SUM((실제값 - 예측값)**2) / length(실제값)
mse_model

# 잔차 - Residuals / 실제값 - 예측값 = 오차
residuals(model)  # Y - fitted(model)

# 잔차 제곱합  
deviance(model) # sum((Y - fitted(model))**2) 

# 평균 제곱오차(MSE)
deviance(model) / length(Y) #sum((Y - fitted(model))**2) / length(Y)

summary(model)

# 예측
newX <- data.frame(X=c(1.2, 2.0, 20.65))
newX
predict(model, newdata=newX)

# 연습문제 1
x <- c(10, 12, 9.5, 22.2, 8)
y <- c(360.2, 420, 359.5, 679, 315.3)
m <- lm(y ~ x)
summary(m)
plot(x, y, pch=1)
abline(m, col='red')

newx <- data.frame(x=c(10.5,25.0,15.0))
newy <- predict(m, newdata=newx)
newy

plot(newx$x, newy, pch=2)
abline(m, col='red')