# dplyr 라이브러리를 이용한 데이터 가공
# fillter, select, arrange(오름차순, 내림차순), group_by(그루핑해서 끄집어냄) & summarize(그루핑해서 계산), mutate(새로운 col을 만들고 싶다)
# %>% 체인 / 파이프라고 함 

library(dplyr)
library(gapminder)

# 1. select(매트릭스/테이블따위, ) 원하는 열 추출,''따옴표를 안붙여도 됨

select(gapminder, country, year, lifeExp)
select(gapminder, country, year, lifeExp) %>% head()
select(gapminder, country, year, lifeExp) %>% head(10)

# 2. filter(매트릭스/테이블따위,) 원하는 행 추출

filter(gapminder, country=='Croatia')
filter(gapminder, country=='Croatia' & year>2000)
filter(gapminder, continent=='Europe' & year==2007)

# 3.arrange(오름차순/내림차순) 기본값 = 오름차순 1 ~ 9

europe_pop <- filter(gapminder, continent=='Europe' & year==2007)
arrange(europe_pop, lifeExp) # lifeExp을 기준으로 오름차순할꺼야
arrange(europe_pop, desc(lifeExp)) #desc() 내림차순 9 ~ 1
arrange(europe_pop, desc(lifeExp))

# 아프리카 대륙에서 평균 수명이 가장  긴 나라 5개

africa.pop <- filter(gapminder, continent == 'Africa'& year ==2007)
arrange(africa.pop, desc(lifeExp)) %>% head(5)

gapminder %>% # 체인을 이용한 요약
    filter(continent == 'Africa'& year ==2007) %>%
    arrange(desc(lifeExp)) %>% 
    head(5)

# 4. group_by 와 summarize(테이블, 함수) mutate를 이용해 새로 만든 변수도 이용 가능하다
summarize(africa.pop, pop_avg=mean(pop)) # 2007년 아프리카 국가별 평균 인구수
summarise(group_by(gapminder, continent), pop_avg=mean(pop)) # 대륙별 평균 인구수
summarise(group_by(gapminder, country), life_avg=mean(lifeExp))

asia_pop <- gapminder %>%
    filter(continent=='Asia')

    summarise(group_by(asia_pop, country), life_avg=mean(lifeExp))
    
    summarise(group_by(asia_pop, country), life_avg=mean(lifeExp)) %>%
        arrange(desc(life_avg)) %>%
        head(5)
    
    gapminder %>%
        filter(continent=='Asia') %>%
        group_by(country) %>%
        summarise(life_avg=mean(lifeExp)) %>%
        arrange(desc(life_avg)) %>%
        head(5)
 
# 2007년 인구수 5000만 이상인 국가중 기대수명이 가장 큰 TOP 5 국가   
    gapminder %>%
        filter(year==2007 & pop>=5e7) %>%
        group_by(country) %>%
        summarise(life_avg=mean(lifeExp)) %>%
        arrange(desc(life_avg)) %>%
        head(5)
        
    

#mpg(mile - per - gallon)

library(ggplot2)    
head(mpg)    
glimpse(mpg)
summary(mpg)

#통합연비 변수
df <- mpg
df$total <-(df$cty + df$hwy) / 2
head(df)
mean(df$total)
summary(df$total)
hist(df$total)

# 평균 연비가 20 이상이면 합격 아니면 불합격
df$test <-ifelse(df$total>=20, 'pass' , 'fail')
table(df$test)
qplot(df$test)

# 평균 연비가 30 이상이면 A 등급, 20이상이면 B 등급, 아니면 C 등급
df$grade <- ifelse(df$total>=30, 'A',
                   ifelse(df$total>=20, 'B','C'))
table(df$grade)

# mutat 잘 모르겠음 찾아보기
mpg %>%
    mutate(grade2=ifelse(df$total>=30, 'A',
                         ifelse(df$total>=20, 'B','C')))
mpg <- mpg %>% 
    mutate(grade2=ifelse(df$total>=30, 'A',
                         ifelse(df$total>=20, 'B','C')))

table(mpg$grade2)

#  벡터 내 특정 값 포함 여부 확인 연산자 %in% 찾아보기
    