library(gapminder)
library(dplyr)
library(ggplot2)
library(tidyr)

glimpse(mpg)

# 1번

y <- mpg %>% 
    select(cty,hwy) %>% 
    ggplot(aes(cty,hwy)) +
    geom_point()
y

# 2번

glimpse(midwest)


x <- midwest%>% 
    select(poptotal,popasian) %>% 
    ggplot(aes(poptotal,popasian)) +
    geom_point() +
    xlim(0e+00,5e+05) +
    ylim(0,10000)+
    scale_x_log10()+
    scale_y_log10()

x

# 3번

z<- mpg %>% 
    filter(class == 'suv') %>% 
    group_by(manufacturer) %>% 
    summarise(cty_avg=mean(cty)) %>% 
    arrange(desc(cty_avg)) %>% 
    head(5)

z 
    
barplot(z$cty_avg, names.arg = z$manufacturer)

# 4 

com <- filter(mpg, class == 'compact')
sub <- filter(mpg, class == 'subcompact')
suv <- filter(mpg, class == 'suv')

c.c <- table(com$class)
c.sb<- table(sub$class)
c.sv<- table(suv$class)

class.count <- rbind(c.c, c.sb, c.sv)

barplot(class.count, beside = T, main='차 종류별 빈도수', col=c('red', 'green', 'blue'))

legend('topleft',
       legend = c('Compact', 'SubCompact', 'Suv'),
       fill=c('red','green','blue'))

# 5

glimpse(economics)

w<- economics %>% 
    select(date,psavert) 
w %>% 
    ggplot(aes(date,psavert)) +
    geom_line()

# 6

com <- filter(mpg, class == 'compact')
sub <- filter(mpg, class == 'subcompact')
suv <- filter(mpg, class == 'suv')

c_c <- com %>% 
    group_by(cty)
  
c_c  

sb_c <- sub %>% 
    group_by(cty)

sb_c

sv_c <- suv%>% 
    group_by(cty)

sv_c

boxplot(c_c$cty, sb_c$cty, sv_c$cty,
        col=c('red','yellow','green'),
        names=c('compact.cty','subcompact.cty','suv.cty'),
        main='By class of cty')

# 7번 

# 7-1 
glimpse(diamonds)
levels(diamonds$cut)

fai <- filter(diamonds, cut == "Fair")
goo <- filter(diamonds, cut == "Good" )
vgo <- filter(diamonds, cut == "Very Good" )
pre <- filter(diamonds, cut == "Premium")
ide <- filter(diamonds, cut == "Ideal")

fa <- table(fai$cut)
go <- table(goo$cut)
vg <- table(vgo$cut)
pr <- table(pre$cut)
id <- table(ide$cut)

total_cut <- rbind(fa, go, vg, pr, id)
barplot(total_cut, beside = T, main='Cutting Rate', col= c('red', 'green', 'blue','yellow', 'orange'))

# 7-2 컷에 따라 가격

diamonds %>% 
    group_by(cut, price) %>% 
    ggplot(aes(cut, price)) +
    geom_bar(stat = 'identity', aes(fill = cut)) +
    scale_fill_brewer(palette = 'Spectral')

# 7-3 cut과 color에 따른 가격의 변화

diamonds %>% 
group_by(cut, price, color) %>% 
    ggplot(aes(cut, price, col=color)) +
    geom_bar(stat = 'identity' , aes(fill=color))


