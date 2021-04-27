# anscombe's quartet
head(anscombe)

# 평균

apply(anscombe, 2, mean)

# 분산

apply(anscombe, 2, var)

# 상관관계

cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)

for (i in 1:4) {
    ans_cor <- cor(anscombe[,i], anscombe[,i+4])
    print(ans_cor)
}

# 요약

summary(anscombe)
