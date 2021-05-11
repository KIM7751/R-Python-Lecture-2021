# 지니 일간차트 크롤링
library(rvest)
library(stringr)
library(dplyr)

base_url <- 'https://www.genie.co.kr/chart/genre'
query <- '?ditc=D&ymd=20210509&genrecode=M0100&pg='
url <- paste0(base_url, query, '1')
html <- read_html(url)

html %>%
    html_node('table.list-wrap') %>%
    html_node('tbody') %>% 
    html_nodes('tr') -> trs
len <- length(trs)

tr <- trs[24]
tr
num <- html_node(tr, '.number') %>% html_text() 
num
nums <- unlist(str_split(num, '\r\n'))
nums
rank <- as.integer(nums[1])
move <- str_trim(nums[2])
move
if (move == 'new') {
    last <- 999
} else {
    slen <- str_length(move)
    inc <- 0
    if (slen > 2) {
        inc <- as.integer(substring(move, 1, slen-2))
    }
    inc
    c_str <- substring(move, slen-1, slen)
    if (c_str == '상승') {
        last <- rank + inc
    } else if (c_str == '하강') {
        last <- rank - inc
    } else {
        last <- rank
    }
}
last
title <- html_node(tr, '.title.ellipsis') %>% html_text()
title
title <- gsub('\r\n', '', title)
title
artist <- html_node(tr, '.artist.ellipsis') %>% html_text()
artist
album <- html_node(tr, '.albumtitle.ellipsis') %>% html_text()
album

ranks <- c()
last_ranks <- c()
titles <- c()
artists <- c()
albums <- c()
for (page in 1:2) {
    url <- paste0(base_url, query, page)
    html <- read_html(url)
    trs <- html %>%
        html_node('.list-wrap') %>%
        html_node('tbody') %>% 
        html_nodes('tr')
    for (tr in trs) {
        num <- html_node(tr, '.number') %>% html_text()
        nums <- unlist(str_split(num, '\r\n'))
        rank <- as.integer(nums[1])
        ranks <- c(ranks, rank)
        move <- str_trim(nums[2])
        if (move == 'new') {
            last <- 999
        } else {
            slen <- str_length(move)
            inc <- 0
            if (slen > 2) {
                inc <- as.integer(substring(move, 1, slen-2))
            }
            c_str <- substring(move, slen-1, slen)
            if (c_str == '상승') {
                last <- rank + inc
            } else if (c_str == '하강') {
                last <- rank - inc
            } else {
                last <- rank
            }
        }
        last_ranks <- c(last_ranks, last)
        title <- html_node(tr, '.title.ellipsis') %>% html_text()
        title <- gsub('\r\n', '', title)
        titles <- c(titles, title)
        artist <- html_node(tr, '.artist.ellipsis') %>% html_text()
        artists <- c(artists, artist)
        album <- html_node(tr, '.albumtitle.ellipsis') %>% html_text()
        albums <- c(albums, album)
    }
}
daily_chart <- data.frame(rank=ranks, last=last_ranks, 
                          title=titles, artist=artists, album=albums)
View(daily_chart)