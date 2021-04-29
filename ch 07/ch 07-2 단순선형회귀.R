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


# 속도 21.5 제동거리는 ?

nx1 <- data.frame(speed=c(21.5)) # 숫자 값이 하나라도 벡터 해줘야함
predict(cars_model, nx1)

# 고차식(polynomoial) 적용하면 어떻게 될까? 

lm2 <- lm(dist ~ poly(speed,2), data=cars) # 폴리를 써서 2차식을 만듦
plot(cars)
x <- seq(4, 25, length.out = 211) # 4 ~ 25사이의 숫자를 211개 만들어라
x 
y <- predict(lm2, data.frame(speed=x))
y
lines(x,y, col='purple', lwd=2)
abline(cars_model, col='red', lwd=2)

summary(lm2)

#cars 1차식 부터 4차식까지
x <- seq(4, 25, length.out = 211)
colors <- c('red', 'purple', 'orange', 'blue')
plot(cars)
for (i in 1:4) {
    m <- lm(dist ~ poly(speed, i), data = cars)
    assign(paste('m', i , sep = '.'), m)
    y <-predict(m, data.frame(speed=x))
    lines(x, y, col=colors[i], lwd=2)
}

# 분산 분석(아노바)

anova(m.1, m.2, m.3, m.4)

# Women data

women
plot(women)
m <-lm(weight ~ height, data = women)
abline(m, col= 'red', lwd =2)
summary(m)

# 2차식으로 모델링 

m2 <- lm(weight ~ poly(height, 2), data = women)
x <-seq(58 , 72, length.out = 300)
y <-predict(m2, data.frame(height=x))
lines(x,y, col='purple', lwd=2)
abline(m, col='red', lwd=2)
summary(m2) # 2차식이 1차식 보다 낫다.
