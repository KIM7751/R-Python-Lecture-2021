# 파일 읽기
getwd()
students <- read.table('data/students1.txt', header = T) #일반 텍스트 파일 읽음
students                                      # 첫 행을 헤더로 쓰겠다라는 뜻 
str(students)                                 # 헤더가 없는 데이터 파일의 경우 F 사용
                                              # table은 공백, 클론, 탭 통해 데이터를 구분

#read.csv 첫 행을 헤더로 읽는 것이 기본 값임 / ,(쉼표)로 데이터 구분
students <- read.csv('data/students.csv')
students

# 파일 쓰기 + 인코딩 신경 쓸 것 
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8')
write.csv(students, file = 'data/output.csv', fileEncoding = 'utf-8')


# row.names=F 옵션 설정 / 행 인덱스 번호를 저장 하지 않음
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8', row.names = F)
write.csv(students, file = 'data/output.csv', fileEncoding = 'utf-8' , row.names = F)

# quote=F OPTION / "" 사라짐
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8', row.names = F,quote = F)
write.csv(students, file = 'data/output.csv', fileEncoding = 'utf-8' , row.names = F,quote = F)

# 제대로 읽는지 확인
students <- read.table('data/output.txt', header = T, fill = T, fileEncoding = 'utf-8')
students
students <- read.csv('data/output.csv',fileEncoding = 'utf-8')
students

# 읽을 때 stringAsfactor=F로 하면 문자열을 범주형으로 읽지 않음
students <- read.csv('data/output.csv',fileEncoding = 'utf-8', stringsAsFactors = F)
students