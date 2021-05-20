# 가설검정
# 1. 단일 모집단의 가설검정
data <- read.table("http://www.amstat.org/publications/jse/datasets/babyboom.dat.txt", header=F)
str(data)
names(data) <- c("time", "gender", "weight", "minutes")
head(data)
tmp <- subset(data, gender==1)
weight <- tmp[[3]]

barx <- mean(weight) #여자 신생아의 몸무게
s <- sd(weight)      #여아의 몸무게 표준편차
n <- length(weight) 
h0 <- 2800           #모집단의 평균(기존 여아의 몸무게 평균 =2800)
t.t <- (barx - h0) / (s / sqrt(n)) # 검정 통계량

alpha <- 0.05
c.u <- qt(1-alpha, df=n-1)     # 누적 확률이 0.95가 되는 점
p.value <- 1 - pt(t.t, df=n-1) # 검정 통계량 2.23 보다 클 확률 

# R에서 제공하는 t-test// p-value 0.05 보다 크냐 작냐
t.test(weight, mu=2800, alternative="greater")

# 도표 작성 
par(mar=c(0,1,1,1))
x <- seq(-3, 3, by=0.001)
y <- dt(x, df=n-1)
plot(x, y, type="l", axes=F, ylim=c(-0.02, 0.38), 
     main="", xlab="t", ylab="")
abline(h=0)

polygon(c(c.u, x[x>c.u], 3), c(0, y[x>c.u], 0), col=2)
text(c.u, -0.02, expression(t[0.05]==1.74))
text(1.8, 0.2, expression(alpha == 0.05), cex=0.8)
arrows(1.8, 0.18, 1.8, 0.09, length=0.05)

polygon(c(t.t, x[x>t.t], 3), c(0, y[x>t.t], 0), density=20, angle=45)
text(t.t, -0.02, paste("t=", round(t.t, 3)), pos=4)
text(2.65, 0.1, expression(plain(P)(T>2.233) == 0.0196), cex=0.8)
arrows(2.7, 0.08, 2.5, 0.03, length=0.05)

# 2. 모집단이 두개인 경우
# 히스토그램
par(mar=c(2, 1, 1, 1))
hist(data$weight[data$gender==1], xlim=c(1500, 4500), ylim=c(0, 12), 
     col="orange", border=NA, main="", xlab="", ylab="", axes=F)
hist(data$weight[data$gender==2], density=10, angle=45, 
     add=TRUE, col="green")
axis(1)
abline(v = mean(data$weight[data$gender==1]), lty=1, lwd=3, col="orange")
abline(v = mean(data$weight[data$gender==2]), lty=1, lwd=3, col="green")
legends = c("여자아이", "남자아이")
legend("topright", legend=legends, 
       fill=c("orange", "green"), density=c(NA, 20))

boy <- subset(data, gender==1)
girl <- subset(data, gender==2)
# 정규성 테스트
shapiro.test(boy$weight) # p-value < 0.05, 정규성 없음
qqnorm(boy$weight)
qqline(boy$weight)
shapiro.test(girl$weight) # p-value > 0.05, 정규성 있음
qqnorm(girl$weight)
qqline(girl$weight)

iriss <- subset(iris, Species=='setosa')
shapiro.test(iriss$Sepal.Length)  # p-value > 0.05, 정규성 있음

qqnorm(iriss$Sepal.Length)
qqline(iriss$Sepal.Length)
shapiro.test(iriss$Petal.Width)   # p-value < 0.05, 정규성 없음
qqnorm(iriss$Petal.Width)
qqline(iriss$Petal.Width)

# 분산의 동일성 여부에 따른 차이
x <- seq(-3, 3, by=0.01)
y <- dnorm(x)

plot(x, y, type="l", xlim=c(-3, 3.5), ylim=c(0, 0.5), axes=FALSE)
axis(1)
lines(c(0, 0), c(0, max(y)), lty=3)
text(-0.3, max(y)+0.05, "① 평균 0, 표준편차 1")
arrows(-0.2, max(y)+0.03, 0, max(y), length=0.1)

y2 <- dnorm(x+0.5, mean=0.5)
lines(x+0.5, y2, col="red")
lines(c(0.5, 0.5), c(0, max(y2)), lty=3)
text(2.3, max(y2)+0.05, "② 평균 0.5, 표준편차 1")
arrows(2, max(y2)+0.03, 1, dnorm(1, mean=0.5), length=0.1)

y3 <- dnorm(x-1, mean=-1, sd=1.5)
lines(x-1, y3, col="blue")
lines(c(-1, -1), c(0, max(y3)), lty=3)
text(-2, max(y3)+0.05, "③ 평균 -1, 표준편차 1.5")
arrows(-2, max(y3)+0.03, -1.5, dnorm(-1.5, mean=-1, sd=1.5), length=0.1)

# 등분산성 테스트
var.test(data$weight ~ data$gender) # p > 0.05 분산이 같다
var.test(weight ~ gender, data=data)

# 2-sample T test
t.test(data$weight ~ data$gender, mu=0, alternative="less", 
       var.equal=TRUE )

# 3. paired T-test 
# 식욕부진증 치료요법의 효과 검정
install.packages("PairedData")
library(PairedData)
data(Anorexia)
data <- Anorexia
str(data)

install.packages('psych')
library(psych)
summary(data)
describe(data) #표준 편차도 나오더라

n <- length(data$Prior - data$Post)
m <- mean( data$Prior - data$Post )
s <- sd (data$Prior - data$Post)
t.t <- m/(s / sqrt(n))
alpha <- 0.05
qt(alpha, df=16)
pt(t.t, df=16)    # 검정통계량으로부터 구한 유의확률

t.test(data$Prior, data$Post, paired=T, alternative="less")

