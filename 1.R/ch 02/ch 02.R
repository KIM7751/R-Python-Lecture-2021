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

# 두 속성의 상관 관계 (col = 색깔로 종 구분 , pch = 점 표현 방식)
plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species, pch=18)


# tips.csv download
tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
head(tips)
str(tips)
# 요약 통계
summary(tips)

# ggplot2 그림 그려보기 (처음 ggplot 으로 축을 설정하고 + 그래프를 설정해 표현함)
tips %>% ggplot(aes(size))+geom_histogram() #aes는 축을 설정함 / 히스토그램은 축 하나만 설정가능 다른 하나는 "카운트"
tips %>% ggplot(aes(total_bill, tip))+geom_point() # 포인트는 양 축을 모두 정의 해줘야 함.
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day)) # 날짜별 컬러를 더해 시각화 효과 부각
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day,pch=sex),size=3)
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day,pch=time),size=3)                             

# %>% 의 뜻 과 용법 예시

y <- h(g(f(x))) # 괄호가 너무 많아서 복잡해 보임
x %>% f() %>% g() %>% h() <- y # %>%를 사용해 괄호가 많아  헷갈리는 것을 방지