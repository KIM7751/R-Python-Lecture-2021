# 사물의 범주를 구분하는 목적으로 사용하는 데이터 범주형 데이터
review <- c('good', 'good', 'indifferent', 'bad','good')
review # 6개의 문자 원소를 가지는 벡터임
review.factor <- factor(review) 
review.factor # 벡터의 '' 마크가 사라짐 / levels라는 말이 보임
              # levels에 bad, good, indifferent가 생김
              # 팩터는 level을 원소로 하는 벡터로 정의 가능
              # 3개의 범주를 갖는 팩터다 라고 얘기 가능
str(review.factor) # 알파벳 순으로 bad 가 1 / good 이 2 / indifferent 가 3 으로 표현됨
as.numeric(review.factor) # 숫자데이터로 바꿔주면 위 순서대로 출력
review.factor <- factor(review,
                        levels = c('indifferent', 'bad','good', 'not good'))
                 #levels = 를 이용해 factor 안의 level을 확장 시켜줄 수 있다.
                 # 또 그 전에 factor시에는 알파벳 순서로 나열 돼 있지만 
                 # levles 를 적용하면 내가 원하는 순서대로 나열 가능하다
levels(review.factor)
levels(review.factor) <- c("I","B",'G','N') # levels 바꾸기
levels(review.factor) 
nlevels(review.factor) # levels 개수

# 데이터 프레임
name  <- c("철수", '춘향', '길동')
age <- c("22", '20', '25')
gender <-factor(c('M', 'F', 'M'))
blood_type <- factor(c('a', 'b', 'o')) 

patients <- data.frame(name,age, gender, blood_type)
patients 

patients$name 
patients[1,] # 첫번째 행 모두, 공백은 all
patients[,2] # patients$age와 동일 
patients[2,3] # F
patients$gender[3]
patients[patients$name=="철수",] # patients[1,] filtering
patients[patients$name=="철수",c('age','gender')] #selection


# 데이터 프레임의 속성명을 변수명으로 사용(attach ~ detach)
attach(patients)
name
blood_type
detach(patients)

head(cars)
attach(cars)
speed
dist
detach(cars)
speed # 에러: 객체 "speed"를 찾을 수 없습니다.

mean(cars$speed) # 평균
max(cars$dist)

#subset
subset(cars, speed>20) # 많이 안씀 둘 다 같은 결과 도출
cars[cars$speed>20,]
subset(cars, speed>20, select = c(dist))
subset(cars, speed>20, select = -c(dist))

# 결측값(NA) 처리 중간에 결측치가 있으면 총합도 결측값이 나와 처리해야함
head(airquality)
str(airquality)
sum(airquality$Ozone)

head(na.omit(airquality)) #결측값이 포함된 행이 지워지고 다음 행들이 나옴

# 병합
patients
patients1 <- data.frame(name, age, gender)
patients2 <- data.frame(name, blood_type)
merge(patients1, patients2, by="name")


length(patients1)
 
# 데이터프레임에 행 추가
length(patients1$name)
patients1[length(patients1$name)+1,] <- c('몽룡', 19, 'M')
patients1
patients2[length(patients2$name)+1,] <- c('영희', 'a')
patients2

# 데이터프레임에 열 추가
patients1['birth_year'] <- c(1500, 1550, 1600, 1800)
patients1

#merge
#inner join (x,y)
merge(patients1, patients2)
#left outer join (x,y)
merge(patients1, patients2, all.x =T)
#right outer join (x,y)
merge(patients1, patients2, all.y =T)
# FULL OUTER JOIN (x,y)
merge(patients1, patients2, all.x = T, all.y = T)
