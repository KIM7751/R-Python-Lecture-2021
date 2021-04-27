# 데이터 시각화
library(gapminder)
library(dplyr)

y <- gapminder %>%
    group_by(year, continent) %>%
    summarise(c_pop=sum(pop))

head(y, 10)

# x 축은 yeat / y 축은 대륙별 인구수로 하자 / col 를 이용해 대륙별 구분

# 1단계 - 막그리는 그래프

plot(y$year, y$c_pop) # x축 / y축 설정 plot 은 산점도가 기본임

# 2단계 - 마커의 색상을 대륙별로 다르게 지정

plot(y$year, y$c_pop, col=y$continent)

# 3단계 - 마커의 모양을 대륙별로 다르게 지정

plot(y$year, y$c_pop, col=y$continent, pch=c(1:5))
length(levels(y$continent))
plot(y$year, y$c_pop, col=y$continent, 
     pch = c(1:length(levels(y$continent)))) # length를 넣어주면서 앞으로 생길 대륙에 있어서도 적용될 수 있도록 설정함
                                             # level은 중복 되지 않은 고유 벡터

# 4단계 - 범례 표시

legend('topleft',
       legend = levels(y$continent),
       pch = c(1:length(levels(y$continent))),
       col = c(1:length(levels(y$continent))))


# 대륙별 인당 GDP, 기대수명

plot(gapminder$gdpPercap, gapminder$lifeExp,
     col=gapminder$continent, pch=c(1:length(levels(gapminder$continent))))

legend('bottomright',
       legend = levels(gapminder$continent),
       pch = c(1:length(levels(gapminder$continent))),
       col = c(1:length(levels(gapminder$continent))))

# 로그 스케일 적용

plot(log10(gapminder$gdpPercap), gapminder$lifeExp,
     col=gapminder$continent, pch=c(1:length(levels(gapminder$continent))))

legend('bottomright',
       legend = levels(gapminder$continent),
       pch = c(1:length(levels(gapminder$continent))),
       col = c(1:length(levels(gapminder$continent))))

# ggplot을 이용해 그리기 / aes 심미적인, 미적인 / 쉽고 간단함

library(ggplot2)
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent)) + 
    geom_point() +
    scale_x_log10()

# 인구수에 따라 포인트 크기 조절 

library(ggplot2)
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, 
                      col=continent, size=pop)) + 
    geom_point() +
    scale_x_log10()

# 포인트의 투명도 조절 

library(ggplot2)
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, 
                      col=continent, size=pop)) + 
    geom_point(alpha=0.5) +
    scale_x_log10()


# 2007년도 자료만 보기 # ctrl + shift + m -> %>% 출력 / dplyr과 ggplot 연동

gapminder %>%
    filter(year==2007) %>% 
    ggplot(aes(x=gdpPercap, y=lifeExp, 
               col=continent, size=pop)) +
    geom_point(alpha=0.5) +
    scale_x_log10()

# 년도별 여러개 그래프 그리기

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, 
                      col=continent, size=pop)) + 
    geom_point(alpha=0.5) +
    scale_x_log10() +
    facet_wrap(~year)

# 시각화 기본기능

# 1. 비교/순위

gapminder %>% 
    filter(continent == 'Asia' & year == 1952) %>%
    ggplot(aes(reorder(country, pop),pop)) +
    geom_bar(stat = 'identity') +  
    coord_flip()                   # x축 글자가 너무 겹쳐서 y축과 바꿈 

# 2. 비교 / 순위 - 로그 스케일

gapminder %>% 
    filter(continent == 'Asia' & year == 1952) %>%
    ggplot(aes(reorder(country, pop),pop)) +
    geom_bar(stat = 'identity') +
    scale_y_log10() +
    coord_flip()

# 3. 변화 추세

gapminder %>% 
    filter(country == 'Korea, Rep.') %>% 
    ggplot(aes(year, lifeExp, col = country)) +
    geom_point() +
    geom_line()

# 4. 여러 데이터의 변화 추세

ggplot(gapminder, aes(year,lifeExp, col=continent)) +
    geom_point(alpha=0.2) +
    geom_smooth()

# 분포 - 히스토그램

x <- filter(gapminder, year == 1952)
hist(x$lifeExp, main = 'Histogram of lifeExp in 1952')

x %>% 
    ggplot(aes(lifeExp)) +
    geom_histogram()

# 6. 대륙별 세분화된 분포특성성

x %>% 
    ggplot(aes(continent, lifeExp)) +
    geom_boxplot()

# 7. 상관 관계
plot(log10(gapminder$gdpPercap), gapminder$lifeExp)
