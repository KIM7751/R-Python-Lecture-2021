# 식신 - 한남대 핫 플레이스 검색 결과
library(rvest)
library(stringr)
library(dplyr)

base_url <- 'https://www.siksinhot.com'
path <- '/search'
place <- '한남대'
query <- paste0('?keywords=', URLencode(iconv(place, to='UTF-8')))
url <- paste0(base_url, path, query)
html <- read_html(url)

# ul 태그의 자식 li 태그가 5개가 아니라 25개 있음
lis <- html %>% 
    html_node('div.listTy1') %>% 
    html_nodes('ul>li')
length(lis)

# ul 태그의 바로 자식인 li 태그만 선택
lis <- html %>% 
    html_node('div.listTy1') %>% 
    html_node('ul') %>% 
    html_children()
length(lis)

li <- lis[3]
name <- li %>% html_node('.store') %>% html_text()
name
menu <- li %>% html_node('p') %>% html_text()
menu

href <- li %>% html_node('a') %>% html_attr('href')
href
sub_url <- paste0(base_url, href)
sub_url
sub_html <- read_html(sub_url)
tel <- sub_html %>% 
    html_node('div.p_tel') %>% 
    html_node('p') %>% 
    html_text()
tel
addr <- sub_html %>% 
    html_node('a.txt_adr') %>% 
    html_text(trim=T)
addr

name_vec <- c()
menu_vec <- c()
tel_vec <- c()
addr_vec <- c()
for (li in lis) {
    name <- li %>% html_node('.store') %>% html_text()
    menu <- li %>% html_node('p') %>% html_text()
    href <- li %>% html_node('a') %>% html_attr('href')
    sub_url <- paste0(base_url, href)
    print(sub_url)
    sub_html <- read_html(sub_url)
    tel <- sub_html %>% 
        html_node('div.p_tel') %>% 
        html_node('p') %>% 
        html_text()
    addr <- sub_html %>% 
        html_node('a.txt_adr') %>% 
        html_text(trim=T)
    
    name_vec <- c(name_vec, name)
    menu_vec <- c(menu_vec, menu)
    tel_vec <- c(tel_vec, tel)
    addr_vec <- c(addr_vec, addr)
}
hot_place <- data.frame(name=name_vec, menu=menu_vec,
                        tel=tel_vec, addr=addr_vec)
View(hot_place)