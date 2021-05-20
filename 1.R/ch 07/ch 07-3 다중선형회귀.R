# 영희의 물리 실험
install.packages('scatterplot3d')
library(scatterplot3d)

x <- c(3,6,3,6.)
u <- c(10,10,20,20.)
y <- c(4.65,5.9,6.7,8.02)

scatterplot3d(x, u, y,
              xlim = 2:7 , ylim = 7:23, zlim = 0:10,
              pch = 20, type = 'h')

model <- lm(y ~ x + u) #독립변수로 x 와 u를 쓰겠다 / y = f(x, u)
coef(model) # y = 0.428 * x +0.209 * u + 1.26

s <- scatterplot3d(x, u, y,
                   xlim = 2:7 , ylim = 7:23, zlim = 0:10,
                   pch = 20, type = 'h')

s$plane3d(model)


# 잔차

fitted(model) # 예측한 y 값 도출 
y # 약간의 오차 발생을 볼 수 있다

residuals(model) # y - fitted(model) 예측 y 값 = "잔차"

# 평균 제곱 오차 (MSE)

mse = deviance(model) / length(y)
mse 

# 새로운 데이터에 대한 예측

nx = c(7.5, 5)
nu = c(15,12.)
new_data <- data.frame(x=nx, u=nu)
new_data 
ny <- predict(model, new_data)
ny

s <- scatterplot3d(nx, nu, ny,
                   xlim = 2:10 , ylim = 7:23, zlim = 0:10,
                   pch = 20, type = 'h', color = 'red', angle = 60)

s$plane3d(model)

summary(model)

# trees 데이터

head(trees)
dim(trees)
summary(trees)

scatterplot3d(trees$Girth,trees$Height, trees$Volume)

# 모델링

tm <- lm(Volume ~ Girth + Height, data=trees)
tm # Volume = 4.7082 * Girth + 0.3393 * Height + -57.9877 
summary(tm)

# 예측
ndata <- data.frame(Girth=c(8.5, 13, 19), Height=c(72, 86, 85.))
predict(tm, newdata = ndata)
