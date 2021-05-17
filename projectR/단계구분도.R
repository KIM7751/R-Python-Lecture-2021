# 단계 구분도(Choropleth)
install.packages("geojsonio")
library(geojsonio)
library(leaflet)
library(stringr)

map <- geojson_read('map_data/daejon.json',what ='sp' )
leaflet(map) %>%  
    setView(lng = 127.39, lat = 36.35, zoom = 12) %>% 
    addProviderTiles('Stamen.TonerLite') %>% 
    addPolygons()
class(map) # SpatialPolygonsDataFrame
slotNames(map)
map@data # 읽는 방법이 특이함
