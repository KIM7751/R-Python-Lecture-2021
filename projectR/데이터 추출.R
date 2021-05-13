library(rvest)
library(stringr)
library(dplyr)
library(httr)

df <- read.csv('data/Seasons_Stats_NEW1.csv')
df1 <- df %>% filter(Year>=2000)
options(digits = 3)

# 센터 스탯

C_Sats <- df1 %>% 
       filter(Pos == 'C', MP >= median(MP)) %>% 
       group_by(Age) %>% 
       select(MP,TRB,BLK,PT) %>%  
       arrange(desc(Age)) %>% 
       summarize('TRB'=mean(TRB, na.rm=T), 'BLK'=mean(BLK, na.rm=T), 
       'PT'=mean(PT, na.rm=T),  'MP'=mean(MP, na.rm=T))

View(C_Sats)
    

# 포인트가드 스탯 

PG_Stats <- df1 %>% 
         filter(Pos == 'PG', MP >= median(MP)) %>% 
         group_by(Age) %>% 
         select(MP,STL,AST,PT,FT.) %>%  
         arrange(desc(Age)) %>% 
         summarize('STL'= mean(STL, na.rm=T), 'AST'= mean(AST, na.rm=T), 
                   'PT'= mean(PT, na.rm=T), 'FT'= mean(FT., na.rm=T), 'MP'=mean(MP, na.rm=T))

View(PG_Stats)
