# 제이슨 기본 (내장 데이터 처리)
library(jsonlite)

pi
json_pi <- toJSON(pi, digits = 3) # 제이슨으로 만들겠다
json_pi
fromJSON(json_pi) 

city <- '대전'
json_city <- toJSON(city)
json_city
fromJSON(json_city)

subject <- c('국어', '영어', '수학')
json_subject <- toJSON(subject)
json_subject
fromJSON(json_subject)

# 데이터 프레임

name <- c('test')
age <- c(25)
sex <- c('F')
address <- c('seoul')
hobby <- c('basketball')
person <- data.frame(Name=name, Age=age, Sex=sex,
                     Address=address, Hobby = hobby)

json_person <- toJSON(person)
json_person
prettify(json_person)

##########################

df_json_person <- fromJSON(json_person)
str(df_json_person)

########################## 두개의 데이터 프레임의 데이터 값이 같은지 비교

all(person == df_json_person)

########################## cars 내장 데이터로 테스트

cars
json_cars <- toJSON(cars)
prettify(json_cars)
df_json_cars <- fromJSON(json_cars)
all(cars == df_json_cars)
