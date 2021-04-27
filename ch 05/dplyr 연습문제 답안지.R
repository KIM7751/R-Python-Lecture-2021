# dplyr 연습문제
library(dplyr)
library(ggplot2)

# 1.
displ4 <- mpg %>% filter(displ <= 4)
displ5 <- mpg %>% filter(displ >= 5)
mean(displ4$hwy)
mean(displ5$hwy)

mpg %>%
    mutate(displ45=ifelse(displ<=4,'DISPL4','DISPL5')) %>%
    group_by(displ45) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))

# 2.
mpg %>% 
    filter(manufacturer %in% c('audi','toyota')) %>%
    group_by(manufacturer) %>%
    summarise(avg_cty=mean(cty)) %>%
    arrange(desc(avg_cty))

# 3.
mpg %>%
    filter(manufacturer %in% c('chevrolet','ford','honda')) %>%
    summarise(avg_hwy=mean(hwy))

# 4.
mpg4 <- mpg %>%
    select(class, cty)
head(mpg4)

# 5. 
mpg4 %>%
    filter(class %in% c('suv','compact')) %>%
    group_by(class) %>%
    summarise(avg_cty=mean(cty)) %>%
    arrange(desc(avg_cty))

# 6.
mpg %>%
    filter(manufacturer=='audi') %>%
    arrange(desc(hwy)) %>%
    head(5)

# 7.
df <- mpg %>%
    mutate(total=cty+hwy)
head(df)

df$avg <- df$total/2
df %>% 
    arrange(desc(avg)) %>% 
    head(3)

mpg %>%
    mutate(total=cty+hwy, avg=total/2) %>%
    arrange(desc(avg)) %>%
    head(3)

# 8.
mpg %>%
    group_by(class) %>%
    summarise(avg_cty=mean(cty))

# 9.
mpg %>%
    group_by(class) %>%
    summarise(avg_cty=mean(cty)) %>%
    arrange(desc(avg_cty))

# 10
mpg %>%
    group_by(manufacturer) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy)) %>%
    head(3)

# 11.
mpg %>%
    filter(class=='compact') %>%
    group_by(manufacturer) %>%
    summarise(num_kind=n()) %>%  # n() - 행의 갯수
    arrange(desc(num_kind))