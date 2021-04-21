install.packages("dplyr")
install.packages("ggplot2")
women
plot(women)
str(cars)

# 두 줄을 선택후상단에 있는 'run' 버튼을 누르면 한꺼번에 실행됨.
a <- 2 
b <- a+a
# 직업 디렉토리 지정
getwd()
setwd('/workspace/r')
getwd()

library(dplyr)
library(ggplot2)
search()
str(iris)
head(iris)      #default는 6
head(iris, 10)
tail(iris)
plot(iris)

# 두 속성의 상관 관계
plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species, pch=18)


# tips.csv download
tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
head(tips)
str(tips)
# 요약 통계
summary(tips)

# ggplot2 그림 그려보기
tips %>% ggplot(aes(size))+geom_histogram()
tips %>% ggplot(aes(total_bill, tip))+geom_point()
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day))
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day,pch=sex),size=3)
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day,pch=time),size=3)                             
