# 다음 블로그 검색
library(httr)
library(jsonlite)

kakao_api_key <- readLines('openAPI/kakao_api_key.txt')
base_url <- "https://dapi.kakao.com/v2/search/blog"
query <- paste0('query=https://brunch.co.kr/@tourism')
url <- paste(base_url, query, sep = '?')
url

auth_key <- paste('KakaoAK', kakao_api_key)
auth_key
res <- GET(url, add_headers('Authorization' = auth_key))
res

