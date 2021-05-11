# Converting JSON to R DataFrame
library(jsonlite)

df_repos <- fromJSON("https://api.github.com/users/hadley/repos")
str(df_repos)
names(df_repos)

names(df_repos$owner)
