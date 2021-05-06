# 문자열 처리
library(stringr)

# 1. Character 형 변환

example <- 1
typeof(example) # double 숫자
example <- as.character(example)
typeof(example) # character

# 입력을 받는 경우

input <- readline('prompt> ') # 밑에 콘솔창이 뜸 , 숫자를 입력시 출력됨
input                         # 문자열로 출력
i <- as.numeric(input)        # 숫자로 바꾸기
3 * i

# 2. string 이어 붙이기

paste('A','quick', 'brown','box') # 공백을 포함해 붙여줌.
paste0('A','quick', 'brown','box') # 공백 제외 출력
paste('A','quick', 'brown','box', sep='-') # - 으로 구분해 출력
s <- paste('A','quick', 'brown','box', sep='-')
sample <- c('A','quick', 'brown','box')
paste(sample)
paste(sample, collapse = " ") # 원소 구분을 떼어버리고 공백을 기준해 묶어버림
str_c(sample, '1', sep = '_') # 각각 원소에 1을 붙여 출력함 
str_c(sample, '1', sep = '_', collapse = '@@')

# 3. Character 개수 카운트

x <- 'Hello'
nchar(x)         # 알파벳 하나의 1바이트
h <- '안녕하세요' 
nchar(h)         # 한글에 대해서 고민 안해도 됨
str_length(h)


# 4. 소문자 변환(한글은 해당 x)

tolower(x)

# 5. 대문자 변환(한글은 해당 x)

toupper(x)

# 6. 2개의 character vector를 중복되는 항목 없이 합하기 

str_1 <- c("hello", "world", "r", "program")
str_2 <- c("hi", "world", "r", "coding")
union(str_1, str_2) # 합집합, 중복된 요소 제외

# 7. 2개의 character vector에서 공통된 항목 추출 

intersect(str_1, str_2) # 교집합

# 8. 차집합

setdiff(str_1, str_2)

# 9. 2개의 character vector 동일 여부 확인 (순서에 관계없이) 

str_3 <- c("hello", "world", "r", "program")
setequal(str_1, str_2)
setequal(str_1, str_3)

# 10. 공백 없애기

vector_1 <- c("   Hello World!  ", "    Hi R!    ")
str_trim(vector_1, side = 'left') # 글자 사이에 공백이 아닌 글자 앞부분의 공백제거
str_trim(vector_1, side = 'right')
str_trim(vector_1, side = 'both')

# 11. string 반복

str_dup(x, 3) # 하나의 원소로 반복
rep(x, 3) # 원소 단위로 구분해 반복 

# 12. Substring(String의 일정 부분) 추출 

string_1 <- "Hello World"
substr(string_1, 7, 9)
substring(string_1, 7, 9)
str_sub(string_1, 7, 9)
substr(string_1, 7)    # error
substring(string_1, 7) # 7번째부터 끝까지
str_sub(string_1, 7)
str_sub(string_1, 7, -1)
str_sub(string_1, 7, -3)
string_1[7:9] # N/A

# 13. String의 특정 위치에 있는 값 바꾸기  

string_1 <- "Today is Monday"
substr(string_1, 10, 12) <- "Sun"
string_1
substr(string_1, 10, 12) <- "Thurs" # 글자수가 많아서 안들어감 비효율적
string_1                            # "Today is Thuday"


# 14. 특정 패턴(문자열)을 기준으로 String 자르기

strsplit(string_1, split = ' ')
str_split(string_1, pattern = ' ')
str_split(string_1, pattern = ' ', n=2)
str_split(string_1, pattern = ' ', simplify = T) # matrix
s <- str_split(string_1, pattern = ' ')
typeof(s)
s[[1]]
s[[1]][1]
# 리스트를 벡터로 변환 
unlist(s)
paste(unlist(s), collapse = ' ')

# 15. 특정 패턴(문자열) 찾기 (기본 function)

vector_1 <- c("Xman", "Superman", "Joker")
grep('man', vector_1)
grepl('man', vector_1)
regexpr('man', vector_1)
gregexpr("man", vector_1)

# 16. 특정 패턴(문자열) 찾기 (stringr package function)

fruit <- c('apple', 'banana', 'cherry')
str_count(fruit, 'a')
str_detect(fruit, 'a')
str_locate(fruit, 'a')
str_locate_all(fruit, 'a')

people <- c('rorori', 'emilia', 'youna')
str_match(people, 'o(\\D)') # \\D는 non-digit character 의미

# 17. 특정 패턴(문자열) 찾아서 다른 패턴(문자열)으로 바꾸기

fruits <- c("one apple", "two pears", "three bananas")
sub('a', 'A', fruits)
gsub('a', 'A', fruits)
str_replace(fruits, 'a', 'A')
str_replace_all(fruits, 'a', 'A')
