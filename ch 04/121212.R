# 1번 문제

product <- 0
for (i in 1:100) {
    if(i %% 3 == 0 & i %% 4 != 0)
    product <- product + i
} 
print(product)

# 2번 문제

result <- function(x,n) {
    sum <- 0
    for (i in 1:n) {
        if (i %% x ==0)
            sum = sum + i
        }
return(sum)
}

result(1,5)
