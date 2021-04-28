library(gapminder)
library(dplyr)
library(ggplot2)

# 1-1

x <- gapminder %>% 
    filter(year==1952) %>% 
    select(country,pop) %>% 
    arrange(desc(pop)) %>% 
    head()
pie(x$pop, x$country)
barplot(x$pop, names.arg = x$country)

x

# 1-2

for (i in seq(1952,2007,5)) {
    print(i)
    x <- gapminder %>% 
        filter(year==i) %>% 
        select(country,pop) %>% 
        arrange(desc(pop)) %>% 
        head()
    pie(as.numeric(x$pop), x$country) # 중국 인도 인구 표기 제한 21억을 초과로 numeric을 만들어 정수 표현
    barplot(x$pop, names.arg=x$country)
    title(i)
}

# 그래프를 그릴때 여러 항목일 때 x, y 두 가지로 항목을 통일해보자

# 2

install.packages('tidyr')
library(tidyr)

# 2-1 airquality

head(airquality)
air_tidy <- gather(airquality, key = 'Measure', value = 'Value', 
                   -Day, -Month) # 날짜 데이터는 같은 종의 변수가 아니기 때문에 제외해주고 
                                 # 나머지 두 줄로 만들 key 와 value 를 정해준다
                                 # key는 문자 value는 숫자 데이터를 묶더라
head(air_tidy)                   
tail(air_tidy)
dim(airquality) # dim 행과 열의 갯수
dim(air_tidy)

air_tidy %>% 
    ggplot(aes(Day, Value, col=Measure)) +
    geom_point() +
    facet_wrap(~Month)

# 2-2 iris

iris_tidy <- gather(iris, key = 'feat', value = 'value',
                    -Species) # key는 문자 value는 숫자 데이터를 묶더라

head(iris_tidy)
tail(iris_tidy)
iris_tidy %>% 
    ggplot(aes(feat, value, col=Species)) +
    geom_point(position = 'jitter') # 데이터가 많이 겹쳐 있을때 표시나게 하는것

# 3 품종별로 Sepal/Petal의 Length, Width 산점도 그리기. (총 6개)
library(gridExtra)
seto <- filter(iris, Species == 'setosa')
vers <- filter(iris, Species == 'versicolor')
virg <- filter(iris, Species == 'virginica')

seto_s <- seto %>% 
    ggplot(aes(Sepal.Length,Sepal.Width, col=Species))+
    geom_point()

seto_s

seto_p <- seto %>% 
    ggplot(aes(Petal.Length,Petal.Width, col=Species))+
    geom_point()

seto_p

vers_s <- vers %>% 
    ggplot(aes(Sepal.Length,Sepal.Width, col=Species))+
    geom_point()

vers_s

vers_p <- vers %>% 
    ggplot(aes(Petal.Length,Petal.Width, col=Species))+
    geom_point()

vers_p

virg_s <- virg %>% 
    ggplot(aes(Sepal.Length,Sepal.Width, col=Species))+
    geom_point()

virg_s

virg_p <- virg %>% 
    ggplot(aes(Petal.Length,Petal.Width, col=Species))+
    geom_point()

virg_p

grid.arrange(seto_s, seto_p, vers_s, vers_p, virg_s, virg_p, ncol=2)

# 3-2 
# barplot + legend 품종별 Sepal/Petal의 Length/Width 평균을 비교하되

# 항목을 옆으로 늘어놓은 것(beside=T)과 위로 쌓아올린 것 2개를 그리시오. 

# (총 12개 항목의 데이터를 2개의 그래프에)


seto_mean <- apply(iris[iris$Species=='setosa', 1:4],2,mean)
vers_mean <- apply(iris[iris$Species=='versicolor', 1:4],2,mean)
virg_mean <- apply(iris[iris$Species=='virginica', 1:4],2,mean)
mean_of_iris <- rbind(seto_mean, vers_mean, virg_mean)
mean_of_iris

barplot(mean_of_iris, beside = T, #비사이드는 옆으로 돌리는 것
        main='품종별 평균', ylim=c(0,8), col=c('red', 'green', 'blue'))
legend('topright',
       legend = c('Setosa', 'Versicolor', 'Virginica'),
       fill=c('red','green','blue'))

##ggplot

df <- iris %>% 
    group_by(Species) %>% 
    summarise(Sepal.Length=mean(Sepal.Length), Sepal.Width=mean(Sepal.Width),
              Petal.Length=mean(Petal.Length), Petal.Width=mean(Petal.Width))

df

df_tidy <- gather(df, key = 'Feature', value = 'Value', -Species)
df_tidy

ggplot(df_tidy, aes(x=Feature, y=Value, fill=Species)) + #fill = 칠하는 것
    geom_bar(stat = 'identity')

ggplot(df_tidy, aes(x=Feature, y=Value, fill=Species)) +
    geom_bar(stat = 'identity', position = 'dodge')

# 3-3 박스 플롯 그리기

# boxplot
par(mfrow=c(3,1))     # 3행 1열의 그래프
boxplot(seto$Sepal.Length, seto$Sepal.Width,
        seto$Petal.Length, seto$Petal.Width,
        col=c('red','yellow','green','blue'),
        names=c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width'),
        main='Setosa')
boxplot(vers$Sepal.Length, vers$Sepal.Width,
        vers$Petal.Length, vers$Petal.Width,
        col=c('red','yellow','green','blue'),
        names=c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width'),
        main='Versicolor')
boxplot(virg$Sepal.Length, virg$Sepal.Width,
        virg$Petal.Length, virg$Petal.Width,
        col=c('red','yellow','green','blue'),
        names=c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width'),
        main='Virginica')
par(mfrow=c(1,1))

# ggplot
seto_tidy <- gather(seto, key='Feature', value='Value', -Species)
head(seto_tidy)
s1 <- ggplot(seto_tidy, aes(x=Feature,y=Value,col=Feature)) +
    geom_boxplot() +
    ggtitle('Setosa')
s1

vers_tidy <- gather(vers, key='Feature', value='Value', -Species)
virg_tidy <- gather(virg, key='Feature', value='Value', -Species)
s2 <- ggplot(vers_tidy, aes(x=Feature,y=Value,col=Feature)) +
    geom_boxplot() +
    ggtitle('Versicolor')
s3 <- ggplot(virg_tidy, aes(x=Feature,y=Value,col=Feature)) +
    geom_boxplot() +
    ggtitle('Virginica')
grid.arrange(s1,s2,s3, ncol=1)