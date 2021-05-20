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

# 그래프

library(ggplot2)

ggplot(anscombe) +
    geom_point(aes(x1, y1), color ='darkorange', size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +
    scale_y_continuous(breaks = seq(2,14,2)) +  # 스케일을 먼저 먹이고 리미트
    xlim(2,20) +                                # y 절편 intersept, 기울기 slop y = a(기울기)x +b(y절편)
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,                   
                color = 'cornflowerblue', size =1) +
    labs(title = 'Dataset 1')

par(mflow=c(1,1)) # plot 일때는 적용이되지만 ggplot은 안된다고 함 
                                       

# 하나의 변수명으로 그래프를 넣어둠
p1 <- ggplot(anscombe) +
    geom_point(aes(x1, y1), color ='darkorange', size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +
    scale_y_continuous(breaks = seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,                   
                color = 'cornflowerblue', size =1) +
    labs(title = 'Dataset 1')
p1

p2 <- ggplot(anscombe) +
    geom_point(aes(x2, y2), color ='darkorange', size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +
    scale_y_continuous(breaks = seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,                   
                color = 'cornflowerblue', size =1) +
    labs(title = 'Dataset 2')

p2

p3 <- ggplot(anscombe) +
    geom_point(aes(x3, y3), color ='darkorange', size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +
    scale_y_continuous(breaks = seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,                   
                color = 'cornflowerblue', size =1) +
    labs(title = 'Dataset 3')

p3

p4 <- ggplot(anscombe) +
    geom_point(aes(x4, y4), color ='darkorange', size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +
    scale_y_continuous(breaks = seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,                   
                color = 'cornflowerblue', size =1) +
    labs(title = 'Dataset 4')

p4

install.packages('gridExtra') # 그래프를 한꺼번에 그려주는 녀석
library(gridExtra)

grid.arrange(p1,p2,p3,p4, ncol=2, top = "anscombe's Quartet") 

# 동일한 코드가 반복되지 않게 할거야

figures <- list()
figures <- append(figures, p1)
figures <- append(figures, p2)
figures <- append(figures, p3)
figures <- append(figures, p4)

figures[1]

#################################################################

#Source Refactoring

x <- ggplot(anscombe) +
    geom_point(aes(x4, y4), color ='darkorange', size=3)
x

##프로그램에서 변수명을 임의로 변경할때 ( for 반복문에서 변수명에 넣으려고)
assign(paste('m',4,sep = '.'), x)
grid.arrange(p1,p2,p3,m.4, ncol=2, top = "anscombe's Quartet")

for (i in 1:4) {
    x <- ggplot(anscombe) +
        geom_point(aes(anscombe[,i],anscombe[,i+4]), color ='darkorange', size=3) +
        scale_x_continuous(breaks = seq(2,20,2)) +
        scale_y_continuous(breaks = seq(2,14,2)) +
        xlim(2,20) +
        ylim(2,14) +
        geom_abline(intercept = 3, slope = 0.5,                   
                    color = 'cornflowerblue', size =1) +
        labs(title = paste0('Dataset' , i), 
             x=paste0('x',i), y=paste0('y',i))
    assign(paste('m',i,sep = '.'), x)
    }

grid.arrange(m.1,m.2,m.3,m.4, ncol=2, top = "anscombe's Quartet")
