# base R 을 이용한 데이터 가공

install.packages("gapminder") # ''꼭 붙이기
library(gapminder)
library(dplyr)

glimpse(gapminder) # 이게 뭔지 찾아보기
gapminder          # 이게 뭔지 찾아보기   

# 각 나라의 기대 수명(lifeExp)

tail(gapminder[,c('country','lifeExp')])
tail(gapminder[,c('country','lifeExp','year')]) #셀렉션 열 추출

# 샘플과 속성의 추출(필터링 - 행 & 셀렉션 - 열) 필터링으로 행에 조건을 주는 것 발견 / 셀렉션은 열 옵션만

gapminder[1000:1009,c('country','lifeExp','year')] 
gapminder[gapminder$country == 'Croatia',]
gapminder[gapminder$country == 'Croatia',c('year', 'pop')]

# 크로아티아의 1990년도 이후의 기대수명과 인구

gapminder[gapminder$country=='Croatia' & gapminder$year>1990 , c('year','lifeExp','pop')]

# 행/열 단위의 연산 apply(대상, 1 or 2, 함수)

apply(gapminder[gapminder$country=='Croatia',c('lifeExp','pop')],
      2, mean)

# CAGR 연평균 증가율 (끝나는값/시작값) ** 1/차이(끝나는값년도 - 시작값년도)  - 1

(4493312/3882229) ** (1/55) - 1

# 별도 함수를 만들어보자

peak2peak = function(x) {
    return(max(x) - min(x))
}

apply(gapminder[gapminder$country=='Croatia',c('lifeExp','pop')],
      2, peak2peak)


