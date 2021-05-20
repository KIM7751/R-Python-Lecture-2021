# 멜론 차트 웹 크롤링 
library(rvest)
library(stringr)
library(dplyr)
library(httr)

url <- 'https://www.melon.com/chart/week/index.htm'
ua <- 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
res <- GET(url=url, user_agent(agent=ua))
html <- read_html(res)

table <- html %>% 
    html_node('div.service_list_song') %>% 
    html_node('table')
trs <- table %>% 
    html_node('tbody') %>% 
    html_nodes('tr')

tr <- trs[1]
rank <- tr %>% 
    html_node('span.rank') %>% 
    html_text()
rank <- as.integer(rank)
# 전주 순위: 1, 2, 3, 22 (유지, 상승, 하강, 신규)
for (i in c(1, 2, 3, 22)) {
    tr <- trs[i]         # trs[1], trs[2], trs[3], trs[22]
    tds <- html_nodes(tr, 'td') 
    spans <- html_nodes(tds[3], 'span')
    last_str <- html_text(spans[3])
    if (length(spans) == 4) {
        t <- as.integer(html_text(spans[4]))
        if (last_str == '순위 동일') {
            last_rank <- rank
        } else if (last_str == '단계 상승') {
            last_rank <- rank + t
        } else {
            last_rank <- rank - t
        }
    } else {
        last_rank <- 999
    }
}

anchors <- tr %>% 
    html_node('.wrap_song_info') %>% 
    html_nodes('a')
title <- html_text(anchors[1])
artist <- html_text(anchors[2])

title <- tr %>% 
    html_node('.ellipsis.rank01') %>% 
    html_node('a') %>% 
    html_text()
artist <- tr %>% 
    html_node('.ellipsis.rank02') %>% 
    html_node('a') %>% 
    html_text()
album <- tr %>% 
    html_node('.ellipsis.rank03') %>% 
    html_node('a') %>% 
    html_text()

rank_vec <- c()
last_vec <- c()
title_vec <- c()
artist_vec <- c()
album_vec <- c()
for (tr in trs) {
    rank <- tr %>% 
        html_node('span.rank') %>% 
        html_text()
    rank <- as.integer(rank)
    
    tds <- html_nodes(tr, 'td') 
    spans <- html_nodes(tds[3], 'span')
    last_str <- html_text(spans[3])
    if (length(spans) == 4) {
        t <- as.integer(html_text(spans[4]))
        if (last_str == '순위 동일') {
            last_rank <- rank
        } else if (last_str == '단계 상승') {
            last_rank <- rank + t
        } else {
            last_rank <- rank - t
        }
    } else {
        last_rank <- 999
    }
    
    title <- tr %>% 
        html_node('.ellipsis.rank01') %>% 
        html_node('a') %>% 
        html_text()
    artist <- tr %>% 
        html_node('.ellipsis.rank02') %>% 
        html_node('a') %>% 
        html_text()
    album <- tr %>% 
        html_node('.ellipsis.rank03') %>% 
        html_node('a') %>% 
        html_text()
    
    rank_vec <- c(rank_vec, rank)
    last_vec <- c(last_vec, last_rank)
    title_vec <- c(title_vec, title)
    artist_vec <- c(artist_vec, artist)
    album_vec <- c(album_vec, album)
}
week_chart <- data.frame(
    rank=rank_vec, last_rank=last_vec, title=title_vec,
    artist=artist_vec, album=album_vec
)
View(week_chart)