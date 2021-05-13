library(rvest)
library(stringr)
library(dplyr)
library(httr)

df <- read.csv('data/Seasons_Stats_NEW1.csv')
df1 <- df %>% filter(Year>=2000)
options(digits = 3)

# C 스탯

C_Sats <- df1 %>% 
       filter(Pos == 'C', MP >= median(MP)) %>% 
       group_by(Age) %>% 
       select(MP,TRB,BLK,PT) %>%  
       arrange(desc(Age)) %>% 
       summarize('TRB'=mean(TRB, na.rm=T), 'BLK'=mean(BLK, na.rm=T), 
       'PT'=mean(PT, na.rm=T),  'MP'=mean(MP, na.rm=T))

View(C_Sats)
    

# PG 스탯 

PG_Stats <- df1 %>% 
         filter(Pos == 'PG', MP >= median(MP)) %>% 
         group_by(Age) %>% 
         select(MP,STL,AST,PT,FT.) %>%  
         arrange(desc(Age)) %>% 
         summarize('STL'= mean(STL, na.rm=T), 'AST'= mean(AST, na.rm=T), 
                   'PT'= mean(PT, na.rm=T), 'FT'= mean(FT., na.rm=T), 'MP'=mean(MP, na.rm=T))

View(PG_Stats)

# SF 스탯


SF_Stats <- df1 %>%
    filter(Year >= 2000) %>% 
    select(Pos, Age, MP, FG., FT., PT) %>%
    filter(Pos == "SF" & MP >= median(MP)) %>% 
    na.omit()

SF_Stats <- SF_Stats %>% 
    group_by(Age) %>% 
    arrange(desc(Age)) %>% 
    summarize('FG.'=mean(FG.), 'FT%'=mean(FT.), 'PT' = mean(PT))
View(SF_Stats)

# SG 스탯

stat_1 <- df1 %>% filter(Year>=2000)

SG_stats <- stat_1 %>% 
    filter(Pos == 'SG' & MP>=median(MP)) %>% 
    group_by(Age) %>% 
    select(X3P., X2P., FT., PT, MP) %>% 
    arrange(desc(Age)) %>% 
    summarize('3P%'=mean(X3P., na.rm=T), '2P%'=mean(X2P., na.rm=T), 
              'FT%'=mean(FT., na.rm=T), 'PT'=mean(PT, na.rm=T), 
              'MP'=mean(MP, na.rm=T))

View(SG_stats)


# PF 스탯

df1  <- df1 %>%
    filter(Year>=2000) 

PF_stats <- df1 %>%
    filter(Pos == 'PF' & MP>=median(MP)) %>% 
    group_by(Age) %>% 
    select(Pos, Age, BLK, TRB, PT, FG.) %>%
    arrange(desc(Age)) %>%  
    summarize('BLK'=mean(BLK, na.rm=T), 'TRB'=mean(TRB, na.rm=T), 'PT' = mean(PT, na.rm=T), 'FG.'= mean(FG., na.rm=T))

View(PF_stats)
