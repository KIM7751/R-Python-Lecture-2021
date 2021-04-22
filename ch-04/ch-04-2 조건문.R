# 조건문
# 1. []에 행/열 조건 명시
test <- c(15, 20, 30, NA, 45)
test[test<40]                 # NA도 선택
test[test<40 & !is.na(test)]  # NA 배제
test[test%%3==0]
test[test%%3==0 & !is.na(test)] #3의 배수

df <- data.frame(name= c('길동', '춘향', '철수'), age= c(30,16,21), gender=factor(c('m', 'f', 'm')))

df                 

#여성인 행 추출
df[df$gender=='f',]
#25세 이상이고 남성인 행 추출
df[df$gender=='m' & df$age>=25,]

# 2. IF문
x <- 5
if (x%%2 == 0) {
    print('짝수입니다')  #indentation 주의할 것 
} else {
    print('홀수입니다')
}

if (x > 1e-10) {
    print("양수")
} else if (x < -1e-10){
    print('음수')
} else {
    print('zero')
}

# 3. ifelse문
score <-75
pass <- ifelse(score>=60, '합격', '불합격')
pass

# students.csv 파일 읽엇거 학점 부여하기 
students <- read.csv('data/students.csv', fileEncoding = 'euc-kr')
students
options(digits = 4) #유효숫자 자리수
apply(students[,2:4],1,mean)
students['평균'] = c(apply(students[,2:4],1,mean))
students
students['학점'] = ifelse(students$평균 >=90, 'A',
                        ifelse(students$평균>=80, 'B',
                               ifelse(students$평균>=70, 'c', 'd')))
students
