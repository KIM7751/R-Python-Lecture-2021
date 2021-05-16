library(rvest)
library(stringr)
library(dplyr)
library(httr)
library(ggplot2)
df <- read.csv('data/projectData/Seasons_Stats_NEW1.csv')
df1 <- df %>% filter(Year>=2000)
options(digits = 3)

# C 스탯
head(df1)
C_stats <- df1 %>% 
    filter(Pos == 'C', MP >= median(MP)) %>%
    group_by(Age) %>% 
    select(Pos,X3P.,X2P.,TRB,BLK,PT,MP) %>%  
    na.omit() %>% 
    arrange(desc(Age)) %>% 
    summarize('P3'=mean(X3P.), 'P2'=mean(X2P.), 'TRB'=mean(TRB), 'BLK'=mean(BLK), 
              'PT'=mean(PT),  'MP'=mean(MP))

C_stats <- as.data.frame(C_stats)


# PG 스탯 
# STL, AST, PT, FT, MP

PG_stats <- df1 %>% 
    filter(Pos == 'PG', MP >= median(MP)) %>%
    group_by(Age) %>% 
    select(Pos,STL,AST,PT,FT., MP) %>%  
    na.omit() %>% 
    arrange(desc(Age)) %>% 
    summarize('STL'= mean(STL), 'AST'= mean(AST), 
              'PT'= mean(PT), 'FT'= mean(FT.), 'MP'=mean(MP))


# SF 스탯
# FG%, FT%, PT, MP


SF_stats <- df1 %>% 
    filter(Pos == 'SF', MP >= median(MP)) %>%
    group_by(Age) %>% 
    select(Pos,FG., FT., PT, MP) %>%  
    na.omit() %>% 
    arrange(desc(Age)) %>% 
    summarize('FG.'=mean(FG.), 'FT%'=mean(FT.), 'PT' = mean(PT), 'MP'=mean(MP))


# SG 스탯
# X3P%, X2P%, FT%, PT, MP

SG_stats <- df1 %>% 
    filter(Pos == 'SG', MP >= median(MP)) %>%
    group_by(Age) %>% 
    select(Pos,X3P., X2P., FT., PT, MP) %>%  
    na.omit() %>% 
    arrange(desc(Age)) %>% 
    summarize('3P%'=mean(X3P.), '2P%'=mean(X2P.), 
              'FT%'=mean(FT.), 'PT'=mean(PT), 
              'MP'=mean(MP))


# PF 스탯
# BLK, TRB, PT, FG%, MP

PF_stats <- df1 %>% 
    filter(Pos == 'PF', MP >= median(MP)) %>%
    group_by(Age) %>% 
    select(Pos,BLK, TRB, PT, FG., MP) %>%  
    na.omit() %>% 
    arrange(desc(Age)) %>% 
    summarize('BLK'=mean(BLK), 'TRB'=mean(TRB), 'PT' = mean(PT), 'FG.'= mean(FG.), 'MP' = mean(MP))





sum_data <- merge(C_stats, PF_stats, PG_stats, SF_stats, SG_stats, by = Pos)



# C 포지션 그래프
pos_C_X3P <- C_stats %>% 
    ggplot(aes(x= Age, y = P3))+
    geom_line()

pos_C_X2P <- C_stats %>% 
    ggplot(aes(x= Age, y = P2))+
    geom_line()

pos_C_TRB <- C_stats %>% 
    ggplot(aes(x= Age, y = TRB))+
    geom_line()

pos_C_BLK <- C_stats %>% 
    ggplot(aes(x= Age, y = BLK))+
    geom_line()

pos_C_PT <- C_stats %>% 
    ggplot(aes(x= Age, y = PT))+
    geom_line()

pos_C_MP <- C_stats %>% 
    ggplot(aes(x= Age, y = MP))+
    geom_line()


library(gridExtra)
library(grid)
title_C <- textGrob("센터 세부 스텟",
                     gp=gpar(fontsize=20,fontface=2))
grid.arrange(pos_C_X3P, pos_C_X2P, pos_C_TRB, pos_C_BLK, pos_C_PT, pos_C_MP, ncol=2, top = title_C)

# SF 그래프

SF_stats <- df1 %>% 
    filter(Pos == 'SF', MP >= median(MP)) %>%
    group_by(Age) %>% 
    select(Pos, X3P., X2P., PT, MP, TRB, STL) %>%  
    na.omit() %>% 
    arrange(desc(Age)) %>% 
    summarize('P3'=mean(X3P.), 'P2'=mean(X2P.), 'PT' = mean(PT), 'MP'=mean(MP), 'TRB' = mean(TRB), 'STL' = mean(STL))


                  
pos_SF_X3P <- SF_stats %>% 
    ggplot(aes(x= Age, y = P3))+
    geom_line()

pos_SF_X2P <- SF_stats %>% 
    ggplot(aes(x= Age, y = P2))+
    geom_line()

pos_SF_TRB <- SF_stats %>% 
    ggplot(aes(x= Age, y = TRB))+
    geom_line()

pos_SF_STL <- SF_stats %>% 
    ggplot(aes(x= Age, y = STL))+
    geom_line()

pos_SF_PT <- SF_stats %>% 
    ggplot(aes(x= Age, y = PT))+
    geom_line()

pos_SF_MP <- SF_stats %>% 
    ggplot(aes(x= Age, y = MP))+
    geom_line()

library(grid)
library(gtable)
library(gridExtra)
title_SF <- textGrob("스몰포워드 세부 스텟",
                  gp=gpar(fontsize=20,fontface=2))

grid.arrange(pos_SF_X3P, pos_SF_X2P, pos_SF_TRB, pos_SF_STL, pos_SF_PT, pos_SF_MP, ncol=2, top = title_SF)
