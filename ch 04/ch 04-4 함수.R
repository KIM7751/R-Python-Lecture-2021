# 함수
# 팩토리얼 함수

fact <- function(x) {
    prod <- 1
    for (i in 1:x) {
        prod <- prod * i
    }
    return(prod)
}

fact(5)
fact(10)

# 정수 a ~ b 의 합(range_sum)
range_sum <- function(a, b) {
    sum <- 0
    for (i in a:b) {
        sum <- sum + i
    }
    return(sum)
}

range_sum(1,10)

# 재귀 함수(자기가 자기를 불러옴)
facto <- function(n) {
    if (n==0) {
        return(1)
    }
    return(n * facto(n-1))
}
facto(10)

# 피보나치 수열
fibo <- function(n) {
    if(n==0 | n==1)  {
        return(1)
    }
    return(fibo(n-1) + fibo(n-2))
}
# 피보나치 1~10까지 시도해보자
for (i in 0:10) {
    print(paste(i, fibo(i)))
}

# 피크 투 피크 함수 (직접 만들어 쓸 수 있다는 예시)

peak2peak <- function(x) {
    return(max(x) - min(x))
}

mat <- matrix(1:12, nrow=3)
apply(mat, 1, mean)
mat

apply(mat, 1, peak2peak)
apply(mat, 2, peak2peak)


