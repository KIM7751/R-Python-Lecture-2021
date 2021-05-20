# 시각화 도구
library(dplyr)
library(ggplot2)
library(gapminder)
# 1. plot

head(cars)
plot(cars, type='p', main='cars') # p - point , main - title
plot(cars, type='l', main='cars') # l - line
plot(cars, type='b', main='cars') # b - both point and line
plot(cars, type='h', main='cars') # h - 히스토그램과 같은 막대 그래프

# 2. pie & barplot

x <- gapminder %>% 
    filter(year==1952 & continent=='Asia') %>% 
    mutate(gdp=gdpPercap*pop) %>% 
    select(country, gdp) %>% 
    arrange(desc(gdp)) %>% 
    head()
x

pie(x$gdp, x$country)

barplot(x$gdp, names.arg = x$country)

x <- gapminder %>% 
    filter(year==2007 & continent=='Asia') %>% 
    mutate(gdp=gdpPercap*pop) %>% 
    select(country, gdp) %>% 
    arrange(desc(gdp)) %>% 
    head()
x

pie(x$gdp, x$country)
barplot(x$gdp, names.arg = x$country)

# 3. matplot

matplot(iris[,1:4], type = 'l')
legend('topleft',
       names(iris)[1:4],
       lty = c(1:4),
       col = c(1:4))

# 4. 히스토그램

hist(cars$speed)
hist(iris$Sepal.Length)

## ggplot2 라이브러리 

# 1. geom_histogram - stack 형태가 기본 값임 

gapminder %>% 
    filter(year==2007) %>% 
    ggplot(aes(lifeExp, col = continent)) +
    geom_histogram()

gapminder %>% 
    filter(year==2007) %>% 
    ggplot(aes(lifeExp, col = continent)) +
    geom_histogram(position = 'dodge')

# 2. geom_boxplot

gapminder %>% 
    filter(year == 2007) %>% 
    ggplot(aes(continent, lifeExp, col = continent)) +
    geom_boxplot()

# 3. scale_x_log10(), scale_y_log10()

ggplot(gapminder, aes(gdpPercap, lifeExp, col = continent)) +
    geom_point(alpha=0.2) +
    scale_x_log10()

# 4. coord_flip()

gapminder %>% 
    filter(continent == 'Africa') %>% 
    ggplot(aes(country, lifeExp)) +
    geom_bar(stat = 'identity') +
    coord_flip()


gapminder %>% 
    filter(continent == 'Africa') %>% 
    ggplot(aes(country, lifeExp, col=country)) +
    geom_bar(stat = 'identity') +
    coord_flip()

# 5. scale_fill_brewer

library(RColorBrewer)
display.brewer.all()

# 기본 팔레트

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent))

# spectral 팔레트

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'Spectral')

# blues 팔레트

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'Blues')

# RdBu 팔레트

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'RdBu')

# 그래프 표시 순서

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(reorder(continent, n), n)) +
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'Blues')

    