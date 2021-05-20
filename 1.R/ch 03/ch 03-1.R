getwd()
setwd('/workspace/r')

# 변수(variable)
x <- 1
y <- 2
z <- x + y
z

# swapping (하나 변수를 만들어 x 값을 보관 / y 값을 비어있는 x에 이동 / 비어있는 y에 x값이 보관 된 변수 대입)
temp <- x
x <- y
y <- temp

# 변수의 타입 (character = 문자형 / "",'' 따옴표로 묶으면 문자형이 됨)
typeof(x)
a <- 'string'
typeof(a)
b <- 'double quote'
typeof(b)
c <- '한글'
typeof(c)

# 실수(Numeric 수치형 -> double 실수형)
x <- 5
y <- 2
typeof(x / y)

# 정수(Numeric 수치형 -> Int 정수형 / L은 완전한 정수를 표현함)
x <- 5L
y <- 2L
typeof(x)

#데이터 타입의 우선 순위(문자형이 가장 높고, 수치형, 논리형이 가장 낮다)

character > numeric > logical

# 복소수(Complex 복소수형 a + bi 형태)
xi <- 1 + 2i
yi <- 1 - 2i
xi + yi
xi * yi
typeof(xi + yi)

# 범주형
blood_type = factor(c('A', 'B','O','AB'))
blood_type

# 논리형
TRUE
FALSE
T
F

# 양의 무한대 / 음의 무한대 / NaN 수학적으로 계산 불가능
xinf = Inf
yinf = -Inf
xinf / yinf 

# 데이터형 확인 함수(is. ??? --> '괄호안에 값이 ??? 형태 맞아?' 라는 뜻 )
class(x) # R 객체지향 관점
typeof(x) # R 언어자체 관점
is.integer(x)
is.numeric(x)
is.complex(xi)
is.character(c)
is.na(xinf/yinf)

# 데이터형 변환 함수(as. ??? -> '괄호 안에 값 ??? 형태로 바꿀 꺼야' 하는 뜻 )
is.integer(as.integer(x))
is.factor(as.factor(c))

# 산술연산자(+,-,*,^,/)
5 ^ 2 #거듭제곱
4 ^ (1/2)
x %% y # 나머지
x %/% y # 몫

# 비교 연산자(<,<=,>,>=,==,!=)
x < y 
x <= y
       '***'
x >= y
x == y
x != y

# 논리 연산자(! 는 부정)
!T 
!F
x | y   #OR  숫자 중 하나라도 1 포함 되면 T / 벡터 개별 원소끼리  비교 1 포함 T 
x & y   #AND 숫자 중 하나라도 0 포함 되면 F / 벡터 개별 원소끼리  비교 0 포함 F / 비교 연산자와 쓰이면 교집합으로 쓰임 
x || y
a <- c(F, F, T, T)
b <- c(F, T, F, T)
a | b # element-wise OR 
a || b # 첫번쩨 엘리먼트만의 논리합
a & b
a && b # 첫번쩨 엘리먼트만의 논리합
2 ^ -3 -5 ** 1/2 >2 # '**' 거듭제곱을 뜻함
