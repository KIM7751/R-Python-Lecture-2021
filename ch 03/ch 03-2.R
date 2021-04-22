# 벡터( 1차원 데이터)
s <- c(1,2,3,4,5,6)
s2 <- c(1:6)         # 시작:끝
s3 <- c(6:1)
s4 <- 1:5
c(1:3, c(4:6))
c(1:30)
seq(1, 100, by=2) # from, to , increment
seq(from=100, to=1, by=-3)
seq(0, 1, by=0.1)
seq(0, 1, length.out=11)

rep(c(1:3), times=2) # 1 2 3 1 2 3
rep(c(1:3), each=2)  # 1 1 2 2 3 3

# 인덱싱
x <- seq(2,10,by=2)
x[1]
x[-1]
x[-3]

#slicing
x[1:3]
x[c(1,3,5)] #원하는거 빼오려고 벡터를 씀
x[-c(2,4)]

# 연산
x <- c(1:4)
y <- c(5:8)
z <- c(3,4)
w <- c(5:7)

x + 2 # 3 4 5 6  
x + y # 6 8 10 12
x + z # 4 6 6 8 
x + w # 6 8 10 9

length(w)

x > 2
all(x>2) # AND
any(x>2) # OR

# fancy indexing
y[x>2]

x <- 1:10
head(x)
head(x, 3)
tail(x,3)

# 집합 연산
x <- 1:3
y <- 3:5
z <- c(3,1,2)

union(x, y)    #합집합(중복 없이)
intersect(x,y) #교집합
setdiff(x, y)  #차집합
setdiff(y, x)
setequal(x, y) # F
setequal(x, z) # T


