# 반복문 
# 1.repeat
i <- 1
sum <- 0
repeat {
    if(i > 10) {
        break
    }
    sum <- sum + i
    i <- i + 1
}
print(sum)

# while
i <- 1
sum <- 0
while (i <= 10) {
    sum <- sum + i
    i <- i + 1
}
print(sum)

# for
sum <- 0
for (i in 1:10) {
    sum <- sum + i
}
print(sum)

# 1 ~ 10 까지 곱하기
i <- 1
factorial <- 1
while (i<=10) {
    factorial <- factorial * i
    i <- i + 1
}
print(factorial)

# 1 ~ 100까지 홀수만 더하기 # for (i in seq(1,100,by=2))
product <- 0
for (i in 1:100) {
    if (i %% 2 !=0)
        product <- product + i
}
print(product)

# 구구단 만들기 
for (k in 1:9){
    print(paste('2', 'x', 'k','=',2*k))
}
for (i in 2:9) {
    print(paste0(i, '단=============================='))
    for (k in 1:9){
        print(paste(i, 'x', k,'=', i*k))
    }
}

#매트릭스 문제 풀기
mat <- matrix(1:12, nrow = 3)
nrow <- 3
ncol <- 4

sum1 <- 0
sum2 <- 0
sum3 <- 0
for (i in 1:nrow) {
    for (k in 1:ncol) {
        sum1 <- sum1 + mat[i,k]
        sum2 <- sum2 + mat[i,k]**2
        sum3 <- sum3 + mat[i,k]**i
    }
    
}
print(paste(sum1, sum2, sum3))

# 별 그리기
for (i in 1:5) {
    star <- ''
    for (k in 1:i) {
        star <- paste0(star, '+')
        }
    print(star)
}

# 리스트 만들기
lst = list()
lst <- append(lst,3)
lst <- append(lst,5)
lst <- append(lst,7)
length(lst)
lst[1]
lst[2]
lst[3]
print(lst)

lst = list()
for (i in 1:5){
    lst <- append(lst, i)
}
lst

for (element in lst) {
    print(element)
}

vec <- c(1,7,8)
for (element in vec) {
    print(element)
}

for (element in mat) {
    print(element)
}